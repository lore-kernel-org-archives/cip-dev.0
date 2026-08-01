Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC7FC55178
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:12 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2479.1785575709760868915
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ydm72vNU;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso3349225e9.1
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575708; x=1786180508; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NX7tRcHBRSJ4ugBIaGd6BfT8LizFDJKjJnUZfmFr/eQ=;
        b=Ydm72vNU1+bLtNmU9Qk85PuJP4I0BPqtVfXomgnm1gHsd0b1UOeqJOngftfQxP+UdK
         XHhUI8NCjf9gQZTI5h+FASBgIbSSau1ZWstO5f4D+xq0prT6VDMITuMVw+UMheDE7SOe
         W/EvXn0+sWR9xhJeD24DW7sIprZq0bOvJRn+jQrVSczJ9N6B3UMnkT6RfEgj0G4pYqzH
         zAbjKPB8skefLLWpj1bArorMIqL/maCsOvI9eeDq/Ff8lf2KFh4KMPiWdsIElrjv7n10
         zkm68t6+e//PztZCMmIfyyDr+larc+9kxYvPvAFglI2kASpEdek9NBhs5eXp+fQikknq
         EmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575708; x=1786180508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NX7tRcHBRSJ4ugBIaGd6BfT8LizFDJKjJnUZfmFr/eQ=;
        b=Rd4nbjKsf3C6+FYbauPYKoyMbMR3CwdlQ7haQ8vxmWXDyHy7zKFAei3c1sqJj6ynsq
         1ljouRR8mKX5b4EdxgySa/EgkmUWA/zfRLrgx2NzlPZVTHhuZJGjat7GetkKXG89veHE
         Nsr9zOftG74X2bTX++kdFNPzvqBOYsmh97gGxe3e3OVMMq3Ssw03bEv9uFgJVCkMAUy2
         qJ64g8ZP5l7GtuD7EKaG5SrCEJ/+BKIcVVkyqAcNRN60K/Vy8sv9bmMpLfutaZELtdSB
         epUrC3Oa2xBpqdbkMQqrz0McPw5qhePCh3tS6PLfZrHow8GycAbuZMbKmSGJ++CSPGmE
         NLVQ==
X-Gm-Message-State: AOJu0YzdbZu/lcxkKeuq2v/xBHeRAH6B8tm1Rva0z3yNLqZb6U5S1THZ
	/ncpX22sZeJXCEGg5mvt/Y2+IXEY0z16w/5ac80e42DrjU90ur/nmt1fpfl4/A==
X-Gm-Gg: AR+sD13N/YiztdLuNdY7/1KgUk86+biQiMV7DuIO1EquyjcIEB9Eaj0ajq6XwJI5LPv
	NWqmogg5Wh25tf9iScuAR6oJ0BxKbiECQh20gM06gtNIuSBEnfyWRaWb2KwswMhx1XZaDM/Jpt/
	VhgQ0PAjPJQ2aqVkV0W0xXfFk5499b5czLgWKjKOrY93CYBlKWHm7+POAQ7Hc24SBiF8Jn/LSy0
	/eOGz20t0VA1UOkmLnM/IWLlxsM2r/78/Gpf/whDCHPL7x/N96pZa6wbFXolEiD3omtTStVvxh/
	t62KOKGTAyhrlRUVIs1UAEcrBwetsR6W+hHyQo4gGlpICna79t9wHM1HyawDKzGkAKtv2gwWTH9
	Q0QVuoQnWD5kLHCj6cAm/28tLsuwL3Q8n3loYU9v2oLzf/0g2FFK3CvWnS1DoUEBSwN08xKf6Yx
	v8SQJFQVS/Wzy5mfM0wCccqKLyXEt4PV/gEaqD2rOkod6nc1vCTJC4IjIH2GDw/KJKqyf2fMuDj
	UzRE3oyIFpCsA==
X-Received: by 2002:a05:600c:3b10:b0:495:6bc9:62b0 with SMTP id 5b1f17b1804b1-4980c680bc8mr33048735e9.17.1785575707951;
        Sat, 01 Aug 2026 02:15:07 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:07 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/19] arm64: dts: renesas: r9a08g046: Add i2c{0..3} device nodes
Date: Sat,  1 Aug 2026 10:14:42 +0100
Message-ID: <20260801091458.14026-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23838

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit bee6b1251fd2e91de6221bb3e23d2ae1384ffb4f ]

Add i2c{0..3} device nodes to RZ/G3L ("R9A08G046") SoC DTSI.
As the place holders for i2c0 is removed, add the pincontrol
device nodes to make it functional on the board DTS.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505070206.7932-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 83 ++++++++++++++++++-
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 11 +++
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
index 19f2c9f29f5c..323e7d107a19 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g046.dtsi
@@ -257,10 +257,91 @@ scif5: serial@1004e000 {
 		};
 
 		i2c0: i2c@100ae000 {
+			compatible = "renesas,riic-r9a08g046", "renesas,riic-r9a09g057";
 			reg = <0 0x100ae000 0 0x400>;
+			interrupts = <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G046_I2C0_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G046_I2C0_MRST>;
+			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* placeholder */
+			status = "disabled";
+		};
+
+		i2c1: i2c@10090400 {
+			compatible = "renesas,riic-r9a08g046", "renesas,riic-r9a09g057";
+			reg = <0 0x10090400 0 0x400>;
+			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G046_I2C1_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G046_I2C1_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@10090800 {
+			compatible = "renesas,riic-r9a08g046", "renesas,riic-r9a09g057";
+			reg = <0 0x10090800 0 0x400>;
+			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 345 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G046_I2C2_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G046_I2C2_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@10090c00 {
+			compatible = "renesas,riic-r9a08g046", "renesas,riic-r9a09g057";
+			reg = <0 0x10090c00 0 0x400>;
+			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 352 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 353 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G046_I2C3_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G046_I2C3_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		canfd: can@100c0000 {
diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index 6ced094d9f6e..06c6ccac5ad2 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -28,6 +28,7 @@ / {
 	aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
+		i2c0 = &i2c0;
 	};
 
 	memory@48000000 {
@@ -67,6 +68,11 @@ &extal_clk {
 	clock-frequency = <24000000>;
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+};
+
 &mdio0 {
 	phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640";
@@ -161,6 +167,11 @@ ctrl {
 				 power-source = <1800>;
 		};
 	};
+
+	i2c0_pins: i2c0 {
+		pinmux = <RZG3L_PORT_PINMUX(L, 2, 4)>, /* RIIC0_SCL */
+			 <RZG3L_PORT_PINMUX(L, 3, 4)>; /* RIIC0_SDA */
+	};
 };
 
 &wdt0 {
-- 
2.43.0


