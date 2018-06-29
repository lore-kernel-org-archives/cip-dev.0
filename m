From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:04 +0100
Subject: [cip-dev] [PATCH 63/86] ARM: dts: r8a7745: Add I2C DT support
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-64-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add I2C[0-5] devices to the r8a7745 device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 282fbf4066e58b4c60683ab5cba30c5c998c7250)
(moved the node to a better location to allow for better sorting.
removed resets and i2c-scl-internal-delay-ns properties. modified
clocks and power-domains properties.)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 5f1cc84..aa3c1685 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -17,6 +17,15 @@
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
@@ -200,6 +209,78 @@
 			power-domains = <&cpg_clocks>;
 		};
 
+		i2c0: i2c at e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7745",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7745_CLK_I2C0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at e6518000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7745",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6518000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7745_CLK_I2C1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at e6530000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7745",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6530000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7745_CLK_I2C2>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at e6540000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7745",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6540000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7745_CLK_I2C3>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at e6520000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7745",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6520000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7745_CLK_I2C4>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c5: i2c at e6528000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7745",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6528000 0 0x40>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7745_CLK_I2C5>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		timer {
 			compatible = "arm,armv7-timer";
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-- 
2.7.4
