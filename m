From: biju.das@bp.renesas.com (Biju Das)
Date: Tue,  8 Aug 2017 10:50:18 +0100
Subject: [cip-dev] [PATCH 04/14] clk: shmobile: Document r8a7743 CPG DIV6
	clock support
In-Reply-To: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
References: <1502185828-45443-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1502185828-45443-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 38dcf03..2990615 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -9,6 +9,7 @@ Required Properties:
   - compatible: Must be one of the following
     - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
     - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
+    - "renesas,r8a7743-div6-clock" for R8A7743 (RZ/G1M) DIV6 clocks
     - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
     - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2-W) DIV6 clocks
     - "renesas,r8a7793-div6-clock" for R8A7793 (R-Car M2-N) DIV6 clocks
-- 
1.9.1
