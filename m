From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:37:05 +0100
Subject: [cip-dev] [PATCH 4.4.y 40/52] ARM: dts: r8a77470: Add SCIF support
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-41-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 8cdb8f1ab7efbd88868d3067ec1f211ff289bc01 upstream.

Describe SCIF ports in the R8A77470 device tree.
Also it fixes the CPG clock index ZS from 6 to 5.

Fixes: 6929dfc5918049 ("ARM: dts: r8a77470: Initial SoC device tree")
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[fab: reworked to make it fit 4.4.y-cip definitions, like include
files, and properties like clocks, clock-names, and power-domains.
Also, removed resets properties as not applicable here. Finally,
the fix for the ZS clock index is not applicable to this version]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index d9a89fa..2d542b3 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -177,6 +177,17 @@
 			reg = <0 0xe6300000 0 0x20000>;
 		};
 
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a77470", "renesas,scif";
+			reg = <0 0xe6e60000 0 0x40>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_SCIF0>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		scif1: serial at e6e68000 {
 			compatible = "renesas,scif-r8a77470", "renesas,scif";
 			reg = <0 0xe6e68000 0 0x40>;
@@ -188,6 +199,51 @@
 			status = "disabled";
 		};
 
+		scif2: serial at e6e58000 {
+			compatible = "renesas,scif-r8a77470", "renesas,scif";
+			reg = <0 0xe6e58000 0 0x40>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_SCIF2>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif3: serial at e6ea8000 {
+			compatible = "renesas,scif-r8a77470", "renesas,scif";
+			reg = <0 0xe6ea8000 0 0x40>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_SCIF3>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif4: serial at e6ee0000 {
+			compatible = "renesas,scif-r8a77470", "renesas,scif";
+			reg = <0 0xe6ee0000 0 0x40>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_SCIF4>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		scif5: serial at e6ee8000 {
+			compatible = "renesas,scif-r8a77470",
+				     "renesas,rcar-gen2-scif", "renesas,scif";
+			reg = <0 0xe6ee8000 0 0x40>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_SCIF5>,
+				 <&zs_clk>, <&scif_clk>;
+			clock-names = "sci_ick", "brg_int", "scif_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.7.4
