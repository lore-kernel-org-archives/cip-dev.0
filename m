From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 10:58:11 +0100
Subject: [cip-dev] [PATCH 4.19.y 12/17] clk: renesas: r8a774c0: Add TMU clock
In-Reply-To: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554112696-20706-13-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit d1de227de8145e661e940377e050286098197eeb upstream.

This patch adds the TMU clocks to the R8A774C0 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 4f3111b..aeadb4d 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -122,6 +122,11 @@ static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
 };
 
 static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
+	DEF_MOD("tmu4",			 121,	R8A774C0_CLK_S0D6C),
+	DEF_MOD("tmu3",			 122,	R8A774C0_CLK_S3D2C),
+	DEF_MOD("tmu2",			 123,	R8A774C0_CLK_S3D2C),
+	DEF_MOD("tmu1",			 124,	R8A774C0_CLK_S3D2C),
+	DEF_MOD("tmu0",			 125,	R8A774C0_CLK_CP),
 	DEF_MOD("scif5",		 202,	R8A774C0_CLK_S3D4C),
 	DEF_MOD("scif4",		 203,	R8A774C0_CLK_S3D4C),
 	DEF_MOD("scif3",		 204,	R8A774C0_CLK_S3D4C),
-- 
2.7.4
