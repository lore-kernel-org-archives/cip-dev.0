From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  8 Mar 2018 17:28:08 +0000
Subject: [cip-dev] [PATCH 3/4] spi: sh-msiof: Add r8a774[35] to the
	compatible list
In-Reply-To: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520530089-4988-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 4702f4b23a2fc6196abacf515a959e69176da40e)
(removed "renesas,rcar-gen3-msiof")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index ef65d54..7a20ec6 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -1,13 +1,15 @@
 Renesas MSIOF spi controller
 
 Required properties:
-- compatible           : "renesas,msiof-r8a7790" (R-Car H2)
+- compatible           : "renesas,msiof-r8a7743" (RZ/G1M)
+			 "renesas,msiof-r8a7745" (RZ/G1E)
+			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
 			 "renesas,msiof-r8a7792" (R-Car V2H)
 			 "renesas,msiof-r8a7793" (R-Car M2-N)
 			 "renesas,msiof-r8a7794" (R-Car E2)
 			 "renesas,sh-mobile-msiof" (generic SH-Mobile compatibile device)
-			 "renesas,rcar-gen2-msiof" (generic R-Car Gen2 compatible device)
+			 "renesas,rcar-gen2-msiof" (generic R-Car Gen2 and RZ/G1 compatible device)
 			 "renesas,sh-msiof"      (deprecated)
 
 			 When compatible with the generic version, nodes
-- 
2.7.4
