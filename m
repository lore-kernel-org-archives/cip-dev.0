From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:16 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 17/32] drm: rcar-du: lvds: Adjust
	operating frequency for D3 and E3
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-18-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 871370308675e477abd57a69ce66ca4730a4249c upstream.

The D3 and E3 SoCs have different pixel clock frequency limits for the
LVDS encoder than the other SoCs in the Gen3 family. Adjust the mode
fixup implementation accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 27a382f..3b5884a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -530,11 +530,16 @@ static bool rcar_lvds_mode_fixup(struct drm_bridge *bridge,
 				 const struct drm_display_mode *mode,
 				 struct drm_display_mode *adjusted_mode)
 {
+	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
+	int min_freq;
+
 	/*
 	 * The internal LVDS encoder has a restricted clock frequency operating
-	 * range (31MHz to 148.5MHz). Clamp the clock accordingly.
+	 * range, from 5MHz to 148.5MHz on D3 and E3, and from 31MHz to
+	 * 148.5MHz on all other platforms. Clamp the clock accordingly.
 	 */
-	adjusted_mode->clock = clamp(adjusted_mode->clock, 31000, 148500);
+	min_freq = lvds->info->quirks & RCAR_LVDS_QUIRK_EXT_PLL ? 5000 : 31000;
+	adjusted_mode->clock = clamp(adjusted_mode->clock, min_freq, 148500);
 
 	return true;
 }
-- 
2.7.4
