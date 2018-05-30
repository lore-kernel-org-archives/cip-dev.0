From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:36:02 +0100
Subject: [cip-dev] [PATCH v2 06/11] dt-bindings: thermal: rcar: Add device
	tree support for r8a7743
In-Reply-To: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527701767-41785-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add thermal sensor support for r8a7743 SoC. The Renesas RZ/G1M
(r8a7743) thermal sensor module is identical to the R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,rcar-gen2-thermal".

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit 2d14a0ee5e73d5224873777892fd86d3a283b059)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index e5ee3f1..689e7e8 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -6,6 +6,7 @@ Required properties:
 			   "renesas,rcar-thermal" (without thermal-zone) as fallback.
 			  Examples with soctypes are:
 			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
+			    - "renesas,thermal-r8a7743" (RZ/G1M)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
 			    - "renesas,thermal-r8a7790" (R-Car H2)
 			    - "renesas,thermal-r8a7791" (R-Car M2-W)
-- 
2.7.4
