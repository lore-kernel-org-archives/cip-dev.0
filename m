From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:01 +0100
Subject: [cip-dev] [PATCH 60/86] ARM: dts: r8a7745: Add APMU node and second
	CPU core
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-61-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add DT node for the Advanced Power Management Unit (APMU), add the
second CPU core, and use "renesas,apmu" as "enable-method".

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit aaca1ff0dbfcb341c453abf160511d3419545431)
(removed power-domains property)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 4b93ea3..450e034 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -20,6 +20,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -30,6 +31,14 @@
 			next-level-cache = <&L2_CA7>;
 		};
 
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <1>;
+			clock-frequency = <1000000000>;
+			next-level-cache = <&L2_CA7>;
+		};
+
 		L2_CA7: cache-controller-0 {
 			compatible = "cache";
 			cache-unified;
@@ -164,6 +173,12 @@
 			power-domains = <&cpg_clocks>;
 		};
 
+		apmu at e6151000 {
+			compatible = "renesas,r8a7745-apmu", "renesas,apmu";
+			reg = <0 0xe6151000 0 0x188>;
+			cpus = <&cpu0 &cpu1>;
+		};
+
 		irqc: interrupt-controller at e61c0000 {
 			compatible = "renesas,irqc-r8a7745", "renesas,irqc";
 			#interrupt-cells = <2>;
-- 
2.7.4
