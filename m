Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFA4D6E2A2
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:25 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44882.1766071943612695289
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VmD6RLCK;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43246af170aso455540f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071942; x=1766676742; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn2ZLvgJ1JoZWlD+wapq5lUL7Z9+qH5Odewup+4seLA=;
        b=VmD6RLCKlM9fn4Kr5sDxgEnzlmfzXUMpoa9OO0G+wY/kslC0fo/gR3eDaWfNH2EIOA
         dcjJ1mbhztYONG99BycsO5MKb0IqKDMPHhrgk6CfLlCN2a4FCyx2ODuZ2B7O4XPfCrad
         l6zhdONBYIBeyYritsUQsWKU9JDQdBk6DBZ+Te31lpqUXdU5hYzB974HYNuHslazRUmK
         WeJdFtj+DWIn8fq/7eyu2/6Oh+9v5vOZblMgpawtdYpncUHUpOTIb4wmmx5Ezgb0R/wR
         HTNURzVYdUJe5NEOrqWTj2Jywk3oyqd108iPGDebX1vyzCrDrBRVH9rx0mOWxRj2T5Br
         el3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071942; x=1766676742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jn2ZLvgJ1JoZWlD+wapq5lUL7Z9+qH5Odewup+4seLA=;
        b=Gzve7eCkdMG1+TnnRQ9Wilu/UUOGYL/m86oPSHAenHihgcws9ZPbrG+qX83Xn2KMvS
         Ti/w4qiuiHZNEdU0eKp1N1/cfJFEK9WtUSPKu1X8wqpLvDxDqUpjV66kITb1YU9uP9t8
         EESEZf78ZytvrW2gfMqKU3TAzGPq56E9JsbVQHulsll+1ECaXikIaZEBBwvbGllXGrpG
         MJoGfayOIqPH/r/30qiN6Gbzjb6qsJS+inaSHtxBeo958rBYAUuRSUXWWQFA+27zuVy+
         t7Y72ukCcRaY1vIjUMrMQ17RCMMntwuo/6yNqU7ZqJ5N3FFtu4DKgUZOyrsYG89pchXc
         X2OQ==
X-Gm-Message-State: AOJu0YyBfQv+HckKAlily4grrQF5gOr8oGvVqbzjfGsjBKZeuDYEQJL0
	v8vp+PYR1QVW76GPMRewM51Y0brjLIeILds0M5EU5miU1XEEHg9tByxYq6z1UA==
X-Gm-Gg: AY/fxX6EOAwVX4IRUTajccX7HOvJWkBWTqFcOyeeAtFSSM3zXj/o1gUF0j8FABW5ore
	L2OsV5Nfxa3ltspsguX13zUqIrG+YAqGirH4aBpAu/HaI/hr5e8kzI0hz2ArZnYwxBMUlaqICFj
	an3sjPhlu6kri4trel4RMjp4MMLY9RxzcHGIzRPEjcW2sdoVY4uJBbYIQwcHAtQPYT67C+JJhf4
	FtNp2NE5c9gynqonLFGOnNMUJg94ggcStm7tGQ42CCHZ5HVN+aX5jrmLlqxscHJVFqoG7p4x8ac
	bzo2FPT8JcaeIzAE15xhDnGWFOEXTWqGWgdGdEOmQ6yyBVzPkawvd9ivxUZOJRYuw9JjX4r9Gl6
	bHd6dR6Sziel6DA+TKn6/8mRSKaxMP7+GSxIctUDobViWruRSjj7uHxJ4xeqDIGawnqM9xgWfBG
	fEjEZBBQROuULCooAHGg==
X-Google-Smtp-Source: AGHT+IHOJeAPLm52SvF7n82SOTeKPDQluFFijLgFLaVRUjsAkTJENI/9aXafX+vIFMt02H3iMx9oew==
X-Received: by 2002:a05:6000:2407:b0:430:a803:e49f with SMTP id ffacd0b85a97d-432448b7f43mr4391490f8f.15.1766071941665;
        Thu, 18 Dec 2025 07:32:21 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:21 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/12] pinctrl: renesas: rzg2l: Validate pins before setting mux function
Date: Thu, 18 Dec 2025 15:31:52 +0000
Message-ID: <20251218153219.228506-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21128

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
index 062e109126a4..f8330265336e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -517,6 +517,23 @@ static void rzv2h_pmc_writeb(struct rzg2l_pinctrl *pctrl, u8 val, u16 offset)
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
@@ -560,6 +577,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	unsigned int i, *psel_val;
 	struct group_desc *group;
 	const unsigned int *pins;
+	int ret;
 
 	func = pinmux_generic_get_function(pctldev, func_selector);
 	if (!func)
@@ -576,6 +594,10 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 		u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
 		u32 pin = RZG2L_PIN_ID_TO_PIN(pins[i]);
 
+		ret = rzg2l_validate_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(pins[i]), pin);
+		if (ret)
+			return ret;
+
 		dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",
 			RZG2L_PIN_ID_TO_PORT(pins[i]), pin, off, psel_val[i] - hwcfg->func_base);
 
@@ -833,23 +855,6 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
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


