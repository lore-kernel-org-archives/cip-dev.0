Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCEFE7718B
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:35 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.104388.1734524611205825079
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OY4F9Frg;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436249df846so44538455e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524609; x=1735129409; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgxTatePtmMYlJQsFEFDlE1obW/nLAy4k+ERKlaRMTw=;
        b=OY4F9Frg9sk2tQU/z6CQvj3uuMGTZwDV/vw5jty7rylRBQPZYz6ITMbEJdAmzHUmfx
         GV0GCB7X4ja+Rw34ikCfDW0sJN3sdIusIMOThKcroWr9Uf/t3PhfxzWllyQxlGi498XI
         xv8s0QnaWRvBWok37ocCi2+WMBMcrCZ80XGFAWZJ1BabFu2+s9Lso72MTCdZFAhJKvK0
         5SAE7o/JzOV1Pb3GD9T7GacprLVNIJUlZcAxGR3LGDJb8ErMKvuifDMY5cxEW/j5QqfM
         JcOBgIDwBtjLjpT1mbJBxs0Jh+jVsDM1o3uPG6q0hSZ8oDi8GG4gzkKsoY3KGu5HDifk
         PvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524609; x=1735129409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgxTatePtmMYlJQsFEFDlE1obW/nLAy4k+ERKlaRMTw=;
        b=onZq+R6Cu+Q8Z0r3bm9ZwsWz+tYcQNEsmXoRNvyqoplYHTIUvU+/WcXsu59jnAygli
         y+2GDYGKX3oDHyben52zdYg/PRINjQszkhSuC8TY54KDtD0u1yThD7B2l1hFkvnN7RGA
         BWVJUjzIB+D8usy4kv0AZhkzBl+i0WOhb+RohBl60tPB7gVotP2oPDTZGhEjOtve2b0Y
         en6wkULAqh9KLpXOrgX+DBMQ8V6LAKfBJIeFLx7TWuKbviDgech7K7U+76y/E0RpgZNI
         C8HiiTSTuK9qr2RMQzMsvFPYsjX99HIpx87uDgQRci5ofDcGl/oglSoj/3L0HMAbovLJ
         thhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUetCPl5RM7fyQD+KME4Vqm/ZhMvDgqwObvGwBzD6qQkyeowFEqkMzjTji30I/EKXNmReDVPDlV@lists.cip-project.org
X-Gm-Message-State: AOJu0YxuZRJagbai+CJDgovtvVA39S2jXy2vUnYJX0uy8q3dr+iNVKhy
	LLIv6CKN014ipmra4BVNc6w2iYOSIMt3wamtTTx5WuANOdDOW4c70Fdj+M+Z50E=
X-Gm-Gg: ASbGncuoE7csOKd99L9QlkLLhCQT9PA/ZJ2qFSCUMgpM40otuKi8dYjZcV0S1cBtSAX
	mTbeSqpZ0DnQJEPyUEBrTdhZTR6S3ljKNLe5osLmqXaEKBlTgAnDH/J/+T25EsXkJ05tcZg0/vp
	ej4ac633adyRCYpriGQM/rx6KMZlID2Cq+6X4nyBkrsRpHX7tcQFY0iLsl3mFRvOevJ1VeOBI6G
	X380NXlXP3u5frpUht7RXrVacD/6POdfF9CYR8thFtCPhKP4fxdo+klm3nyv9Vl/zeaR811pE3a
	HwgCdaFrFJ8=
X-Google-Smtp-Source: AGHT+IEkI32YBqLWbo+O1L+Y301UBmt1cFmLplllBKR/0MzVKan82VDKX3amtbwJ+W4x/LNvILKQ2A==
X-Received: by 2002:a05:600c:4ed3:b0:436:488f:4f3 with SMTP id 5b1f17b1804b1-4365536e7ccmr25013235e9.17.1734524609622;
        Wed, 18 Dec 2024 04:23:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:28 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 09/10] arm64: dts: renesas: r9a08g045: Add watchdog node
Date: Wed, 18 Dec 2024 14:23:16 +0200
Message-ID: <20241218122317.2365272-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17462

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


