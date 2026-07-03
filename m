Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5D4C44503
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 10:08:17 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.89979.1783073291192286316
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jul 2026 03:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YKflYjh0;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493b77b150aso2965415e9.2
        for <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 03:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783073289; x=1783678089; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NKMoa4hUREQAeYIUgM4mEMzJN9A8bHUtcBKwoBV2Nrk=;
        b=YKflYjh02Ws4WwLZZD/5u5eJdjwfFqij8Ke85UQomQ47a3j9rBrMbPQ6UFAA1XcBUq
         hDUadW3T6WM79vGD7tbjs9Gf0MOt5H08XXnbn/SBUCFbOB6wDXC4sbyD2TU4Tw7TEKFd
         gCztokbRsMjqHsBZbL1MGe2q+GzBImKGyu2KW+/QXLxdkznPInDFm9PtMykC1vhHRsKH
         +W7zLiIxcJU/iuKLmI2KhWfsNul9vorWEME5BbnXc/oJWwaevlNsSPEm0oTOlTRrB/i4
         ahlf7Pv/V3yX+MXinTpKAeUue0feHrfXoGN/hd2WXfbhsb4TtQYkpYsnIZbAE4xKafiV
         rNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073289; x=1783678089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NKMoa4hUREQAeYIUgM4mEMzJN9A8bHUtcBKwoBV2Nrk=;
        b=PWTUe//GfgTkqeqCUa4UfgPT2O+TM+cu0VsnZAKqmKa2g2rz3x1KX8/8Mb9dbmxNPn
         Y6BK4RZe9w86+r/J0ACsQ30yREeyPVJTpyiUJpXXcmMGA9yII/KmjqyD5EU7FUgE9MGO
         XKXSi6bH6Hoe82g5mA38Cpr1GJb1sNbsYD2WUYBZVh32dgh5GlepTb8cEIxsbxuI3643
         09HrAWpxEx41GyIDfetD3+QhQ3LIFbAunpQQzbFI5obrIpjXpldyHcD08D6WT5JPiHW8
         8AV/T+mKKE8LU9zfkKetigKuL4RF1Xh27oxaulynRmvRsVXCRrRwYvjff4wFXQALHZCC
         c6Ag==
X-Gm-Message-State: AOJu0YwvpJ416rR2oIKHalhK4AQxweYtRW3q6BCGXjn9+w9kJToe9qEj
	edLDSeGgGers8Fx6dRcza5vZV6KzcUIddgQLXcCii1Nlm4Tid5Hb56cmvyrooobL
X-Gm-Gg: AfdE7ckavjG+r/DZn2L9TmIQJPzf8b4/QIBSc6YO9UsNyfodYbHe+laqMYH6siMO9oV
	TAyKrL4Z4Xy8/ZgJE90mYsGQTcETe/8CDwgYaNNV37BG9Es15VL882zLMPZuopkY/5gzGUPteMm
	ESSe58QILQBJ+3+jfl8AbFGe9/2TVlkaPJNlZvSZ/1TwXOzuoZnMTfbTkK4Xtdl3F0JXemnIGi/
	/2N/QO9PLCzpyYnvT1jFpzmpKZowYqYbPQQPIoobEKvBybQz3Kjm/nNOF7+lx2Hryx3NCONlKPz
	2IF283AFF7NbWaqnZBYSR7PfLyy/An1xCKrcJxcfQqSDb9xyD1EmfifsPqkUWsurELNDBOfJWXN
	KYmc3NpgoL4IXUnEII9MVkjNLYanUx/iEO1FGHYo8vpY6WtaKR8uYRTnsQlZq/SZfZKDbND1gHk
	S8SSmSGm93j+VvhkMDKI9i
X-Received: by 2002:a05:600d:2:b0:492:3e69:a86f with SMTP id 5b1f17b1804b1-493c3cd0fb3mr140136105e9.1.1783073289107;
        Fri, 03 Jul 2026 03:08:09 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:76eb:405a:5f87:72eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccdab3a8sm40993765e9.6.2026.07.03.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:08:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 22/26] irqchip/renesas-rzg2l: Add RZ/G3L support
Date: Fri,  3 Jul 2026 11:07:41 +0100
Message-ID: <20260703100756.238233-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
References: <20260703100756.238233-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jul 2026 10:08:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23414

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 98b24d39c852d2498aae24c9aa0a3b11edb8cc2c ]

The IRQC block on the RZ/G3L SoC is almost identical to the one found on
the RZ/G2L SoC, with the following differences:

 - The number of GPIO interrupts for TINT selection is 113 instead of 123.
 - The pin index and TINT selection index are not in the 1:1 map.
 - The number of external interrupts are 16 instead of 8, out of these
   8 external interrupts are shared with TINT.

Add support for the RZ/G3L driver by filling the rzg2l_hw_info table and
adding LUT for mapping between pin index and TINT selection index.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260325192451.172562-16-biju.das.jz@bp.renesas.com
[biju: Replaced rzg3l_irqc_probe()->rzg3l_irqc_init() ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 48 +++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 86e79f1484c2..0dd3ce30f7ad 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -68,11 +68,13 @@ struct rzg2l_irqc_reg_cache {
 
 /**
  * struct rzg2l_hw_info - Interrupt Control Unit controller hardware info structure.
+ * @tssel_lut:		TINT lookup table
  * @irq_count:		Number of IRQC interrupts
  * @tint_start:		Start of TINT interrupts
  * @num_irq:		Total Number of interrupts
  */
 struct rzg2l_hw_info {
+	const u8	*tssel_lut;
 	unsigned int	irq_count;
 	unsigned int	tint_start;
 	unsigned int	num_irq;
@@ -332,9 +334,9 @@ static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
-	u32 iitseln = hwirq - IRQC_IRQ_START;
+	unsigned int iitseln = hwirq - IRQC_IRQ_START;
 	bool clear_irq_int = false;
-	u16 sense, tmp;
+	unsigned int sense, tmp;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_LEVEL_LOW:
@@ -378,6 +380,11 @@ static u32 rzg2l_disable_tint_and_set_tint_source(struct irq_data *d, struct rzg
 	u32 tint = (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
 	u32 tien = reg & (TIEN << TSSEL_SHIFT(tssr_offset));
 
+	if (priv->info.tssel_lut)
+		tint = priv->info.tssel_lut[tint];
+	else
+		tint = (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+
 	/* Clear the relevant byte in reg */
 	reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
 	/* Set TINT and leave TIEN clear */
@@ -693,6 +700,36 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	return 0;
 }
 
+/* Mapping based on port index on Table 4.2-1 and GPIOINT on Table 4.6-7 */
+static const u8 rzg3l_tssel_lut[] = {
+	 83,  84,					/* P20-P21 */
+	  7,   8,   9,  10,  11,  12,  13,		/* P30-P36 */
+	 85,  86,  87,  88,  89,  90,  91,		/* P50-P56 */
+	 92,  93,  94,  95,  96,  97,  98,		/* P60-P66 */
+	 99, 100, 101, 102, 103, 104, 105, 106,		/* P70-P77 */
+	107, 108, 109, 110, 111, 112,			/* P80-P85 */
+	 45,  46,  47,  48,  49,  50,  51,  52,		/* PA0-PA7 */
+	 53,  54,  55,  56,  57,  58,  59,  60,		/* PB0-PB7 */
+	 61,  62,  63,					/* PC0-PC2 */
+	 64,  65,  66,  67,  68,  69,  70,  71,		/* PD0-PD7 */
+	 72,  73,  74,  75,  76,  77,  78,  79,		/* PE0-PE7 */
+	 80,  81,  82,					/* PF0-PF2 */
+	 27,  28,  29,  30,  31,  32,  33,  34,		/* PG0-PG7 */
+	 35,  36,  37,  38,  39,  40,			/* PH0-PH5 */
+	  2,   3,   4,   5,   6,			/* PJ0-PJ4 */
+	 41,  42,  43,  44,				/* PK0-PK3 */
+	 14,  15,  16,  17,  26,			/* PL0-PL4 */
+	 18,  19,  20,  21,  22,  23,  24,  25,		/* PM0-PM7 */
+	  0,   1					/* PS0-PS1 */
+};
+
+static const struct rzg2l_hw_info rzg3l_hw_params = {
+	.tssel_lut	= rzg3l_tssel_lut,
+	.irq_count	= 16,
+	.tint_start	= IRQC_IRQ_START + 16,
+	.num_irq	= IRQC_IRQ_START + 16 + IRQC_TINT_COUNT,
+};
+
 static const struct rzg2l_hw_info rzg2l_hw_params = {
 	.irq_count	= 8,
 	.tint_start	= IRQC_IRQ_START + 8,
@@ -705,6 +742,12 @@ static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
 				      rzg2l_hw_params);
 }
 
+static int rzg3l_irqc_init(struct device_node *node, struct device_node *parent)
+{
+	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_irq_chip, &rzg2l_irqc_tint_chip,
+				      rzg3l_hw_params);
+}
+
 static int rzfive_irqc_init(struct device_node *node, struct device_node *parent)
 {
 	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_irq_chip, &rzfive_irqc_tint_chip,
@@ -713,6 +756,7 @@ static int rzfive_irqc_init(struct device_node *node, struct device_node *parent
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
 IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
+IRQCHIP_MATCH("renesas,r9a08g046-irqc", rzg3l_irqc_init)
 IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzfive_irqc_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
-- 
2.43.0


