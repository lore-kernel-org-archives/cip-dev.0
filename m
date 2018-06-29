From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:08 +0100
Subject: [cip-dev] [PATCH 07/86] clk: shmobile: Document r8a7745 CPG clock
	support
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Document r8a7745 CPG clock support.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index 986b8a1..a75c26a 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -9,6 +9,7 @@ Required Properties:
 
   - compatible: Must be one of
     - "renesas,r8a7743-cpg-clocks" for the r8a7743 CPG
+    - "renesas,r8a7745-cpg-clocks" for the r8a7745 CPG
     - "renesas,r8a7790-cpg-clocks" for the r8a7790 CPG
     - "renesas,r8a7791-cpg-clocks" for the r8a7791 CPG
     - "renesas,r8a7793-cpg-clocks" for the r8a7793 CPG
-- 
2.7.4
