Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE8C41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:30 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.18434.1713526763163815577
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=qjDCeR4x;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a55692e09c9so108365566b.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526761; x=1714131561; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihHq2K/Eesv6cmEwqNDuJG5KtndtJfZuAfbklCgj5rg=;
        b=qjDCeR4xM4U6CPcWAyFEUVZ+0UIxw0S3nHGdtGL4FrJDNOoj0cdWj08730yCRyB7G7
         Ge1M17blWH6R5/PHpfEoMWBO0Z4dKT09d2ygVq8r8DrOqAKiRKz2Rj3FLK+82UvCJ93b
         pTJrSNAcB4k0r5yJfXGwNfTaJ5OoWm7/+5ojy97neM7QiYaCH0LdWJsOIgZyAbdhqABp
         WLUzH4iKMeC3NWqbJGqPcyHFqUUAUeYaUbvzMV1ccDgwSCKXtMXm6InTZQTXgzfyqjRP
         HDM+bElrZCI/PumR3+LO43XkxxhsKEuq+54e03WzrjtEgdSojkqpxTzW39bs604mf8Qn
         DSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526761; x=1714131561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihHq2K/Eesv6cmEwqNDuJG5KtndtJfZuAfbklCgj5rg=;
        b=XO8Av2iGvGCxruXnXBr7fWv8Xqxlilse2A8AshmWgTY6aFdPklbtrPOSz9v/aOxVNN
         nJzSKyLDhijgZ8rhMIhFuHGfz0Wr2aQvibMCaoEwJ/wUPXBKTlBLGKD7f2OngXgZM/bK
         dvTlDBvBQpfDhcDCYZCfPBVScd3hmPJh06hjRmnAMTnpxIRlvJOWCtEfx6F234cXuRfV
         IDM/vJ8sSqXijSnD2ac2rN+QRJ4zayIAAOK+YDNGcBN4xWmyqdwoaK1LM13LJKhYEi1n
         kyXk9gYs/1BY7L3JhBSkIdNVgt9U6ikGCVXl+gLzkTcG7YnnZ7mycaLdax8cL+uEFVdb
         x1kQ==
X-Gm-Message-State: AOJu0Yzx7pc17heR77D6rOX78F69lAen1+GiZiimAtPFpk1Os8ClgeUJ
	5JwTO+wazi1+CW70El/o6Sx6df6e8UHXGhSiVswnqUFWVMjOd+H4XJtIWzF/urs=
X-Google-Smtp-Source: AGHT+IEyAeirORCyDv55E6AEZquBaVOWHOkyp3Roadwh2glcgXwtcnhRF1PBrNZq8IqFoSKCbMyhwA==
X-Received: by 2002:a50:9e65:0:b0:570:37d:badd with SMTP id z92-20020a509e65000000b00570037dbaddmr1689470ede.28.1713526761581;
        Fri, 19 Apr 2024 04:39:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 25/44] pinctrl: renesas: rzg2l: Adapt for different SD/PWPR register offsets
Date: Fri, 19 Apr 2024 14:38:23 +0300
Message-Id: <20240419113842.3675543-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15676

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1f89aa906fac1d569ecf8f427b1edca6e26fa472 upstream.

SD, PWPR power registers have different offsets b/w RZ/G2L and RZ/G3S.
Add a per SoC configuration data structure that is initialized with the
proper register offsets for individual SoCs.  The rzg2l_hwcfg structure
will be extended further in later commits.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-16-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 52 ++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 789a2f7dd65c..eb7ac2253642 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -97,8 +97,7 @@
 #define IOLH(off)		(0x1000 + (off) * 8)
 #define IEN(off)		(0x1800 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
-#define PWPR			(0x3014)
-#define SD_CH(n)		(0x3000 + (n) * 4)
+#define SD_CH(off, ch)		((off) + (ch) * 4)
 #define QSPI			(0x3008)
 
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
@@ -123,6 +122,24 @@
 #define RZG2L_TINT_IRQ_START_INDEX	9
 #define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
 
+/**
+ * struct rzg2l_register_offsets - specific register offsets
+ * @pwpr: PWPR register offset
+ * @sd_ch: SD_CH register offset
+ */
+struct rzg2l_register_offsets {
+	u16 pwpr;
+	u16 sd_ch;
+};
+
+/**
+ * struct rzg2l_hwcfg - hardware configuration data structure
+ * @regs: hardware specific register offsets
+ */
+struct rzg2l_hwcfg {
+	const struct rzg2l_register_offsets regs;
+};
+
 struct rzg2l_dedicated_configs {
 	const char *name;
 	u32 config;
@@ -135,6 +152,7 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
+	const struct rzg2l_hwcfg *hwcfg;
 };
 
 struct rzg2l_pinctrl {
@@ -162,6 +180,7 @@ static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
+	const struct rzg2l_register_offsets *regs = &pctrl->data->hwcfg->regs;
 	unsigned long flags;
 	u32 reg;
 
@@ -177,8 +196,8 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
 
 	/* Set the PWPR register to allow PFC register to write */
-	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
-	writel(PWPR_PFCWE, pctrl->base + PWPR);  /* B0WI=0, PFCWE=1 */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_PFCWE, pctrl->base + regs->pwpr);	/* B0WI=0, PFCWE=1 */
 
 	/* Select Pin function mode with PFC register */
 	reg = readl(pctrl->base + PFC(off));
@@ -186,8 +205,8 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
 
 	/* Set the PWPR register to be write-protected */
-	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
-	writel(PWPR_B0WI, pctrl->base + PWPR);  /* B0WI=1, PFCWE=0 */
+	writel(0x0, pctrl->base + regs->pwpr);		/* B0WI=0, PFCWE=0 */
+	writel(PWPR_B0WI, pctrl->base + regs->pwpr);	/* B0WI=1, PFCWE=0 */
 
 	/* Switch to Peripheral pin function with PMC register */
 	reg = readb(pctrl->base + PMC(off));
@@ -522,6 +541,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	unsigned int arg = 0;
@@ -557,9 +578,9 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		u32 pwr_reg = 0x0;
 
 		if (cfg & PIN_CFG_IO_VMC_SD0)
-			pwr_reg = SD_CH(0);
+			pwr_reg = SD_CH(regs->sd_ch, 0);
 		else if (cfg & PIN_CFG_IO_VMC_SD1)
-			pwr_reg = SD_CH(1);
+			pwr_reg = SD_CH(regs->sd_ch, 1);
 		else if (cfg & PIN_CFG_IO_VMC_QSPI)
 			pwr_reg = QSPI;
 		else
@@ -611,6 +632,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	enum pin_config_param param;
 	unsigned long flags;
 	void __iomem *addr;
@@ -654,9 +677,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 				return -EINVAL;
 
 			if (cfg & PIN_CFG_IO_VMC_SD0)
-				pwr_reg = SD_CH(0);
+				pwr_reg = SD_CH(regs->sd_ch, 0);
 			else if (cfg & PIN_CFG_IO_VMC_SD1)
-				pwr_reg = SD_CH(1);
+				pwr_reg = SD_CH(regs->sd_ch, 1);
 			else if (cfg & PIN_CFG_IO_VMC_QSPI)
 				pwr_reg = QSPI;
 			else
@@ -1532,6 +1555,13 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_hwcfg rzg2l_hwcfg = {
+	.regs = {
+		.pwpr = 0x3014,
+		.sd_ch = 0x3000,
+	},
+};
+
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
@@ -1539,6 +1569,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
+	.hwcfg = &rzg2l_hwcfg,
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
@@ -1549,6 +1580,7 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.n_port_pins = ARRAY_SIZE(r9a07g044_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
 		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
+	.hwcfg = &rzg2l_hwcfg,
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
-- 
2.39.2


