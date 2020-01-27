From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Mon, 27 Jan 2020 14:25:54 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 5/8] arm64: dts: renesas: r8a774b1: Add
	GPIO device nodes
In-Reply-To: <1580135157-14117-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580135157-14117-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580135157-14117-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit bbbb919f3286f3bddfe9b23feaf184860d11d0ac upstream.

Add GPIO device nodes to the DT of the r8a774b1 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1569831527-1250-4-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 64 +++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index e6c8cca..641af27 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -132,75 +132,123 @@
 		};
 
 		gpio0: gpio at e6050000 {
+			compatible = "renesas,gpio-r8a774b1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 0 16>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 912>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
 		gpio1: gpio at e6051000 {
+			compatible = "renesas,gpio-r8a774b1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 32 29>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 911>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
 		gpio2: gpio at e6052000 {
+			compatible = "renesas,gpio-r8a774b1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 64 15>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 910>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
 		gpio3: gpio at e6053000 {
+			compatible = "renesas,gpio-r8a774b1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 96 16>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 909>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
 		gpio4: gpio at e6054000 {
+			compatible = "renesas,gpio-r8a774b1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 128 18>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 908>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
 		gpio5: gpio at e6055000 {
+			compatible = "renesas,gpio-r8a774b1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 160 26>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 907>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
 		gpio6: gpio at e6055400 {
+			compatible = "renesas,gpio-r8a774b1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055400 0 0x50>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 192 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 906>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 906>;
 		};
 
 		gpio7: gpio at e6055800 {
+			compatible = "renesas,gpio-r8a774b1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055800 0 0x50>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 224 4>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 905>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
 		};
 
 		pfc: pin-controller at e6060000 {
-- 
2.7.4
