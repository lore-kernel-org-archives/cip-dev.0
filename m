From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:26 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 01/17] dt-bindings: rcar-dmac: Document
	r8a7744 support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 6b1e23c93cba2d056a94d9837a17d420dae1f510 upstream.

Renesas RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
Document RZ/G1N (also known as R8A7744) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 5954b05..21fb14c4 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -17,6 +17,7 @@ Required Properties:
 - compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.
 	      Examples with soctypes are:
 		- "renesas,dmac-r8a7743" (RZ/G1M)
+		- "renesas,dmac-r8a7744" (RZ/G1N)
 		- "renesas,dmac-r8a7745" (RZ/G1E)
 		- "renesas,dmac-r8a77470" (RZ/G1C)
 		- "renesas,dmac-r8a7790" (R-Car H2)
-- 
2.7.4
