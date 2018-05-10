From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:07:53 +0100
Subject: [cip-dev] [PATCH 04/62] ARM: dts: r8a7743: Add CAN[01] SoC support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add the definitions for can0 and can1 to the SoC .dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 6ee6959fb85c3e03ec0674d329dc96c733f51dce)
(updated clocks and power-domains property. removed resets property)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index eb3cdc8..94ccda0 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1330,6 +1330,32 @@
 			};
 		};
 
+		can0: can at e6e80000 {
+			compatible = "renesas,can-r8a7743",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e80000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_RCAN0>,
+				 <&cpg_clocks R8A7743_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		can1: can at e6e88000 {
+			compatible = "renesas,can-r8a7743",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e88000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_RCAN1>,
+				 <&cpg_clocks R8A7743_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		pci0: pci at ee090000 {
 			compatible = "renesas,pci-r8a7743",
 				     "renesas,pci-rcar-gen2";
@@ -1420,6 +1446,14 @@
 		clock-frequency = <48000000>;
 	};
 
+	/* External CAN clock */
+	can_clk: can {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board. */
+		clock-frequency = <0>;
+	};
+
 	/* External SCIF clock */
 	scif_clk: scif {
 		compatible = "fixed-clock";
-- 
2.7.4
