From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:24 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 08/21] clk: shmobile: Document r8a7744
	MSTP clock support
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document r8a7744 MSTP clock support.

The clock driver architecture has changed quite dramatically
over time, there is nothing we can backport from mainline
for this, hence the new patch.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
index a9d2e65..1f64680 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
@@ -14,6 +14,7 @@ Required Properties:
     - "renesas,r8a73a4-mstp-clocks" for R8A73A4 (R-Mobile APE6) MSTP gate clocks
     - "renesas,r8a7740-mstp-clocks" for R8A7740 (R-Mobile A1) MSTP gate clocks
     - "renesas,r8a7743-mstp-clocks" for R8A7743 (RZ/G1M) MSTP gate clocks
+    - "renesas,r8a7744-mstp-clocks" for R8A7744 (RZ/G1N) MSTP gate clocks
     - "renesas,r8a7745-mstp-clocks" for R8A7745 (RZ/G1E) MSTP gate clocks
     - "renesas,r8a77470-mstp-clocks" for R8A77470 (RZ/G1C) MSTP gate clocks
     - "renesas,r8a7778-mstp-clocks" for R8A7778 (R-Car M1) MSTP gate clocks
-- 
2.7.4
