Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FF2C27C75
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:07:20 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.42683.1717769238632821341
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:07:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BYptAK2l;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.169, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so24701961fa.1
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769237; x=1718374037; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PljkYX4MzGn3AuO/93dNoKz9oJQFG43wuanxbBIoro8=;
        b=BYptAK2lo1+zBEmPAM+OAT2fqabUFs8Ws9v7kUL3q7ppdzQG5vTpk436tR+3DHZ7cN
         QLK0pTfrqiGkA1ce2LJoyLfahD0t/LjJRVpUr6iZCD+sNnc5Gf1wVk9f1zOtSPwZwhrU
         Hq0fwesPLc2JPigc4ERu5nZMhTGCXsDx/XPjx1enh+tESA81X2+FAvvHbF3C3pJGd8AX
         IVaiPjqKdv+t0xb7P4FbcjZoO0+S7BFAefzH6cwq2bCpaIz0Wz52C8TvVX/KQtpUiWyG
         52IcpcJyP7GzDNB7theTFHg+7R8PAMIPV3motdXYL/eOh8LUPFzHVeM29fC55TfBz/WR
         1Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769237; x=1718374037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PljkYX4MzGn3AuO/93dNoKz9oJQFG43wuanxbBIoro8=;
        b=hWWhY4Ke13e7/L5sCJG0/J56YqiB7ZNuGhMbG9zTfj93gjOTlAhyQnir+I1uAmcN4t
         +1UrtYkmNoa5dTygj42Y4+BbMtxOjo9+7uAg0PZ9PxR4+ShPGX8MxkH3+P0Z6DboaVV3
         /iudxUZXgag6iKWazJ5YOiY+wPWJu2Kmf3+P0vLs+RYTGBXKzeOl6SkKuV4Hkwb0q00l
         asV5SHaX0mcCzapofu8wWwv0cKWRZ/bPoIi4E4Y3LNcZECBpWoLx8umiRh6fdT6nqUte
         ++JBMd9DTzrkI9E/dUN0ihMBSekEyiFhn2BG64WIVhKWwbnrAWSNXbq47v7dazS5//Qh
         5Ajw==
X-Gm-Message-State: AOJu0Yzg1vfKLzk04rsYUi07xviyy1IbiD2JtO05B3B5WzI3jb5xPrFY
	UlUcSNn7Z/ffTKw/Cr32gzAs09IcSP86fNN4COENRVsPTYDUbXfHUwINSV2puzg=
X-Google-Smtp-Source: AGHT+IEpkQ9DmVnPnDx4EqDgJxCX71Vq3hSkaFiDeJmNfQvNJGBcZbXDCA8CLTobTj9NQnDosRIdzA==
X-Received: by 2002:a2e:7004:0:b0:2ea:e26e:e6d6 with SMTP id 38308e7fff4ca-2eae26ee9acmr9670461fa.30.1717769236843;
        Fri, 07 Jun 2024 07:07:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9cf05sm2823968a12.3.2024.06.07.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:07:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 5.10.y-cip 03/19] pinctrl: renesas: rzg2l: Improve code for readability
Date: Fri,  7 Jun 2024 17:06:55 +0300
Message-Id: <20240607140711.2497286-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140711.2497286-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16144

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
index 32ca9da27d11..bd9469ac7631 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021 Renesas Electronics Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
@@ -34,8 +35,6 @@
  */
 #define MUX_PIN_ID_MASK		GENMASK(15, 0)
 #define MUX_FUNC_MASK		GENMASK(31, 16)
-#define MUX_FUNC_OFFS		16
-#define MUX_FUNC(pinconf)	(((pinconf) & MUX_FUNC_MASK) >> MUX_FUNC_OFFS)
 
 /* PIN capabilities */
 #define PIN_CFG_IOLH_A			BIT(0)
@@ -77,8 +76,12 @@
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
@@ -86,14 +89,17 @@
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
@@ -428,8 +434,8 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		ret = of_property_read_u32_index(np, "pinmux", i, &value);
 		if (ret)
 			goto done;
-		pins[i] = value & MUX_PIN_ID_MASK;
-		psel_val[i] = MUX_FUNC(value);
+		pins[i] = FIELD_GET(MUX_PIN_ID_MASK, value);
+		psel_val[i] = FIELD_GET(MUX_FUNC_MASK, value);
 	}
 
 	if (parent) {
@@ -556,7 +562,7 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
 				   u32 cfg, u32 port, u8 bit)
 {
-	u8 pincount = RZG2L_GPIO_PORT_GET_PINCNT(cfg);
+	u8 pincount = FIELD_GET(PIN_CFG_PIN_CNT_MASK, cfg);
 	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
 	u32 data;
 
@@ -862,9 +868,9 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
-	cfg = RZG2L_PIN_CFG_TO_CAPS(*pin_data);
+	cfg = FIELD_GET(PIN_CFG_MASK, *pin_data);
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
+		bit = FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, *pin_data);
 	} else {
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
@@ -966,9 +972,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
-	cfg = RZG2L_PIN_CFG_TO_CAPS(*pin_data);
+	cfg = FIELD_GET(PIN_CFG_MASK, *pin_data);
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
+		bit = FIELD_GET(RZG2L_SINGLE_PIN_BITS_MASK, *pin_data);
 	} else {
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
@@ -1604,12 +1610,12 @@ static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2l_pinctrl_
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
@@ -1785,7 +1791,7 @@ static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
 		bit = offset % 8;
 
 		if (port >= pctrl->data->n_ports ||
-		    bit >= RZG2L_GPIO_PORT_GET_PINCNT(pctrl->data->port_pin_configs[port]))
+		    bit >= FIELD_GET(PIN_CFG_PIN_CNT_MASK, pctrl->data->port_pin_configs[port]))
 			clear_bit(offset, valid_mask);
 	}
 }
-- 
2.39.2


