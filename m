Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E149DC4829D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:28:15 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20166.1707222484157462118
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:28:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="196960631"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 21:28:11 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 388934005E16;
	Tue,  6 Feb 2024 21:28:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 17/44] irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
Date: Tue,  6 Feb 2024 12:27:07 +0000
Message-Id: <20240206122734.13477-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:28:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14801

commit dd46337ca69662b6912bc230d393c4261d126b8f upstream.

The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
edge until the previous completion message has been received and
NCEPLIC100 doesn't support pending interrupt counter, hence losing the
interrupts if not acknowledged in time.

So the workaround for edge-triggered interrupts to be handled correctly
and without losing is that it needs to be acknowledged first and then
handler must be run so that we don't miss on the next edge-triggered
interrupt.

This patch adds a new compatible string for NCEPLIC100 (from Andes
Technology) interrupt controller found on Renesas RZ/Five SoC and adds
quirk bits to priv structure and implements PLIC_QUIRK_EDGE_INTERRUPT
quirk to change the interrupt flow.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220630100241.35233-3-samuel@sholland.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/irqchip/irq-sifive-plic.c | 78 +++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 3a8a795000bf4..c42d90543a018 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -60,10 +60,13 @@
 #define	PLIC_DISABLE_THRESHOLD		0x7
 #define	PLIC_ENABLE_THRESHOLD		0
 
+#define PLIC_QUIRK_EDGE_INTERRUPT	0
+
 struct plic_priv {
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
+	unsigned long plic_quirks;
 };
 
 struct plic_handler {
@@ -81,6 +84,8 @@ static int plic_parent_irq;
 static bool plic_cpuhp_setup_done;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
+static int plic_irq_set_type(struct irq_data *d, unsigned int type);
+
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
 	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
@@ -176,6 +181,17 @@ static void plic_irq_eoi(struct irq_data *d)
 	}
 }
 
+static struct irq_chip plic_edge_chip = {
+	.name		= "SiFive PLIC",
+	.irq_ack	= plic_irq_eoi,
+	.irq_mask	= plic_irq_mask,
+	.irq_unmask	= plic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = plic_set_affinity,
+#endif
+	.irq_set_type	= plic_irq_set_type,
+};
+
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
 	.irq_mask	= plic_irq_mask,
@@ -184,8 +200,32 @@ static struct irq_chip plic_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = plic_set_affinity,
 #endif
+	.irq_set_type	= plic_irq_set_type,
 };
 
+static int plic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	if (!test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+		return IRQ_SET_MASK_OK_NOCOPY;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		irq_set_chip_handler_name_locked(d, &plic_edge_chip,
+						 handle_edge_irq, NULL);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_chip_handler_name_locked(d, &plic_chip,
+						 handle_fasteoi_irq, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IRQ_SET_MASK_OK;
+}
+
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
@@ -198,6 +238,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int plic_irq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	struct plic_priv *priv = d->host_data;
+
+	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
+
+	return irq_domain_translate_onecell(d, fwspec, hwirq, type);
+}
+
 static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				 unsigned int nr_irqs, void *arg)
 {
@@ -206,7 +259,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type;
 	struct irq_fwspec *fwspec = arg;
 
-	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -220,7 +273,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops plic_irqdomain_ops = {
-	.translate	= irq_domain_translate_onecell,
+	.translate	= plic_irq_domain_translate,
 	.alloc		= plic_irq_domain_alloc,
 	.free		= irq_domain_free_irqs_top,
 };
@@ -283,8 +336,9 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init plic_init(struct device_node *node,
-		struct device_node *parent)
+static int __init __plic_init(struct device_node *node,
+			      struct device_node *parent,
+			      unsigned long plic_quirks)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
@@ -295,6 +349,8 @@ static int __init plic_init(struct device_node *node,
 	if (!priv)
 		return -ENOMEM;
 
+	priv->plic_quirks = plic_quirks;
+
 	priv->regs = of_iomap(node, 0);
 	if (WARN_ON(!priv->regs)) {
 		error = -EIO;
@@ -412,6 +468,20 @@ static int __init plic_init(struct device_node *node,
 	return error;
 }
 
+static int __init plic_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	return __plic_init(node, parent, 0);
+}
+
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
 IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
+
+static int __init plic_edge_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
+}
+
+IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
-- 
2.34.1


