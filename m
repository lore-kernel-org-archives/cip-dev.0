From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:55 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 17/22] dt-bindings: mmc: renesas_sdhi:
	Add r8a77470 support
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit be6f8db406a49511a8d213f9443ae79fe5b086c3 upstream.

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
[biju: Removed R-Car Gen3 devices]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 25f06e6..cbce1e6 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -17,6 +17,8 @@ Required properties:
 		"renesas,sdhi-r8a7740" - SDHI IP on R8A7740 SoC
 		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
 		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
+		"renesas,sdhi-r8a77470" - SDHI IP on R8A77470 SoC
+		"renesas,sdhi-mmc-r8a77470" - SDHI/MMC IP on R8A77470 SoC
 		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
 		"renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
 		"renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
@@ -25,8 +27,8 @@ Required properties:
 		"renesas,sdhi-r8a7793" - SDHI IP on R8A7793 SoC
 		"renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
 		"renesas,rcar-gen1-sdhi" - a generic R-Car Gen1 SDHI controller
-		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 or RZ/G1
-					   SDHI controller
+		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 and RZ/G1 SDHI
+					   (not SDHI/MMC) controller
 
 		When compatible with the generic version, nodes must list
 		the SoC-specific version corresponding to the platform
-- 
2.7.4
