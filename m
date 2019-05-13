From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:55 +0100
Subject: [cip-dev] [PATCH 4.4.y 30/52] clk: shmobile: Document r8a77470 CPG
	clock support
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-31-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document r8a77470 CPG clock support.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index a75c26a..ba321bc 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -10,6 +10,7 @@ Required Properties:
   - compatible: Must be one of
     - "renesas,r8a7743-cpg-clocks" for the r8a7743 CPG
     - "renesas,r8a7745-cpg-clocks" for the r8a7745 CPG
+    - "renesas,r8a77470-cpg-clocks" for the r8a77470 CPG
     - "renesas,r8a7790-cpg-clocks" for the r8a7790 CPG
     - "renesas,r8a7791-cpg-clocks" for the r8a7791 CPG
     - "renesas,r8a7793-cpg-clocks" for the r8a7793 CPG
-- 
2.7.4
