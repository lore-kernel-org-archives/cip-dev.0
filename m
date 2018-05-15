From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 15 May 2018 12:19:51 +0100
Subject: [cip-dev] [PATCH 1/7] dt-bindings: display: rcar-du: Document
	R8A774[35] DU
In-Reply-To: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1526383197-5913-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1526383197-5913-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add device tree bindings for r8a7743 and r8a7745 DUs.
r8a7743 DU is similar to the one from r8a7791, r8a7745 DU is similar
to the one from r8a7794.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[Don't reference R8A779[0123456] and R8A774[35] explicitly]
[Number all DPAD, HDMI and LVDS ports]
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
(cherry picked from commit faf4a3ff36137aaa8de1a8da99a92f6e712903f1)
(removed R-Car gen3 SoCs)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 .../devicetree/bindings/display/renesas,du.txt     | 24 +++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index eccd4f4..2cc5fdd 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -3,6 +3,8 @@
 Required Properties:
 
   - compatible: must be one of the following.
+    - "renesas,du-r8a7743" for R8A7743 (RZ/G1M) compatible DU
+    - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
     - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
     - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
     - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
@@ -24,10 +26,10 @@ Required Properties:
   - clock-names: Name of the clocks. This property is model-dependent.
     - R8A7779 uses a single functional clock. The clock doesn't need to be
       named.
-    - R8A779[0134] use one functional clock per channel and one clock per LVDS
-      encoder (if available). The functional clocks must be named "du.x" with
-      "x" being the channel numerical index. The LVDS clocks must be named
-      "lvds.x" with "x" being the LVDS encoder numerical index.
+    - All other DU instances use one functional clock per channel and one
+      clock per LVDS encoder (if available). The functional clocks must be
+      named "du.x" with "x" being the channel numerical index. The LVDS clocks
+      must be named "lvds.x" with "x" being the LVDS encoder numerical index.
     - In addition to the functional and encoder clocks, all DU versions also
       support externally supplied pixel clocks. Those clocks are optional.
       When supplied they must be named "dclkin.x" with "x" being the input
@@ -41,13 +43,15 @@ bindings specified in Documentation/devicetree/bindings/graph.txt.
 The following table lists for each supported model the port number
 corresponding to each DU output.
 
-		Port 0		Port1		Port2
+                      Port 0         Port1          Port2
 -----------------------------------------------------------------------------
- R8A7779 (H1)	DPAD 0		DPAD 1		-
- R8A7790 (H2)	DPAD		LVDS 0		LVDS 1
- R8A7791 (M2-W)	DPAD		LVDS 0		-
- R8A7793 (M2-N)	DPAD		LVDS 0		-
- R8A7794 (E2)	DPAD 0		DPAD 1		-
+ R8A7743 (RZ/G1M)     DPAD 0         LVDS 0         -
+ R8A7745 (RZ/G1E)     DPAD 0         DPAD 1         -
+ R8A7779 (R-Car H1)   DPAD 0         DPAD 1         -
+ R8A7790 (R-Car H2)   DPAD 0         LVDS 0         LVDS 1
+ R8A7791 (R-Car M2-W) DPAD 0         LVDS 0         -
+ R8A7793 (R-Car M2-N) DPAD 0         LVDS 0         -
+ R8A7794 (R-Car E2)   DPAD 0         DPAD 1         -
 
 
 Example: R8A7790 (R-Car H2) DU
-- 
2.7.4
