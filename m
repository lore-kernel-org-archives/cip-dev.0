From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:54 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 09/23] clk: renesas: r8a774a1: Fix
	LAST_DT_CORE_CLK
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit df446f7e6ec0ed474dab2e6f19e4618116907f29 upstream.

Enum LAST_DT_CORE_CLK needs updating as R8A774A1_CLK_CANFD
was recently added and it's the core clock with the highest
index.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Fixes: 9d034e151b40 ("clk: renesas: r8a774a1: Add missing CANFD clock")
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index e103741..4d92b27 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -21,7 +21,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R8A774A1_CLK_OSC,
+	LAST_DT_CORE_CLK = R8A774A1_CLK_CANFD,
 
 	/* External Input Clocks */
 	CLK_EXTAL,
-- 
2.7.4
