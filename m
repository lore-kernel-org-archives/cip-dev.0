Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35652E7718B
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:05 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.104363.1734524577719746594
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iPDFNgxF;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so4384261f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524576; x=1735129376; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgxTatePtmMYlJQsFEFDlE1obW/nLAy4k+ERKlaRMTw=;
        b=iPDFNgxFEB3YjmhrRXGWhyLUwIUpCCc7ynPQsgfRJhLjPThMyM08B8xPgkepjzjtvO
         CfwdeWMIenExqYP7/8f4mG4oOLdAG5Uo5Sh3BRo7sgNGjYVrxmMT4nE/AkWKQqtJjSpI
         mJEKWhDbjbD4a9HPzMTS4Hfxj7HohTtqQEHfaL/Gv3aJsrUmYv6hgDwN0XEv3AY01S0n
         PgegmMYjzmFdK4TDvOLMEm4W8O2rTl4yomrhXceIb9efMzKAHJ1PsnjeZrL+urAvK1q+
         qfOz7vUeEERqA2af+xVp/lbTBxP0QmFlllvhpU/i2+m18uNdSmAW3ApMaNG8Sx4T5ihv
         cK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524576; x=1735129376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgxTatePtmMYlJQsFEFDlE1obW/nLAy4k+ERKlaRMTw=;
        b=EwtIgEENiuCFUr8aIudakiVCdemdRHk+0jIg/hhjPTZM12zzaIVtA6gHQJX/ctQaNf
         gHbkdYBekIIi55QHeeMlIoEbyWzXrDW92LZ8QLLF62gDeq/W9FrKgFtxQ8mbqBQ8KFbp
         xdaEqNlpMzEVaLs+HI9r/IOYKNWkNjTNjdkUk5sw38M9WVKZrYKhwN2HzcRo8kJMGjCY
         3z2CdJ4WqeztMc3FuO90JuMd7FMRRI/Ee17XG2H3Wmum/Ul8yaDC1BkH5+gQIwy8hEsH
         RUiKMi3o0+KFc9vbQgpzZ5nhy9wCELLc+d4I4dfuBO8S1F5uy+ExRPxcH5s+ZkjcTwce
         9ZLw==
X-Forwarded-Encrypted: i=1; AJvYcCVRfDUZfNy4BFUN1ZkeZOptE1A6Gf4VKOizaSsh5V+eUPVLeTtsT00shoKEx1rXGouQ9TBnKynz@lists.cip-project.org
X-Gm-Message-State: AOJu0YxgIFT0L5fw6XfG8Lxzthh8Xa/XP4w9aVC4HZ1NgC5TrlmNUz5Y
	1VOZbfZTRFbxiI3aNobrLXiadJbhtmw8WjuNpmxGJP65pjIX+nwJJv5j6NuS/X4=
X-Gm-Gg: ASbGncvQVQpuvXN8TwlkdO+WgijZ+mWbNhArrfYfn1UrXdiYLtpYJV8e68yiw6ruy/k
	ef2POIbhM/2aVn25BeRL+7A3SG6qZjbjCBzd2b0FYCZqj3+Lg//hT/3Glij6HkpiJgg1Hphdh16
	qECeqjGh7cjPEXbyvaBbAhZR38mIJk5QgQUYQGDGfwAB2OSzqIm/r/7ZxhTiliiN8hYnzNxhb7t
	uYN8s+z2pNQkpdi3Vv0eK+/Ba9Ij5V0lX+WvyHg+V0tFu/ug8ORGOoCg1HCNokJq+cFEFjO8OqA
	GeQKs8zgZo8=
X-Google-Smtp-Source: AGHT+IGGa74TGxXM+6aBwjYyYwIf85/ZnJsH04f+87BdwwbRFuscwHirXlP3RkWtarpt7cZTRoMFXA==
X-Received: by 2002:a05:6000:156b:b0:386:3825:2c3b with SMTP id ffacd0b85a97d-388e4d43a86mr2520764f8f.18.1734524576162;
        Wed, 18 Dec 2024 04:22:56 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 7/8] arm64: dts: renesas: r9a08g045: Add watchdog node
Date: Wed, 18 Dec 2024 14:22:45 +0200
Message-ID: <20241218122246.2365189-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17451

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit cee7bef61f51c04c9946cf4ddb81e85d9c1833d2 upstream.

Add the DT node for the watchdog IP accessible by Cortex-A of RZ/G3S
SoC (R9108G045).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240122111115.2861835-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index aba6b0383778..f5f3f4f4c8d6 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -273,6 +273,20 @@ gic: interrupt-controller@12400000 {
 			      <0x0 0x12440000 0 0x60000>;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
+
+		wdt0: watchdog@12800800 {
+			compatible = "renesas,r9a08g045-wdt", "renesas,rzg2l-wdt";
+			reg = <0 0x12800800 0 0x400>;
+			clocks = <&cpg CPG_MOD R9A08G045_WDT0_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_WDT0_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A08G045_WDT0_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.43.0


