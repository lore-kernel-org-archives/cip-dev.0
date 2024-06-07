Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121EAC27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:11 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.43043.1717769347135356372
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hAm86Xcn;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b8b638437so2465967e87.3
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769345; x=1718374145; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJy1Az2PNLBPcSoVi+TupvRoGqbtUfH+O+CunED7iSo=;
        b=hAm86XcnvIwUgCkVeVtO0DHqlvPZD6QUhWK8+33nPeuUnVLE+WgURep8pthlL+GhYZ
         eNhG3oFnTXRP8hX453WkNxFPf4v2SvYpsBipo0e1SyLOzxyGcHAJXXR5KZo+7tW4DKO9
         HE8LHbENqII/JNJ2KCA6cgrTMQtKez9R3ioGPexEzhOSjpIUzDOuE4wTSNObasvlvnmo
         pJq5DHlGLrXiT9AqivJ9J4Z61I1lV0N1VRzrX8Tlr57H1YppokZ487K8B48wvJas82pC
         5w9JGZ2TXDHxpHiB0HDrBVAxpHPGCMt4OYyaHx9pQkNUqNoj1BwnOeg7nMtfWv27d8g6
         YtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769345; x=1718374145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJy1Az2PNLBPcSoVi+TupvRoGqbtUfH+O+CunED7iSo=;
        b=wMwyKB7u3rw5azy26H+CU5hfK69Zo9AMTdGCB1VfsnMlm1os4pAxgNPawVLUlX+1Lj
         8nIeIqKOkYdqnJ05UaN8xYXslxCV3MEGx6gEJnSUyxelO8oYz0NX74JvcKaWQTr4GjNg
         B982ogg8LI4iEP1LiSeaFhmQLDfwMo12gUAB79GYBh9yWdHdcRSVN774jVmQm8zDF4si
         USoUPrvjdx2F6GPfhGdZ5XviHJS7l/XbBRW8n5V/ZXe21njWUZpYDJ87/z7EYO1AGAyY
         YPGe7mGYV3gxy2CmXakUdsvYqL9ewSeCpNJXwhiXn1NxJI7McRdJ6nLQ5Qlp3Slt6kVc
         KJgg==
X-Gm-Message-State: AOJu0YyoSEi1+5d/5hqlzaQSM+Z2nR4f4UHZ6dC4ciD2Z7wz8w1NK1I6
	PIWyo6cSFFczHeBTFxw7vBhIPYf8QinwVK4KP5/8OdQgLMZFnpAU7LFyulIYJTE=
X-Google-Smtp-Source: AGHT+IEE9Co+MA5DXozs6LE4pgSBXx52PPQZLKA/yldqdzsyHBXMhq2882ycIfUZ3JhBXZRvdlnq4w==
X-Received: by 2002:a19:f716:0:b0:52b:c0b1:ab9e with SMTP id 2adb3069b0e04-52bc0b1ac39mr786356e87.5.1717769345239;
        Fri, 07 Jun 2024 07:09:05 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 05/17] pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
Date: Fri,  7 Jun 2024 17:08:44 +0300
Message-Id: <20240607140856.2497508-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16166

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fea58424e2523376ece6f734479e63061e17ad7f upstream.

Add the missing port pins P19 to P28 for RZ/Five SoC. These additional
pins provide expanded capabilities and are exclusive to the RZ/Five SoC.

Couple of port pins have different configuration and are not identical for
the complete port so introduce struct rzg2l_variable_pin_cfg to handle
such cases and introduce the PIN_CFG_VARIABLE macro. The actual pin config
is then assigned in rzg2l_pinctrl_get_variable_pin_cfg().

Add an additional check in rzg2l_gpio_get_gpioint() to only allow GPIO pins
which support interrupt facility.

While at define RZG2L_GPIO_PORT_PACK() using RZG2L_GPIO_PORT_SPARSE_PACK().

Update the gpio-ranges property in the RZ/Five SoC DTSI, as it must
match the driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240129135556.63466-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Link: https://lore.kernel.org/r/20240129135556.63466-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 213 +++++++++++++++++++-
 2 files changed, 208 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index b0796015e36b..e68a91c9fe77 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -42,6 +42,10 @@ cpu0_intc: interrupt-controller {
 	};
 };
 
+&pinctrl {
+	gpio-ranges = <&pinctrl 0 0 232>;
+};
+
 &soc {
 	dma-noncoherent;
 	interrupt-parent = <&plic>;
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index e05d4e3bd9c4..336b7313e108 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -56,6 +56,8 @@
 #define PIN_CFG_IOLH_C			BIT(13)
 #define PIN_CFG_SOFT_PS			BIT(14)
 #define PIN_CFG_OEN			BIT(15)
+#define PIN_CFG_VARIABLE		BIT(16)
+#define PIN_CFG_NOGPIO_INT		BIT(17)
 
 #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
 					(PIN_CFG_IOLH_##group | \
@@ -75,17 +77,23 @@
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
 
-/*
- * n indicates number of pins in the port, a is the register index
- * and f is pin configuration capabilities supported.
- */
 #define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(35, 28)
 #define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
 #define PIN_CFG_MASK			GENMASK(19, 0)
 
-#define RZG2L_GPIO_PORT_PACK(n, a, f)	((((1ULL << (n)) - 1) << 28) | \
-					 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
-					 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
+/*
+ * m indicates the bitmap of supported pins, a is the register index
+ * and f is pin configuration capabilities supported.
+ */
+#define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)	(FIELD_PREP_CONST(PIN_CFG_PIN_MAP_MASK, (m)) | \
+						 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
+						 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
+
+/*
+ * n indicates number of pins in the port, a is the register index
+ * and f is pin configuration capabilities supported.
+ */
+#define RZG2L_GPIO_PORT_PACK(n, a, f)	RZG2L_GPIO_PORT_SPARSE_PACK((1ULL << (n)) - 1, (a), (f))
 
 /*
  * BIT(63) indicates dedicated pin, p is the register index while
@@ -198,6 +206,18 @@ struct rzg2l_dedicated_configs {
 	u64 config;
 };
 
+/**
+ * struct rzg2l_variable_pin_cfg - pin data cfg
+ * @cfg: port pin configuration
+ * @port: port number
+ * @pin: port pin
+ */
+struct rzg2l_variable_pin_cfg {
+	u32 cfg:20;
+	u32 port:5;
+	u32 pin:3;
+};
+
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
 	const u64 *port_pin_configs;
@@ -206,6 +226,8 @@ struct rzg2l_pinctrl_data {
 	unsigned int n_port_pins;
 	unsigned int n_dedicated_pins;
 	const struct rzg2l_hwcfg *hwcfg;
+	const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
+	unsigned int n_variable_pin_cfg;
 };
 
 /**
@@ -241,6 +263,143 @@ struct rzg2l_pinctrl {
 
 static const u16 available_ps[] = { 1800, 2500, 3300 };
 
+#ifdef CONFIG_RISCV
+static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pctrl,
+					      u64 pincfg,
+					      unsigned int port,
+					      u8 pin)
+{
+	unsigned int i;
+
+	for (i = 0; i < pctrl->data->n_variable_pin_cfg; i++) {
+		if (pctrl->data->variable_pin_cfg[i].port == port &&
+		    pctrl->data->variable_pin_cfg[i].pin == pin)
+			return (pincfg & ~PIN_CFG_VARIABLE) | pctrl->data->variable_pin_cfg[i].cfg;
+	}
+
+	return 0;
+}
+
+static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg[] = {
+	{
+		.port = 20,
+		.pin = 0,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 20,
+		.pin = 1,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 20,
+		.pin = 2,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+		       PIN_CFG_IEN  | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 20,
+		.pin = 3,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 20,
+		.pin = 4,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 20,
+		.pin = 5,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 20,
+		.pin = 6,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 20,
+		.pin = 7,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 23,
+		.pin = 1,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_NOGPIO_INT
+	},
+	{
+		.port = 23,
+		.pin = 2,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 23,
+		.pin = 3,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 23,
+		.pin = 4,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 23,
+		.pin = 5,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 24,
+		.pin = 0,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 24,
+		.pin = 1,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 24,
+		.pin = 2,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 24,
+		.pin = 3,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 24,
+		.pin = 4,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_NOGPIO_INT,
+	},
+	{
+		.port = 24,
+		.pin = 5,
+		.cfg = PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+		       PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+		       PIN_CFG_NOGPIO_INT,
+	},
+};
+#endif
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -1444,6 +1603,25 @@ static const u64 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(4, 0x21, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
+#ifdef CONFIG_RISCV
+	/* Below additional port pins (P19 - P28) are exclusively available on RZ/Five SoC only */
+	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x06, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+				    PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P19 */
+	RZG2L_GPIO_PORT_PACK(8, 0x07, PIN_CFG_VARIABLE),				/* P20 */
+	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x08, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+				    PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),			/* P21 */
+	RZG2L_GPIO_PORT_PACK(4, 0x09, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
+			     PIN_CFG_IEN | PIN_CFG_NOGPIO_INT),				/* P22 */
+	RZG2L_GPIO_PORT_SPARSE_PACK(0x3e, 0x0a, PIN_CFG_VARIABLE),			/* P23 */
+	RZG2L_GPIO_PORT_PACK(6, 0x0b, PIN_CFG_VARIABLE),				/* P24 */
+	RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_FILONOFF |
+				    PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL |
+				    PIN_CFG_NOGPIO_INT),				/* P25 */
+	0x0,										/* P26 */
+	0x0,										/* P27 */
+	RZG2L_GPIO_PORT_PACK(6, 0x0f, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO_INT),	/* P28 */
+#endif
 };
 
 static const u64 r9a08g045_gpio_configs[] = {
@@ -1604,12 +1782,18 @@ static const struct rzg2l_dedicated_configs rzg3s_dedicated_pins[] = {
 						       PIN_CFG_IO_VMC_SD1)) },
 };
 
-static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_data *data)
+static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinctrl *pctrl)
 {
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[virq];
+	const struct rzg2l_pinctrl_data *data = pctrl->data;
+	u64 *pin_data = pin_desc->drv_data;
 	unsigned int gpioint;
 	unsigned int i;
 	u32 port, bit;
 
+	if (*pin_data & PIN_CFG_NOGPIO_INT)
+		return -EINVAL;
+
 	port = virq / 8;
 	bit = virq % 8;
 
@@ -1719,7 +1903,7 @@ static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
 	unsigned long flags;
 	int gpioint, irq;
 
-	gpioint = rzg2l_gpio_get_gpioint(child, pctrl->data);
+	gpioint = rzg2l_gpio_get_gpioint(child, pctrl);
 	if (gpioint < 0)
 		return gpioint;
 
@@ -1905,6 +2089,13 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		if (i && !(i % RZG2L_PINS_PER_PORT))
 			j++;
 		pin_data[i] = pctrl->data->port_pin_configs[j];
+#ifdef CONFIG_RISCV
+		if (pin_data[i] & PIN_CFG_VARIABLE)
+			pin_data[i] = rzg2l_pinctrl_get_variable_pin_cfg(pctrl,
+									 pin_data[i],
+									 j,
+									 i % RZG2L_PINS_PER_PORT);
+#endif
 		pins[i].drv_data = &pin_data[i];
 	}
 
@@ -2056,6 +2247,10 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
 	.hwcfg = &rzg2l_hwcfg,
+#ifdef CONFIG_RISCV
+	.variable_pin_cfg = r9a07g043f_variable_pin_cfg,
+	.n_variable_pin_cfg = ARRAY_SIZE(r9a07g043f_variable_pin_cfg),
+#endif
 };
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
-- 
2.39.2


