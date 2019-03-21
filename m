From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 16:22:14 +0000
Subject: [cip-dev] [PATCH 05/10] dmaengine: rcar-dmac: Document R8A774A1
	bindings
In-Reply-To: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
References: <1553185339-26890-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553185339-26890-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Renesas' RZ/G2M (R8A774A1) SoC has DMA controllers compatible
with this driver, therefore document RZ/G2M specific bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
(cherry picked from commit 9693f670895fe2b439f2c26c2c78e4bba671b1b2)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 946229c..2de2eed 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -1,6 +1,6 @@
 * Renesas R-Car (RZ/G) DMA Controller Device Tree bindings
 
-Renesas R-Car Generation 2 SoCs have multiple multi-channel DMA
+Renesas R-Car (Gen 2/3) and RZ/G SoCs have multiple multi-channel DMA
 controller instances named DMAC capable of serving multiple clients. Channels
 can be dedicated to specific clients or shared between a large number of
 clients.
@@ -19,6 +19,7 @@ Required Properties:
 		- "renesas,dmac-r8a7743" (RZ/G1M)
 		- "renesas,dmac-r8a7745" (RZ/G1E)
 		- "renesas,dmac-r8a77470" (RZ/G1C)
+		- "renesas,dmac-r8a774a1" (RZ/G2M)
 		- "renesas,dmac-r8a7790" (R-Car H2)
 		- "renesas,dmac-r8a7791" (R-Car M2-W)
 		- "renesas,dmac-r8a7792" (R-Car V2H)
-- 
2.7.4
