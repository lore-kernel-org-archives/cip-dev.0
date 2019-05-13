From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:56 +0100
Subject: [cip-dev] [PATCH 4.4.y 31/52] clk: shmobile: Document r8a77470 CPG
	DIV6 clock support
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-32-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document r8a77470 CPG DIV6 clock support.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index feb9ab5..3a05843 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -11,6 +11,7 @@ Required Properties:
     - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
     - "renesas,r8a7743-div6-clock" for R8A7743 (RZ/G1M) DIV6 clocks
     - "renesas,r8a7745-div6-clock" for R8A7745 (RZ/G1E) DIV6 clocks
+    - "renesas,r8a77470-div6-clock" for R8A77470 (RZ/G1C) DIV6 clocks
     - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
     - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2-W) DIV6 clocks
     - "renesas,r8a7793-div6-clock" for R8A7793 (R-Car M2-N) DIV6 clocks
-- 
2.7.4
