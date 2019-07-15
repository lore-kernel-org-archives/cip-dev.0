From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:47 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 02/23] clk: renesas: rcar-gen3: Set
	state when registering SD clocks
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

commit ecda0a09fa9933bcd67e33c952f778f0872392ed upstream.

The driver tries to figure out which state a SD clock is in when the
clock is registered, instead of setting a known state. This can be
problematic for two reasons.

1. If the clock driver can't figure out the state of the clock,
   registration of the clock fails, and setting of a known state by a
   clock user is not possible.

2. The state of the clock depends on if and how the bootloader
   configured it. The driver only checks that the rate is known, not if
   the clock is stopped or not for example.

Fix this by setting a known state and making sure the clock is stopped.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 4346fde..d6f5bd1 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -363,7 +363,7 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 	struct sd_clock *clock;
 	struct clk *clk;
 	unsigned int i;
-	u32 sd_fc;
+	u32 val;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
 	if (!clock)
@@ -380,17 +380,9 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 	clock->div_table = cpg_sd_div_table;
 	clock->div_num = ARRAY_SIZE(cpg_sd_div_table);
 
-	sd_fc = readl(clock->csn.reg) & CPG_SD_FC_MASK;
-	for (i = 0; i < clock->div_num; i++)
-		if (sd_fc == (clock->div_table[i].val & CPG_SD_FC_MASK))
-			break;
-
-	if (WARN_ON(i >= clock->div_num)) {
-		kfree(clock);
-		return ERR_PTR(-EINVAL);
-	}
-
-	clock->cur_div_idx = i;
+	val = readl(clock->csn.reg) & ~CPG_SD_FC_MASK;
+	val |= CPG_SD_STP_MASK | (clock->div_table[0].val & CPG_SD_FC_MASK);
+	writel(val, clock->csn.reg);
 
 	clock->div_max = clock->div_table[0].div;
 	clock->div_min = clock->div_max;
-- 
2.7.4
