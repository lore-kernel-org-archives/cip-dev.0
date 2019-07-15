From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:46 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 01/23] clk: renesas: r8a774a1: Add CPEX
	clock
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f845b01d478a4d139fe3493f1e6ec8d9110ce56c upstream.

Implement support for the CPEX clock on RZ/G2M.  This clock can be
selected as a clock source for CMT1 (Compare Match Timer Type 1).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index b0da342..10e8525 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -100,6 +100,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 
 	DEF_FIXED("cl",         R8A774A1_CLK_CL,    CLK_PLL1_DIV2, 48, 1),
 	DEF_FIXED("cp",         R8A774A1_CLK_CP,    CLK_EXTAL,      2, 1),
+	DEF_FIXED("cpex",       R8A774A1_CLK_CPEX,  CLK_EXTAL,      2, 1),
 
 	DEF_DIV6P1("csi0",      R8A774A1_CLK_CSI0,  CLK_PLL1_DIV4, 0x00c),
 	DEF_DIV6P1("mso",       R8A774A1_CLK_MSO,   CLK_PLL1_DIV4, 0x014),
-- 
2.7.4
