Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B11C48298
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:26 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.61484.1707136940412229412
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="196827711"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:24 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6396B4001DDB;
	Mon,  5 Feb 2024 21:42:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 22/48] irqchip/sifive-plic: Make better use of the effective affinity mask
Date: Mon,  5 Feb 2024 12:41:09 +0000
Message-Id: <20240205124135.14779-23-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14691

From: Samuel Holland <samuel@sholland.org>

commit de078949218242d57f791b63fac87cdb09cb0424 upstream.

The PLIC driver already updates the effective affinity mask in its
.irq_set_affinity callback. Take advantage of that information to only
touch bits (and take spinlocks) for the specific relevant hart contexts.

First, make sure the effective affinity mask is set before IRQ startup.

Then, since this mask already takes priv->lmask into account, checking
that mask later is no longer needed (and handler->present is equivalent
to the bit being set in priv->lmask).

Finally, when (un)masking or changing affinity, only clear/set the
enable bits in the specific old/new context(s). The cpumask operations
in plic_irq_unmask() are not needed because they duplicate the code in
plic_set_affinity().

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701202440.59059-2-samuel@sholland.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/irqchip/Kconfig           |  1 +
 drivers/irqchip/irq-sifive-plic.c | 27 +++++++++------------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3c24bf45263c..63c65deb6737 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -529,6 +529,7 @@ config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
 	   This enables support for the PLIC chip found in SiFive (and
 	   potentially other) RISC-V systems.  The PLIC controls devices
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c42d90543a01..364023c776d4 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -114,31 +114,18 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
 
-		if (handler->present &&
-		    cpumask_test_cpu(cpu, &handler->priv->lmask))
-			plic_toggle(handler, d->hwirq, enable);
+		plic_toggle(handler, d->hwirq, enable);
 	}
 }
 
 static void plic_irq_unmask(struct irq_data *d)
 {
-	struct cpumask amask;
-	unsigned int cpu;
-	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
-
-	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
-	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
-					   &amask);
-	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
-		return;
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
 }
 
 static void plic_irq_mask(struct irq_data *d)
 {
-	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
-
-	plic_irq_toggle(&priv->lmask, d, 0);
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
 }
 
 #ifdef CONFIG_SMP
@@ -159,11 +146,13 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
+	plic_irq_mask(d);
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
+	if (!irqd_irq_masked(d))
+		plic_irq_unmask(d);
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 #endif
@@ -190,6 +179,7 @@ static struct irq_chip plic_edge_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
+	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static struct irq_chip plic_chip = {
@@ -201,6 +191,7 @@ static struct irq_chip plic_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
+	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type)
-- 
2.34.1


