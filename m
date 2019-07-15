From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:30:07 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 22/23] clk: renesas: rcar-gen3: Remove
	unused variable
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-23-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Stephen Boyd <sboyd@kernel.org>

commit c2f0705f85fdf35a5670df9926f060a37be77439 upstream.

This variable is no longer used and the compiler rightly complains that
it should be removed. Drop it to silence the following:

drivers/clk/renesas/rcar-gen3-cpg.c: In function 'cpg_sd_clk_register':
drivers/clk/renesas/rcar-gen3-cpg.c:386:15: warning: unused variable 'i' [-Wunused-variable]
  unsigned int i;

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: b953eaaeb58e ("clk: renesas: rcar-gen3: Fix cpg_sd_clock_round_rate() return value")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 477b670..0b96b4b 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -386,7 +386,6 @@ static struct clk * __init cpg_sd_clk_register(const char *name,
 	struct clk_init_data init;
 	struct sd_clock *clock;
 	struct clk *clk;
-	unsigned int i;
 	u32 val;
 
 	clock = kzalloc(sizeof(*clock), GFP_KERNEL);
-- 
2.7.4
