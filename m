Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57219D7876F
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 12:29:29 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15743.1766147360141645515
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 04:29:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=demvCbqv;
 spf=pass (domain: gmail.com, ip: 209.85.208.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso4105478a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 04:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766147358; x=1766752158; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeBxl70KsEQQz8/OgDuuAxbLm9HKxqvQ80GXg2zQ1EQ=;
        b=demvCbqvvNUsyaWH4Mlc99W7zgQ0ux7wVAlxEttA17WYuVEkbtIMSSU6vF8aqJXiF5
         JdDvn6PNhAKMP9AmgASPq6J+UG4QvhhDwBpL92RUAx2kUFiqE5ACSCbaSmDoWQyNdDp2
         8g3rnd4TmVHbaflrMfDCMWtDb6tFMZcQW0kDN4hdI6SfKfLfWkhbdd41WhrZ4sFyN+PE
         Q85I//sNeeuTDPVXVosHuhaRAFRaiHBvryI9cx7D9BuuzYkKXlLIPGuZUl+e3pP7zGti
         2DOtVsm2mcFeGir7RVIV9KNyU1za38M13XISKr067JsJii0YB12mMF6j+QbxVwrx1Z+q
         Kuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766147358; x=1766752158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OeBxl70KsEQQz8/OgDuuAxbLm9HKxqvQ80GXg2zQ1EQ=;
        b=J65t9Vxtp+XxMMrbSHY48MqqWbX8fcfYx0erYG2CyHWPDtxsGXsgumQvx4iu+HTOdA
         GTAJ3Koew5HCKy+e52Pe70IiKKWzDvageyOFwPw2PD/R8o7C7g5AdrT3Ek6XfZPtuuIF
         oEI7DQ/xfsl5Vypw4I0zB62Kb4e2yWyoByLgAmDUQK5EVeLXIiEFDk5Um5MTh0wrAHWp
         CMKnKbabLu5Yh5nAkYqR+1XqusLM0K2smxG5yQ4Jkln0G8OorK4HndS+28hVhSp7iOLg
         35lg2FPDDOe8qUDRMhHwTErPe5u2+NdCGkULpbSFBWvTavJcll/vvI1hiwiKZyFLbsv2
         kq6g==
X-Gm-Message-State: AOJu0Ywt2k3mqj4Z8+cisESIfzZjgcBphPrybVAZkNSdMoRh10x9yN4G
	H5OyNjSm3BDxLIg4WZcp5mTo2cSdNG9PBNokfiXEfUlca47c+BbFUnKz/50jAQ==
X-Gm-Gg: AY/fxX4Bpxin9mKnWo1+64+lwCLX5Q67YMr3pWkIfsdOi/xjMu9iMIKVz3ePr68YhZ4
	c6s5HsuVFbPpaWHHmfbRDF/94SXXy+HDhBeU+WqzjyLuSgPa8LVhgaCzUVv7Y/R9ubLzGoJDHoj
	H664ael9Knl2ETCswav5XdyQ36RgH4oozmfXTybZHCZ4UOsg77GK75zUhQdb+ApPeT4D/VGaS2Z
	ddMNDwgNa66HJxcIbwwg+HLABu8EyZAa8XEMrEMVtK5+cS4bh4AoxVMKqsJhcrN626MV2ts8rEr
	PHB4ZVcwYtOoloG8cT31iv/nbHkroEKIef+/n6vAMDy+RGedNyOQUowE7Pnt5GvuHuTJWWykQY8
	8vbQH0JGTjF/9aKe3L40Be6WNxXF+shHe6UYDo7HziXvARODl2JO/GoKYCwAbC5flw0Q3U1ln9n
	a14rU57ndMeB/fHRbXH8tT3PAbgaGFoZMF3w==
X-Google-Smtp-Source: AGHT+IEdJvr8RB6piLDZ8M4kN9wm0U2/PbQ8VIv9JuMwAH2Q7I4hI9HzsPJ2wtEZyWWBOCE6Em8fcg==
X-Received: by 2002:a17:907:940e:b0:b72:d577:11cc with SMTP id a640c23a62f3a-b8035641f7dmr335388966b.12.1766147357958;
        Fri, 19 Dec 2025 04:29:17 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bb1:f7ee:1376:35e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f511fesm223648666b.65.2025.12.19.04.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:29:17 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 1/5] pinctrl: renesas: rzg2l: Validate pins before setting mux function
Date: Fri, 19 Dec 2025 12:29:07 +0000
Message-ID: <20251219122916.129256-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
References: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 12:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21175

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 52161035571cd62be9865039b4be65615860dce0 ]

Ensure only valid pins are configured by validating pin mappings before
setting the mux function.

Rename rzg2l_validate_gpio_pin() to rzg2l_validate_pin() to reflect its
broader purpose validating both GPIO pins and muxed pins. This helps
avoid invalid configurations.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250616132750.216368-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 45 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 1ea2dc1608b3..a8887acfdef8 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -518,6 +518,23 @@ static void rzv2h_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset)
 	writeb(pwpr & ~PWPR_REGWE_A, pctrl->base + regs->pwpr);
 }
 
+static int rzg2l_validate_pin(struct rzg2l_pinctrl *pctrl,
+			      u64 cfg, u32 port, u8 bit)
+{
+	u8 pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
+	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
+	u64 data;
+
+	if (!(pinmap & BIT(bit)) || port >= pctrl->data->n_port_pins)
+		return -EINVAL;
+
+	data = pctrl->data->port_pin_configs[port];
+	if (off != RZG2L_PIN_CFG_TO_PORT_OFFSET(data))
+		return -EINVAL;
+
+	return 0;
+}
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -561,6 +578,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	unsigned int i, *psel_val;
 	struct group_desc *group;
 	const unsigned int *pins;
+	int ret;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
@@ -577,6 +595,10 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
 
+		ret = rzg2l_validate_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(pins[i]), pin);
+		if (ret)
+			return ret;
+
 		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
 			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i] - hwcfg->func_base);
 
@@ -831,23 +853,6 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return ret;
 }
 
-static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
-				   u64 cfg, u32 port, u8 bit)
-{
-	u8 pinmap = FIELD_GET(PIN_CFG_PIN_MAP_MASK, cfg);
-	u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
-	u64 data;
-
-	if (!(pinmap & BIT(bit)) || port >= pctrl->data->n_port_pins)
-		return -EINVAL;
-
-	data = pctrl->data->port_pin_configs[port];
-	if (off != RZG2L_PIN_CFG_TO_PORT_OFFSET(data))
-		return -EINVAL;
-
-	return 0;
-}
-
 static u32 rzg2l_read_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
 				 u8 bit, u32 mask)
 {
@@ -1275,7 +1280,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	} else {
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
-		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
+		if (rzg2l_validate_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
 			return -EINVAL;
 	}
 
@@ -1434,7 +1439,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 	} else {
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
-		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
+		if (rzg2l_validate_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
 			return -EINVAL;
 	}
 
@@ -1672,7 +1677,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u8 reg8;
 	int ret;
 
-	ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
+	ret = rzg2l_validate_pin(pctrl, *pin_data, port, bit);
 	if (ret)
 		return ret;
 
-- 
2.43.0


