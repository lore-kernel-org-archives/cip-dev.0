From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 10:58:12 +0100
Subject: [cip-dev] [PATCH 4.19.y 13/17] clk: renesas: r8a774c0: Fix
	LAST_DT_CORE_CLK
In-Reply-To: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554112696-20706-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit e61b30bb34b6206f76e623269a41b65cd3989fff upstream.

Enum LAST_DT_CORE_CLK needs updating as R8A774C0_CLK_CANFD
was recently added and it's the core clock with the highest
index.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Fixes: 2a6efbc6da5d248c ("clk: renesas: r8a774c0: Add missing CANFD clock")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index aeadb4d..34e274f 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -22,7 +22,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R8A774C0_CLK_CPEX,
+	LAST_DT_CORE_CLK = R8A774C0_CLK_CANFD,
 
 	/* External Input Clocks */
 	CLK_EXTAL,
-- 
2.7.4
