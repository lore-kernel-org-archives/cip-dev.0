From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 31 Jan 2018 11:15:53 +0000
Subject: [cip-dev] [PATCH 08/10] ARM: dts: r8a7743: Add APMU node and second
	CPU core
In-Reply-To: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
References: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517397355-23341-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add DT nodes for the Advanced Power Management Unit (APMU) and the
second CPU core.  Use the enable-method to point out that the APMU
should be used for SMP support.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 60dce695b097a52e6ea5874aa80301f2e4ac627a)
(removed power domain property, since we don't have sysc driver
in 4.4 kernel to support CA15-CPU1 and CA15-SCU power domains).

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index a9dda28..bd1121a 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -21,6 +21,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -31,6 +32,14 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+			clock-frequency = <1500000000>;
+			next-level-cache = <&L2_CA15>;
+		};
+
 		L2_CA15: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
@@ -46,6 +55,12 @@
 		#size-cells = <2>;
 		ranges;
 
+		apmu at e6152000 {
+			compatible = "renesas,r8a7743-apmu", "renesas,apmu";
+			reg = <0 0xe6152000 0 0x188>;
+			cpus = <&cpu0 &cpu1>;
+		};
+
 		gic: interrupt-controller at f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.7.4
