From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:28:48 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 4/6] arm64: dts: renesas: r8a774c0: Fix
	SCIF5 DMA channels
In-Reply-To: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200930-39297-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c21cd4ae82e169b394139243684aaacf31bfcdf8 upstream.

Correct the DMA channels for SCIF5 from 16..47 to 0..15, as was done for
R-Car E3.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Fixes: 2660a6af690ebbb4 ("arm64: dts: renesas: r8a774c0: Add SCIF and HSCIF nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index aecaa9b..169f18e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for the RZ/G2E (R8A774C0) SoC
  *
- * Copyright (C) 2018 Renesas Electronics Corp.
+ * Copyright (C) 2018-2019 Renesas Electronics Corp.
  */
 
 #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
@@ -1154,9 +1154,8 @@
 				 <&cpg CPG_CORE R8A774C0_CLK_S3D1C>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
-			       <&dmac2 0x5b>, <&dmac2 0x5a>;
-			dma-names = "tx", "rx", "tx", "rx";
+			dmas = <&dmac0 0x5b>, <&dmac0 0x5a>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 202>;
 			status = "disabled";
-- 
2.7.4
