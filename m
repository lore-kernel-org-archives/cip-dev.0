From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 16:20:24 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/10] ARM: dts: r8a7744: Add SDHI nodes
In-Reply-To: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
References: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574785231-56219-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b591e323b271fdc2ffdc40eaf06e926a1e272994 upstream.

Add SDHI nodes to the DT of the r8a7744 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: removed resets property. Updated power-domains and clocks properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index a1952ea..574bdf7 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -814,14 +814,43 @@
 			/* placeholder */
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7744";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7744_CLK_SDHI0>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		sdhi1: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7744";
 			reg = <0 0xee140000 0 0x100>;
-			/* placeholder */
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7744_CLK_SDHI1>;
+			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+			       <&dmac1 0xc1>, <&dmac1 0xc2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
 		sdhi2: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7744";
 			reg = <0 0xee160000 0 0x100>;
-			/* placeholder */
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7744_CLK_SDHI2>;
+			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
 		gic: interrupt-controller at f1001000 {
-- 
2.7.4
