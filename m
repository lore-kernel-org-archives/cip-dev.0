Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9240C47BEF
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:41:57 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87303.1767696115103203292
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:41:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jp+Y9NN7;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43260a5a096so502288f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 02:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696113; x=1768300913; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkvbV20gFs70TE6qsmDsKKm4mxx2PzRo5Na2GL3iDSA=;
        b=jp+Y9NN7OzC0qfTisiuCpmWC+LTP7+2f92ZfZwS36Mlm8x115gXw+Kh0fP1DAZhAo8
         luEFHum8bnTUKgg/K1dliVuVG6fCeieTwfOvAaEA4fmfvs6NUCxtLlJzex9IR1j46NWw
         gb8lCDowt+/AhHMQVLXQH3PLFYtlOGcJnYAZuk+ZYOhgX45M3k37u0N7oE7pZ9udNo9H
         htd5nBPqHN/ZheFZgTAFe0N9+EPQDTBqGIecXdZ+ma6nk9vkxzVIoJSIUaRj66p9+UvG
         E5MjUG6dP4Y12ViIinPbZM7loTeUCCPca1HRe+06J0xSW2E7GfIybEITPaIOA306GCM4
         oKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696113; x=1768300913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkvbV20gFs70TE6qsmDsKKm4mxx2PzRo5Na2GL3iDSA=;
        b=q6SOp8v3xMbcoFwbVhlKFdC+1omxllyezSn//8z4uaxlbOZ51RhUy8hg70Sf9nXwvE
         ZR/XYw9WOr5sEcrKELYJF+8wFJm2ygygCou+rn0eh1PEnZZ0GAjbA/tZfxH8vzh0XF4y
         lewmLLP/1dSNq1Mzb6i7rVAUy9DetDVLSu60IG2pEpqAAgdfuE3MAUzeYvYZfm2gM2Vp
         JagCoTL4h2DG38+fg/DT8zElKOj3GD2I1AfGkK3FI0yi9sJXLHGmFZ5J0b1Jl7FfArAg
         NdLmFfFBkVrtrNjjMX908Qpl6IEICOu7hi2t8iyAA24G/NNNAVqjpLhsDGanYriSJeR/
         cXrg==
X-Gm-Message-State: AOJu0YxikKgE0VSJHWIbEZuOGJVICnt/H1WOThVTXGsmiTxADUic43Oa
	wKSEb9C7yiiJXBAhrOCziKRGk7gogM2/FE/Jz46U9v49FnFW9Q1hZZ/EfmzWRg==
X-Gm-Gg: AY/fxX5bYIDeDr0ev4FNGYxNccRYq9Oqv/VNDlVR+HtftRng8mvVid+pfThxhkxUt/U
	F6T1oSx1oQQTy64JfCX5LFtfHD18EWqSl9hSCqj4jShNDX8z7uR1PwVMJKG21ZWjkSaAU6TmoDL
	JMJt7ZLPCE+hbsH1a+S1adQdrR8zaFRk5L0xZLnWTfxQ/htJSQapcXJlZhgUrhIWb51JEj+JNHM
	OWYvheO+SjJ8v/xY5mMR8gHotmS5jSIrIi3Df33TnHD3LsPgP1EwKWPR1dVMsr5P5cPJFDaYDVB
	YnE++2SEhuVskEOQNjZ/ZHm9ByYB4sAbxsd7sAkH18B+27CpeMGcYBtt3BI7sUCOPs2acRL5xw/
	l6GKBYUh8I4YfQ4Mp/dUG2eaqY3kOa2UN8BnC4IZa2t6HBB7sDQrXvSu4N8C6DwHVI7QTP0PYkO
	eP7syPVR7TGdZLWmCjXw==
X-Google-Smtp-Source: AGHT+IEV9mItW+lsOjXlugDQIJl+sx8ULKsW87vde5b4JGLGhiZ+aFOAWdbVHsNUOXWF5CjTd7JL9g==
X-Received: by 2002:a05:6000:604:b0:430:fc5a:40ac with SMTP id ffacd0b85a97d-432bca566d2mr3996898f8f.54.1767696113109;
        Tue, 06 Jan 2026 02:41:53 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm3583184f8f.39.2026.01.06.02.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:41:52 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 1/6] pinctrl: renesas: rzg2l: Validate pins before setting mux function
Date: Tue,  6 Jan 2026 10:41:43 +0000
Message-ID: <20260106104151.88020-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
References: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21326

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
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 45 ++++++++++++++-----------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9935de108d57..be46f02c7c03 100644
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


