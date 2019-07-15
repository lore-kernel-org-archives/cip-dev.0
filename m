From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:49 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 04/23] clk: renesas: rcar-gen3: Add
	HS400 quirk for SD clock
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

commit 36c4da4f552a126bb29a95dc5c9608795491e32a upstream.

On H3 (ES1.x, ES2.0) and M3-W (ES1.0, ES1.1) the clock setting for HS400
needs a quirk to function properly. The reason for the quirk is that
there are two settings which produces same divider value for the SDn
clock. On the effected boards the one currently selected results in
HS400 not working.

This change uses the same method as the Gen2 CPG driver and simply
ignores the first clock setting as this is the offending one when
selecting the settings. Which of the two possible settings is used have
no effect for SDR104.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 00e41de..3ba5076 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -245,6 +245,10 @@ struct sd_clock {
  *  1         0         2 (4)      0 (2)      8
  *  1         0         3 (8)      0 (2)     16
  *  1         0         4 (16)     0 (2)     32
+ *
+ *  NOTE: There is a quirk option to ignore the first row of the dividers
+ *  table when searching for suitable settings. This is because HS400 on
+ *  early ES versions of H3 and M3-W requires a specific setting to work.
  */
 static const struct sd_div_table cpg_sd_div_table[] = {
 /*	CPG_SD_DIV_TABLE_DATA(stp_hck,  stp_ck,   sd_srcfc,   sd_fc,  sd_div) */
@@ -355,6 +359,12 @@ static const struct clk_ops cpg_sd_clock_ops = {
 	.set_rate = cpg_sd_clock_set_rate,
 };
 
+static u32 cpg_quirks __initdata;
+
+#define PLL_ERRATA	BIT(0)		/* Missing PLL0/2/4 post-divider */
+#define RCKCR_CKSEL	BIT(1)		/* Manual RCLK parent selection */
+#define SD_SKIP_FIRST	BIT(2)		/* Skip first clock in SD table */
+
 static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 	void __iomem *base, const char *parent_name,
 	struct raw_notifier_head *notifiers)
@@ -380,6 +390,11 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 	clock->div_table = cpg_sd_div_table;
 	clock->div_num = ARRAY_SIZE(cpg_sd_div_table);
 
+	if (cpg_quirks & SD_SKIP_FIRST) {
+		clock->div_table++;
+		clock->div_num--;
+	}
+
 	val = readl(clock->csn.reg) & ~CPG_SD_FC_MASK;
 	val |= CPG_SD_STP_MASK | (clock->div_table[0].val & CPG_SD_FC_MASK);
 	writel(val, clock->csn.reg);
@@ -407,23 +422,27 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 static const struct rcar_gen3_cpg_pll_config *cpg_pll_config __initdata;
 static unsigned int cpg_clk_extalr __initdata;
 static u32 cpg_mode __initdata;
-static u32 cpg_quirks __initdata;
-
-#define PLL_ERRATA	BIT(0)		/* Missing PLL0/2/4 post-divider */
-#define RCKCR_CKSEL	BIT(1)		/* Manual RCLK parent selection */
 
 static const struct soc_device_attribute cpg_quirks_match[] __initconst = {
 	{
 		.soc_id = "r8a7795", .revision = "ES1.0",
-		.data = (void *)(PLL_ERRATA | RCKCR_CKSEL),
+		.data = (void *)(PLL_ERRATA | RCKCR_CKSEL | SD_SKIP_FIRST),
 	},
 	{
 		.soc_id = "r8a7795", .revision = "ES1.*",
-		.data = (void *)RCKCR_CKSEL,
+		.data = (void *)(RCKCR_CKSEL | SD_SKIP_FIRST),
+	},
+	{
+		.soc_id = "r8a7795", .revision = "ES2.0",
+		.data = (void *)SD_SKIP_FIRST,
 	},
 	{
 		.soc_id = "r8a7796", .revision = "ES1.0",
-		.data = (void *)RCKCR_CKSEL,
+		.data = (void *)(RCKCR_CKSEL | SD_SKIP_FIRST),
+	},
+	{
+		.soc_id = "r8a7796", .revision = "ES1.1",
+		.data = (void *)SD_SKIP_FIRST,
 	},
 	{ /* sentinel */ }
 };
-- 
2.7.4
