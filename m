Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EFEC02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.41688.1737546697422364122
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nbGMQUue;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso49482075e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546696; x=1738151496; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzGO9ARih/R7OvarGAIo/MMNukwFVP28FODqkLvyhug=;
        b=nbGMQUueb0L9oFwUOaMcoEJ9lfnb8jh+pz/PrEa9wOresoH91vNJpW1kVIJrQqEOkq
         zkmIOwIEfQUQNEvN8iznPlVVOnUuntInwkn/6RCC7mC/i0q/vHx69y6GTeKBXS2vCAKf
         yCqgzMrBcgCS+LqOP0CVNUMRKTgtQhpcPwg8TGbBnk0UaXLLok9lRTHiTIQbT9P1EZfp
         9stmgJ/x6atWRUGr3dUpmFLB6z3auMArNWK2cnAHG3jTnmASVntFkq0vX1ZrtS5Rru1I
         zxEUiwzsWiGo4mn/pk+rRZZzk2L6BTuYKqzdPeSO1nn5lGLPQxaOLohncFncq3YVxnEZ
         REBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546696; x=1738151496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzGO9ARih/R7OvarGAIo/MMNukwFVP28FODqkLvyhug=;
        b=Cn6dcLMkIDaFnjYxYEtGNJtxFawSIx1S1mEjh5kRKlH49S05iRfrl/SPfHmvQGvFk1
         m5ldBXiw/WWwMORCKfdARii/IF0+H+JJfl6pJ1kcRkJghe+p7crIXInHx7WJnaz+OdsP
         T3nZoPbdXzN8o+mbDUe/KpI5zfm8iPKuX8CYIERIUw+qfKkBaK5iqyh1YgYLxAjCdCiI
         F6TyVXwj40FULn7j/+2xj51PG66xwmlQu6ttfdsQBse/y3GeK7sLde86Cbqxr5hLpLZM
         eIldKdzqIS6C+8xZScrXozR1QBTQRkMdjS1INXWN143uI1uT9xBGdos00jH54PABK/Ab
         xyIA==
X-Forwarded-Encrypted: i=1; AJvYcCUpzhNKEhpqYwTFa2VdtElZSsWkxmUt/dMqSgSYaTdCAMwveG9NQnzjuYEZATeMvt5P/AEZpRbu@lists.cip-project.org
X-Gm-Message-State: AOJu0YzLUYp6yVVMocTMh5dexW/2h+NlCjJzr0BCLqfXcqX9g6FSKm+C
	qXjnGZiWmRBbPtS0L9GgoeON1+WQR+eCma7DwqNSXpX0zS14z/j6LIifv3CtgLE=
X-Gm-Gg: ASbGncu3DfES2jPbwVBoUS151IFCMCd/NSofnRMlcEcexs8k9xDZo/avwv7i2CLM76S
	8Cqp4mXISa625T6JZBfVVkVQE7EwZQajEbyZUpH1XQBBzrexSqcXfOfqVfzgjy9v7y8YzVwKBtr
	QjeRFJj0Z8Vo4xHubHgmmmSLDr0+PY68UAJBY4Or1PWhBrOUAMt/a8qsdD+9mhtK/ZRS2ASO3R5
	JRNa/rtUKZ+Lcka346c+SjBOSxyTbiHnxz58K8m1Ru9DwdS8PTHLDn17lMZzdfUJxd1xgX87K1Z
	g2PeD0MYSr35axgI0SDQR4g=
X-Google-Smtp-Source: AGHT+IGMmIKZlh76OkaSLUnmOIHcWI3dimcG8iqkQ0ZUih2vNyGGOP4N9b07XJcyaMT66NyDO4QiOg==
X-Received: by 2002:a7b:c44d:0:b0:434:9fac:b158 with SMTP id 5b1f17b1804b1-438a2b59615mr121491055e9.1.1737546695818;
        Wed, 22 Jan 2025 03:51:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 10/14] arm64: dts: renesas: r9a08g045: Add VBATTB node
Date: Wed, 22 Jan 2025 13:51:15 +0200
Message-ID: <20250122115120.2885015-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17573

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 23c44956bce5aa79c060fc3e5d51843735e6eda6 upstream.

Add the DT node for the VBATTB IP along with DT bindings for the clock
it provides.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: the backported patch has references for i2c nodes;
 the i2c nodes are not available in v6.1 cip, thus fixed conflict by
 dropping the i2c nodes]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index f5f3f4f4c8d6..7bc8969a7b5a 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -72,6 +72,18 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		vbattb: clock-controller@1005c000 {
+			compatible = "renesas,r9a08g045-vbattb";
+			reg = <0 0x1005c000 0 0x1000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb_xtal>;
+			clock-names = "bclk", "rtx";
+			#clock-cells = <1>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_VBAT_BRESETN>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g045-cpg";
 			reg = <0 0x11010000 0 0x10000>;
@@ -296,4 +308,11 @@ timer {
 				      <&gic GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
 				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+	vbattb_xtal: vbattb-xtal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
 };
-- 
2.43.0


