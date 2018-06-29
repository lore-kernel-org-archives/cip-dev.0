From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:07 +0100
Subject: [cip-dev] [PATCH 66/86] ARM: dts: r8a7745: Add SDHI controllers
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-67-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add the SDHI controllers to the r8a7745 device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 7079131ef9b934df48602b22e30282d25a6a4827)
(moved the node to a better location to allow for better sorting.
removed resets property. modified clocks and power-domains
properties.)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 27a62ae..c369eca 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -646,6 +646,45 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7745";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7745_CLK_SDHI0>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7745";
+			reg = <0 0xee140000 0 0x100>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7745_CLK_SDHI1>;
+			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+			       <&dmac1 0xc1>, <&dmac1 0xc2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7745";
+			reg = <0 0xee160000 0 0x100>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7745_CLK_SDHI2>;
+			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		mmcif0: mmc at ee200000 {
 			compatible = "renesas,mmcif-r8a7745",
 				     "renesas,sh-mmcif";
-- 
2.7.4
