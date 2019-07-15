From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:55 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 10/23] clk: renesas: rcar-gen3: Pass
	name/offset to cpg_sd_clk_register()
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 6a82559f745bc26d2e4974c1d26014ef7fa14794 upstream.

Explicitly pass the clock's name and register offset to
cpg_sd_clk_register(), so the latter doesn't have to extract them from
the cpg_core_clk object.

This keeps all cpg_core_clk parsing and unmarshalling contained in a
single function (rcar_gen3_cpg_clk_register()).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 3bef9f2..e630c6b 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -372,8 +372,8 @@ static u32 cpg_quirks __initdata;
 #define RCKCR_CKSEL	BIT(1)		/* Manual RCLK parent selection */
 #define SD_SKIP_FIRST	BIT(2)		/* Skip first clock in SD table */
 
-static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
-	void __iomem *base, const char *parent_name,
+static struct clk * __init cpg_sd_clk_register(const char *name,
+	void __iomem *base, unsigned int offset, const char *parent_name,
 	struct raw_notifier_head *notifiers)
 {
 	struct clk_init_data init;
@@ -386,13 +386,13 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 	if (!clock)
 		return ERR_PTR(-ENOMEM);
 
-	init.name = core->name;
+	init.name = name;
 	init.ops = &cpg_sd_clock_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
-	clock->csn.reg = base + core->offset;
+	clock->csn.reg = base + offset;
 	clock->hw.init = &init;
 	clock->div_table = cpg_sd_div_table;
 	clock->div_num = ARRAY_SIZE(cpg_sd_div_table);
@@ -523,8 +523,8 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		break;
 
 	case CLK_TYPE_GEN3_SD:
-		return cpg_sd_clk_register(core, base, __clk_get_name(parent),
-					   notifiers);
+		return cpg_sd_clk_register(core->name, base, core->offset,
+					   __clk_get_name(parent), notifiers);
 
 	case CLK_TYPE_GEN3_R:
 		if (cpg_quirks & RCKCR_CKSEL) {
-- 
2.7.4
