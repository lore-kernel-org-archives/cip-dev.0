Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC03C44509
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89141.1783073288191808230
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ISN/n/KV;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bab44440so2307155e9.0
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073286; x=1783678086; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5bo5SUdctJKU5N3N4d+2S4XjFNPgkbIrWeGyeSqiKU=;
        b=ISN/n/KV+We0l/CyOPk8hZQNXWJMNqJMEY3oYrbs5z3Pn4GRpkz+2KdWLwoKzo/AHK
         A3hNxlF+NfeHUCc+UtqGiKoDYbuAO7KGqKWlGxioMypiukzSS1b+7OqAz4sAZT8CXbQf
         wm2kbwgA2PRNcsxPI8ASklpyPWhLfieWBDFLNYknyl93gHRetYpZ22js4TeUQCmR01kV
         HeVHrE23myvsnkiq7Z43cgtS23q317fR2zaYwj9ssIlGHMX6lbhdu2O4//zmgZ3aVp4w
         twAEl4J1WpxFw5YsQpPinMQWHPTIG8w5l+b784z07Sfqe1mnDO34uUTSXU/YCyOhr3Sg
         T44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073286; x=1783678086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5bo5SUdctJKU5N3N4d+2S4XjFNPgkbIrWeGyeSqiKU=;
        b=hfORishOKpApri6Dn+F7RBMUgJlGKKF7TJWH7+Fc40XpogyGKI97QAduxtQFhA493z
         pceCbWYLufzwgJEOm6Q4GtzcU8f/ogio5uLobNVjsH0Fbyby01m2QQ1a/lAYPSvuGTCo
         tO+qpfCupMmD+kkPimDOfPDGoMe3jILznumGHzQgpwaB7TqPVAgRqwbjQZGtEyycw9GJ
         xGsCCLepfq7WGdsse6OCEKtW5CMAuJVSNzMnmFK/tJ7eP20kvpA9yYawjYxwi16LdFSa
         hra/CZO9F0DYjArM2gq5u3Fo0RvAhR4bR5c0hLgulK/9IB62sssGjgXNydD+ysCp3XFU
         POPg==
X-Gm-Message-State: AOJu0YwmX9TLCOVM6ttO/c6j4jnjQ8kidOHXtVpIrfliuMCWJHn/5wMY
	t7soi+HU7488TKJQO2Wl54xpQKW5H2oMuS/jH6Bg2M3Bf4eHw4jj9LStMSVhvRA8
X-Gm-Gg: AfdE7ck1tIpDWyOl90du9C6JjCwG48oDyOE/FLIKQhss9IB66EfK/lO/EJ0FmRvSHg7
	/UvJtRHqwKyuLY0PROjY0qMCy5OWxiJ0+rrBELWzey5NVT2de5S4gE3rpPKXM2SUcledKGy302R
	gKFr6LWVYoK7MNphFdTXeUKMGwQr0pdmoOIcEPnvCHu6gjOEi9cQ9o10vDG3rdYNsVrmsi0daeW
	5Ntx2N1A1nLbOj00bUcwQukzbXZeurgKAhMRgsMHKrtQebJp/ZxBirYcGGmVAN6o7kprJHWN/jz
	n9nQTTW1LYrlFwqE7eHcLRMAdJ4SkvTeZ4mzQBrxeH+L5qkh9nxvZXJ1hwhBT6m24CxzwpelJNX
	v4nEsouD3MYg1EIQNsYROlU/zhVYYqT10LbYvuxlIgj0MsmasQQ55yU7PPD1SLHu/RO/Or7xiTw
	m09Doavpqy2/ra8Yphfzsf
X-Received: by 2002:a05:600c:8189:b0:493:bc4a:a14d with SMTP id 5b1f17b1804b1-493ca6d6347mr33944935e9.19.1783073286269;
        Fri, 03 Jul 2026 03:08:06 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:06 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/26] irqchip/renesas-rzg2l: Drop IRQC_NUM_IRQ macro
Date: Fri,  3 Jul 2026 11:07:36 +0100
Message-ID: <20260703100756.238233-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23409

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 2f814778950ecc99ca5e71472b626dddb2d2b756 ]

The total number of interrupts in RZ/G2L and RZ/G3L SoC are different.
Introduce struct rzg2l_hw_info to handle the hardware differences and
replace the macro IRQC_NUM_IRQ with num_irq variable in struct
rzg2l_hw_info.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-13-biju.das.jz@bp.renesas.com
[ Biju: Adapated struct rzg2l_hw_info for 6.12.y-cip ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 34 ++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 42a13ee0a50b..87ee70235b69 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -25,7 +25,6 @@
 #define IRQC_IRQ_COUNT			8
 #define IRQC_TINT_START			(IRQC_IRQ_START + IRQC_IRQ_COUNT)
 #define IRQC_TINT_COUNT			32
-#define IRQC_NUM_IRQ			(IRQC_TINT_START + IRQC_TINT_COUNT)
 
 #define ISCR				0x10
 #define IITSR				0x14
@@ -69,6 +68,14 @@ struct rzg2l_irqc_reg_cache {
 	u32	titsr[2];
 };
 
+/**
+ * struct rzg2l_hw_info - Interrupt Control Unit controller hardware info structure.
+ * @num_irq:		Total Number of interrupts
+ */
+struct rzg2l_hw_info {
+	unsigned int	num_irq;
+};
+
 /**
  * struct rzg2l_irqc_priv - IRQ controller private data structure
  * @base:	Controller's base address
@@ -76,6 +83,7 @@ struct rzg2l_irqc_reg_cache {
  * @tint_chip:	Pointer to struct irq_chip for tint
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
+ * @info:	Hardware specific data
  * @cache:	Registers cache for suspend/resume
  */
 static struct rzg2l_irqc_priv {
@@ -84,6 +92,7 @@ static struct rzg2l_irqc_priv {
 	const struct irq_chip		*tint_chip;
 	struct irq_fwspec		*fwspec;
 	raw_spinlock_t			lock;
+	struct rzg2l_hw_info		info;
 	struct rzg2l_irqc_reg_cache	cache;
 } *rzg2l_irqc_data;
 
@@ -568,7 +577,7 @@ static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
 		chip = priv->irq_chip;
 	}
 
-	if (hwirq > (IRQC_NUM_IRQ - 1))
+	if (hwirq >= priv->info.num_irq)
 		return -EINVAL;
 
 	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, chip, (void *)(uintptr_t)tint);
@@ -591,7 +600,7 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 	unsigned int i;
 	int ret;
 
-	for (i = 0; i < IRQC_NUM_IRQ; i++) {
+	for (i = 0; i < priv->info.num_irq; i++) {
 		ret = of_irq_parse_one(np, i, &map);
 		if (ret)
 			return ret;
@@ -604,7 +613,8 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
 
 static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *parent,
 				  const struct irq_chip *irq_chip,
-				  const struct irq_chip *tint_chip)
+				  const struct irq_chip *tint_chip,
+				  const struct rzg2l_hw_info info)
 {
 	struct platform_device *pdev = of_find_device_by_node(node);
 	struct device *dev __free(put_device) = pdev ? &pdev->dev : NULL;
@@ -630,7 +640,9 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
 
-	rzg2l_irqc_data->fwspec = devm_kcalloc(&pdev->dev, IRQC_NUM_IRQ,
+	rzg2l_irqc_data->info = info;
+
+	rzg2l_irqc_data->fwspec = devm_kcalloc(&pdev->dev, info.num_irq,
 					       sizeof(*rzg2l_irqc_data->fwspec), GFP_KERNEL);
 	if (!rzg2l_irqc_data->fwspec)
 		return -ENOMEM;
@@ -655,7 +667,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
 
-	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
+	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, info.num_irq,
 					      node, &rzg2l_irqc_domain_ops,
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
@@ -679,14 +691,20 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	return 0;
 }
 
+static const struct rzg2l_hw_info rzg2l_hw_params = {
+	.num_irq	= IRQC_IRQ_START + IRQC_IRQ_COUNT + IRQC_TINT_COUNT,
+};
+
 static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 {
-	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_irq_chip, &rzg2l_irqc_tint_chip);
+	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_irq_chip, &rzg2l_irqc_tint_chip,
+				      rzg2l_hw_params);
 }
 
 static int rzfive_irqc_init(struct device_node *node, struct device_node *parent)
 {
-	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_irq_chip, &rzfive_irqc_tint_chip);
+	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_irq_chip, &rzfive_irqc_tint_chip,
+				      rzg2l_hw_params);
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
-- 
2.43.0


