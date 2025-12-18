Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2003D6E2C7
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1415.1766076971825870800
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ItjzscGV;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so422087f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076970; x=1766681770; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZ8ARQeiZdoK8n8/6yZVOoQn7O/zelHr7XBlEJrXBwA=;
        b=ItjzscGVFmFOzGbAi8/fUg/h6BlejIQQygyW35Xo79IZeT/cwJUbWMQeTeRXmBKkr9
         S/c25y2XztbGm1jcddzH/36jcqcHlBHQF1zp27wjXwjLi/Hw56V4e4Z8tFKlmwZNAKhQ
         g+qVXJfq9apk7BoKbKnHrviBSDdHJ6JmXvKB96zIo7wlXJ2yPvaW/LdOhj/mbXcDJUYJ
         RYRLu8HNB7VDOart1dWz9/enm/RR03gD9lLCGp51p8wFnSofqhqOYaqDwntCogepnwae
         Lm8XWMHpQBvSeHRIXH8xAIaheXoH+k/LAuB/GPOJkmNaojd2QHhyPs9gCaVLsHOpslVl
         UCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076970; x=1766681770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZ8ARQeiZdoK8n8/6yZVOoQn7O/zelHr7XBlEJrXBwA=;
        b=K1L138G2ce4u1RUQqJ4AV8C1lviCC0qHhRG3J0nnIeBPpmvwYzshYWTrbRZtys4K2i
         tfLGvWopANhK2atGJJfndi1FsTUvegY/dBh/RI/VM8IEDU56zdvaklvSpJcs30bTD8xZ
         Owj4cYwBgqzPtPd09GpgP5K+/ZBDImmR66/Yx2r9AOR8AuAmI6H63/JzhRemexFcAYYN
         NY1Yt5Jo/pLyTDIQNbnARyX5MlrCEb5Yablpqc8JhBYD58u6Xpmfb9ycxXXyj71dahFw
         YRFLzqNYZQTx9Xoa1xFpHG4CnoCkSRFYgKaSTfWD0X1DO81VHiTVZvgnW9jlV2lUwUa1
         kdmA==
X-Gm-Message-State: AOJu0Yx7diRb53ETBhxr6kwXgeqFupA1iPJ4SOyPpFJv8qAHF+qHtCVM
	k2a5k+z9a87/8Sm+FQQp2oC3TrsA6Qux4jPwMk6nvh9/iYRyBTXibfxucMFtoA==
X-Gm-Gg: AY/fxX6j+9qd6pVT4QDdzWWlD8Oo0dU2YyWTRsyQOw++1h3LnDcD2exzBfcFx5SVJCE
	2lJixPCEff4f9L2IaTTQO3Ei0O71mtbER5Dmmc5LylJtIW3/cz2pXnDYFEN7bjt5OMHi5ND8hsi
	Vq23sueYAgJkhd1dzb7g4yXE2xx3dpHLBfOL4m0yiWq+E+uhoT5h9+3QJXawspSYapkfNv8POzS
	IyamCJsgNzFUc982LW+BhL+A7Efrw6IG/FWxzi4dUiJdRg2wPJG8x2+yjDY+rHLxpDgUNrvkqcU
	nq7V8mpWTBu9jp2SMOZjEVwpYlQfO1CRqRnkcriQxbHvaXBB8G7RzMTMsXmXhg1Jn3RcLtrH9ei
	nPZto6HwxoTYtDJ9PSeRfUa76piY453m9LZtuSrC1hZIFVA1Wqg9isn9B7QOgGvlX3GtL0KV0GW
	Pfl3Wo3P5c47KyoZB5WQ==
X-Google-Smtp-Source: AGHT+IGWqiWNNyI44vIGBKlbeHSMvD3CK8UClvhsXJqpfiTM/fOD03KXJdMxm9b9DINiCUkf9Ju9Nw==
X-Received: by 2002:a05:6000:1ac7:b0:431:a38:c2f9 with SMTP id ffacd0b85a97d-4324e715c6bmr143104f8f.63.1766076969938;
        Thu, 18 Dec 2025 08:56:09 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 19/24] can: rcar_canfd: Use devm_clk_get_optional() for RAM clk
Date: Thu, 18 Dec 2025 16:55:18 +0000
Message-ID: <20251218165600.258194-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21157

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit eda3d6c8d784835cec86f42b3f8118c9eb0cc58c ]

Replace devm_clk_get_optional_enabled()->devm_clk_get_optional() as the
RAM clk needs to be enabled in resume for proper operation in STR mode
for RZ/G3E SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251124102837.106973-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e6a90fd94f4f..668980e986f0 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -469,6 +469,7 @@ struct rcar_canfd_global {
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
+	struct clk *clk_ram;		/* Clock RAM */
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
@@ -1977,7 +1978,6 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
-	struct clk *clk_ram;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2067,10 +2067,10 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		gpriv->extclk = gpriv->info->external_clk;
 	}
 
-	clk_ram = devm_clk_get_optional_enabled(dev, "ram_clk");
-	if (IS_ERR(clk_ram))
-		return dev_err_probe(dev, PTR_ERR(clk_ram),
-				     "cannot get enabled ram clock\n");
+	gpriv->clk_ram = devm_clk_get_optional(dev, "ram_clk");
+	if (IS_ERR(gpriv->clk_ram))
+		return dev_err_probe(dev, PTR_ERR(gpriv->clk_ram),
+				     "cannot get ram clock\n");
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
@@ -2136,10 +2136,18 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_reset;
 	}
 
+	/* Enable RAM clock  */
+	err = clk_prepare_enable(gpriv->clk_ram);
+	if (err) {
+		dev_err(dev, "failed to enable RAM clock: %pe\n",
+			ERR_PTR(err));
+		goto fail_clk;
+	}
+
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
 		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
-		goto fail_clk;
+		goto fail_ram_clk;
 	}
 
 	/* Controller in Global reset & Channel reset mode */
@@ -2191,6 +2199,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_channel_remove(gpriv, ch);
 fail_mode:
 	rcar_canfd_disable_global_interrupts(gpriv);
+fail_ram_clk:
+	clk_disable_unprepare(gpriv->clk_ram);
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
@@ -2215,6 +2225,7 @@ static int rcar_canfd_remove(struct platform_device *pdev)
 
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
+	clk_disable_unprepare(gpriv->clk_ram);
 	clk_disable_unprepare(gpriv->clkp);
 	reset_control_assert(gpriv->rstc2);
 	reset_control_assert(gpriv->rstc1);
-- 
2.43.0


