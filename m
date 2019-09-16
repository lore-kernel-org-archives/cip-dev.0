From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 16 Sep 2019 16:50:27 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 13/32] drm: rcar-du: Add interlaced
	feature flag
In-Reply-To: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568649046-17420-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

commit c6e3194a3b55a9365e40c3a25f8e31afa154c26c upstream.

Upcoming implementations of the R-Car DU have removed support for
interlaced display pipelines. Provide a means to determine this based on
the feature flags of the hardware configuration structs.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 14 ++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c  | 32 +++++++++++++++++++++-----------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h  |  1 +
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 15dc9ca..4b43d83 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -684,11 +684,25 @@ static void rcar_du_crtc_atomic_flush(struct drm_crtc *crtc,
 		rcar_du_vsp_atomic_flush(rcrtc);
 }
 
+enum drm_mode_status rcar_du_crtc_mode_valid(struct drm_crtc *crtc,
+				   const struct drm_display_mode *mode)
+{
+	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+	struct rcar_du_device *rcdu = rcrtc->group->dev;
+	bool interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
+
+	if (interlaced && !rcar_du_has(rcdu, RCAR_DU_FEATURE_INTERLACED))
+		return MODE_NO_INTERLACE;
+
+	return MODE_OK;
+}
+
 static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.atomic_begin = rcar_du_crtc_atomic_begin,
 	.atomic_flush = rcar_du_crtc_atomic_flush,
 	.atomic_enable = rcar_du_crtc_atomic_enable,
 	.atomic_disable = rcar_du_crtc_atomic_disable,
+	.mode_valid = rcar_du_crtc_mode_valid,
 };
 
 static struct drm_crtc_state *
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index dfa09cf..3f0cbc4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -39,7 +39,8 @@
 static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -60,7 +61,8 @@ static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 static const struct rcar_du_device_info rzg1_du_r8a7745_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -108,7 +110,7 @@ static const struct rcar_du_device_info rcar_du_r8a774a1_info = {
 
 static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 	.gen = 2,
-	.features = 0,
+	.features = RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -129,7 +131,8 @@ static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.quirks = RCAR_DU_QUIRK_ALIGN_128B,
 	.channels_mask = BIT(2) | BIT(1) | BIT(0),
 	.routes = {
@@ -157,7 +160,8 @@ static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -179,7 +183,8 @@ static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 static const struct rcar_du_device_info rcar_du_r8a7792_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/* R8A7792 has two RGB outputs. */
@@ -197,7 +202,8 @@ static const struct rcar_du_device_info rcar_du_r8a7792_info = {
 static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -219,7 +225,8 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -251,7 +258,8 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -279,7 +287,8 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(3) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -307,7 +316,8 @@ static const struct rcar_du_device_info rcar_du_r8a77970_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_VSP1_SOURCE,
+		  | RCAR_DU_FEATURE_VSP1_SOURCE
+		  | RCAR_DU_FEATURE_INTERLACED,
 	.channels_mask = BIT(0),
 	.routes = {
 		/* R8A77970 has one RGB output and one LVDS output. */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index 78ea20a..c4a6613 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -30,6 +30,7 @@ struct rcar_du_device;
 #define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	BIT(0)	/* Per-CRTC IRQ and clock */
 #define RCAR_DU_FEATURE_EXT_CTRL_REGS	BIT(1)	/* Has extended control registers */
 #define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(2)	/* Has inputs from VSP1 */
+#define RCAR_DU_FEATURE_INTERLACED	BIT(3)	/* HW supports interlaced */
 
 #define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)	/* Align pitches to 128 bytes */
 
-- 
2.7.4
