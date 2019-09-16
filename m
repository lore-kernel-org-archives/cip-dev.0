From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 16 Sep 2019 16:50:32 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 18/32] drm: rcar-du: Rename and
	document dpll_ch field
In-Reply-To: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568649046-17420-19-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

commit 9fe50e64fac7a7301f82e31dbd87a4145384005e upstream.

Document and re-name the 'dpll_ch' field to a more precise 'dpll_mask' for
consistency with the 'channels_mask' field defined in 'struct
rcar_du_device_info'.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c  | 6 +++---
 drivers/gpu/drm/rcar-du/rcar_du_drv.h  | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 342519c..107cbf2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -210,7 +210,7 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 	u32 dsmr;
 	u32 escr;
 
-	if (rcdu->info->dpll_ch & (1 << rcrtc->index)) {
+	if (rcdu->info->dpll_mask & (1 << rcrtc->index)) {
 		unsigned long target = mode_clock;
 		struct dpll_info dpll = { 0 };
 		unsigned long extclk;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index ba360e4..5380f0e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -259,7 +259,7 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 		},
 	},
 	.num_lvds = 1,
-	.dpll_ch =  BIT(2) | BIT(1),
+	.dpll_mask =  BIT(2) | BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a7796_info = {
@@ -289,7 +289,7 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 		},
 	},
 	.num_lvds = 1,
-	.dpll_ch =  BIT(1),
+	.dpll_mask =  BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a77965_info = {
@@ -319,7 +319,7 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 		},
 	},
 	.num_lvds = 1,
-	.dpll_ch =  BIT(1),
+	.dpll_mask =  BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a77970_info = {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 970c077..a6e6316 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -57,6 +57,7 @@ struct rcar_du_output_routing {
  * @channels_mask: bit mask of available DU channels
  * @routes: array of CRTC to output routes, indexed by output (RCAR_DU_OUTPUT_*)
  * @num_lvds: number of internal LVDS encoders
+ * @dpll_mask: bit mask of DU channels equipped with a DPLL
  */
 struct rcar_du_device_info {
 	unsigned int gen;
@@ -65,7 +66,7 @@ struct rcar_du_device_info {
 	unsigned int channels_mask;
 	struct rcar_du_output_routing routes[RCAR_DU_OUTPUT_MAX];
 	unsigned int num_lvds;
-	unsigned int dpll_ch;
+	unsigned int dpll_mask;
 };
 
 #define RCAR_DU_MAX_CRTCS		4
-- 
2.7.4
