From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:55 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 21/22] arm64: dts: renesas: r8a774a1:
	Create thermal zone to support IPA
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-22-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 06a928fb5805d1bb80a87c557ac487b916adc50d upstream.

Setup a thermal zone driven by SoC temperature sensor. Create passive trip
points and bind them to CPUFreq cooling device that supports power
extension.

Based on work by Dien Pham <dien.pham.ry@renesas.com> for r8a7796 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 0e755b8..6f24ddd 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -138,6 +138,7 @@
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		a57_1: cpu at 1 {
@@ -150,6 +151,7 @@
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		a53_0: cpu at 100 {
@@ -159,6 +161,7 @@
 			power-domains = <&sysc R8A774A1_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 			capacity-dmips-mhz = <560>;
@@ -1847,6 +1850,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 0>;
+			sustainable-power = <3874>;
 
 			trips {
 				sensor1_crit: sensor1-crit {
@@ -1861,6 +1865,7 @@
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 1>;
+			sustainable-power = <3874>;
 
 			trips {
 				sensor2_crit: sensor2-crit {
@@ -1869,21 +1874,39 @@
 					type = "critical";
 				};
 			};
-
 		};
 
 		sensor_thermal3: sensor-thermal3 {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 			thermal-sensors = <&tsc 2>;
+			sustainable-power = <3874>;
 
 			trips {
+				target: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
 				sensor3_crit: sensor3-crit {
 					temperature = <120000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&a57_0 0 2>;
+					contribution = <1024>;
+				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&a53_0 0 2>;
+					contribution = <1024>;
+				};
+			};
 		};
 	};
 
-- 
2.7.4
