From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:54 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 20/22] arm64: dts: renesas: r8a774a1:
	Add CPU capacity-dmips-mhz
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-21-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 5f5249497bd7ed65d90cac36c3c3dabcda2903dd upstream.

Set the capacity-dmips-mhz for RZ/G2M(r8a774a1) SoC, that is based on
dhrystone.

Based on work done by Gaku Inami <gaku.inami.xw@bp.renesas.com> for
r8a7796 SoC.

The average dhrystone result for 5 iterations is as below:

r8a774a1 SoC (CA57x2 + CA53x4)
  CPU   max-freq   dhrystone
  ---------------------------------
  CA57   1500 MHz  11428571 lps/s
  CA53   1200 MHz   5000000 lps/s

>From this, CPU capacity-dmips-mhz for CA57 and CA53 are calculated
as follows:

r8a774a1 SoC
  CA57 : 1024 / (11428571 / 1500) * (11428571 / 1500) = 1024
  CA53 : 1024 / (11428571 / 1500) * ( 5000000 / 1200) =  560

Since each CPUs have different max frequencies, the final CPU
capacities of A53 scaled by the above difference is as below

$ cat /sys/devices/system/cpu/cpu*/cpu_capacity
1024
1024
448
448
448
448

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 50f3f17..0e755b8 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -137,6 +137,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		a57_1: cpu at 1 {
@@ -148,6 +149,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z>;
 			operating-points-v2 = <&cluster0_opp>;
+			capacity-dmips-mhz = <1024>;
 		};
 
 		a53_0: cpu at 100 {
@@ -159,6 +161,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <560>;
 		};
 
 		a53_1: cpu at 101 {
@@ -170,6 +173,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <560>;
 		};
 
 		a53_2: cpu at 102 {
@@ -181,6 +185,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <560>;
 		};
 
 		a53_3: cpu at 103 {
@@ -192,6 +197,7 @@
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R8A774A1_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
+			capacity-dmips-mhz = <560>;
 		};
 
 		L2_CA57: cache-controller-0 {
-- 
2.7.4
