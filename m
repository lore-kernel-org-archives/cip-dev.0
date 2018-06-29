From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:20 +0100
Subject: [cip-dev] [PATCH 19/86] ARM: dts: r8a7745: Fix SCIFB0 dmas
	indentation
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-20-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: e0d2da54c4d01ba2 ("ARM: dts: r8a7745: add [H]SCIF{|A|B} support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ad20bb6868f1d29f9c911f14087be4f93c098604)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 8cfc644..804baab 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -242,7 +242,7 @@
 			clocks = <&mstp2_clks R8A7745_CLK_SCIFB0>;
 			clock-names = "sci_ick";
 			dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
-		       <&dmac1 0x3d>, <&dmac1 0x3e>;
+			       <&dmac1 0x3d>, <&dmac1 0x3e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&cpg_clocks>;
 			status = "disabled";
-- 
2.7.4
