From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:25 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 09/21] clk: shmobile: Document r8a7744
	CPG DIV6 clock support
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document r8a7744 CPG DIV6 clock support.

The clock driver architecture has changed quite dramatically
over time, there is nothing we can backport from mainline
for this, hence the new patch.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 3a05843..7b05aff 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -10,6 +10,7 @@ Required Properties:
     - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
     - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
     - "renesas,r8a7743-div6-clock" for R8A7743 (RZ/G1M) DIV6 clocks
+    - "renesas,r8a7744-div6-clock" for R8A7744 (RZ/G1N) DIV6 clocks
     - "renesas,r8a7745-div6-clock" for R8A7745 (RZ/G1E) DIV6 clocks
     - "renesas,r8a77470-div6-clock" for R8A77470 (RZ/G1C) DIV6 clocks
     - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
-- 
2.7.4
