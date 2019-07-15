From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:52 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 07/23] clk: renesas: rcar-gen3: Factor
	out cpg_reg_modify()
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 8cb8f16c62e5ea9c77ca7d25af761f4eaea670ba upstream.

There's quite often repeated sequence of a CPG register read-modify-write,
so it seems worth factoring it out into a function -- this saves 68 bytes
of the object code (AArch64 gcc 4.8.5) and simplifies protecting all such
sequences with a spinlock in the next patch...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 38 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index fa823a3..37be0e8 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -33,6 +33,16 @@
 
 #define CPG_RCKCR_CKSEL	BIT(15)	/* RCLK Clock Source Select */
 
+static void cpg_reg_modify(void __iomem *reg, u32 clear, u32 set)
+{
+	u32 val;
+
+	val = readl(reg);
+	val &= ~clear;
+	val |= set;
+	writel(val, reg);
+};
+
 struct cpg_simple_notifier {
 	struct notifier_block nb;
 	void __iomem *reg;
@@ -121,7 +131,6 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct cpg_z_clk *zclk = to_z_clk(hw);
 	unsigned int mult;
 	unsigned int i;
-	u32 val, kick;
 
 	/* Factor of 2 is for fixed divider */
 	mult = DIV_ROUND_CLOSEST_ULL(rate * 32ULL * 2, parent_rate);
@@ -130,17 +139,14 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
 		return -EBUSY;
 
-	val = readl(zclk->reg) & ~zclk->mask;
-	val |= ((32 - mult) << __ffs(zclk->mask)) & zclk->mask;
-	writel(val, zclk->reg);
+	cpg_reg_modify(zclk->reg, zclk->mask,
+		       ((32 - mult) << __ffs(zclk->mask)) & zclk->mask);
 
 	/*
 	 * Set KICK bit in FRQCRB to update hardware setting and wait for
 	 * clock change completion.
 	 */
-	kick = readl(zclk->kick_reg);
-	kick |= CPG_FRQCRB_KICK;
-	writel(kick, zclk->kick_reg);
+	cpg_reg_modify(zclk->kick_reg, 0, CPG_FRQCRB_KICK);
 
 	/*
 	 * Note: There is no HW information about the worst case latency.
@@ -269,12 +275,10 @@ static const struct sd_div_table cpg_sd_div_table[] = {
 static int cpg_sd_clock_enable(struct clk_hw *hw)
 {
 	struct sd_clock *clock = to_sd_clock(hw);
-	u32 val = readl(clock->csn.reg);
 
-	val &= ~(CPG_SD_STP_MASK);
-	val |= clock->div_table[clock->cur_div_idx].val & CPG_SD_STP_MASK;
-
-	writel(val, clock->csn.reg);
+	cpg_reg_modify(clock->csn.reg, CPG_SD_STP_MASK,
+		       clock->div_table[clock->cur_div_idx].val &
+		       CPG_SD_STP_MASK);
 
 	return 0;
 }
@@ -283,7 +287,7 @@ static void cpg_sd_clock_disable(struct clk_hw *hw)
 {
 	struct sd_clock *clock = to_sd_clock(hw);
 
-	writel(readl(clock->csn.reg) | CPG_SD_STP_MASK, clock->csn.reg);
+	cpg_reg_modify(clock->csn.reg, 0, CPG_SD_STP_MASK);
 }
 
 static int cpg_sd_clock_is_enabled(struct clk_hw *hw)
@@ -330,7 +334,6 @@ static int cpg_sd_clock_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct sd_clock *clock = to_sd_clock(hw);
 	unsigned int div = cpg_sd_clock_calc_div(clock, rate, parent_rate);
-	u32 val;
 	unsigned int i;
 
 	for (i = 0; i < clock->div_num; i++)
@@ -342,10 +345,9 @@ static int cpg_sd_clock_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	clock->cur_div_idx = i;
 
-	val = readl(clock->csn.reg);
-	val &= ~(CPG_SD_STP_MASK | CPG_SD_FC_MASK);
-	val |= clock->div_table[i].val & (CPG_SD_STP_MASK | CPG_SD_FC_MASK);
-	writel(val, clock->csn.reg);
+	cpg_reg_modify(clock->csn.reg, CPG_SD_STP_MASK | CPG_SD_FC_MASK,
+		       clock->div_table[i].val &
+		       (CPG_SD_STP_MASK | CPG_SD_FC_MASK));
 
 	return 0;
 }
-- 
2.7.4
