From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:29 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 19/39] dt-bindings: clock: renesas:
	cpg-mssr: Document r8a774b1 binding
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-20-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 10003938a0c64c2f0d8934ef3f4f36ac5b4960dc upstream.

Add binding documentation for the RZ/G2N (R8A774b1) Clock Pulse
Generator driver.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1568881036-4404-6-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
index 6ff3a06..113d45b 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -17,6 +17,7 @@ Required Properties:
       - "renesas,r8a7745-cpg-mssr" for the r8a7745 SoC (RZ/G1E)
       - "renesas,r8a77470-cpg-mssr" for the r8a77470 SoC (RZ/G1C)
       - "renesas,r8a774a1-cpg-mssr" for the r8a774a1 SoC (RZ/G2M)
+      - "renesas,r8a774b1-cpg-mssr" for the r8a774a1 SoC (RZ/G2N)
       - "renesas,r8a774c0-cpg-mssr" for the r8a774c0 SoC (RZ/G2E)
       - "renesas,r8a7790-cpg-mssr" for the r8a7790 SoC (R-Car H2)
       - "renesas,r8a7791-cpg-mssr" for the r8a7791 SoC (R-Car M2-W)
@@ -37,10 +38,11 @@ Required Properties:
   - clocks: References to external parent clocks, one entry for each entry in
     clock-names
   - clock-names: List of external parent clock names. Valid names are:
-      - "extal" (r8a7743, r8a7745, r8a77470, r8a774a1, r8a774c0, r8a7790,
-		 r8a7791, r8a7792, r8a7793, r8a7794, r8a7795, r8a7796, r8a77965,
-		 r8a77970, r8a77980, r8a77990, r8a77995)
-      - "extalr" (r8a774a1, r8a7795, r8a7796, r8a77965, r8a77970, r8a77980)
+      - "extal" (r8a7743, r8a7745, r8a77470, r8a774a1, r8a774b1, r8a774c0,
+		 r8a7790, r8a7791, r8a7792, r8a7793, r8a7794, r8a7795, r8a7796,
+		 r8a77965, r8a77970, r8a77980, r8a77990, r8a77995)
+      - "extalr" (r8a774a1, r8a774b1, r8a7795, r8a7796, r8a77965, r8a77970,
+		  r8a77980)
       - "usb_extal" (r8a7743, r8a7745, r8a77470, r8a7790, r8a7791, r8a7793,
 		     r8a7794)
 
-- 
2.7.4
