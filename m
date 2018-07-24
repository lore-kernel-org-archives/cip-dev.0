From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 24 Jul 2018 12:03:51 +0100
Subject: [cip-dev] [PATCH 1/3] ARM: dts: r8a7745: Add CAN[01] SoC support
In-Reply-To: <1532430233-32277-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532430233-32277-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532430233-32277-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add the definitions for can0 and can1 to the SoC .dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 85d3122659be310c632ef1908532157ce82900ee)
(moved nodes to a better location to allow for better sorting.
modified clocks and power-domains properties. removed resets
properties)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 6fdd3c2..c2e38ae 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -32,6 +32,14 @@
 		spi3 = &msiof2;
 	};
 
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -844,6 +852,32 @@
 			status = "disabled";
 		};
 
+		can0: can at e6e80000 {
+			compatible = "renesas,can-r8a7745",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e80000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7745_CLK_RCAN0>,
+				 <&cpg_clocks R8A7745_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		can1: can at e6e88000 {
+			compatible = "renesas,can-r8a7745",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e88000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7745_CLK_RCAN1>,
+				 <&cpg_clocks R8A7745_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		pci0: pci at ee090000 {
 			compatible = "renesas,pci-r8a7745",
 				     "renesas,pci-rcar-gen2";
-- 
2.7.4
