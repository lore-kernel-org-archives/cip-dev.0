Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1269ED25B77
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:27:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12818.1769606833293295715
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 05:27:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: iGsz0TthSh+zLthZzBvhiw==
X-CSE-MsgGUID: NLaRNp0YTs2Z2UG4t3yXNQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jan 2026 22:27:14 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5318D40325B7;
	Wed, 28 Jan 2026 22:27:13 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 12/12] arm64: dts: renesas: r9a09g057: Add TSU nodes
Date: Wed, 28 Jan 2026 13:26:49 +0000
Message-ID: <20260128132650.6955-13-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
References: <20260128132650.6955-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 13:27:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21761

commit 1f77aced8c5c6f69566e69f63c3a6c1960f7fc87 upstream.

The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing two dedicated
channels for temperature sensing:
- TSU0, which is located near the DRP-AI block
- TSU1, which is located near the CPU and DRP-AI block

Since TSU1 is physically closer the CPU and the highest temperature
spot, it is used for CPU throttling through a passive trip and cooling
map. TSU0 is configured only with a critical trip.

Add TSU nodes along with thermal zones and keep them enabled in the SoC
DTSI.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251020143107.13974-4-ovidiu.panait.rb@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[OP: Before commit ba5095ebbc7a ("mfd: syscon: Allow syscon nodes without a
"syscon" compatible"), it was mandatory for the system controller node
to have the "syscon" fallback commpatible to be able to read data from it.
Therefore, add "syscon" fallback compatible to system-controller node, so that
TSU can access calibration data using syscon_regmap_lookup_by_phandle_args().]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 77 +++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 925df24693b3..dd2260f15a90 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -65,6 +65,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK0>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -75,6 +76,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK1>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -85,6 +87,7 @@ cpu2: cpu@200 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK2>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -95,6 +98,7 @@ cpu3: cpu@300 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK3>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -245,12 +249,38 @@ cpg: clock-controller@10420000 {
 		};
 
 		sys: system-controller@10430000 {
-			compatible = "renesas,r9a09g057-sys";
+			compatible = "renesas,r9a09g057-sys", "syscon";
 			reg = <0 0x10430000 0 0x10000>;
 			clocks = <&cpg CPG_CORE R9A09G057_SYS_0_PCLK>;
 			resets = <&cpg 0x30>;
 		};
 
+		tsu0: thermal@11000000 {
+			compatible = "renesas,r9a09g057-tsu", "renesas,r9a09g047-tsu";
+			reg = <0 0x11000000 0 0x1000>;
+			interrupts = <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "adi", "adcmpi";
+			clocks = <&cpg CPG_MOD 0x109>;
+			resets = <&cpg 0xf7>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			renesas,tsu-trim = <&sys 0x320>;
+		};
+
+		tsu1: thermal@14002000 {
+			compatible = "renesas,r9a09g057-tsu", "renesas,r9a09g047-tsu";
+			reg = <0 0x14002000 0 0x1000>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "adi", "adcmpi";
+			clocks = <&cpg CPG_MOD 0x10a>;
+			resets = <&cpg 0xf8>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			renesas,tsu-trim = <&sys 0x330>;
+		};
+
 		xspi: spi@11030000 {
 			compatible = "renesas,r9a09g057-xspi", "renesas,r9a09g047-xspi";
 			reg = <0 0x11030000 0 0x10000>,
@@ -1175,6 +1205,51 @@ stmmac_axi_setup: stmmac-axi-config {
 		snps,blen = <16 8 4 0 0 0 0>;
 	};
 
+	thermal-zones {
+		sensor1_thermal: sensor1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&tsu0>;
+
+			trips {
+				sensor1_crit: sensor1-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor2_thermal: sensor2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&tsu1>;
+
+			cooling-maps {
+				map0 {
+					trip = <&sensor2_target>;
+					cooling-device = <&cpu0 0 3>, <&cpu1 0 3>,
+							 <&cpu2 0 3>, <&cpu3 0 3>;
+					contribution = <1024>;
+				};
+			};
+
+			trips {
+				sensor2_target: trip-point {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				sensor2_crit: sensor2-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.51.0


