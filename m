From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:07:43 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 15/32] drm: rcar-du: Don't use TV
	sync mode when not supported by the hardware
In-Reply-To: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568725680-32730-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit ffd15c3e7898cfb6d2a986b2aa8014ad7dc9e333 upstream.

The official way to stop the display is to clear the display enable
(DEN) bit in the DSYSR register, but that operates at a group level and
affects the two channels in the group. To disable channels selectively,
the driver uses TV sync mode that stops display operation on the channel
and turns output signals into inputs.

While TV sync mode is available in all DU models currently supported,
the D3 and E3 DUs don't support it. We will thus need to find an
alternative way to turn channels off.

In the meantime, condition the switch to TV sync mode to the
availability of the feature, to avoid writing an invalid value to the
DSYSR register. When the feature is unavailable the display output will
turn blank as all planes are disabled when stopping the CRTC.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c |  7 ++++++-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c  | 33 ++++++++++++++++++++++-----------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h  |  1 +
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index f2f6322..9e5d00a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -592,8 +592,13 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 	/*
 	 * Select switch sync mode. This stops display operation and configures
 	 * the HSYNC and VSYNC signals as inputs.
+	 *
+	 * TODO: Find another way to stop the display for DUs that don't support
+	 * TVM sync.
 	 */
-	rcar_du_crtc_dsysr_clr_set(rcrtc, DSYSR_TVM_MASK, DSYSR_TVM_SWITCH);
+	if (rcar_du_has(rcrtc->group->dev, RCAR_DU_FEATURE_TVM_SYNC))
+		rcar_du_crtc_dsysr_clr_set(rcrtc, DSYSR_TVM_MASK,
+					   DSYSR_TVM_SWITCH);
 
 	rcar_du_group_start_stop(rcrtc->group, false);
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 3f0cbc4..ba360e4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -40,7 +40,8 @@ static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -62,7 +63,8 @@ static const struct rcar_du_device_info rzg1_du_r8a7745_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -110,7 +112,8 @@ static const struct rcar_du_device_info rcar_du_r8a774a1_info = {
 
 static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 	.gen = 2,
-	.features = RCAR_DU_FEATURE_INTERLACED,
+	.features = RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -132,7 +135,8 @@ static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.quirks = RCAR_DU_QUIRK_ALIGN_128B,
 	.channels_mask = BIT(2) | BIT(1) | BIT(0),
 	.routes = {
@@ -161,7 +165,8 @@ static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -184,7 +189,8 @@ static const struct rcar_du_device_info rcar_du_r8a7792_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/* R8A7792 has two RGB outputs. */
@@ -203,7 +209,8 @@ static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -226,7 +233,8 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -259,7 +267,8 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(2) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -288,7 +297,8 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(3) | BIT(1) | BIT(0),
 	.routes = {
 		/*
@@ -317,7 +327,8 @@ static const struct rcar_du_device_info rcar_du_r8a77970_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
-		  | RCAR_DU_FEATURE_INTERLACED,
+		  | RCAR_DU_FEATURE_INTERLACED
+		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(0),
 	.routes = {
 		/* R8A77970 has one RGB output and one LVDS output. */
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index c4a6613..970c077 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -31,6 +31,7 @@ struct rcar_du_device;
 #define RCAR_DU_FEATURE_EXT_CTRL_REGS	BIT(1)	/* Has extended control registers */
 #define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(2)	/* Has inputs from VSP1 */
 #define RCAR_DU_FEATURE_INTERLACED	BIT(3)	/* HW supports interlaced */
+#define RCAR_DU_FEATURE_TVM_SYNC	BIT(4)	/* Has TV switch/sync modes */
 
 #define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)	/* Align pitches to 128 bytes */
 
-- 
2.7.4
