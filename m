From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:56 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 11/23] clk: renesas: rcar-gen3:
	Parameterise Z and Z2 clock fixed divisor
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-12-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 20cc05ba04a93f05d6c50789fe35d762a2db4e96 upstream.

Parameterise Z and Z2 clock fixed divisor to allow clocks with a fixed
divisor other than 2, the value used by all such clocks supported to date.

This is in preparation for supporting the Z2 clock on the R-Car E3
(r8a77990) SoC which has a fixed divisor of 4.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[simon: squashed several patches; rewrote changelog; added r8a774a1 change]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c |  4 ++--
 drivers/clk/renesas/r8a7795-cpg-mssr.c  |  5 +++--
 drivers/clk/renesas/r8a7796-cpg-mssr.c  |  5 +++--
 drivers/clk/renesas/r8a77965-cpg-mssr.c |  2 +-
 drivers/clk/renesas/rcar-gen3-cpg.c     | 24 +++++++++++++++---------
 drivers/clk/renesas/rcar-gen3-cpg.h     |  4 ++++
 6 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 4d92b27..99bcb7c 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -71,8 +71,8 @@ static const struct cpg_core_clk r8a774a1_core_clks[] __initconst = {
 	DEF_GEN3_OSC(".r",      CLK_RINT,          CLK_EXTAL,      32),
 
 	/* Core Clock Outputs */
-	DEF_BASE("z",           R8A774A1_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0),
-	DEF_BASE("z2",          R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2),
+	DEF_GEN3_Z("z",		R8A774A1_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0, 2),
+	DEF_GEN3_Z("z2",	R8A774A1_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2),
 	DEF_FIXED("ztr",        R8A774A1_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A774A1_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A774A1_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index a85dd50..29b30cc 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -2,6 +2,7 @@
  * r8a7795 Clock Pulse Generator / Module Standby and Software Reset
  *
  * Copyright (C) 2015 Glider bvba
+ * Copyright (C) 2018 Renesas Electronics Corp.
  *
  * Based on clk-rcar-gen3.c
  *
@@ -74,8 +75,8 @@ static struct cpg_core_clk r8a7795_core_clks[] __initdata = {
 	DEF_FIXED(".sdsrc",     CLK_SDSRC,         CLK_PLL1_DIV2,  2, 1),
 
 	/* Core Clock Outputs */
-	DEF_BASE("z",           R8A7795_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0),
-	DEF_BASE("z2",          R8A7795_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2),
+	DEF_GEN3_Z("z",         R8A7795_CLK_Z,	   CLK_TYPE_GEN3_Z,  CLK_PLL0, 2),
+	DEF_GEN3_Z("z2",        R8A7795_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2),
 	DEF_FIXED("ztr",        R8A7795_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7795_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7795_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index dfb267a..761c2c2 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -2,6 +2,7 @@
  * r8a7796 Clock Pulse Generator / Module Standby and Software Reset
  *
  * Copyright (C) 2016 Glider bvba
+ * Copyright (C) 2018 Renesas Electronics Corp.
  *
  * Based on r8a7795-cpg-mssr.c
  *
@@ -74,8 +75,8 @@ static const struct cpg_core_clk r8a7796_core_clks[] __initconst = {
 	DEF_FIXED(".sdsrc",     CLK_SDSRC,         CLK_PLL1_DIV2,  2, 1),
 
 	/* Core Clock Outputs */
-	DEF_BASE("z",           R8A7796_CLK_Z,     CLK_TYPE_GEN3_Z, CLK_PLL0),
-	DEF_BASE("z2",          R8A7796_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2),
+	DEF_GEN3_Z("z",         R8A7796_CLK_Z,     CLK_TYPE_GEN3_Z,  CLK_PLL0, 2),
+	DEF_GEN3_Z("z2",        R8A7796_CLK_Z2,    CLK_TYPE_GEN3_Z2, CLK_PLL2, 2),
 	DEF_FIXED("ztr",        R8A7796_CLK_ZTR,   CLK_PLL1_DIV2,  6, 1),
 	DEF_FIXED("ztrd2",      R8A7796_CLK_ZTRD2, CLK_PLL1_DIV2, 12, 1),
 	DEF_FIXED("zt",         R8A7796_CLK_ZT,    CLK_PLL1_DIV2,  4, 1),
diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 8fae5e9..9401c3e 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -69,7 +69,7 @@ static const struct cpg_core_clk r8a77965_core_clks[] __initconst = {
 	DEF_FIXED(".sdsrc",	CLK_SDSRC,		CLK_PLL1_DIV2,	2, 1),
 
 	/* Core Clock Outputs */
-	DEF_BASE("z",		R8A77965_CLK_Z,		CLK_TYPE_GEN3_Z, CLK_PLL0),
+	DEF_GEN3_Z("z",		R8A77965_CLK_Z,		CLK_TYPE_GEN3_Z,  CLK_PLL0, 2),
 	DEF_FIXED("ztr",	R8A77965_CLK_ZTR,	CLK_PLL1_DIV2,	6, 1),
 	DEF_FIXED("ztrd2",	R8A77965_CLK_ZTRD2,	CLK_PLL1_DIV2,	12, 1),
 	DEF_FIXED("zt",		R8A77965_CLK_ZT,	CLK_PLL1_DIV2,	4, 1),
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index e630c6b..68e9155 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -99,6 +99,7 @@ struct cpg_z_clk {
 	void __iomem *reg;
 	void __iomem *kick_reg;
 	unsigned long mask;
+	unsigned int fixed_div;
 };
 
 #define to_z_clk(_hw)	container_of(_hw, struct cpg_z_clk, hw)
@@ -113,17 +114,18 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 	val = readl(zclk->reg) & zclk->mask;
 	mult = 32 - (val >> __ffs(zclk->mask));
 
-	/* Factor of 2 is for fixed divider */
-	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, 32 * 2);
+	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult,
+				     32 * zclk->fixed_div);
 }
 
 static long cpg_z_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long *parent_rate)
 {
-	/* Factor of 2 is for fixed divider */
-	unsigned long prate = *parent_rate / 2;
+	struct cpg_z_clk *zclk = to_z_clk(hw);
+	unsigned long prate;
 	unsigned int mult;
 
+	prate = *parent_rate / zclk->fixed_div;
 	mult = div_u64(rate * 32ULL, prate);
 	mult = clamp(mult, 1U, 32U);
 
@@ -137,8 +139,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned int mult;
 	unsigned int i;
 
-	/* Factor of 2 is for fixed divider */
-	mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL * 2, parent_rate);
+	mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL * zclk->fixed_div,
+				     parent_rate);
 	mult = clamp(mult, 1U, 32U);
 
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
@@ -181,7 +183,8 @@ static const struct clk_ops cpg_z_clk_ops = {
 static struct clk * __init cpg_z_clk_register(const char *name,
 					      const char *parent_name,
 					      void __iomem *reg,
-					      unsigned long mask)
+					      unsigned long mask,
+					      unsigned int div)
 {
 	struct clk_init_data init;
 	struct cpg_z_clk *zclk;
@@ -201,6 +204,7 @@ static struct clk * __init cpg_z_clk_register(const char *name,
 	zclk->kick_reg = reg + CPG_FRQCRB;
 	zclk->hw.init = &init;
 	zclk->mask = mask;
+	zclk->fixed_div = div; /* PLLVCO x 1/div x SYS-CPU divider */
 
 	clk = clk_register(NULL, &zclk->hw);
 	if (IS_ERR(clk))
@@ -575,11 +579,13 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 
 	case CLK_TYPE_GEN3_Z:
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
-					  base, CPG_FRQCRC_ZFC_MASK);
+					  base, CPG_FRQCRC_ZFC_MASK,
+					  core->div);
 
 	case CLK_TYPE_GEN3_Z2:
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
-					  base, CPG_FRQCRC_Z2FC_MASK);
+					  base, CPG_FRQCRC_Z2FC_MASK,
+					  core->div);
 
 	case CLK_TYPE_GEN3_OSC:
 		/*
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 04dc45d..947d4c0 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -2,6 +2,7 @@
  * R-Car Gen3 Clock Pulse Generator
  *
  * Copyright (C) 2015-2018 Glider bvba
+ * Copyright (C) 2018 Renesas Electronics Corp.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -47,6 +48,9 @@ enum rcar_gen3_clk_types {
 	DEF_BASE(_name, _id, CLK_TYPE_GEN3_RCKSEL,	\
 		 (_parent0) << 16 | (_parent1),	.div = (_div0) << 16 | (_div1))
 
+#define DEF_GEN3_Z(_name, _id, _type, _parent, _div)	\
+	DEF_BASE(_name, _id, _type, _parent, .div = _div)
+
 struct rcar_gen3_cpg_pll_config {
 	u8 extal_div;
 	u8 pll1_mult;
-- 
2.7.4
