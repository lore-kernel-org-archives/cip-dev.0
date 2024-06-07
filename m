Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36200C27C6F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:11 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.43041.1717769344078965696
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UdCuG0m6;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a63359aaacaso335699466b.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769342; x=1718374142; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqcG+ymHJNoMet1clzOb6REmt+cDiyCH63M+6JaG0aI=;
        b=UdCuG0m63BiVdo4xBdYrPbPEt6KPJiFqLPLOuJzjXgvPxgIMX14dsPKmb4rY2rX8/3
         VwTRV2eG2RoJfKmBMwsNAqFgqaOq/RZK/lQtTPWrnig/19aST75mbCBisVniF3d0nMoo
         6HUAY3nZZnXVmTRBIgwphZiH0bZREMkk1yw1An7I9JGS6tKgcKnO6ZPHtJfcEnoAWMuC
         f0b8KJO+HJfWH/xmAAiaIVRFiszn9e2Isp92qU2b6pHNnJ94XqMLH/OOWgCs9AUedjyD
         OLnrXEB+FQtzSSN6kpYOGsXA47TjNBylTlCnLqXD3vfOwPx77ujbiv07805Zes+zTiqY
         pXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769342; x=1718374142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqcG+ymHJNoMet1clzOb6REmt+cDiyCH63M+6JaG0aI=;
        b=ehHVaCfTuQDt4GRyoQ2OHfPrV5FPIpWgD6r3PGno3EsVBx3MkFgAzd/a5vwU5Kpqwk
         MW5U3mEoa4b+P218n79VIDwzSFxTrOiOMcmUMbd0Tq9TrGh8pYX8RqDKjbTvsIfJntKx
         Jyc630RK6ULoVvqhQqMueUcVF5BH5O4HkAb6tT+faZOrTW2WXwNeQCKdTaNoTAomLw9t
         JdkeSgMEGW387moOaLnCCx8bqOzPz/t8rzLgv9GLws5SWeAi+kiyy60ouS70evgjAbTP
         9TFzSEh4ctgkWBFNBfsIv7tUgecKdcb4/JDKTSZIF/SqC9osXauwWeXm81XQVPf2/Rxe
         BzdA==
X-Gm-Message-State: AOJu0YyyG+ymrAJsQr2JHxbHA0RLwXCXuRdrWUO4mghGxAfZJzNmixiK
	9SzUQCQeSRyWn9cVZY0lyIBC8hPlBN2uk//5McxygtIqFdgZP6mklZCtTvp+YU4=
X-Google-Smtp-Source: AGHT+IG+a+2ZirM4nxWVxe4dhbcYBQ/i8R0QIhapaYRewNTR19IB/+L4GGlBrhiRTclZ2F1SvJZwpg==
X-Received: by 2002:a17:906:1305:b0:a68:ad0d:bae6 with SMTP id a640c23a62f3a-a6cd561e522mr182858166b.3.1717769342467;
        Fri, 07 Jun 2024 07:09:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 03/17] pinctrl: renesas: rzg2l: Improve code for readability
Date: Fri,  7 Jun 2024 17:08:42 +0300
Message-Id: <20240607140856.2497508-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16164

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 04d231b90e66fc013a85f556e4dbf19a2c3ef7ea upstream.

As the RZ/G2L pinctrl driver is extensively utilized by numerous SoCs and
has experienced substantial growth, enhance code readability by
incorporating FIELD_PREP_CONST/FIELD_GET macros wherever necessary.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240129135556.63466-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 44 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c0d5bdd3a9c9..c748238d6274 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021 Renesas Electronics Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
@@ -37,8 +38,6 @@
  */
 #define MUX_PIN_ID_MASK		GENMASK(15, 0)
 #define MUX_FUNC_MASK		GENMASK(31, 16)
-#define MUX_FUNC_OFFS		16
-#define MUX_FUNC(pinconf)	(((pinconf) & MUX_FUNC_MASK) >> MUX_FUNC_OFFS)
 
 /* PIN capabilities */
 #define PIN_CFG_IOLH_A			BIT(0)
@@ -80,8 +79,12 @@
  * n indicates number of pins in the port, a is the register index
  * and f is pin configuration capabilities supported.
  */
-#define RZG2L_GPIO_PORT_PACK(n, a, f)	(((n) << 28) | ((a) << 20) | (f))
-#define RZG2L_GPIO_PORT_GET_PINCNT(x)	(((x) & GENMASK(30, 28)) >> 28)
+#define PIN_CFG_PIN_CNT_MASK		GENMASK(30, 28)
+#define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
+#define PIN_CFG_MASK			GENMASK(19, 0)
+#define RZG2L_GPIO_PORT_PACK(n, a, f)	(FIELD_PREP_CONST(PIN_CFG_PIN_CNT_MASK, (n)) | \
+					 FIELD_PREP_CONST(PIN_CFG_PIN_REG_MASK, (a)) | \
+					 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
 
 /*
  * BIT(31) indicates dedicated pin, p is the register index while
@@ -89,14 +92,17 @@
  * (b * 8) and f is the pin configuration capabilities supported.
  */
 #define RZG2L_SINGLE_PIN		BIT(31)
+#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK(30, 24)
+#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK(22, 20)
+
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
-					 ((p) << 24) | ((b) << 20) | (f))
-#define RZG2L_SINGLE_PIN_GET_BIT(x)	(((x) & GENMASK(22, 20)) >> 20)
+					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_INDEX_MASK, (p)) | \
+					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_BITS_MASK, (b)) | \
+					 FIELD_PREP_CONST(PIN_CFG_MASK, (f)))
 
-#define RZG2L_PIN_CFG_TO_CAPS(cfg)		((cfg) & GENMASK(19, 0))
 #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)	((cfg) & RZG2L_SINGLE_PIN ? \
-						(((cfg) & GENMASK(30, 24)) >> 24) : \
-						(((cfg) & GENMASK(26, 20)) >> 20))
+						 FIELD_GET(RZG2L_SINGLE_PIN_INDEX_MASK, (cfg)) : \
+						 FIELD_GET(PIN_CFG_PIN_REG_MASK, (cfg)))
 
 #define P(off)			(0x0000 + (off))
 #define PM(off)			(0x0100 + (off) * 2)
@@ -431,8 +437,8 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		ret = of_property_read_u32_index(np, "pinmux", i, &value);
 		if (ret)
 			goto done;
-		pins[i] = value & MUX_PIN_ID_MASK;
-		psel_val[i] = MUX_FUNC(value);
+		pins[i] = FIELD_GET(MUX_PIN_ID_MASK, value);
+		psel_val[i] = FIELD_GET(MUX_FUNC_MASK, value);
 	}
 
 	if (parent) {
@@ -559,7 +565,7 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
 				   u32 cfg, u32 port, u8 bit)
 {
-	u8 pincount = RZG2L_GPIO_PORT_GET_PINCNT(cfg);
+	u8 pincount = FIELD_GET(PIN_CFG_PIN_CNT_MASK, cfg);
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
 	u32 data;
 
@@ -865,9 +871,9 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
-	cfg = RZG2L_PIN_CFG_TO_CAPS(*pin_data);
+	cfg = FIELD_GET(PIN_CFG_MASK, *pin_data);
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
+		bit = FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, *pin_data);
 	} else {
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
@@ -969,9 +975,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
-	cfg = RZG2L_PIN_CFG_TO_CAPS(*pin_data);
+	cfg = FIELD_GET(PIN_CFG_MASK, *pin_data);
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
+		bit = FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, *pin_data);
 	} else {
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
@@ -1607,12 +1613,12 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_
 	bit = virq % 8;
 
 	if (port >= data->n_ports ||
-	    bit >= RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[port]))
+	    bit >= FIELD_GET(PIN_CFG_PIN_CNT_MASK, data->port_pin_configs[port]))
 		return -EINVAL;
 
 	gpioint = bit;
 	for (i = 0; i < port; i++)
-		gpioint += RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[i]);
+		gpioint += FIELD_GET(PIN_CFG_PIN_CNT_MASK, data->port_pin_configs[i]);
 
 	return gpioint;
 }
@@ -1787,7 +1793,7 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 		bit = offset % 8;
 
 		if (port >= pctrl->data->n_ports ||
-		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(pctrl->data->port_pin_configs[port]))
+		    bit >= FIELD_GET(PIN_CFG_PIN_CNT_MASK, pctrl->data->port_pin_configs[port]))
 			clear_bit(offset, valid_mask);
 	}
 }
-- 
2.39.2


