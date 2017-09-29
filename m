From: chris.paterson2@renesas.com (Chris Paterson)
Date: Fri, 29 Sep 2017 18:28:06 +0100
Subject: [cip-dev] [PATCH 04/15] ARM: dts: r8a7743: Add GPIO support
In-Reply-To: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
References: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1506706097-29770-5-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Describe GPIO blocks in the R8A7743 device tree.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 16ffb25335d7e91cebae9c29252536ddbeac96fa)
(modified the clocks and power-domains property, removed resets property)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 112 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 7f4d8c0..7fc00ee 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -62,6 +62,118 @@
 			power-domains = <&cpg_clocks>;
 		};
 
+		gpio0: gpio at e6050000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7743_CLK_GPIO0>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio1: gpio at e6051000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7743_CLK_GPIO1>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio2: gpio at e6052000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7743_CLK_GPIO2>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio3: gpio at e6053000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7743_CLK_GPIO3>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio4: gpio at e6054000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7743_CLK_GPIO4>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio5: gpio at e6055000 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7743_CLK_GPIO5>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio6: gpio at e6055400 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6055400 0 0x50>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 192 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7743_CLK_GPIO6>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio7: gpio at e6055800 {
+			compatible = "renesas,gpio-r8a7743",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6055800 0 0x50>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 224 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7743_CLK_GPIO7>;
+			power-domains = <&cpg_clocks>;
+		};
+
 		irqc: interrupt-controller at e61c0000 {
 			compatible = "renesas,irqc-r8a7743", "renesas,irqc";
 			#interrupt-cells = <2>;
-- 
1.9.1
