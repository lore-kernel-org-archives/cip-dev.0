From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:50 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 05/23] clk: renesas: Remove usage of
	CLK_IS_BASIC
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Stephen Boyd <sboyd@kernel.org>

commit ddbae6658d4dc495ac62f7977062b33bb15d1af6 upstream.

This flag doesn't look to be used by any code, just set in various clk
init structures and then never tested again. Remove it from these
drivers as it doesn't provide any benefit.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: <linux-renesas-soc@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Removed changes to r9a06g032 device]
---
 drivers/clk/renesas/clk-div6.c         | 2 +-
 drivers/clk/renesas/clk-mstp.c         | 2 +-
 drivers/clk/renesas/rcar-gen3-cpg.c    | 2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/clk-div6.c b/drivers/clk/renesas/clk-div6.c
index 9febbf4..ba19be6 100644
--- a/drivers/clk/renesas/clk-div6.c
+++ b/drivers/clk/renesas/clk-div6.c
@@ -277,7 +277,7 @@ struct clk * __init cpg_div6_register(const char *name,
 	/* Register the clock. */
 	init.name = name;
 	init.ops = &cpg_div6_clock_ops;
-	init.flags = CLK_IS_BASIC;
+	init.flags = 0;
 	init.parent_names = parent_names;
 	init.num_parents = valid_parents;
 
diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index e82adcb..252ff32 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -161,7 +161,7 @@ static struct clk * __init cpg_mstp_clock_register(const char *name,
 
 	init.name = name;
 	init.ops = &cpg_mstp_clock_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	/* INTC-SYS is the module clock of the GIC, and must not be disabled */
 	if (!strcmp(name, "intc-sys")) {
 		pr_debug("MSTP %s setting CLK_IS_CRITICAL\n", name);
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 3ba5076..fa823a3 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -381,7 +381,7 @@ static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *core,
 
 	init.name = core->name;
 	init.ops = &cpg_sd_clock_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index b00a33f..3a23456 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -377,7 +377,7 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 
 	init.name = mod->name;
 	init.ops = &cpg_mstp_clock_ops;
-	init.flags = CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.flags = CLK_SET_RATE_PARENT;
 	for (i = 0; i < info->num_crit_mod_clks; i++)
 		if (id == info->crit_mod_clks[i]) {
 			dev_dbg(dev, "MSTP %s setting CLK_IS_CRITICAL\n",
-- 
2.7.4
