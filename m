Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1721CC5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.6967.1748942351052649442
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oKG+07V+;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad93ff9f714so980139266b.2
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942349; x=1749547149; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5mWeqrusKpqUh037VjpQedgL+L2dc6PNNHq8av6zqc=;
        b=oKG+07V+PX2vxCAuB6zYBKgRicy0/B5umuix29UEddm+/whKl5n4dT2BLene4Y/ySn
         Hs4PS9aB2RXJe/vGEfL64qJhBTrmq13JzzlsfDa8X8Sg2MXNHbm+/y/A1+opz2J5R8T/
         FEKLVlEtIPDZRIZSHf4Dvy2itxiaOa+iLBnCA1LDIApxhFTELDILnEoNQVUodLXRngFu
         dvnLdrVIYc155oeYvrc0vrl42dLHZf/WAfQppfPRKUh4AzUs/awecWiXYTGKFp2Bp2Ns
         gDo6uhJeEDlNH+ArzbwKtLf24N0o4eSYjU0gMmPDCLCd4YD8f2tSZhk32DRHiv46x/sf
         209Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942349; x=1749547149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5mWeqrusKpqUh037VjpQedgL+L2dc6PNNHq8av6zqc=;
        b=Oy0JOh+IcCmWUCO6EP6WlRrWRT3c3PKIdfOGpOGqyiLLVI9oGgL1Of5I+ZzUm6xqdU
         eNLV0lCHEMijDGcRvHZsYw8LEVw7sShst4j08g/LcebofO65MkkcbKomIMZRmzVfjzhB
         AmomUDwh5TYo2XEeR5gPWwRn62oaQBfe9nOreLDPXJqoCBMYVv8xmf3iL56JgSK738EK
         Ih6ylYX7ZUYJGGD2MT2c8YZ7LrlaNQSnU+kYqlfRmzsToDJK+/nIS5WjRVCd+zbtTC5z
         Qzd6QWJJ5Pjn+OtUFB+CVzlDxVAElJSO8mXlgAg6WNcAsXvMU/3RHeZ3owTCVUoqVSj5
         1RNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs42lkkpQHD/X/qieGfmpqS3HZ1KXkUAug09/RwVVRrpKZWAu/loqARKHoki6/ueF3NYzyttOE@lists.cip-project.org
X-Gm-Message-State: AOJu0YxjokaUq8dx/jHv+1oWCN7HnajVamFQSnzElFSi5RI96WdXtCFx
	NDs5/B9oCYjHIMOBjtNlcx2VOIxvA4TKrHCVHd1biHDDFh9CCY5X9lY2ZGUMxUNRz7Q=
X-Gm-Gg: ASbGnctCh44mkF4Ha8Hx42OcnK8aZpPNjC8fVvkSDBiVe5VUuK0X21hCapDaA/OYJmW
	5DxqxjufxhaYIW5DWi2K3orVqY2TNuSZvHzAuNJyD7JiqKCws8VRp4+PeyNp1DmMPlEI98hVfah
	niceIguaLuj+85cBpEbVndcg2jMUOh0mO4WvkzW2ppXxsIqiLucsUEbJZXXomChTfGCK/7ithvj
	cKFMQJ2+fUSYupZrIC+RLG2Oe0v2wlXffkbtI4WVzpo2HiH1A3Kg8WdkuYzhAdZlRnuL8h9umOp
	hQTpEGADZoEJQk2vrLvNmymc0Vu68CxdrW3P/Q2Wv4Fo5vAgZpqZoWPNhZsNkDsGyc/kEwFaeDB
	H7ZG7vQ==
X-Google-Smtp-Source: AGHT+IH0CzVmjlPNxHYBqLrvCIKan72bpEwl8hQcizwngOVK9gl5e0C4KX739JBYsk2dWFECCbS/4g==
X-Received: by 2002:a17:907:9623:b0:acb:5343:e75 with SMTP id a640c23a62f3a-adb36ba4aa3mr1484945066b.34.1748942349396;
        Tue, 03 Jun 2025 02:19:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 4/8] arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
Date: Tue,  3 Jun 2025 12:18:59 +0300
Message-ID: <20250603091903.3917202-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18969

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
index 7913820d88e7..3a8ddfbe1aff 100644
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


