From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:23 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 07/21] clk: shmobile: Document r8a7744
	CPG clock support
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document r8a7744 CPG clock support.

The clock driver architecture has changed quite dramatically
over time, there is nothing we can backport from mainline
for this, hence the new patch.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index ba321bc..631cd38 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -9,6 +9,7 @@ Required Properties:
 
   - compatible: Must be one of
     - "renesas,r8a7743-cpg-clocks" for the r8a7743 CPG
+    - "renesas,r8a7744-cpg-clocks" for the r8a7744 CPG
     - "renesas,r8a7745-cpg-clocks" for the r8a7745 CPG
     - "renesas,r8a77470-cpg-clocks" for the r8a77470 CPG
     - "renesas,r8a7790-cpg-clocks" for the r8a7790 CPG
-- 
2.7.4
