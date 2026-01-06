Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48438CDC17D
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:06:29 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88524.1767701182712559303
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:06:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CPiq9s5F;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso6503835e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 04:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701181; x=1768305981; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn2ZLvgJ1JoZWlD+wapq5lUL7Z9+qH5Odewup+4seLA=;
        b=CPiq9s5FtK92agyv2NY93pTDxsmBWzYZH/rwIObIUDkQZfiZ0gY/oAA50C+Site2GX
         ZuSdyfChJoWaNRVjsUcyYsTJ5M53HNpwFJgr99cChxbHe2PwXyWSCQM+Z2K/nL2E0SN2
         DZg+eHuHjEG1/XF/VRvcfDi3YX2E1WYEHaNFmz4oq5oAsr7626+dsg2oDmUFmIdMHCRw
         QQiNa3Dsb1PXUuYdUB3Bv6A2Ao2qfb/O6UpbsRldM0ZHOv3jkyTYnR6DTgBfk8DyVkBt
         FXFFlkZnTJ1+Wuom3PhlLiQKJ/JAgHYxIDNMneSFfFUYNcHxr3A7OUTdFYeyAwgztlyn
         CkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701181; x=1768305981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jn2ZLvgJ1JoZWlD+wapq5lUL7Z9+qH5Odewup+4seLA=;
        b=KihpeptRORWlDODHBY+3QNpcY3wf6ca/Kh4ftrMZxXdTSlUeB4PugmtERygHd7E2W6
         RHA5yo5eAuiVF1zUJxbtC51fotigUr4KYo8c9d2kjMeqd2AI7gQfqzV3nDcG9SBS3uGD
         D1KCxN4oP4UVzXDNxLRZe4qPgfQr/Wtb2Bq9I+9Y5FUDGXfvHNaowb9N39w2rAkx5avk
         i3kWg5UcOJa5fRT6t4sJ3vlw1Enr/YkKfIfNtOuM6oRIG/FlmwogfdT5I7hnlT8aJDfI
         p0CRmjZf9PLt3NBA+4md1ILcvjvtvelXSjjgT/H0Sd2B/gu3tj7jo7kP8c81LLZyxk8j
         GOFQ==
X-Gm-Message-State: AOJu0Yw+h3lA9QfRJ5bbw2XIeh1spIUkUW+CTAuxBZEaq1YzjAzw4bNi
	N9mJ5hDuK+KYYUH73ZuwsG+NCyi0FcPzNIUcGYvJKAlW0VrRaEnIPIpYkkfLHA==
X-Gm-Gg: AY/fxX7i2o9yuY+3MpP1oU3nxJl79tG0I7f5v7uiq0HfueNPnQBJ/fFGXARvZHMPQsK
	8+wEJBYTKjvF8pCBwota8jGCwn8GKD5SlPJd/ekeUv/+AgESB+u1rAzFJ/lQJ3u50lT+VgVjev/
	3fUwPZOD+QIJQBBWCzN/rj9FtfIs7R9rdyRtPKygPYnoz5MxpY/oKIov3rq/m2KMms4rg/HGymy
	L5HfZcp3xLXCRvfB7G+62/70QqeL7yEga1mEvKlV928sNMUREpAznzay5jTNIV/XDItR+Qfmf41
	SXcsAUr3WEGOCtRC8FZIouH1K6PK3EYQYaKtaavwBXPpeDWXbyPDvx3RTqxaN2U/FNSqSmYojXp
	gLpZKoD/Ra/Xi4gv9lV8sUl38IXy/CekPEAikS49a8jGPunosglX9msvQCuA8HGEsMNP6d6Rhff
	qiZ2QepftYBnGH0FNCkw==
X-Google-Smtp-Source: AGHT+IGskfaka15VfeY9785cVUvCZF2VyisZokTZ6+TIj3LMxcgOg+kvaR/CsX9gvwu8yyFTUaTnxw==
X-Received: by 2002:a05:600c:3554:b0:477:bb0:751b with SMTP id 5b1f17b1804b1-47d7f0a2496mr32135125e9.27.1767701180810;
        Tue, 06 Jan 2026 04:06:20 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41eb3bsm41594405e9.7.2026.01.06.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:06:20 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip v2 03/13] pinctrl: renesas: rzg2l: Validate pins before setting mux function
Date: Tue,  6 Jan 2026 12:06:00 +0000
Message-ID: <20260106120618.181104-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
References: <20260106120618.181104-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21363

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


