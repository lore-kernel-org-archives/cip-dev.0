From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:15 +0100
Subject: [cip-dev] [PATCH 26/62] DT: dmaengine: rcar-dmac: document
	R8A7743/5 support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-27-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Renesas  RZ/G SoC also have the R-Car gen2/3 compatible DMA controllers.
Document RZ/G1[ME] (also known as R8A774[35]) SoC bindings.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit 3770f2a6bfe00869a4b83ee3cced0361ab33289a)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 5b902ac..5f2ce66 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -1,4 +1,4 @@
-* Renesas R-Car DMA Controller Device Tree bindings
+* Renesas R-Car (RZ/G) DMA Controller Device Tree bindings
 
 Renesas R-Car Generation 2 SoCs have multiple multi-channel DMA
 controller instances named DMAC capable of serving multiple clients. Channels
@@ -16,6 +16,8 @@ Required Properties:
 
 - compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.
 	      Examples with soctypes are:
+		- "renesas,dmac-r8a7743" (RZ/G1M)
+		- "renesas,dmac-r8a7745" (RZ/G1E)
 		- "renesas,dmac-r8a7790" (R-Car H2)
 		- "renesas,dmac-r8a7791" (R-Car M2-W)
 		- "renesas,dmac-r8a7792" (R-Car V2H)
-- 
2.7.4
