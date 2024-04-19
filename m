Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C87C41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:48 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.15317.1713514724887666043
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fiCdOBn/;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5568bef315so312505766b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514723; x=1714119523; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsk2O0phvjbEZspd3XQuGgqDn9SdeqDV3GczTLp/M1g=;
        b=fiCdOBn/+JVGdanqBcCym4ktmhpS5FUJ66bJVDqu13uf6yQOtbcN2SxxdK23mRLUpm
         5VQBONzmMFrZfL984JO5tgCoOab1LL8LTNk6xdj+Mi2gulehPsxOlSAfcWmA6GHxN4L4
         YfjIbuCPpfRcIg3uI1vIZ3i53TECPrY5gJ0x9vbLLfpeb7Oe2FsyCosEGgS+gXclibA6
         F5PhxCYiFEVTJsBK8j1V1cKGGu9nKuL2XwRRVFXqQmPS51IFFX0/wOGdhw5NCsXBQh+i
         Hnm8KW6qhc0ACLtalrQVj8aILlMa1WxruJfv61ncUsgMsXW6UVaf4MoXytu6BpHGUWpp
         PFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514723; x=1714119523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsk2O0phvjbEZspd3XQuGgqDn9SdeqDV3GczTLp/M1g=;
        b=vTFZPie1G/qBWcgPRXcnkg2iB1jqo6cOextnMwes7XdPxVDDf55/0Ojr2++1TVRabX
         +cf6Pc2T83GWmlA9HcKvDvm51gjKW9asjQVysvIdkeHv6ZjhB9dxAtw37HoojSMVCr19
         y7fHVIZeW/MB2In48dQQiCpuKdwJW4xgGJcUCnXZdOdKeciCnOe/ZYoEgCb5YKPNyM9w
         R7BlmEcQ+QoDjWxKF3nl71Mn+VQNjmFLThiYDKEAc45QMkslKbYkwlCm71jJXt1u2EBu
         BraGDrhRzTtymZfX4d13c8WIYmuHkPhTGIFR+d3x0IxHj0iSrb3aNrITnPkDzABHCF6E
         0Kgw==
X-Gm-Message-State: AOJu0YwbgbfkFY/obPixQyZJxpGg6q99dwg/V3c5BGj+Ktpi5ggIz/z+
	ZFISmNO72+z0xIXaTHgJfv110ML9nbFsf504442Tl061klkxfrPO/atjNDWZUEI=
X-Google-Smtp-Source: AGHT+IHn9+KGOurjv7EpHbWV9yNCm6GB78kMrLwoOLzqVnGKaC6PeZgZNlKkYrtl1uTDQImD4Ukxrw==
X-Received: by 2002:a17:906:46d6:b0:a52:613d:b5 with SMTP id k22-20020a17090646d600b00a52613d00b5mr1603670ejs.13.1713514723207;
        Fri, 19 Apr 2024 01:18:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 39/53] pinctrl: renesas: rzg2l: Add RZ/G3S support
Date: Fri, 19 Apr 2024 11:17:28 +0300
Message-Id: <20240419081742.3496709-40-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15626

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
index a3f6f2507e7c..a3f31065c4bc 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -54,13 +54,19 @@
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
@@ -1310,6 +1316,36 @@ static const u32 r9a07g043_gpio_configs[] = {
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
@@ -1396,6 +1432,46 @@ static const struct {
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
@@ -1759,6 +1835,9 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT >
 		     ARRAY_SIZE(rzg2l_gpio_names));
 
+	BUILD_BUG_ON(ARRAY_SIZE(r9a08g045_gpio_configs) * RZG2L_PINS_PER_PORT >
+		     ARRAY_SIZE(rzg2l_gpio_names));
+
 	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
@@ -1804,6 +1883,35 @@ static const struct rzg2l_hwcfg rzg2l_hwcfg = {
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
@@ -1825,6 +1933,16 @@ static struct rzg2l_pinctrl_data r9a07g044_data = {
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
@@ -1834,6 +1952,10 @@ static const struct of_device_id rzg2l_pinctrl_of_table[] = {
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


