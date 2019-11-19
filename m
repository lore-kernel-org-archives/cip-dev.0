From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:29 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 04/17] ARM: dts: r8a7744: Add GPIO
	support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 78ce1559b2f1c741ceda6f511c80beee57b1b71e upstream.

Describe GPIO blocks in the R8A7744 device tree.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: removed resets property. Updated power-domains and clocks properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 94 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 18aedf3..3e125f6 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -115,29 +115,115 @@
 		ranges;
 
 		gpio0: gpio at e6050000 {
+			compatible = "renesas,gpio-r8a7744",
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&mstp9_clks R8A7744_CLK_GPIO0>;
+			power-domains = <&cpg_clocks>;
 		};
 
 		gpio1: gpio at e6051000 {
+			compatible = "renesas,gpio-r8a7744",
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-			/* placeholder */
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7744_CLK_GPIO1>;
+			power-domains = <&cpg_clocks>;
 		};
 
 		gpio2: gpio at e6052000 {
+			compatible = "renesas,gpio-r8a7744",
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-			/* placeholder */
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7744_CLK_GPIO2>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio3: gpio at e6053000 {
+			compatible = "renesas,gpio-r8a7744",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7744_CLK_GPIO3>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio4: gpio at e6054000 {
+			compatible = "renesas,gpio-r8a7744",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7744_CLK_GPIO4>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio5: gpio at e6055000 {
+			compatible = "renesas,gpio-r8a7744",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7744_CLK_GPIO5>;
+			power-domains = <&cpg_clocks>;
 		};
 
 		gpio6: gpio at e6055400 {
+			compatible = "renesas,gpio-r8a7744",
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055400 0 0x50>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-			/* placeholder */
+			gpio-controller;
+			gpio-ranges = <&pfc 0 192 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7744_CLK_GPIO6>;
+			power-domains = <&cpg_clocks>;
+		};
+
+		gpio7: gpio at e6055800 {
+			compatible = "renesas,gpio-r8a7744",
+				     "renesas,rcar-gen2-gpio";
+			reg = <0 0xe6055800 0 0x50>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 224 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&mstp9_clks R8A7744_CLK_GPIO7>;
+			power-domains = <&cpg_clocks>;
 		};
 
 		pfc: pin-controller at e6060000 {
-- 
2.7.4
