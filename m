From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:30:06 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 21/23] clk: renesas: rcar-gen3: Fix
	cpg_sd_clock_round_rate() return value
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-22-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit b953eaaeb58efc944f51cffd3f6838657958f0f8 upstream.

cpg_sd_clock_round_rate() may return an unsupported clock rate for the
requested clock rate. Therefore, when cpg_sd_clock_set_rate() sets the
clock rate acquired by cpg_sd_clock_round_rate(), an error may occur.

This is not conform the clk API design.

This patch fixes that by making sure cpg_sd_clock_calc_div() considers
only the division values defined in cpg_sd_div_table[].
With this fix, the cpg_sd_clock_round_rate() always return a support
clock rate.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Fixes: 90c073e53909da85 ("clk: shmobile: r8a7795: Add SD divider support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 8b8cc22..477b670 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -2,6 +2,7 @@
  * R-Car Gen3 Clock Pulse Generator
  *
  * Copyright (C) 2015-2018 Glider bvba
+ * Copyright (C) 2019 Renesas Electronics Corp.
  *
  * Based on clk-rcar-gen3.c
  *
@@ -239,8 +240,6 @@ struct sd_clock {
 	const struct sd_div_table *div_table;
 	struct cpg_simple_notifier csn;
 	unsigned int div_num;
-	unsigned int div_min;
-	unsigned int div_max;
 	unsigned int cur_div_idx;
 };
 
@@ -317,14 +316,20 @@ static unsigned int cpg_sd_clock_calc_div(struct sd_clock *clock,
 					  unsigned long rate,
 					  unsigned long parent_rate)
 {
-	unsigned int div;
-
-	if (!rate)
-		rate = 1;
-
-	div = DIV_ROUND_CLOSEST(parent_rate, rate);
+	unsigned long calc_rate, diff, diff_min = ULONG_MAX;
+	unsigned int i, best_div = 0;
+
+	for (i = 0; i < clock->div_num; i++) {
+		calc_rate = DIV_ROUND_CLOSEST(parent_rate,
+					      clock->div_table[i].div);
+		diff = calc_rate > rate ? calc_rate - rate : rate - calc_rate;
+		if (diff < diff_min) {
+			best_div = clock->div_table[i].div;
+			diff_min = diff;
+		}
+	}
 
-	return clamp_t(unsigned int, div, clock->div_min, clock->div_max);
+	return best_div;
 }
 
 static long cpg_sd_clock_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -408,13 +413,6 @@ static struct clk * __init cpg_sd_clk_register(const char *name,
 	val |= CPG_SD_STP_MASK | (clock->div_table[0].val & CPG_SD_FC_MASK);
 	writel(val, clock->csn.reg);
 
-	clock->div_max = clock->div_table[0].div;
-	clock->div_min = clock->div_max;
-	for (i = 1; i < clock->div_num; i++) {
-		clock->div_max = max(clock->div_max, clock->div_table[i].div);
-		clock->div_min = min(clock->div_min, clock->div_table[i].div);
-	}
-
 	clk = clk_register(NULL, &clock->hw);
 	if (IS_ERR(clk))
 		goto free_clock;
-- 
2.7.4
