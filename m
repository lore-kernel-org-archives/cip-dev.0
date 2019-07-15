From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:28:47 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 3/6] arm64: dts: renesas: r8a774c0:
	Enable DMA for SCIF2
In-Reply-To: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200930-39297-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d9fd4e5814079ba4a2111d7d792a24bf8f747500 upstream.

SCIF2 on RZ/G2E can be used with both DMAC1 and DMAC2.

Fixes: 1b24f9e8ea3ff95f ("arm64: dts: renesas: r8a774c0: Add SCIF and HSCIF nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index b6f6929..aecaa9b 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -1105,6 +1105,9 @@
 				 <&cpg CPG_CORE R8A774C0_CLK_S3D1C>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>,
+			       <&dmac2 0x13>, <&dmac2 0x12>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
-- 
2.7.4
