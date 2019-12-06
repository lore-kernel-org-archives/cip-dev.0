From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:22 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 06/12] dt-bindings: thermal: rcar: Add
	device tree support for r8a7744
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 304d9b486b3c6994c193b6693c601b463987e6ac upstream.

Add thermal sensor support for r8a7744 SoC. The Renesas RZ/G1N
(r8a7744) thermal sensor module is identical to the R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,rcar-gen2-thermal".

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index 689e7e8..1e0f837 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -7,6 +7,7 @@ Required properties:
 			  Examples with soctypes are:
 			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
 			    - "renesas,thermal-r8a7743" (RZ/G1M)
+			    - "renesas,thermal-r8a7744" (RZ/G1N)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
 			    - "renesas,thermal-r8a7790" (R-Car H2)
 			    - "renesas,thermal-r8a7791" (R-Car M2-W)
-- 
2.7.4
