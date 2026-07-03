Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A9C44500
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:05 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89972.1783073284178015187
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PPHgyVGi;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c7902f47so2340085e9.1
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073282; x=1783678082; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nk/xoRw4jdf8hX7dvV4tIsvZu6SH02/o+oRvP6iFZzM=;
        b=PPHgyVGiL2Sggiw1mU77x1E7rtLishYADesPTonXehq9VIj1qps3lA/dg6WRlQnL1L
         jPrhpKIpV/kVJ0xaiR2/MysOEgP6suZboS9ARuxxDeZV5SRzAOab2mqpYuBWGPODjhaO
         aGAgcDlLXZjrpF8sNzfgovRPYJAYtYoPHMdTjrxom2xzPk+yRmGsd+j0aIfLy5aZ70VR
         gP6SE2+hEcDcpJw1leheWqTdTyD2+gFnE6RBtljjd1RfE5MPgVVj4yQMnbuDTBT3eINb
         rQKLm1wJA1A2vPgrkWLLkSepLAAaHpRR+5SyK9Ahl065h6ZRHh5gt+Xj31kvAsvKR5TM
         1wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073282; x=1783678082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nk/xoRw4jdf8hX7dvV4tIsvZu6SH02/o+oRvP6iFZzM=;
        b=Cq9vPBWBroqTpXN9RcEBdUp4+1ECxdAlyW5ISR1LFzY1TlZf7UBLMpqVoT5CdSSTQb
         xe1FK/5dRnrFNKvZCASDr4Nu7NaLh8la35OfSO08h4MSMh/4eXb5ppTjo7VzXeHUi8kN
         4em757SEWtjo4mkD+aBKGf0I41Fyif0xZlLaTHoNfDncqNKNQ8AuIRPIhlYAYFvRIfAC
         dQ0cS8MgtrWWQJB6K5KZCKoeNH0a250MwXjXaC1KxT0lhpU8qZRVSMd1tTqMWvK/A6bS
         YzQKq2Q4E+RoVNENIxo369HHgqMS4AdDQJzLS0gEqbRUSP4z0+SMRXhn+JRMt4Du0Rw1
         sBpw==
X-Gm-Message-State: AOJu0Yzlb0TCUIq32XezgrdepCjd3o4xVZ7/AM7e6Om0H2t46qTUsR1r
	W8hc3Y9dz00fmhVedMkEdgeW0bJpvsGi8FoKJyBGy/t+mvMiQfmn4nBsIUj825N3
X-Gm-Gg: AfdE7clyOYnAWw8rUX3bQG8ryEgvW5tjouLvkAAl0sFNV+QarMJTB67ww1EtgtjbKfP
	Y6L/HCUsmux7EhV0Ikapx3G9X3ILbHXxiQ5hkU135+kdAGLDg7rlZi4978rr6GQrOVLhstcKkIW
	B/KhGTPU/sWKB2Zfx1mYnYP+GVRj6Jhfb7W+leRNvHehrbZTkOfex5QN3g9oJ8n75EmYv7rUDgZ
	YjwfEMBjZvfHUldIOAQT57mSkQ5e1oBWids/sA1X1YNjkUu5QRC4segEOlVD9f+7y/oy6VJ3sBa
	YGX6dzV7IZFYYF9wcxC6mV0E4vVmJL/fhKj9uaLvRGAVSplF9qSWDYzP5DMGtKpX/yuJZqYdh+X
	6vI9oAaECJwP1nQXiiqqZMHEXIAkwnHJ8nYsCP3BBtDtBfgWXrlAufdCyuC3csD2kR3Qw+3Dxuw
	Ndrb/WqUNe7ocfDNfgbu+4
X-Received: by 2002:a05:600c:1988:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-493c84c2bf1mr61504725e9.29.1783073282167;
        Fri, 03 Jul 2026 03:08:02 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/26] irqchip/renesas-rzg2l: Replace single irq_chip with per-region irq_chip instances
Date: Fri,  3 Jul 2026 11:07:29 +0100
Message-ID: <20260703100756.238233-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23402

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4b11d14cac6ae198ea855b871c73dc208a177a0e ]

The driver uses a single irq_chip instance shared across all interrupt
types, relying on dispatcher callbacks to differentiate between IRQ and
TINT regions at runtime.

Replace the per-SoC irq_chip and its dispatcher callbacks with dedicated
irq_chip instances for each interrupt region: IRQ and TINT. Subsequent
patches will add per-region callbacks for IRQ and TINT from the common
code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-6-biju.das.jz@bp.renesas.com
[Biju: Retained rzg2l_irqc_common_init() ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 61 ++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 122d744afdf9..4a4b6624ecb6 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -72,14 +72,16 @@ struct rzg2l_irqc_reg_cache {
 /**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
- * @irqchip:	Pointer to struct irq_chip
+ * @irq_chip:	Pointer to struct irq_chip for irq
+ * @tint_chip:	Pointer to struct irq_chip for tint
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  * @cache:	Registers cache for suspend/resume
  */
 static struct rzg2l_irqc_priv {
 	void __iomem			*base;
-	const struct irq_chip		*irqchip;
+	const struct irq_chip		*irq_chip;
+	const struct irq_chip		*tint_chip;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
 	raw_spinlock_t			lock;
 	struct rzg2l_irqc_reg_cache	cache;
@@ -431,7 +433,7 @@ static struct syscore_ops rzg2l_irqc_syscore_ops = {
 	.resume		= rzg2l_irqc_irq_resume,
 };
 
-static const struct irq_chip rzg2l_irqc_chip = {
+static const struct irq_chip rzg2l_irqc_irq_chip = {
 	.name			= "rzg2l-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
 	.irq_mask		= irq_chip_mask_parent,
@@ -448,7 +450,41 @@ static const struct irq_chip rzg2l_irqc_chip = {
 				  IRQCHIP_SKIP_SET_WAKE,
 };
 
-static const struct irq_chip rzfive_irqc_chip = {
+static const struct irq_chip rzg2l_irqc_tint_chip = {
+	.name			= "rzg2l-irqc",
+	.irq_eoi		= rzg2l_irqc_eoi,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_disable		= rzg2l_irqc_irq_disable,
+	.irq_enable		= rzg2l_irqc_irq_enable,
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
+static const struct irq_chip rzfive_irqc_irq_chip = {
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
+static const struct irq_chip rzfive_irqc_tint_chip = {
 	.name			= "rzfive-irqc",
 	.irq_eoi		= rzg2l_irqc_eoi,
 	.irq_mask		= rzfive_irqc_mask,
@@ -469,6 +505,7 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 			    unsigned int nr_irqs, void *arg)
 {
 	struct rzg2l_irqc_priv *priv = domain->host_data;
+	const struct irq_chip *chip;
 	unsigned long tint = 0;
 	irq_hw_number_t hwirq;
 	unsigned int type;
@@ -488,13 +525,15 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 	if (hwirq > IRQC_IRQ_COUNT) {
 		tint = TINT_EXTRACT_GPIOINT(hwirq);
 		hwirq = TINT_EXTRACT_HWIRQ(hwirq);
+		chip = priv->tint_chip;
+	} else {
+		chip = priv->irq_chip;
 	}
 
 	if (hwirq > (IRQC_NUM_IRQ - 1))
 		return -EINVAL;
 
-	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
-					    (void *)(uintptr_t)tint);
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, chip, (void *)(uintptr_t)tint);
 	if (ret)
 		return ret;
 
@@ -526,7 +565,8 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 }
 
 static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *parent,
-				  const struct irq_chip *irq_chip)
+				  const struct irq_chip *irq_chip,
+				  const struct irq_chip *tint_chip)
 {
 	struct platform_device *pdev = of_find_device_by_node(node);
 	struct device *dev __free(put_device) = pdev ? &pdev->dev : NULL;
@@ -545,7 +585,8 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
-	rzg2l_irqc_data->irqchip = irq_chip;
+	rzg2l_irqc_data->irq_chip = irq_chip;
+	rzg2l_irqc_data->tint_chip = tint_chip;
 
 	rzg2l_irqc_data->base = devm_of_iomap(dev, dev->of_node, 0, NULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
@@ -597,12 +638,12 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 {
-	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_chip);
+	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_irq_chip, &rzg2l_irqc_tint_chip);
 }
 
 static int rzfive_irqc_init(struct device_node *node, struct device_node *parent)
 {
-	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_chip);
+	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_irq_chip, &rzfive_irqc_tint_chip);
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
-- 
2.43.0


