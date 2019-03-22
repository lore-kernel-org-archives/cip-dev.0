From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:40:06 +0000
Subject: [cip-dev] [PATCH 07/11] dt-bindings: mmc: renesas_sdhi: Add
	r8a77470 support
In-Reply-To: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
References: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553247610-33056-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

The RZ/G1C (a.k.a. R8A77470) comes with three SDHI interfaces,
SDHI0 and SDHI2 are compatible with R-Car Gen2 SDHIs, and
SDHI1 is compatible with R-Car Gen3 SDHIs, as it comes with an
internal DMAC, therefore SDHI1 is fully compatible with driver
renesas_sdhi_internal_dmac driver. As a result, the compatible
strings for the R8A77470 SDHI interfaces are a little bit special.
Document SDHI support for the RZ/G1C SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit be6f8db406a49511a8d213f9443ae79fe5b086c3)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 8315fb5..f1bffc7 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -18,6 +18,8 @@ Required properties:
 		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
 		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
 		"renesas,sdhi-r8a774a1" - SDHI IP on R8A774A1 SoC
+		"renesas,sdhi-r8a77470" - SDHI IP on R8A77470 SoC
+		"renesas,sdhi-mmc-r8a77470" - SDHI/MMC IP on R8A77470 SoC
 		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
 		"renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
 		"renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
@@ -33,8 +35,8 @@ Required properties:
 		"renesas,sdhi-r8a77995" - SDHI IP on R8A77995 SoC
 		"renesas,sdhi-shmobile" - a generic sh-mobile SDHI controller
 		"renesas,rcar-gen1-sdhi" - a generic R-Car Gen1 SDHI controller
-		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 or RZ/G1
-					   SDHI controller
+		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 and RZ/G1 SDHI
+					   (not SDHI/MMC) controller
 		"renesas,rcar-gen3-sdhi" - a generic R-Car Gen3 or RZ/G2
 					   SDHI controller
 
-- 
2.7.4
