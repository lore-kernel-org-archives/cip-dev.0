From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Mon, 27 Jan 2020 14:25:50 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 1/8] dt-bindings: dmaengine: rcar-dmac:
	Document R8A774B1 bindings
In-Reply-To: <1580135157-14117-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580135157-14117-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580135157-14117-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 9d2bbbc21772f133fd693bf10f38982e17f6549f upstream.

Renesas RZ/G2N (R8A774B1) SoC also has the R-Car gen2/3 compatible
DMA controllers, therefore document RZ/G2N specific bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1569580629-55677-1-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index e78a621..b6927eb 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -20,6 +20,7 @@ Required Properties:
 		- "renesas,dmac-r8a7745" (RZ/G1E)
 		- "renesas,dmac-r8a77470" (RZ/G1C)
 		- "renesas,dmac-r8a774a1" (RZ/G2M)
+		- "renesas,dmac-r8a774b1" (RZ/G2N)
 		- "renesas,dmac-r8a774c0" (RZ/G2E)
 		- "renesas,dmac-r8a7790" (R-Car H2)
 		- "renesas,dmac-r8a7791" (R-Car M2-W)
-- 
2.7.4
