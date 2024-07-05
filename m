Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20CDC38150
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 12:52:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.16471.1720183957853784969
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 05:52:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="210416233"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jul 2024 21:52:43 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ABF0244CC61C;
	Fri,  5 Jul 2024 21:52:41 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/10] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
Date: Fri,  5 Jul 2024 13:52:25 +0100
Message-Id: <20240705125230.125392-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 12:52:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16400

commit d011c022efe275791897668aa421e2db9f2e6450 upstream.

The IX45 block has additional mask registers (NMSK/IMSK/TMSK) compared
to the RZ/G2L (family) SoC.

A new rzfive_irqc_chip irq_chip is introduced for RZ/Five, where function
pointers for irq_[un]mask() and irq_[dis|en]able() handle the ([un]masking
of the interrupts. The irq_chip pointer is now passed as an init callback
and stored in the priv pointer to differentiate between RZ/G2L and RZ/Five.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240604173710.534132-3-prabhakar.mahadev-lad.rj@bp.renesas.com
[PL: Dropped const qualifier for irqchip]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 148 +++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index b2a830ed90ff7..c7f342a2c5dc3 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -38,6 +38,8 @@
 #define TSSEL_SHIFT(n)			(8 * (n))
 #define TSSEL_MASK			GENMASK(7, 0)
 #define IRQ_MASK			0x3
+#define IMSK				0x10010
+#define TMSK				0x10020
 
 #define TSSR_OFFSET(n)			((n) % 4)
 #define TSSR_INDEX(n)			((n) / 4)
@@ -70,12 +72,14 @@ struct rzg2l_irqc_reg_cache {
 /**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
+ * @irqchip:	Pointer to struct irq_chip
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  * @cache:	Registers cache for suspend/resume
  */
 static struct rzg2l_irqc_priv {
 	void __iomem			*base;
+	struct irq_chip			*irqchip;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
 	raw_spinlock_t			lock;
 	struct rzg2l_irqc_reg_cache	cache;
@@ -139,6 +143,111 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	irq_chip_eoi_parent(d);
 }
 
+static void rzfive_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					   unsigned int hwirq)
+{
+	u32 bit = BIT(hwirq - IRQC_IRQ_START);
+
+	writel_relaxed(readl_relaxed(priv->base + IMSK) | bit, priv->base + IMSK);
+}
+
+static void rzfive_irqc_unmask_irq_interrupt(struct rzg2l_irqc_priv *priv,
+					     unsigned int hwirq)
+{
+	u32 bit = BIT(hwirq - IRQC_IRQ_START);
+
+	writel_relaxed(readl_relaxed(priv->base + IMSK) & ~bit, priv->base + IMSK);
+}
+
+static void rzfive_irqc_mask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					    unsigned int hwirq)
+{
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
+
+	writel_relaxed(readl_relaxed(priv->base + TMSK) | bit, priv->base + TMSK);
+}
+
+static void rzfive_irqc_unmask_tint_interrupt(struct rzg2l_irqc_priv *priv,
+					      unsigned int hwirq)
+{
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
+
+	writel_relaxed(readl_relaxed(priv->base + TMSK) & ~bit, priv->base + TMSK);
+}
+
+static void rzfive_irqc_mask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	raw_spin_lock(&priv->lock);
+	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+		rzfive_irqc_mask_irq_interrupt(priv, hwirq);
+	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzfive_irqc_mask_tint_interrupt(priv, hwirq);
+	raw_spin_unlock(&priv->lock);
+	irq_chip_mask_parent(d);
+}
+
+static void rzfive_irqc_unmask(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	raw_spin_lock(&priv->lock);
+	if (hwirq >= IRQC_IRQ_START && hwirq <= IRQC_IRQ_COUNT)
+		rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
+	else if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ)
+		rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
+	raw_spin_unlock(&priv->lock);
+	irq_chip_unmask_parent(d);
+}
+
+static void rzfive_tint_irq_endisable(struct irq_data *d, bool enable)
+{
+	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+
+	if (hwirq >= IRQC_TINT_START && hwirq < IRQC_NUM_IRQ) {
+		u32 offset = hwirq - IRQC_TINT_START;
+		u32 tssr_offset = TSSR_OFFSET(offset);
+		u8 tssr_index = TSSR_INDEX(offset);
+		u32 reg;
+
+		raw_spin_lock(&priv->lock);
+		if (enable)
+			rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
+		else
+			rzfive_irqc_mask_tint_interrupt(priv, hwirq);
+		reg = readl_relaxed(priv->base + TSSR(tssr_index));
+		if (enable)
+			reg |= TIEN << TSSEL_SHIFT(tssr_offset);
+		else
+			reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
+		writel_relaxed(reg, priv->base + TSSR(tssr_index));
+		raw_spin_unlock(&priv->lock);
+	} else {
+		raw_spin_lock(&priv->lock);
+		if (enable)
+			rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
+		else
+			rzfive_irqc_mask_irq_interrupt(priv, hwirq);
+		raw_spin_unlock(&priv->lock);
+	}
+}
+
+static void rzfive_irqc_irq_disable(struct irq_data *d)
+{
+	irq_chip_disable_parent(d);
+	rzfive_tint_irq_endisable(d, false);
+}
+
+static void rzfive_irqc_irq_enable(struct irq_data *d)
+{
+	rzfive_tint_irq_endisable(d, true);
+	irq_chip_enable_parent(d);
+}
+
 static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 {
 	unsigned int hw_irq = irqd_to_hwirq(d);
@@ -324,7 +433,7 @@ static struct syscore_ops rzg2l_irqc_syscore_ops = {
 	.resume		= rzg2l_irqc_irq_resume,
 };
 
-static struct irq_chip irqc_chip = {
+static struct irq_chip rzg2l_irqc_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
 	.irq_mask		= irq_chip_mask_parent,
@@ -341,6 +450,23 @@ static struct irq_chip irqc_chip = {
 				  IRQCHIP_SKIP_SET_WAKE,
 };
 
+static struct irq_chip rzfive_irqc_chip = {
+	.name			= "rzfive-irqc",
+	.irq_eoi		= rzg2l_irqc_eoi,
+	.irq_mask		= rzfive_irqc_mask,
+	.irq_unmask		= rzfive_irqc_unmask,
+	.irq_disable		= rzfive_irqc_irq_disable,
+	.irq_enable		= rzfive_irqc_irq_enable,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= rzg2l_irqc_set_type,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
 static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 			    unsigned int nr_irqs, void *arg)
 {
@@ -372,7 +498,7 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (hwirq > (IRQC_NUM_IRQ - 1))
 		return -EINVAL;
 
-	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_chip,
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
 					    (void *)(uintptr_t)tint);
 	if (ret)
 		return ret;
@@ -404,7 +530,8 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 	return 0;
 }
 
-static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
+static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *parent,
+				  struct irq_chip *irq_chip)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct platform_device *pdev;
@@ -425,6 +552,8 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
+	rzg2l_irqc_data->irqchip = irq_chip;
+
 	rzg2l_irqc_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
@@ -475,8 +604,21 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
+static int __init rzg2l_irqc_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_chip);
+}
+
+static int __init rzfive_irqc_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_chip);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
 IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
+IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzfive_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
-- 
2.34.1


