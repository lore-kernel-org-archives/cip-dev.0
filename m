From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  1 Apr 2019 10:58:09 +0100
Subject: [cip-dev] [PATCH 4.19.y 10/17] clk: renesas: r8a774c0: Add missing
	CANFD clock
In-Reply-To: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1554112696-20706-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 2a6efbc6da5d248c4fbe7fdb7de7f3eff1de95a4 upstream.

This patch adds the missing CANFD clock to the r8a774c0 specific
clock driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r8a774c0-cpg-mssr.c       | 4 ++++
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 10b9689..28bcc81 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -33,6 +33,7 @@ enum clk_ids {
 	CLK_PLL1,
 	CLK_PLL3,
 	CLK_PLL0D4,
+	CLK_PLL0D6,
 	CLK_PLL0D8,
 	CLK_PLL0D20,
 	CLK_PLL0D24,
@@ -61,6 +62,7 @@ static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
 
 	DEF_FIXED(".pll0",     CLK_PLL0,           CLK_MAIN,	   1, 100),
 	DEF_FIXED(".pll0d4",   CLK_PLL0D4,         CLK_PLL0,       4, 1),
+	DEF_FIXED(".pll0d6",   CLK_PLL0D6,         CLK_PLL0,       6, 1),
 	DEF_FIXED(".pll0d8",   CLK_PLL0D8,         CLK_PLL0,       8, 1),
 	DEF_FIXED(".pll0d20",  CLK_PLL0D20,        CLK_PLL0,      20, 1),
 	DEF_FIXED(".pll0d24",  CLK_PLL0D24,        CLK_PLL0,      24, 1),
@@ -112,6 +114,7 @@ static const struct cpg_core_clk r8a774c0_core_clks[] __initconst = {
 	DEF_GEN3_PE("s3d2c",   R8A774C0_CLK_S3D2C, CLK_S3, 2, CLK_PE, 2),
 	DEF_GEN3_PE("s3d4c",   R8A774C0_CLK_S3D4C, CLK_S3, 4, CLK_PE, 4),
 
+	DEF_DIV6P1("canfd",    R8A774C0_CLK_CANFD, CLK_PLL0D6, 0x244),
 	DEF_DIV6P1("csi0",     R8A774C0_CLK_CSI0,  CLK_PLL1D2, 0x00c),
 	DEF_DIV6P1("mso",      R8A774C0_CLK_MSO,   CLK_PLL1D2, 0x014),
 
@@ -187,6 +190,7 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 	DEF_MOD("gpio2",		 910,	R8A774C0_CLK_S3D4),
 	DEF_MOD("gpio1",		 911,	R8A774C0_CLK_S3D4),
 	DEF_MOD("gpio0",		 912,	R8A774C0_CLK_S3D4),
+	DEF_MOD("can-fd",		 914,	R8A774C0_CLK_S3D2),
 	DEF_MOD("can-if1",		 915,	R8A774C0_CLK_S3D4),
 	DEF_MOD("can-if0",		 916,	R8A774C0_CLK_S3D4),
 	DEF_MOD("i2c6",			 918,	R8A774C0_CLK_S3D2),
diff --git a/include/dt-bindings/clock/r8a774c0-cpg-mssr.h b/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
index 8fe51b6..8ad9cd6 100644
--- a/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
+++ b/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
@@ -56,5 +56,6 @@
 #define R8A774C0_CLK_CSI0		45
 #define R8A774C0_CLK_CP			46
 #define R8A774C0_CLK_CPEX		47
+#define R8A774C0_CLK_CANFD		48
 
 #endif /* __DT_BINDINGS_CLOCK_R8A774C0_CPG_MSSR_H__ */
-- 
2.7.4
