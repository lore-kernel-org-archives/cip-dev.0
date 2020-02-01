From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Sat,  1 Feb 2020 12:27:01 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 13/14] clk: renesas: r8a774b1: Add TMU
	clock
In-Reply-To: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580560022-26873-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580560022-26873-14-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 56278c8fcb71874d591907d654272d511ce3597c upstream.

This patch adds the TMU clocks to the R8A774B1 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1569249688-15821-1-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r8a774b1-cpg-mssr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r8a774b1-cpg-mssr.c b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
index 6cad6ba..c9af7091 100644
--- a/drivers/clk/renesas/r8a774b1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774b1-cpg-mssr.c
@@ -110,6 +110,11 @@ static const struct cpg_core_clk r8a774b1_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774b1_mod_clks[] __initconst = {
+	DEF_MOD("tmu4",			 121,	R8A774B1_CLK_S0D6),
+	DEF_MOD("tmu3",			 122,	R8A774B1_CLK_S3D2),
+	DEF_MOD("tmu2",			 123,	R8A774B1_CLK_S3D2),
+	DEF_MOD("tmu1",			 124,	R8A774B1_CLK_S3D2),
+	DEF_MOD("tmu0",			 125,	R8A774B1_CLK_CP),
 	DEF_MOD("fdp1-0",		 119,	R8A774B1_CLK_S0D1),
 	DEF_MOD("scif5",		 202,	R8A774B1_CLK_S3D4),
 	DEF_MOD("scif4",		 203,	R8A774B1_CLK_S3D4),
-- 
2.7.4
