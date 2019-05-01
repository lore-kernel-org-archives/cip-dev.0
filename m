From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:21 +0100
Subject: [cip-dev] [PATCH 4.19.y 27/29] dt-bindings: thermal: rcar-thermal:
	add R8A774C0 support
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-28-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 69f8f55185ff2405366b1b193d3d2fea16589e54 upstream.

Document RZ/G2E SoC (a.k.a. r8a774c0) bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
[fab: removed references to R-Car V3M as not supported
in this version]
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index 67c563f..26703f4 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -4,10 +4,11 @@ Required properties:
 - compatible		: "renesas,thermal-<soctype>",
 			   "renesas,rcar-gen2-thermal" (with thermal-zone) or
 			   "renesas,rcar-thermal" (without thermal-zone) as
-                           fallback except R-Car D3.
+                           fallback except R-Car D3 and RZ/G2E.
 			  Examples with soctypes are:
 			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
 			    - "renesas,thermal-r8a7743" (RZ/G1M)
+			    - "renesas,thermal-r8a774c0" (RZ/G2E)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
 			    - "renesas,thermal-r8a7790" (R-Car H2)
 			    - "renesas,thermal-r8a7791" (R-Car M2-W)
@@ -22,6 +23,7 @@ Option properties:
 
 - interrupts		: If present should contain 3 interrupts for
                           R-Car D3 or 1 interrupt otherwise.
+                          R-Car D3 and RZ/G2E or 1 interrupt otherwise.
 
 Example (non interrupt support):
 
-- 
2.7.4
