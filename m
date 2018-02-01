From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  1 Feb 2018 13:46:26 +0000
Subject: [cip-dev] [PATCH  4/7] ARM: dts: r8a7743: Add I2C DT support
In-Reply-To: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
References: <1517492789-44830-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517492789-44830-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add the I2C[0-5] devices to the r8a7743 device tree.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 2d33ced5500320f55fd2f63364f1212ba19453e8)
(modified clk property,removed reset property)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index e755cb9..b7be573 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -18,6 +18,15 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -297,6 +306,82 @@
 			dma-channels = <15>;
 		};
 
+		/* The memory map in the User's Manual maps the cores to bus
+		 *  numbers
+		 */
+		i2c0: i2c at e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_I2C0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at e6518000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6518000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_I2C1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at e6530000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6530000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_I2C2>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at e6540000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6540000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_I2C3>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at e6520000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6520000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_I2C4>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c5: i2c at e6528000 {
+			/* doesn't need pinmux */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7743",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6528000 0 0x40>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7743_CLK_I2C5>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		scifa0: serial at e6c40000 {
 			compatible = "renesas,scifa-r8a7743", "renesas,scifa";
 			reg = <0 0xe6c40000 0 0x40>;
-- 
2.7.4
