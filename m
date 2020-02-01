From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Sat,  1 Feb 2020 12:26:54 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 06/14] arm64: dts: renesas: r8a774b1:
	Add OPPs table for cpu devices
In-Reply-To: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580560022-26873-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit ce21f29032ae49a0bb2a260ab5ebf4c516c9f6e9 upstream.

This patch adds OPPs table for CA57{0,1} cpu devices.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1569250648-33857-2-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index f4d60d5..c69df89 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -45,6 +45,28 @@
 		clock-frequency = <0>;
 	};
 
+	cluster0_opp: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <830000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -59,6 +81,7 @@
 			#cooling-cells = <2>;
 			dynamic-power-coefficient = <854>;
 			clocks = <&cpg CPG_CORE R8A774B1_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		a57_1: cpu at 1 {
@@ -69,6 +92,7 @@
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774B1_CLK_Z>;
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		L2_CA57: cache-controller-0 {
-- 
2.7.4
