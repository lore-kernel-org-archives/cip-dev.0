From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:02:46 +0100
Subject: [cip-dev] [PATCH 4.19.y 15/60] clk: renesas: cpg-mssr: Remove error
	messages on out-of-memory conditions
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit ed04e6288ac59a59a2e9265194a6be892f708c66 upstream.

pm_clk_create() and pm_clk_add_clk() can fail only when running out of
memory.  Hence there is no need to print error messages on failure, as
the memory allocation core already takes care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 3fe648a..d9541e1 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -473,16 +473,12 @@ int cpg_mssr_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 		return PTR_ERR(clk);
 
 	error = pm_clk_create(dev);
-	if (error) {
-		dev_err(dev, "pm_clk_create failed %d\n", error);
+	if (error)
 		goto fail_put;
-	}
 
 	error = pm_clk_add_clk(dev, clk);
-	if (error) {
-		dev_err(dev, "pm_clk_add_clk %pC failed %d\n", clk, error);
+	if (error)
 		goto fail_destroy;
-	}
 
 	return 0;
 
-- 
2.7.4
