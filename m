From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:43 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 09/22] clk: renesas: r8a774a1: Add TMU
	clock
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit c1324171a9d1771d3610cd13c952b981d52317df upstream.

This patch adds the TMU clocks to the R8A774A1 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 76ed7d1..e05bfa2 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -113,6 +113,11 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
+	DEF_MOD("tmu4",			 121,	R8A774A1_CLK_S0D6),
+	DEF_MOD("tmu3",			 122,	R8A774A1_CLK_S3D2),
+	DEF_MOD("tmu2",			 123,	R8A774A1_CLK_S3D2),
+	DEF_MOD("tmu1",			 124,	R8A774A1_CLK_S3D2),
+	DEF_MOD("tmu0",			 125,	R8A774A1_CLK_CP),
 	DEF_MOD("fdp1-0",		 119,	R8A774A1_CLK_S0D1),
 	DEF_MOD("scif5",		 202,	R8A774A1_CLK_S3D4),
 	DEF_MOD("scif4",		 203,	R8A774A1_CLK_S3D4),
-- 
2.7.4
