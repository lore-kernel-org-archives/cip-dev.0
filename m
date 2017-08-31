From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 31 Aug 2017 15:34:18 +0100
Subject: [cip-dev] [PATCH v2 13/18] ARM: dts: r8a7743: Fix SCIFB0 dmas
	indentation
In-Reply-To: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
References: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1504190063-61519-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: 809c013426914694 ("ARM: dts: r8a7743: add [H]SCIF{A|B} support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit c8290f9f2e1d119512e1821fc13d1d145aa23f77)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 8aa869e..9227ab4 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -241,7 +241,7 @@
 			clocks = <&mstp2_clks R8A7743_CLK_SCIFB0>;
 			clock-names = "sci_ick";
 			dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
-		       <&dmac1 0x3d>, <&dmac1 0x3e>;
+			       <&dmac1 0x3d>, <&dmac1 0x3e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
-- 
1.9.1
