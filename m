From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:30:08 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 23/23] arm64: dts: renesas: r8a774c0:
	Add OPPs table for cpu devices
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-24-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 231d8908a66fa98f09553d31ad8cd5f382b29959 upstream.

This patch defines OOP tables for all CPUs, similarly to
what done by Takeshi Kihara and Yoshihiro Kaneko for the
R8A77990.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index c47ca0b..8a2e4d8 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -44,6 +44,27 @@
 		clock-frequency = <0>;
 	};
 
+	cluster1_opp: opp_table10 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <820000>;
+			clock-latency-ns = <300000>;
+			opp-suspend;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -55,6 +76,8 @@
 			power-domains = <&sysc R8A774C0_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		a53_1: cpu at 1 {
@@ -64,6 +87,8 @@
 			power-domains = <&sysc R8A774C0_PD_CA53_CPU1>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
+			clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;
+			operating-points-v2 = <&cluster1_opp>;
 		};
 
 		L2_CA53: cache-controller-0 {
-- 
2.7.4
