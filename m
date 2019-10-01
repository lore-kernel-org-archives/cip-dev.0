From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:22 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 23/32] drm: rcar-du: Fix external clock
	error checks
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-24-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 63a298f22a6183b5b7536a203596c6570dfcfe8e upstream.

The rcar-du driver supports probe deferral for external clocks, but
implements it badly by checking the wrong pointer due to a bad copy and
paste. Fix it.

While at it, reject invalid clocks outright for DU channels that have a
display PLL, as the external clock is mandatory in that case. This
avoids a WARN_ON() at runtime.

Fixes: 1b30dbde8596 ("drm: rcar-du: Add support for external pixel clock")
Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 0cfb015..3763f8c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -232,9 +232,6 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 		 * system clock, and have no internal clock divider.
 		 */
 
-		if (WARN_ON(!rcrtc->extclock))
-			return;
-
 		/*
 		 * The H3 ES1.x exhibits dot clock duty cycle stability issues.
 		 * We can work around them by configuring the DPLL to twice the
@@ -1045,9 +1042,16 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int swindex,
 	clk = devm_clk_get(rcdu->dev, clk_name);
 	if (!IS_ERR(clk)) {
 		rcrtc->extclock = clk;
-	} else if (PTR_ERR(rcrtc->clock) == -EPROBE_DEFER) {
-		dev_info(rcdu->dev, "can't get external clock %u\n", hwindex);
+	} else if (PTR_ERR(clk) == -EPROBE_DEFER) {
 		return -EPROBE_DEFER;
+	} else if (rcdu->info->dpll_mask & BIT(hwindex)) {
+		/*
+		 * DU channels that have a display PLL can't use the internal
+		 * system clock and thus require an external clock.
+		 */
+		ret = PTR_ERR(clk);
+		dev_err(rcdu->dev, "can't get dclkin.%u: %d\n", hwindex, ret);
+		return ret;
 	}
 
 	init_waitqueue_head(&rcrtc->flip_wait);
-- 
2.7.4
