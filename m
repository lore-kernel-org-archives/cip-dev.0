From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:51 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 06/23] clk: renesas: r8a774a1: Add
	missing CANFD clock
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 9d034e151b407cbd2c66bc4c48b423f814533374 upstream.

This patch adds the missing CANFD clock to the r8a774a1 specific
clock driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c       | 2 ++
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 10e8525..e103741 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -102,6 +102,7 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 	DEF_FIXED("cp",         R8A774A1_CLK_CP,    CLK_EXTAL,      2, 1),
 	DEF_FIXED("cpex",       R8A774A1_CLK_CPEX,  CLK_EXTAL,      2, 1),
 
+	DEF_DIV6P1("canfd",     R8A774A1_CLK_CANFD, CLK_PLL1_DIV4, 0x244),
 	DEF_DIV6P1("csi0",      R8A774A1_CLK_CSI0,  CLK_PLL1_DIV4, 0x00c),
 	DEF_DIV6P1("mso",       R8A774A1_CLK_MSO,   CLK_PLL1_DIV4, 0x014),
 	DEF_DIV6P1("hdmi",      R8A774A1_CLK_HDMI,  CLK_PLL1_DIV4, 0x250),
@@ -191,6 +192,7 @@ static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
 	DEF_MOD("gpio2",		 910,	R8A774A1_CLK_S3D4),
 	DEF_MOD("gpio1",		 911,	R8A774A1_CLK_S3D4),
 	DEF_MOD("gpio0",		 912,	R8A774A1_CLK_S3D4),
+	DEF_MOD("can-fd",		 914,	R8A774A1_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A774A1_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A774A1_CLK_S3D4),
 	DEF_MOD("i2c6",			 918,	R8A774A1_CLK_S0D6),
diff --git a/include/dt-bindings/clock/r8a774a1-cpg-mssr.h b/include/dt-bindings/clock/r8a774a1-cpg-mssr.h
index 9bc5d45..e355363 100644
--- a/include/dt-bindings/clock/r8a774a1-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a774a1-cpg-mssr.h
@@ -54,5 +54,6 @@
 #define R8A774A1_CLK_CPEX		43
 #define R8A774A1_CLK_R			44
 #define R8A774A1_CLK_OSC		45
+#define R8A774A1_CLK_CANFD		46
 
 #endif /* __DT_BINDINGS_CLOCK_R8A774A1_CPG_MSSR_H__ */
-- 
2.7.4
