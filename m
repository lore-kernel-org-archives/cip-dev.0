From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 13 May 2019 16:36:27 +0100
Subject: [cip-dev] [PATCH 4.4.y 02/52] clk: shmobile: rcar-gen2: Add quirks
	for the RZ/G1C
In-Reply-To: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557761837-24993-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557761837-24993-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds a quirk for clocks "sd0" and "sd1" for the
RZ/G1C (a.k.a. r8a77470) SoC, similarly to what has been done
upstream with commit:
5bf2fbbef50c ("clk: renesas: cpg-mssr: Add r8a77470 support")

and also customizes the settings for the PLLs.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clk/shmobile/clk-rcar-gen2.c | 39 +++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index 6ab0199..3f7d331 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -268,6 +268,24 @@ static struct clk * __init cpg_adsp_clk_register(struct rcar_gen2_cpg *cpg)
 #define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 12) | \
 					 (((md) & BIT(13)) >> 12) | \
 					 (((md) & BIT(19)) >> 19))
+
+/*
+ * This table is only valid for the RZ/G1C
+ *
+ *    MD	EXTAL		PLL0	PLL1	PLL3
+ * 14 13	(MHz)		*1	*2
+ *---------------------------------------------------
+ * 0  0		20 / 1		x80	x78	x50
+ * 0  1		26 / 1		x60	x60	x56
+ * 1  0		Prohibited setting
+ * 1  1		30 / 1		x52	x52	x50
+ *
+ * *1 :	Table 7.4 indicates VCO output (PLL0 = VCO)
+ * *2 :	Table 7.4 indicates VCO output (PLL1 = VCO)
+ */
+#define CPG_PLL_CONFIG_INDEX_RZG1C(md)	((((md) & BIT(14)) >> 13) | \
+					 (((md) & BIT(13)) >> 13))
+
 struct cpg_pll_config {
 	unsigned int extal_div;
 	unsigned int pll1_mult;
@@ -282,6 +300,14 @@ static const struct cpg_pll_config cpg_pll_configs[8] __initconst = {
 	{ 2, 208, 106, 200 }, { 2, 208,  88, 200 },
 };
 
+static const struct cpg_pll_config cpg_pll_configs_rzg1c[4] __initconst = {
+	/* EXTAL div	PLL1 mult x2	PLL3 mult */
+	{ 1,		156,		50,	},
+	{ 1,		120,		56,	},
+	{ /* Invalid*/				},
+	{ 1,		104,		50,	},
+};
+
 /* SDHI divisors */
 static const struct clk_div_table cpg_sdh_div_table[] = {
 	{  0,  2 }, {  1,  3 }, {  2,  4 }, {  3,  6 },
@@ -308,6 +334,8 @@ static const char * const pll0_mult_match[] = {
 	NULL
 };
 
+static const char *r8a77470_compat = "renesas,r8a77470-cpg-clocks";
+
 static struct clk * __init
 rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
 			     const struct cpg_pll_config *config,
@@ -357,10 +385,16 @@ rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
 	} else if (!strcmp(name, "sd0")) {
 		parent_name = "pll1";
 		table = cpg_sd01_div_table;
+		if (of_device_is_compatible(np, r8a77470_compat))
+			table++;
+
 		shift = 4;
 	} else if (!strcmp(name, "sd1")) {
 		parent_name = "pll1";
 		table = cpg_sd01_div_table;
+		if (of_device_is_compatible(np, r8a77470_compat))
+			table++;
+
 		shift = 0;
 	} else if (!strcmp(name, "z")) {
 		return cpg_z_clk_register(cpg);
@@ -414,7 +448,10 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 	if (WARN_ON(cpg->reg == NULL))
 		return;
 
-	config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
+	if (of_device_is_compatible(np, r8a77470_compat))
+		config = &cpg_pll_configs_rzg1c[CPG_PLL_CONFIG_INDEX_RZG1C(cpg_mode)];
+	else
+		config = &cpg_pll_configs[CPG_PLL_CONFIG_INDEX(cpg_mode)];
 
 	for (i = 0; i < num_clks; ++i) {
 		const char *name;
-- 
2.7.4
