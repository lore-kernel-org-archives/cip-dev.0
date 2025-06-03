Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B69C61CE7
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:57 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.6981.1748942388225125911
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bkbgTpK3;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d51dso9250977a12.2
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942387; x=1749547187; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIe74c3lnxezeRHihBqvwan1qGrpCDrEkylOYmq2oMA=;
        b=bkbgTpK3mazpNadcCnWoAlYR0330CxfCFl8hRfCwxEa+tlLXnylFVWNCSofd7iHmq1
         pEJ8053CVrAVQj0Z5aeS6nh7ZDHsZszQ08IlzAuQepFzjBL4FfvBJeXuLenYKxpPEm7W
         Azs+ELhRH9fdUFw1zB6AWhfuPuFYVJ4TysoEB94IzgPoN4uv98SGEBEkbTA2OrE7lhBQ
         rNoXBG0RgsUzaw2yjr4MVr9ji1MY32B0ebtG9Pxti/VTe43qlP9U+pR1/ljljHq1P57w
         Ct0ckFYaqC0H2c/uzucs/ZI98E7U60/iuYdTls6OzPFvwGDxnmw3m4TW0gZdofjSp2pi
         YU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942387; x=1749547187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIe74c3lnxezeRHihBqvwan1qGrpCDrEkylOYmq2oMA=;
        b=a9AfwIrJqiJ07eoEEWfgVdEbbXom6ucscBhpQTVycpq4MpenBSxg3lGhIVKGMISCbD
         8h8SZz7HHqkk8h8d/Ryr8+DE/Q2yOPYSsN63+stEXxYM6CGXH2m0dclzm3lC3yx0nFmG
         qTIjGVOrSvxbd4XwEJ1C3Wgdqwzq0hDaTrOiSoSY1/BpgoNr/N4M4zRCvfmM7yD27fmx
         GhWoLtHWB8QT8P1a7UGh39JlXGExI1ydpfyR5ikxKen0dWLfoK3bKKtbfyarEh4+2xKi
         /OpLcmvqnOOsMu9NPvPc42f4SjlgrW1iIJeKXsr7IA8B7lkpJlcR0ST2FyX9lSPP4nHU
         5MUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq4te0ehhr5B18BvdkKJe7g32XgQ33BGYRTN4KqtwiL1E39FATdsowNKZhrmBkBBShzFe4cKbZ@lists.cip-project.org
X-Gm-Message-State: AOJu0YzQU0Wnwm0FG0vItcTVA8rZjJBZW0pc2dHr5a3pbzhF46ZUiTOh
	oSNybIl4oNc9AqHnbjs4LvaDGysT7c1m96MO10maCrRtp4yTDfFu6Tcuay3UfHL9Rl2lAdqzqGo
	c0O77
X-Gm-Gg: ASbGnctu9cIRS8hgLMqDzOsS7KImPGqypU+Adxpejf0Eb1+1UtF3SxC99CdFzLcN5JZ
	f4vGl6N17LyN5M0PPbN1CrU4H2sr1vjwBmLXojJjwMw1dPjYHdyVQC6KQYo2EK9q9UAS1Uy+pUY
	AFwQ2Kr7syuAcS7WIVuz2Tmzj5ArWwBMZlC+u1uwU2VUj72eWOhIeH7C5hDnvzHjvAnsG/TiZ5u
	blR4xS19jFxyi0SAk6Z8mFFHjSSQmK4JWCjqXtGRtCMBUft+RvRL8VpOv9gen44ckHzUhe2ph4S
	SUDgAHmk0aqVwDeBNvyVR2yeENQss/CYYrXcIgSqo733i1mNOM0L6hdCcElecDdgpeBLx2eZiIq
	4D0dEuxPWFmVSz4r2
X-Google-Smtp-Source: AGHT+IGvTxxMQB6ucN67I3q/lxQlnsflxOG1WZPNt5sykqJqQWFB6nI/U3/ZLZQS+06qPsauq0Pdaw==
X-Received: by 2002:a05:6402:210c:b0:601:f4dd:8572 with SMTP id 4fb4d7f45d1cf-6056df48906mr17607207a12.17.1748942386662;
        Tue, 03 Jun 2025 02:19:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 4/8] arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
Date: Tue,  3 Jun 2025 12:19:36 +0300
Message-ID: <20250603091940.3917581-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18978

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit aaf7188d7f77bb8a6e043c70dc6cc6616c427762 upstream.

The Renesas RZ/G3S SoC has 6 SCIF interfaces. SCIF0 is used as debug
console. Add the remaining ones.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241115134401.3893008-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index c317c23adc50..5634eff1e921 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -87,6 +87,96 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		scif1: serial@1004bc00 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004bc00 0 0x400>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF1_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF1_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif2: serial@1004c000 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c000 0 0x400>;
+			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF2_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF2_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif3: serial@1004c400 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c400 0 0x400>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF3_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF3_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif4: serial@1004c800 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c800 0 0x400>;
+			interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF4_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF4_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif5: serial@1004e000 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004e000 0 0x400>;
+			interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF5_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF5_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
 		rtc: rtc@1004ec00 {
 			compatible = "renesas,r9a08g045-rtca3", "renesas,rz-rtca3";
 			reg = <0 0x1004ec00 0 0x400>;
-- 
2.43.0


