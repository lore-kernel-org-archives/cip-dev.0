Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC3C27C77
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:11 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.42752.1717769345291875326
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WpoNs3zq;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a626919d19dso599387466b.0
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769344; x=1718374144; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1jXNA+HP8ShCFvsJfYzTIQUi6beh9M5fM5nzKjyP3Q=;
        b=WpoNs3zq/MY97EjHs/wc5hmHPYs2Tni6F7WcE5viGRRsOGHl4S/rSesIKxaeSIZ8LR
         w6/Z7d4+Bib4O4VmVy4Qvgr+r7qIHZ/sAV7y0vW7O16H/W2rZ2odeu4fKUVAR3GTnPx3
         Q9H36q/C9LxZABHf5t/6rOTubq99D1kez7HAcspUQ6nMzFHZaOcsNvwqfSFki/pu2v0A
         RlPYNVtV1QBz0XTjJ6T7pHDyJzx/AybKsoyTf5PuecHWrrnf28vE+L4ovAn/iYT4fEJI
         yI1KDOtu7wNcaSTQkB6Sr6IFrdSvy37qulplGTejzp5rTBq33OZco/MKTMoCiYEKZgXC
         rmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769344; x=1718374144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1jXNA+HP8ShCFvsJfYzTIQUi6beh9M5fM5nzKjyP3Q=;
        b=jG0OqANa8n+AQZKMMB/WuLj+AufOBDHQYs7lPwJztRNLiPETss+C2KQatnTLzkhHGS
         1om8ivAe7uuCVkefpJDCTnE2hnokE/+UHcoVpkfULWjBqEcPk+ECiYMVPkLWxKGf/yA4
         DXRnjUUJ0JGjc+rxjn4BEwwYO1cjCtm9A6JUV7pujPMbwM/4mclY3VqX3Zz5WlTr+0/5
         n3Cfv/dN7QSmhfTLUXp4pPmVXBnCdxnjo7OzF9K+WR8K4T/oDYQB7dNuh9p7YImh5Rs/
         /Zb7zFdcN8gDK/lkTVQyW5V+4NInN8HIPvPAkzo95NOT/jUMuUBGvsAxZ5s+rgMDy0na
         pHpQ==
X-Gm-Message-State: AOJu0Yyszmuz/kstK6Mjae8+Fx3sCzXoMikCp+9vvOWNL42sXwdzAtd8
	EWxYPXP+PYD0Xw44C1UxpFgqhJUncLQyeXJC80aYA5neLQYc54k36NiCH2D2UlQ=
X-Google-Smtp-Source: AGHT+IFQjG+yTIdfTC+5LvjDAVcbVV/zAxI4obedag1v0Y5uGhdaNvQoA2W3mzBl769rxvrpcp5Kkw==
X-Received: by 2002:a17:906:a099:b0:a5a:8673:cccd with SMTP id a640c23a62f3a-a6cbc6ca3d4mr209108566b.30.1717769343689;
        Fri, 07 Jun 2024 07:09:03 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 04/17] pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK() macro
Date: Fri,  7 Jun 2024 17:08:43 +0300
Message-Id: <20240607140856.2497508-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16165

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 15e4ae4f9ae74433e96331164e96f744769c0f8e upstream.

Currently we assume all the port pins are sequential ie always PX_0 to
PX_n (n=1..7) exist, but on RZ/Five SoC we have additional pins P19_1 to
P28_5 which have holes in them, for example only one pin on port19 is
available and that is P19_1 and not P19_0. So to handle such cases
include pinmap for each port which would indicate the pin availability
on each port. As the pincount can be calculated based on pinmap drop this
from RZG2L_GPIO_PORT_PACK() macro.

Previously we had a max of 7 pins on each port but on RZ/Five Port-20
has 8 pins, so move the single pin configuration to BIT(63).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240129135556.63466-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict in rzg2l_pinctrl_set_mux() function]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 56 +++++++++++++------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c748238d6274..e05d4e3bd9c4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -79,19 +79,20 @@
  * n indicates number of pins in the port, a is the register index
  * and f is pin configuration capabilities supported.
  */
-#define PIN_CFG_PIN_CNT_MASK		GENMASK(30, 28)
+#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(35, 28)
 #define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
 #define PIN_CFG_MASK			GENMASK(19, 0)
-#define RZG2L_GPIO_PORT_PACK(n, a, f)	(FIELD_PREP_CONST(PIN_CFG_PIN_CNT_MASK, (n)) | \
+
+#define RZG2L_GPIO_PORT_PACK(n, a, f)	((((1ULL << (n)) - 1) << 28) | \
 					 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
 					 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
 
 /*
- * BIT(31) indicates dedicated pin, p is the register index while
+ * BIT(63) indicates dedicated pin, p is the register index while
  * referencing to SR/IEN/IOLH/FILxx registers, b is the register bits
  * (b * 8) and f is the pin configuration capabilities supported.
  */
-#define RZG2L_SINGLE_PIN		BIT(31)
+#define RZG2L_SINGLE_PIN		BIT_ULL(63)
 #define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK(30, 24)
 #define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK(22, 20)
 
@@ -194,12 +195,12 @@ struct rzg2l_hwcfg {
 
 struct rzg2l_dedicated_configs {
 	const char *name;
-	u32 config;
+	u64 config;
 };
 
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
-	const u32 *port_pin_configs;
+	const u64 *port_pin_configs;
 	unsigned int n_ports;
 	const struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
@@ -300,7 +301,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	pins = group->pins;
 
 	for (i = 0; i < group->num_pins; i++) {
-		unsigned int *pin_data = pctrl->desc.pins[pins[i]].drv_data;
+		u64 *pin_data = pctrl->desc.pins[pins[i]].drv_data;
 		u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
 
@@ -563,13 +564,13 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 }
 
 static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
-				   u32 cfg, u32 port, u8 bit)
+				   u64 cfg, u32 port, u8 bit)
 {
-	u8 pincount = FIELD_GET(PIN_CFG_PIN_CNT_MASK, cfg);
+	u8 pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
-	u32 data;
+	u64 data;
 
-	if (bit >= pincount || port >= pctrl->data->n_port_pins)
+	if (!(pinmap & BIT(bit)) || port >= pctrl->data->n_port_pins)
 		return -EINVAL;
 
 	data = pctrl->data->port_pin_configs[port];
@@ -861,7 +862,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
-	unsigned int *pin_data = pin->drv_data;
+	u64 *pin_data = pin->drv_data;
 	unsigned int arg = 0;
 	u32 off, cfg;
 	int ret;
@@ -964,7 +965,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
-	unsigned int *pin_data = pin->drv_data;
+	u64 *pin_data = pin->drv_data;
 	enum pin_config_param param;
 	unsigned int i, arg, index;
 	u32 cfg, off;
@@ -1169,7 +1170,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	u32 *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
@@ -1201,7 +1202,7 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
 				     bool output)
 {
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
@@ -1222,7 +1223,7 @@ static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
@@ -1253,7 +1254,7 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
@@ -1286,7 +1287,7 @@ static int rzg2l_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	u16 reg16;
@@ -1371,7 +1372,7 @@ static const char * const rzg2l_gpio_names[] = {
 	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6", "P48_7",
 };
 
-static const u32 r9a07g044_gpio_configs[] = {
+static const u64 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
@@ -1423,7 +1424,7 @@ static const u32 r9a07g044_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static const u32 r9a07g043_gpio_configs[] = {
+static const u64 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x10, RZG2L_MPXED_PIN_FUNCS),
 	RZG2L_GPIO_PORT_PACK(5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
 	RZG2L_GPIO_PORT_PACK(4, 0x12, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
@@ -1445,7 +1446,7 @@ static const u32 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static const u32 r9a08g045_gpio_configs[] = {
+static const u64 r9a08g045_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(4, 0x20, RZG3S_MPXED_PIN_FUNCS(A)),			/* P0  */
 	RZG2L_GPIO_PORT_PACK(5, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IOLH_C |
 								PIN_CFG_IO_VMC_ETH0)) |
@@ -1613,12 +1614,12 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_
 	bit = virq % 8;
 
 	if (port >= data->n_ports ||
-	    bit >= FIELD_GET(PIN_CFG_PIN_CNT_MASK, data->port_pin_configs[port]))
+	    bit >= hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK, data->port_pin_configs[port])))
 		return -EINVAL;
 
 	gpioint = bit;
 	for (i = 0; i < port; i++)
-		gpioint += FIELD_GET(PIN_CFG_PIN_CNT_MASK, data->port_pin_configs[i]);
+		gpioint += hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK, data->port_pin_configs[i]));
 
 	return gpioint;
 }
@@ -1629,7 +1630,7 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
@@ -1656,7 +1657,7 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
-	unsigned int *pin_data = pin_desc->drv_data;
+	u64 *pin_data = pin_desc->drv_data;
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
@@ -1793,7 +1794,8 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 		bit = offset % 8;
 
 		if (port >= pctrl->data->n_ports ||
-		    bit >= FIELD_GET(PIN_CFG_PIN_CNT_MASK, pctrl->data->port_pin_configs[port]))
+		    bit >= hweight8(FIELD_GET(PIN_CFG_PIN_MAP_MASK,
+					      pctrl->data->port_pin_configs[port])))
 			clear_bit(offset, valid_mask);
 	}
 }
@@ -1875,7 +1877,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct pinctrl_pin_desc *pins;
 	unsigned int i, j;
-	u32 *pin_data;
+	u64 *pin_data;
 	int ret;
 
 	pctrl->desc.name = DRV_NAME;
-- 
2.39.2


