From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:01 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 14/57] clk: renesas: cpg-mssr: Use
	genpd of_node instead of local copy
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit f243220e674c61ae6434209e25c25c12cada4e4e upstream.

Since commit 6a0ae73d95956f7e ("PM / Domain: Add support to parse
domain's OPP table"), of_genpd_add_provider_simple() fills in
the dev.of_node field in the generic_pm_domain structure.

Hence cpg_mssr_is_pm_clk() can use that instead of its own copy in the
driver-private cpg_mssr_clk_domain structure.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 3a23456..3fe648a 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -411,7 +411,6 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 
 struct cpg_mssr_clk_domain {
 	struct generic_pm_domain genpd;
-	struct device_node *np;
 	unsigned int num_core_pm_clks;
 	unsigned int core_pm_clks[0];
 };
@@ -423,7 +422,7 @@ static bool cpg_mssr_is_pm_clk(const struct of_phandle_args *clkspec,
 {
 	unsigned int i;
 
-	if (clkspec->np != pd->np || clkspec->args_count != 2)
+	if (clkspec->np != pd->genpd.dev.of_node || clkspec->args_count != 2)
 		return false;
 
 	switch (clkspec->args[0]) {
@@ -513,7 +512,6 @@ static int __init cpg_mssr_add_clk_domain(struct device *dev,
 	if (!pd)
 		return -ENOMEM;
 
-	pd->np = np;
 	pd->num_core_pm_clks = num_core_pm_clks;
 	memcpy(pd->core_pm_clks, core_pm_clks, pm_size);
 
-- 
2.7.4
