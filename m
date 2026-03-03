Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6947EDA6AE
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 16:55:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23420.1772556895103688060
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 08:54:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: /tprqexkSYqivO/kEp7z7Q==
X-CSE-MsgGUID: 5HLErye7SOWrD3PX0s8yjw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Mar 2026 01:54:54 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.13])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0E2D640031DC;
	Wed,  4 Mar 2026 01:54:52 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 08/11] arm64: dts: renesas: r9a09g087: Add ADCs support
Date: Tue,  3 Mar 2026 18:53:48 +0200
Message-ID: <20260303165351.914437-9-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 16:55:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22068

commit 4ed27b4fdeb166821d84ddd64d40c28f7f13b794 upstream.

Renesas RZ/T2H (R9A09G087) includes three 12-Bit successive
approximation A/D converters, two 4-channel ADCs, and one 15-channel
ADC.

Add support for all of them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251005111323.804638-5-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 6cbee27a0c5a..9e2ad080215a 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -229,6 +229,72 @@ gic: interrupt-controller@83000000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
+		adc0: adc@90014000 {
+			compatible = "renesas,r9a09g087-adc", "renesas,r9a09g077-adc";
+			reg = <0 0x90014000 0 0x400>;
+			interrupts = <GIC_SPI 698 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 699 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 700 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 701 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 851 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 852 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adi", "gbadi", "gcadi",
+					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
+				 <&cpg CPG_MOD 206>;
+			clock-names = "adclk", "pclk";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
+		adc1: adc@90014400 {
+			compatible = "renesas,r9a09g087-adc", "renesas,r9a09g077-adc";
+			reg = <0 0x90014400 0 0x400>;
+			interrupts = <GIC_SPI 703 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 704 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 705 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 853 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 854 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adi", "gbadi", "gcadi",
+					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
+				 <&cpg CPG_MOD 207>;
+			clock-names = "adclk", "pclk";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
+		adc2: adc@80008000 {
+			compatible = "renesas,r9a09g087-adc", "renesas,r9a09g077-adc";
+			reg = <0 0x80008000 0 0x400>;
+			interrupts = <GIC_SPI 708 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 709 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 710 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 855 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 856 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "adi", "gbadi", "gcadi",
+					  "cmpai", "cmpbi", "wcmpm", "wcmpum";
+			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>,
+				 <&cpg CPG_MOD 225>;
+			clock-names = "adclk", "pclk";
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		sdhi0: mmc@92080000  {
 			compatible = "renesas,sdhi-r9a09g087",
 				     "renesas,sdhi-r9a09g057";
-- 
2.53.0


