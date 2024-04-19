Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD414C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:40 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.18442.1713526770634165599
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ik+z0ogY;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso3195455a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526769; x=1714131569; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CUJHPDD+VyWmL3FTCgxQaK6yP0p0e+1evt3g4EG160=;
        b=ik+z0ogY/3X/BeYM18HLDCnLT8gz0rDNT1uCDwHBbXj81JDpBFyH8O7P2xqGaA0Bk9
         HcREkzdqama9bNe11njxiQ9Feb9MAcjf0nWkrs1QIzbikB/E8D5sV+M8EuL5N4AcgxfR
         vfgpKkVOtjfkm5gB4mB0RSMQ/wzdov0mlpMG5RZQVDWE4mY59htHm++cDhJcHpM4xeWr
         MBdm1CAD1B2BYKs+O613r7SdQrC3ezZGbwCFIYoUGpE2CGEYdlwCQU4ZywyS7S3H/9Vj
         92/mRKE6SF3peq7pTILFkQmNTGdhHfhPoF8vECLpORm/F5Ckb+MRR5ask5o5j3/dHCIM
         V7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526769; x=1714131569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CUJHPDD+VyWmL3FTCgxQaK6yP0p0e+1evt3g4EG160=;
        b=thKc021S44L04qeZk4khzDIpopSP16x1ZThd0Wd+UgEIgnY4pn7U8qS49rPwtqBYmM
         srnFKl0Ydr0ST2BTEVEhdZefsNgUOhy0NH7iT40zapBOM5pjmbux0oGgi7CwhdQn3eJn
         UA7tp8AbS3CPZxHsXYG4/APdcCbpmMykA85INvLmEGRSz16/jIBxLVWKts3KbnFw/ERf
         gfnRx/SYSkcdPo0jgi/UZRSXYoplcyrpa91J5hPvXuHAVcx93Cb2M+zO02gqf/VeUSFs
         8P7Vff8ezo06AsGY8h2p3uEOGlo28uo+hlsdjO6QtIqZJtfXnGImKs8zfEgRuESEa5rZ
         6r0A==
X-Gm-Message-State: AOJu0Yx8xWiyqGwp2XjL7bte/ctp5ppeDncVdwbWohYrQyTMxUttZxH2
	6rRnYRstmImPp8HS/7MuyKuWq7pef2FkLTXm3UAIa/eBnuxqOMJX3ptNTFDH6h4=
X-Google-Smtp-Source: AGHT+IH55hgCEPHar26WJ+0fa0H4MSapKByTgdOTFCmV3nxON2ctq/X6Qsn1Qi9kuAR8PQMl84srYg==
X-Received: by 2002:a50:d703:0:b0:56f:e4a2:1640 with SMTP id t3-20020a50d703000000b0056fe4a21640mr1525372edi.21.1713526769035;
        Fri, 19 Apr 2024 04:39:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 30/44] pinctrl: renesas: rzg2l: Add RZ/G3S support
Date: Fri, 19 Apr 2024 14:38:28 +0300
Message-Id: <20240419113842.3675543-31-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15681

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c6a088e5a03b37a1ee646986b4ef44121715b46e upstream.

Add basic support for RZ/G3S to be able to boot from SD card, have a
running console port, and use GPIOs.  RZ/G3S has 82 general-purpose IO
ports.  Support for the remaining pin functions (e.g. Ethernet, XSPI)
will be added along with controller-specific support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-22-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 126 +++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 4a52cac7a192..777d6c291b33 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -57,13 +57,19 @@
 #define PIN_CFG_IOLH_C			BIT(13)
 #define PIN_CFG_SOFT_PS			BIT(14)
 
-#define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
-					 PIN_CFG_SR | \
+#define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
+					(PIN_CFG_IOLH_##group | \
 					 PIN_CFG_PUPD | \
 					 PIN_CFG_FILONOFF | \
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
 
+#define RZG2L_MPXED_PIN_FUNCS		(RZG2L_MPXED_COMMON_PIN_FUNCS(A) | \
+					 PIN_CFG_SR)
+
+#define RZG3S_MPXED_PIN_FUNCS(group)	(RZG2L_MPXED_COMMON_PIN_FUNCS(group) | \
+					 PIN_CFG_SOFT_PS)
+
 #define RZG2L_MPXED_ETH_PIN_FUNCS(x)	((x) | \
 					 PIN_CFG_FILONOFF | \
 					 PIN_CFG_FILNUM | \
@@ -1313,6 +1319,36 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
+static const u32 r9a08g045_gpio_configs[] = {
+	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
+	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH0)),	/* P1 */
+	RZG2L_GPIO_PORT_PACK(4, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH0)),	/* P2 */
+	RZG2L_GPIO_PORT_PACK(4, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH0)),	/* P3 */
+	RZG2L_GPIO_PORT_PACK(6, 0x33, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH0)),	/* P4 */
+	RZG2L_GPIO_PORT_PACK(5, 0x21, RZG3S_MPXED_PIN_FUNCS(A)),			/* P5  */
+	RZG2L_GPIO_PORT_PACK(5, 0x22, RZG3S_MPXED_PIN_FUNCS(A)),			/* P6  */
+	RZG2L_GPIO_PORT_PACK(5, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH1)),	/* P7 */
+	RZG2L_GPIO_PORT_PACK(5, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH1)),	/* P8 */
+	RZG2L_GPIO_PORT_PACK(4, 0x36, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH1)),	/* P9 */
+	RZG2L_GPIO_PORT_PACK(5, 0x37, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
+								PIN_CFG_IO_VMC_ETH1)),	/* P10 */
+	RZG2L_GPIO_PORT_PACK(4, 0x23, RZG3S_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),		/* P11  */
+	RZG2L_GPIO_PORT_PACK(2, 0x24, RZG3S_MPXED_PIN_FUNCS(B) | PIN_CFG_IEN),		/* P12  */
+	RZG2L_GPIO_PORT_PACK(5, 0x25, RZG3S_MPXED_PIN_FUNCS(A)),			/* P13  */
+	RZG2L_GPIO_PORT_PACK(3, 0x26, RZG3S_MPXED_PIN_FUNCS(A)),			/* P14  */
+	RZG2L_GPIO_PORT_PACK(4, 0x27, RZG3S_MPXED_PIN_FUNCS(A)),			/* P15  */
+	RZG2L_GPIO_PORT_PACK(2, 0x28, RZG3S_MPXED_PIN_FUNCS(A)),			/* P16  */
+	RZG2L_GPIO_PORT_PACK(4, 0x29, RZG3S_MPXED_PIN_FUNCS(A)),			/* P17  */
+	RZG2L_GPIO_PORT_PACK(6, 0x2a, RZG3S_MPXED_PIN_FUNCS(A)),			/* P18 */
+};
+
 static const struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
@@ -1399,6 +1435,46 @@ static const struct {
 	}
 };
 
+static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
+	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x0, 0, (PIN_CFG_FILONOFF | PIN_CFG_FILNUM |
+						PIN_CFG_FILCLKSEL)) },
+	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x1, 0, (PIN_CFG_IOLH_A | PIN_CFG_IEN |
+						      PIN_CFG_SOFT_PS)) },
+	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x1, 1, (PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS)) },
+	{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0x6, 0, PIN_CFG_IOLH_A | PIN_CFG_SOFT_PS) },
+	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x10, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x10, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						     PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x10, 2, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA0", RZG2L_SINGLE_PIN_PACK(0x11, 0, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA1", RZG2L_SINGLE_PIN_PACK(0x11, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA2", RZG2L_SINGLE_PIN_PACK(0x11, 2, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA3", RZG2L_SINGLE_PIN_PACK(0x11, 3, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA4", RZG2L_SINGLE_PIN_PACK(0x11, 4, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA5", RZG2L_SINGLE_PIN_PACK(0x11, 5, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA6", RZG2L_SINGLE_PIN_PACK(0x11, 6, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD0_DATA7", RZG2L_SINGLE_PIN_PACK(0x11, 7, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD0)) },
+	{ "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0x12, 0, (PIN_CFG_IOLH_B | PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0x12, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						     PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_DATA0", RZG2L_SINGLE_PIN_PACK(0x13, 0, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_DATA1", RZG2L_SINGLE_PIN_PACK(0x13, 1, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_DATA2", RZG2L_SINGLE_PIN_PACK(0x13, 2, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD1)) },
+	{ "SD1_DATA3", RZG2L_SINGLE_PIN_PACK(0x13, 3, (PIN_CFG_IOLH_B | PIN_CFG_IEN |
+						       PIN_CFG_IO_VMC_SD1)) },
+};
+
 static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
 {
 	unsigned int gpioint;
@@ -1761,6 +1837,9 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
 
+	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg2l_gpio_names));
+
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -1806,6 +1885,35 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
 	.iolh_groupb_oi = { 100, 66, 50, 33, },
 };
 
+static const struct rzg2l_hwcfg rzg3s_hwcfg = {
+	.regs = {
+		.pwpr = 0x3000,
+		.sd_ch = 0x3004,
+	},
+	.iolh_groupa_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 2200, 4400, 9000, 10000,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 1900, 4000, 8000, 9000,
+	},
+	.iolh_groupb_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 7000, 8000, 9000, 10000,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 4000, 6000, 8000, 9000,
+	},
+	.iolh_groupc_ua = {
+		/* 1v8 power source */
+		[RZG2L_IOLH_IDX_1V8] = 5200, 6000, 6550, 6800,
+		/* 2v5 source */
+		[RZG2L_IOLH_IDX_2V5] = 4700, 5300, 5800, 6100,
+		/* 3v3 power source */
+		[RZG2L_IOLH_IDX_3V3] = 4500, 5200, 5700, 6050,
+	},
+	.drive_strength_ua = true,
+	.func_base = 1,
+};
+
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
@@ -1827,6 +1935,16 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.hwcfg = &rzg2l_hwcfg,
 };
 
+static struct rzg2l_pinctrl_data r9a08g045_data = {
+	.port_pins = rzg2l_gpio_names,
+	.port_pin_configs = r9a08g045_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a08g045_gpio_configs),
+	.dedicated_pins = rzg3s_dedicated_pins,
+	.n_port_pins = ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT,
+	.n_dedicated_pins = ARRAY_SIZE(rzg3s_dedicated_pins),
+	.hwcfg = &rzg3s_hwcfg,
+};
+
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 	{
 		.compatible = "renesas,r9a07g043-pinctrl",
@@ -1836,6 +1954,10 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
 		.compatible = "renesas,r9a07g044-pinctrl",
 		.data = &r9a07g044_data,
 	},
+	{
+		.compatible = "renesas,r9a08g045-pinctrl",
+		.data = &r9a08g045_data,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.39.2


