From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 10:58:06 +0100
Subject: [cip-dev] [PATCH 4.19.y 07/17] dt-bindings: timer: renesas,
	cmt: Document r8a774a1 CMT support
In-Reply-To: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554112696-20706-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit e5a805202c8ebb3b27cd8ad1b227158ae9cb9464 upstream.

Document SoC specific bindings for RZ/G2M (r8a774a1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 49948fc..8d2acc5 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -26,6 +26,8 @@ Required Properties:
     - "renesas,r8a7743-cmt1" for the 48-bit CMT1 device included in r8a7743.
     - "renesas,r8a7745-cmt0" for the 32-bit CMT0 device included in r8a7745.
     - "renesas,r8a7745-cmt1" for the 48-bit CMT1 device included in r8a7745.
+    - "renesas,r8a774a1-cmt0" for the 32-bit CMT0 device included in r8a774a1.
+    - "renesas,r8a774a1-cmt1" for the 48-bit CMT1 device included in r8a774a1.
     - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
@@ -45,9 +47,12 @@ Required Properties:
 		and RZ/G1.
 		These are fallbacks for r8a73a4, R-Car Gen2 and RZ/G1 entries
 		listed above.
-    - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3.
-    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3.
-		These are fallbacks for R-Car Gen3 entries listed above.
+    - "renesas,rcar-gen3-cmt0" for 32-bit CMT0 devices included in R-Car Gen3
+		and RZ/G2.
+    - "renesas,rcar-gen3-cmt1" for 48-bit CMT1 devices included in R-Car Gen3
+		and RZ/G2.
+		These are fallbacks for R-Car Gen3 and RZ/G2 entries listed
+		above.
 
   - reg: base address and length of the registers block for the timer module.
   - interrupts: interrupt-specifier for the timer, one per channel.
-- 
2.7.4
