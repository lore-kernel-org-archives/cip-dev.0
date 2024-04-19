Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE51AC04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:30 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.18457.1713526762113530751
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ITjR6dR0;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d4d80d00so2423249e87.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526760; x=1714131560; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KquqdFtvsm9zFXGda0IXwSXevKKGV4AD5w1jx0ZS9PA=;
        b=ITjR6dR0gZvN1v3RsI8EGuPpOtmxWDge6IWKSriOZijO3d3ZXbuzwwTJayt8egtlRy
         adJ943W785qh2CiYolaxSACC7yzBE7iUIGgLIOpLUcxVdgKOd3gabGYP5v2KAQslLrzG
         BBmi7gKlXWwjP+KZS2rtXkmf6aNeXCTIZyxGzdmH8vJpl56lBkpEb94T6UldHTZddPRN
         FtLf8IcexRiumJ+FgGbE3dTvtAq+ugXXgvyMZUf4pwdL0Lkm7dzusPZhH3/lyn5cpdJl
         dntMRJurOIUU+HH6AsNLdqozRo9NYremq215iCgOxNp+xdi+pq8AStkssZDIpPUV1XjZ
         om7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526760; x=1714131560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KquqdFtvsm9zFXGda0IXwSXevKKGV4AD5w1jx0ZS9PA=;
        b=TPPJttVAVoHrwg7DbSYmuP0Wp3bwNX7RrktEVxKHeT250qdkdv0WnR0LvA5IHBpsjt
         x5L/LpSlmxArADMbhBKkVJQOy57NKRF6vQ3yGu30ZiyVGx823iVW2yKhwXbHG6AkHH6K
         5rC+Y2D9jfExlZPA+ODC8j0qx2aMYrGCUGQwSZhGCuyM9XBmmsB8Wy75ld1sykhmegR7
         1NH/ZlRQ3cip2PGJJ1mRcOXaMYlvPUmuwW/2VHsce9gsUXUueUF4f1smSR6h5EaHfjWy
         BuMqKyHZftml3dKdNyfIqn4J1qQUb5uKKyfTEEP1WJj8mKFVWME57M9+GErLGkxK6sRf
         Sb6g==
X-Gm-Message-State: AOJu0YygmB6+K7AvvYTpxwDAaWHY3L0Hg6OHIES4kcmsb9erY11IOyu0
	v/wAtcVLFFOzrSd7P/bFC77RibD0W/tbf/zPg0+MbWgXZMJjnnu3FYuMc6yBH2E=
X-Google-Smtp-Source: AGHT+IHKx5lhzRITJ3269hH1CcRNMl+R1NF10mu95WsmMO6q145R7U88BE1YZT1DHFfr+KPBiPNvZw==
X-Received: by 2002:a05:6512:3449:b0:518:b5af:5f67 with SMTP id j9-20020a056512344900b00518b5af5f67mr1114962lfr.64.1713526760120;
        Fri, 19 Apr 2024 04:39:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 24/44] pinctrl: renesas: rzg2l: Index all registers based on port offset
Date: Fri, 19 Apr 2024 14:38:22 +0300
Message-Id: <20240419113842.3675543-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15675

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 77e18969da3a5a0ed5f7c3b80869c0acf25377ab upstream.

To get the address that needs to be read/written for specific port
functionalities, the P(), PM(), PMC(), PFC(), PIN(), IOLH() IEN(),
ISEL() macros are used.  Some of these macros receive as argument the
hardware port identifier, some the hardware port offset address (e.g.
ISEL() received port identifier, IOLH() received port offset address).
This makes it hard to extend the current driver for SoCs where port
identifiers are not contiguous in the memory map of the pin controller.
This is the case for the RZ/G3S pin controller where ports are mapped as
follows:

    port offset    port identifier
    -----------    ---------------
    0x20           P0
    0x21           P5
    0x22           P6
    0x23           P11
    0x24           P12
    0x25           P13
    0x26           P14
    0x27           P15
    0x28           P16
    0x29           P17
    0x2a           P18
    0x30           P1
    0x31           P2
    0x32           P3
    0x33           P4
    0x34           P7
    0x35           P8
    0x36           P8
    0x37           P10

To make this achievable, change all the above macros used to get the
address of a port register for a specific port functionality based on
the port hardware address.  Summarized, all the above macros will get as
argument the port offset address listed in the above table.

With this RZG2L_SINGLE_PIN_GET_PORT_OFFSET(),
RZG2L_PIN_ID_TO_PORT_OFFSET() and RZG2L_GPIO_PORT_GET_INDEX() were
replaced by RZG2L_PIN_CFG_TO_PORT_OFFSET(); RZG2L_SINGLE_PIN_GET_CFGS()
and RZG2L_GPIO_PORT_GET_CFGS() were replaced by RZG2L_PIN_CFG_TO_CAPS().

Also rzg2l_pinctrl_set_pfc_mode() does not need the port argument
anymore.  Also rzg2l_gpio_direction_input() and
rzg2l_gpio_direction_output() do not need to translate port and bit
locally as this can be done by rzg2l_gpio_set_direction().

To use the same naming for port, bit/pin, and register offset, replace
the port_offset variable names in different places by variables named
off.  There is no longer a need to initialize cfg and bit in different
code places.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20230929053915.1530607-15-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 174 ++++++++++++------------
 1 file changed, 88 insertions(+), 86 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 45a39e04ec49..789a2f7dd65c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -73,8 +73,6 @@
  */
 #define RZG2L_GPIO_PORT_PACK(n, a, f)	(((n) << 28) | ((a) << 20) | (f))
 #define RZG2L_GPIO_PORT_GET_PINCNT(x)	(((x) & GENMASK(30, 28)) >> 28)
-#define RZG2L_GPIO_PORT_GET_INDEX(x)	(((x) & GENMASK(26, 20)) >> 20)
-#define RZG2L_GPIO_PORT_GET_CFGS(x)	((x) & GENMASK(19, 0))
 
 /*
  * BIT(31) indicates dedicated pin, p is the register index while
@@ -84,18 +82,21 @@
 #define RZG2L_SINGLE_PIN		BIT(31)
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 ((p) << 24) | ((b) << 20) | (f))
-#define RZG2L_SINGLE_PIN_GET_PORT_OFFSET(x)	(((x) & GENMASK(30, 24)) >> 24)
 #define RZG2L_SINGLE_PIN_GET_BIT(x)	(((x) & GENMASK(22, 20)) >> 20)
-#define RZG2L_SINGLE_PIN_GET_CFGS(x)	((x) & GENMASK(19, 0))
-
-#define P(n)			(0x0000 + 0x10 + (n))
-#define PM(n)			(0x0100 + 0x20 + (n) * 2)
-#define PMC(n)			(0x0200 + 0x10 + (n))
-#define PFC(n)			(0x0400 + 0x40 + (n) * 4)
-#define PIN(n)			(0x0800 + 0x10 + (n))
-#define IOLH(n)			(0x1000 + (n) * 8)
-#define IEN(n)			(0x1800 + (n) * 8)
-#define ISEL(n)			(0x2c80 + (n) * 8)
+
+#define RZG2L_PIN_CFG_TO_CAPS(cfg)		((cfg) & GENMASK(19, 0))
+#define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)	((cfg) & RZG2L_SINGLE_PIN ? \
+						(((cfg) & GENMASK(30, 24)) >> 24) : \
+						(((cfg) & GENMASK(26, 20)) >> 20))
+
+#define P(off)			(0x0000 + (off))
+#define PM(off)			(0x0100 + (off) * 2)
+#define PMC(off)		(0x0200 + (off))
+#define PFC(off)		(0x0400 + (off) * 4)
+#define PIN(off)		(0x0800 + (off))
+#define IOLH(off)		(0x1000 + (off) * 8)
+#define IEN(off)		(0x1800 + (off) * 8)
+#define ISEL(off)		(0x2C00 + (off) * 8)
 #define PWPR			(0x3014)
 #define SD_CH(n)		(0x3000 + (n) * 4)
 #define QSPI			(0x3008)
@@ -116,7 +117,6 @@
 #define PM_OUTPUT		0x2
 
 #define RZG2L_PIN_ID_TO_PORT(id)	((id) / RZG2L_PINS_PER_PORT)
-#define RZG2L_PIN_ID_TO_PORT_OFFSET(id)	(RZG2L_PIN_ID_TO_PORT(id) + 0x10)
 #define RZG2L_PIN_ID_TO_PIN(id)		((id) % RZG2L_PINS_PER_PORT)
 
 #define RZG2L_TINT_MAX_INTERRUPT	32
@@ -160,7 +160,7 @@ static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
 static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
 
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
-				       u8 port, u8 pin, u8 func)
+				       u8 pin, u8 off, u8 func)
 {
 	unsigned long flags;
 	u32 reg;
@@ -168,30 +168,30 @@ static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 	spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
-	reg = readw(pctrl->base + PM(port));
+	reg = readw(pctrl->base + PM(off));
 	reg &= ~(PM_MASK << (pin * 2));
-	writew(reg, pctrl->base + PM(port));
+	writew(reg, pctrl->base + PM(off));
 
 	/* Temporarily switch to GPIO mode with PMC register */
-	reg = readb(pctrl->base + PMC(port));
-	writeb(reg & ~BIT(pin), pctrl->base + PMC(port));
+	reg = readb(pctrl->base + PMC(off));
+	writeb(reg & ~BIT(pin), pctrl->base + PMC(off));
 
 	/* Set the PWPR register to allow PFC register to write */
 	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
 	writel(PWPR_PFCWE, pctrl->base + PWPR);  /* B0WI=0, PFCWE=1 */
 
 	/* Select Pin function mode with PFC register */
-	reg = readl(pctrl->base + PFC(port));
+	reg = readl(pctrl->base + PFC(off));
 	reg &= ~(PFC_MASK << (pin * 4));
-	writel(reg | (func << (pin * 4)), pctrl->base + PFC(port));
+	writel(reg | (func << (pin * 4)), pctrl->base + PFC(off));
 
 	/* Set the PWPR register to be write-protected */
 	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
 	writel(PWPR_B0WI, pctrl->base + PWPR);  /* B0WI=1, PFCWE=0 */
 
 	/* Switch to Peripheral pin function with PMC register */
-	reg = readb(pctrl->base + PMC(port));
-	writeb(reg | BIT(pin), pctrl->base + PMC(port));
+	reg = readb(pctrl->base + PMC(off));
+	writeb(reg | BIT(pin), pctrl->base + PMC(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 };
@@ -217,11 +217,14 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	pins = group->pins;
 
 	for (i = 0; i < group->num_pins; i++) {
-		dev_dbg(pctrl->dev, "port:%u pin: %u PSEL:%u\n",
-			RZG2L_PIN_ID_TO_PORT(pins[i]), RZG2L_PIN_ID_TO_PIN(pins[i]),
-			psel_val[i]);
-		rzg2l_pinctrl_set_pfc_mode(pctrl, RZG2L_PIN_ID_TO_PORT(pins[i]),
-					   RZG2L_PIN_ID_TO_PIN(pins[i]), psel_val[i]);
+		unsigned int *pin_data = pctrl->desc.pins[pins[i]].drv_data;
+		u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
+
+		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
+			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i]);
+
+		rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
 	}
 
 	return 0;
@@ -467,14 +470,14 @@ static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
 				   u32 cfg, u32 port, u8 bit)
 {
 	u8 pincount = RZG2L_GPIO_PORT_GET_PINCNT(cfg);
-	u32 port_index = RZG2L_GPIO_PORT_GET_INDEX(cfg);
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
 	u32 data;
 
 	if (bit >= pincount || port >= pctrl->data->n_port_pins)
 		return -EINVAL;
 
 	data = pctrl->data->port_pin_configs[port];
-	if (port_index != RZG2L_GPIO_PORT_GET_INDEX(data))
+	if (off != RZG2L_PIN_CFG_TO_PORT_OFFSET(data))
 		return -EINVAL;
 
 	return 0;
@@ -524,20 +527,17 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	unsigned int arg = 0;
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port_offset;
-	u32 cfg = 0;
-	u8 bit = 0;
+	u32 off, cfg;
+	u8 bit;
 
 	if (!pin_data)
 		return -EINVAL;
 
+	off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	cfg = RZG2L_PIN_CFG_TO_CAPS(*pin_data);
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(*pin_data);
-		cfg = RZG2L_SINGLE_PIN_GET_CFGS(*pin_data);
 		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
 	} else {
-		cfg = RZG2L_GPIO_PORT_GET_CFGS(*pin_data);
-		port_offset = RZG2L_PIN_ID_TO_PORT_OFFSET(_pin);
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
 		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
@@ -548,7 +548,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_INPUT_ENABLE:
 		if (!(cfg & PIN_CFG_IEN))
 			return -EINVAL;
-		arg = rzg2l_read_pin_config(pctrl, IEN(port_offset), bit, IEN_MASK);
+		arg = rzg2l_read_pin_config(pctrl, IEN(off), bit, IEN_MASK);
 		if (!arg)
 			return -EINVAL;
 		break;
@@ -578,7 +578,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		if (!(cfg & PIN_CFG_IOLH_A))
 			return -EINVAL;
 
-		index = rzg2l_read_pin_config(pctrl, IOLH(port_offset), bit, IOLH_MASK);
+		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
 		arg = iolh_groupa_mA[index];
 		break;
 	}
@@ -589,7 +589,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		if (!(cfg & PIN_CFG_IOLH_B))
 			return -EINVAL;
 
-		index = rzg2l_read_pin_config(pctrl, IOLH(port_offset), bit, IOLH_MASK);
+		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
 		arg = iolh_groupb_oi[index];
 		break;
 	}
@@ -614,21 +614,18 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	enum pin_config_param param;
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port_offset;
 	unsigned int i;
-	u32 cfg = 0;
-	u8 bit = 0;
+	u32 cfg, off;
+	u8 bit;
 
 	if (!pin_data)
 		return -EINVAL;
 
+	off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	cfg = RZG2L_PIN_CFG_TO_CAPS(*pin_data);
 	if (*pin_data & RZG2L_SINGLE_PIN) {
-		port_offset = RZG2L_SINGLE_PIN_GET_PORT_OFFSET(*pin_data);
-		cfg = RZG2L_SINGLE_PIN_GET_CFGS(*pin_data);
 		bit = RZG2L_SINGLE_PIN_GET_BIT(*pin_data);
 	} else {
-		cfg = RZG2L_GPIO_PORT_GET_CFGS(*pin_data);
-		port_offset = RZG2L_PIN_ID_TO_PORT_OFFSET(_pin);
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
 		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
@@ -645,7 +642,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (!(cfg & PIN_CFG_IEN))
 				return -EINVAL;
 
-			rzg2l_rmw_pin_config(pctrl, IEN(port_offset), bit, IEN_MASK, !!arg);
+			rzg2l_rmw_pin_config(pctrl, IEN(off), bit, IEN_MASK, !!arg);
 			break;
 		}
 
@@ -686,7 +683,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (index >= ARRAY_SIZE(iolh_groupa_mA))
 				return -EINVAL;
 
-			rzg2l_rmw_pin_config(pctrl, IOLH(port_offset), bit, IOLH_MASK, index);
+			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
 		}
 
@@ -704,7 +701,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			if (index >= ARRAY_SIZE(iolh_groupb_oi))
 				return -EINVAL;
 
-			rzg2l_rmw_pin_config(pctrl, IOLH(port_offset), bit, IOLH_MASK, index);
+			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
 		}
 
@@ -795,9 +792,10 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
 	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	u32 *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
-	u32 *pin_data = pin_desc->drv_data;
 	unsigned long flags;
 	u8 reg8;
 	int ret;
@@ -813,28 +811,32 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Select GPIO mode in PMC Register */
-	reg8 = readb(pctrl->base + PMC(port));
+	reg8 = readb(pctrl->base + PMC(off));
 	reg8 &= ~BIT(bit);
-	writeb(reg8, pctrl->base + PMC(port));
+	writeb(reg8, pctrl->base + PMC(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 
 	return 0;
 }
 
-static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 port,
-				     u8 bit, bool output)
+static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 offset,
+				     bool output)
 {
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
 	u16 reg16;
 
 	spin_lock_irqsave(&pctrl->lock, flags);
 
-	reg16 = readw(pctrl->base + PM(port));
+	reg16 = readw(pctrl->base + PM(off));
 	reg16 &= ~(PM_MASK << (bit * 2));
 
 	reg16 |= (output ? PM_OUTPUT : PM_INPUT) << (bit * 2);
-	writew(reg16, pctrl->base + PM(port));
+	writew(reg16, pctrl->base + PM(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 }
@@ -842,13 +844,15 @@ static void rzg2l_gpio_set_direction(struct rzg2l_pinctrl *pctrl, u32 port,
 static int rzg2l_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
-	if (!(readb(pctrl->base + PMC(port)) & BIT(bit))) {
+	if (!(readb(pctrl->base + PMC(off)) & BIT(bit))) {
 		u16 reg16;
 
-		reg16 = readw(pctrl->base + PM(port));
+		reg16 = readw(pctrl->base + PM(off));
 		reg16 = (reg16 >> (bit * 2)) & PM_MASK;
 		if (reg16 == PM_OUTPUT)
 			return GPIO_LINE_DIRECTION_OUT;
@@ -861,10 +865,8 @@ static int rzg2l_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
-	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
-	rzg2l_gpio_set_direction(pctrl, port, bit, false);
+	rzg2l_gpio_set_direction(pctrl, offset, false);
 
 	return 0;
 }
@@ -873,19 +875,21 @@ static void rzg2l_gpio_set(struct gpio_chip *chip, unsigned int offset,
 			   int value)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	unsigned long flags;
 	u8 reg8;
 
 	spin_lock_irqsave(&pctrl->lock, flags);
 
-	reg8 = readb(pctrl->base + P(port));
+	reg8 = readb(pctrl->base + P(off));
 
 	if (value)
-		writeb(reg8 | BIT(bit), pctrl->base + P(port));
+		writeb(reg8 | BIT(bit), pctrl->base + P(off));
 	else
-		writeb(reg8 & ~BIT(bit), pctrl->base + P(port));
+		writeb(reg8 & ~BIT(bit), pctrl->base + P(off));
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 }
@@ -894,11 +898,9 @@ static int rzg2l_gpio_direction_output(struct gpio_chip *chip,
 				       unsigned int offset, int value)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
-	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 
 	rzg2l_gpio_set(chip, offset, value);
-	rzg2l_gpio_set_direction(pctrl, port, bit, true);
+	rzg2l_gpio_set_direction(pctrl, offset, true);
 
 	return 0;
 }
@@ -906,17 +908,19 @@ static int rzg2l_gpio_direction_output(struct gpio_chip *chip,
 static int rzg2l_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct rzg2l_pinctrl *pctrl = gpiochip_get_data(chip);
-	u32 port = RZG2L_PIN_ID_TO_PORT(offset);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[offset];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 	u8 bit = RZG2L_PIN_ID_TO_PIN(offset);
 	u16 reg16;
 
-	reg16 = readw(pctrl->base + PM(port));
+	reg16 = readw(pctrl->base + PM(off));
 	reg16 = (reg16 >> (bit * 2)) & PM_MASK;
 
 	if (reg16 == PM_INPUT)
-		return !!(readb(pctrl->base + PIN(port)) & BIT(bit));
+		return !!(readb(pctrl->base + PIN(off)) & BIT(bit));
 	else if (reg16 == PM_OUTPUT)
-		return !!(readb(pctrl->base + P(port)) & BIT(bit));
+		return !!(readb(pctrl->base + P(off)) & BIT(bit));
 	else
 		return -EINVAL;
 }
@@ -1175,17 +1179,16 @@ static void rzg2l_gpio_irq_disable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port;
-	u8 bit;
 
 	irq_chip_disable_parent(d);
 
-	port = RZG2L_PIN_ID_TO_PORT(hwirq);
-	bit = RZG2L_PIN_ID_TO_PIN(hwirq);
-
-	addr = pctrl->base + ISEL(port);
+	addr = pctrl->base + ISEL(off);
 	if (bit >= 4) {
 		bit -= 4;
 		addr += 4;
@@ -1203,17 +1206,16 @@ static void rzg2l_gpio_irq_enable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl, gpio_chip);
 	unsigned int hwirq = irqd_to_hwirq(d);
+	const struct pinctrl_pin_desc *pin_desc = &pctrl->desc.pins[hwirq];
+	unsigned int *pin_data = pin_desc->drv_data;
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
+	u8 bit = RZG2L_PIN_ID_TO_PIN(hwirq);
 	unsigned long flags;
 	void __iomem *addr;
-	u32 port;
-	u8 bit;
 
 	gpiochip_enable_irq(gc, hwirq);
 
-	port = RZG2L_PIN_ID_TO_PORT(hwirq);
-	bit = RZG2L_PIN_ID_TO_PIN(hwirq);
-
-	addr = pctrl->base + ISEL(port);
+	addr = pctrl->base + ISEL(off);
 	if (bit >= 4) {
 		bit -= 4;
 		addr += 4;
-- 
2.39.2


