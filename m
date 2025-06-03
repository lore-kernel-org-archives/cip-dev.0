Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC99C61CE5
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:20:17 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.7117.1748942414271192515
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:20:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Qc0le8YB;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d54bso9662192a12.2
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942413; x=1749547213; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZprY/s2douEtKiOsefldNxA5kNkxWI2dndy+8sKMNx0=;
        b=Qc0le8YB00oB4+QLyNhCQUCNEqer5d847iMWBq90JxTm3ZtEXSjLUloA0NrZ6Lv38E
         p2Mruj2Vhx7DOB6PdVPGKvNFOMvsdZxIaAImWg1gSjFv0JXw8pwajhhu4dkbsnXaSSMT
         5jC68ieSyLv0WTIRel4m5XeO6MxDE46ZO2tan518CKvQMCUJ8I3Pgnc3kquOufY4xLKS
         lCXutCH/oTgqlw9XbFu82Am3l+ncHA9r3t6niI+u+CdYJ/LazpEAtmZkmyKoFMPtk5bj
         xW074bmhcu1op5MribKyFexdUFTlf46ltrdTUL2Jy0OsdS6okf5sLAxeEu6z+DobojHK
         qADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942413; x=1749547213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZprY/s2douEtKiOsefldNxA5kNkxWI2dndy+8sKMNx0=;
        b=c8UnJDPyPobxzGCvo6aTwgBI10smxPSgOJVe+FZkvulL2gPb79vEg8eJBq9srQaKvZ
         lkCuiHOPONrlYkFTUX9QlTfL/gy7ZU+cilJkTFn071GIOjhq6Kl/PX8kvQlfxfUPUbqE
         0AyU/kWXBLgrFK5QjMeMz/MztPe626BBUOwIgwbe2PYSQX3iRgk5hEQgn7b96beXkAce
         dbg1ui5gqw+rAYIk7SYZiwuhaNUtxkhStpepew+5LOAV4C/fLJtHmwCBJxx1tHBuRlzY
         mx3TGdWeXVVrCd3kyWREcp62uEWVzjp4IX/3XiJEFn8fA5w9vk9uX8DjdHerCAP3zLIZ
         uYhw==
X-Forwarded-Encrypted: i=1; AJvYcCUF+951HoMn8G7XxMrh1RUeWkM9FB/4L0jyFDcvsAX/3Q8oBzmMgIebaHW6o0ugIusqxbF6Cd8n@lists.cip-project.org
X-Gm-Message-State: AOJu0YztfUn57LPALP6nUSxii0Nh67t0Ar23JGpuNZQxN1OITZORsuqK
	Xu0E94I7P2R6x8L7t24jcpNLG5J1hkVY0CB/JmvP96QCqCUym/+EljzCggOVMNGZzRo=
X-Gm-Gg: ASbGncsPiSjEBzBJNCJLv4qTuAqQk3pSB87qUibTr3hk7tbeSxw9S9axT/PkqOmb2RF
	FY5BbMZiv4wHzzJE4roqrlvD6fpaiBBPnkQbtx3VSlMpet8gwUtToSHEQ9/5BFRs7VYM33oMr8l
	o4iXp1Y7m07uCHwgJzGcRiX9ibARW/F/qsn2QVkudaFwk0HLvSwpZw0SHl1Qwvzlo3T1EJdsaVh
	Xbvx8Kyp1srJgwaoMAV1Z5PZiOf6q349nRyJ/s79/Da0Zd2UzdqJ2rnHNF43Lv3tehYI3/YzYoi
	JMIwDeulz8essI238WzIJTtAvGn9ogpDczPJznuuBYzZ+NkIBnHxFX/a4RhGdrbQ8qmnfaroHV/
	GSDH1LY+R7JPGrEw0
X-Google-Smtp-Source: AGHT+IHsRrOiD4GPMtt4Y4a7+ctCTSwAZrKn8/V/1Ho7B7ii5nlY9d4DRcjt5AiWDKRd/TRLiiQQdg==
X-Received: by 2002:a17:907:3c8b:b0:ad2:4d69:6da5 with SMTP id a640c23a62f3a-adb495d7f62mr1133079766b.57.1748942412639;
        Tue, 03 Jun 2025 02:20:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2e220548sm817017266b.109.2025.06.03.02.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:20:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 4/7] arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
Date: Tue,  3 Jun 2025 12:20:02 +0300
Message-ID: <20250603092005.3917850-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603092005.3917850-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18987

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
index 7cf8587bfe0f..1707d47a09df 100644
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


