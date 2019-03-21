From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 15:12:07 +0000
Subject: [cip-dev] [PATCH 8/9] dt-bindings: clock: renesas: cpg-mssr:
	Document r8a774c0
In-Reply-To: <1553181128-8171-1-git-send-email-biju.das@bp.renesas.com>
References: <1553181128-8171-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553181128-8171-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch documents RZ/G2E (a.k.a. R8A774C0) bindings for the
Clock Pulse Generator driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 7c0043c0a48c18fccd43e5cd9f45751316564647)
[removed r7s9210 and r8a7744 devices]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
index 42d0f83..6ff3a06 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -17,6 +17,7 @@ Required Properties:
       - "renesas,r8a7745-cpg-mssr" for the r8a7745 SoC (RZ/G1E)
       - "renesas,r8a77470-cpg-mssr" for the r8a77470 SoC (RZ/G1C)
       - "renesas,r8a774a1-cpg-mssr" for the r8a774a1 SoC (RZ/G2M)
+      - "renesas,r8a774c0-cpg-mssr" for the r8a774c0 SoC (RZ/G2E)
       - "renesas,r8a7790-cpg-mssr" for the r8a7790 SoC (R-Car H2)
       - "renesas,r8a7791-cpg-mssr" for the r8a7791 SoC (R-Car M2-W)
       - "renesas,r8a7792-cpg-mssr" for the r8a7792 SoC (R-Car V2H)
@@ -36,8 +37,8 @@ Required Properties:
   - clocks: References to external parent clocks, one entry for each entry in
     clock-names
   - clock-names: List of external parent clock names. Valid names are:
-      - "extal" (r8a7743, r8a7745, r8a77470, r8a774a1, r8a7790, r8a7791,
-		 r8a7792, r8a7793, r8a7794, r8a7795, r8a7796, r8a77965,
+      - "extal" (r8a7743, r8a7745, r8a77470, r8a774a1, r8a774c0, r8a7790,
+		 r8a7791, r8a7792, r8a7793, r8a7794, r8a7795, r8a7796, r8a77965,
 		 r8a77970, r8a77980, r8a77990, r8a77995)
       - "extalr" (r8a774a1, r8a7795, r8a7796, r8a77965, r8a77970, r8a77980)
       - "usb_extal" (r8a7743, r8a7745, r8a77470, r8a7790, r8a7791, r8a7793,
-- 
2.7.4
