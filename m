From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:58 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 13/23] clk: renesas: rcar-gen3: Remove
	CLK_TYPE_GEN3_Z2
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit e0836e36384321ab1b4af05ab441c0c59a972596 upstream.

After recent reworking of Z and Z2 clk handling
CLK_TYPE_GEN3_Z and CLK_TYPE_GEN3_Z2 have come to have precisely
the same meaning. Remove this redundancy by eliminating the latter.

This is not expected to have any run-time effect.

As suggested by Geert Uytterhoeven.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 2 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c  | 2 +-
 drivers/clk/renesas/r8a7796-cpg-mssr.c  | 2 +-
 drivers/clk/renesas/rcar-gen3-cpg.c     | 1 -
 drivers/clk/renesas/rcar-gen3-cpg.h     | 1 -
 5 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 8e7bb43..44161fd 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -72,7 +72,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",		R8A774A1_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
-	DEF_GEN3_Z("z2",	R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("z2",	R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
 	DEF_FIXED("ztr",        R8A774A1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774A1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774A1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 97a6b2e..283a1b6 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -76,7 +76,7 @@ static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
 
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",         R8A7795_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
-	DEF_GEN3_Z("z2",        R8A7795_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("z2",        R8A7795_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
 	DEF_FIXED("ztr",        R8A7795_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7795_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7795_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 9464b9d..ace2196 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -76,7 +76,7 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 
 	/* Core Clock Outputs */
 	DEF_GEN3_Z("z",         R8A7796_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2, 8),
-	DEF_GEN3_Z("z2",        R8A7796_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2, 0),
+	DEF_GEN3_Z("z2",        R8A7796_CLK_Z2,    CLK_TYPE_GEN3_Z,  CLK_PLL2, 2, 0),
 	DEF_FIXED("ztr",        R8A7796_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7796_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7796_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 9e885e4..01c1d8f 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -576,7 +576,6 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		break;
 
 	case CLK_TYPE_GEN3_Z:
-	case CLK_TYPE_GEN3_Z2:
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
 					  base, core->div, core->offset);
 
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 6272931..131ede2 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -23,7 +23,6 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_R,
 	CLK_TYPE_GEN3_MDSEL,	/* Select parent/divider using mode pin */
 	CLK_TYPE_GEN3_Z,
-	CLK_TYPE_GEN3_Z2,
 	CLK_TYPE_GEN3_OSC,	/* OSC EXTAL predivider and fixed divider */
 	CLK_TYPE_GEN3_RCKSEL,	/* Select parent/divider using RCKCR.CKSEL */
 };
-- 
2.7.4
