From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:37:12 +0100
Subject: [cip-dev] [PATCH 4.4.y 47/52] ARM: dts: r8a77470: Add SCIF DMA
	support
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-48-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit e4696122205634f40e26f9c33359a71823d1e68c upstream.

Add SCIF DMA support for R8A77470 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 0daa451..6f5fd91 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -267,6 +267,9 @@
 			clocks = <&mstp7_clks R8A77470_CLK_SCIF0>,
 				 <&zs_clk>, <&scif_clk>;
 			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
+			       <&dmac1 0x29>, <&dmac1 0x2a>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -278,6 +281,9 @@
 			clocks = <&mstp7_clks R8A77470_CLK_SCIF1>,
 				 <&zs_clk>, <&scif_clk>;
 			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
+			       <&dmac1 0x2d>, <&dmac1 0x2e>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -289,6 +295,9 @@
 			clocks = <&mstp7_clks R8A77470_CLK_SCIF2>,
 				 <&zs_clk>, <&scif_clk>;
 			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
+			       <&dmac1 0x2b>, <&dmac1 0x2c>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -300,6 +309,9 @@
 			clocks = <&mstp7_clks R8A77470_CLK_SCIF3>,
 				 <&zs_clk>, <&scif_clk>;
 			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x2f>, <&dmac0 0x30>,
+			       <&dmac1 0x2f>, <&dmac1 0x30>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -311,6 +323,9 @@
 			clocks = <&mstp7_clks R8A77470_CLK_SCIF4>,
 				 <&zs_clk>, <&scif_clk>;
 			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0xfb>, <&dmac0 0xfc>,
+			       <&dmac1 0xfb>, <&dmac1 0xfc>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
@@ -323,6 +338,9 @@
 			clocks = <&mstp7_clks R8A77470_CLK_SCIF5>,
 				 <&zs_clk>, <&scif_clk>;
 			clock-names = "sci_ick", "brg_int", "scif_clk";
+			dmas = <&dmac0 0xfd>, <&dmac0 0xfe>,
+			       <&dmac1 0xfd>, <&dmac1 0xfe>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
 		};
-- 
2.7.4
