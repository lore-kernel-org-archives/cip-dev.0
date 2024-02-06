Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E108EC48297
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:28:25 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.20171.1707222496328553437
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:28:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="193048743"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 21:28:15 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 427FE4005E16;
	Tue,  6 Feb 2024 21:28:13 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 19/44] irqchip/sifive-plic: Separate the enable and mask operations
Date: Tue,  6 Feb 2024 12:27:09 +0000
Message-Id: <20240206122734.13477-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:28:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14803

From: Samuel Holland <samuel@sholland.org>

commit a1706a1c5062e0908528170f853601ed53f428c8 upstream.

The PLIC has two per-IRQ checks before sending an IRQ to a hart context.
First, it checks that the IRQ's priority is nonzero. Then, it checks
that the enable bit is set for that combination of IRQ and context.

Currently, the PLIC driver sets both the priority value and the enable
bit in its (un)mask operations. However, modifying the enable bit is
problematic for two reasons:
  1) The enable bits are packed, so changes are not atomic and require
     taking a spinlock.
  2) The following requirement from the PLIC spec, which explains the
     racy (un)mask operations in plic_irq_eoi():

       If the completion ID does not match an interrupt source
       that is currently enabled for the target, the completion
       is silently ignored.

Both of these problems are solved by using the priority value to mask
IRQs. Each IRQ has a separate priority register, so writing the priority
value is atomic. And since the enable bit remains set while an IRQ is
masked, the EOI operation works normally. The enable bits are still used
to control the IRQ's affinity.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701202440.59059-3-samuel@sholland.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/irqchip/irq-sifive-plic.c | 55 +++++++++++++++++++------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 364023c776d43..2673f726f85d8 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -108,9 +108,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 				   struct irq_data *d, int enable)
 {
 	int cpu;
-	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
@@ -118,16 +116,37 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	}
 }
 
-static void plic_irq_unmask(struct irq_data *d)
+static void plic_irq_enable(struct irq_data *d)
 {
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
 }
 
-static void plic_irq_mask(struct irq_data *d)
+static void plic_irq_disable(struct irq_data *d)
 {
 	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
 }
 
+static void plic_irq_unmask(struct irq_data *d)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(1, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+}
+
+static void plic_irq_mask(struct irq_data *d)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+}
+
+static void plic_irq_eoi(struct irq_data *d)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+
+	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
+}
+
 #ifdef CONFIG_SMP
 static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
@@ -146,32 +165,21 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	plic_irq_mask(d);
+	plic_irq_disable(d);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-	if (!irqd_irq_masked(d))
-		plic_irq_unmask(d);
+	if (!irqd_irq_disabled(d))
+		plic_irq_enable(d);
 
 	return IRQ_SET_MASK_OK_DONE;
 }
 #endif
 
-static void plic_irq_eoi(struct irq_data *d)
-{
-	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
-
-	if (irqd_irq_masked(d)) {
-		plic_irq_unmask(d);
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-		plic_irq_mask(d);
-	} else {
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-	}
-}
-
 static struct irq_chip plic_edge_chip = {
 	.name		= "SiFive PLIC",
+	.irq_enable	= plic_irq_enable,
+	.irq_disable	= plic_irq_disable,
 	.irq_ack	= plic_irq_eoi,
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
@@ -184,6 +192,8 @@ static struct irq_chip plic_edge_chip = {
 
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
+	.irq_enable	= plic_irq_enable,
+	.irq_disable	= plic_irq_disable,
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
 	.irq_eoi	= plic_irq_eoi,
@@ -431,8 +441,11 @@ static int __init __plic_init(struct device_node *node,
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 done:
-		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
+		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
+			writel(1, priv->regs + PRIORITY_BASE +
+				  hwirq * PRIORITY_PER_ID);
+		}
 		nr_handlers++;
 	}
 
-- 
2.34.1


