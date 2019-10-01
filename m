From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:15 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 16/32] drm: rcar-du: lvds: Fix post-DLL
	divider calculation
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-17-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 167e535438ecc73d299340bb1269616432020dfb upstream.

The PLL parameters are computed by looping over the range of acceptable
M, N and E values, and selecting the combination that produces the
output frequency closest to the target. The internal frequency
constraints are taken into account by restricting the tested values for
the PLL parameters, reducing the search space. The target frequency,
however, is only taken into account when computing the post-PLL divider,
which can result in a 0 value for the divider when the PLL output
frequency being tested is lower than half of the target frequency.
Subsequent loops will produce a better set of PLL parameters, but for
some of the iterations this can result in a division by 0.

Fix it by clamping the divider value. We could instead restrict the E
values being tested in the inner loop, but that would require additional
calculation that would likely be less efficient as the E parameter can
only take three different values.

Fixes: c25c01361199 ("drm: rcar-du: lvds: D3/E3 support")
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 7f82bde..27a382f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -282,7 +282,7 @@ static void rcar_lvds_d3_e3_pll_calc(struct rcar_lvds *lvds, struct clk *clk,
 				 * divider.
 				 */
 				fout = fvco / (1 << e) / div7;
-				div = DIV_ROUND_CLOSEST(fout, target);
+				div = max(1UL, DIV_ROUND_CLOSEST(fout, target));
 				diff = abs(fout / div - target);
 
 				if (diff < pll->diff) {
-- 
2.7.4
