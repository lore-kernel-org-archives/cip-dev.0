From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:26 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 27/32] drm: rcar-du: Replace
	EXT_CTRL_REGS feature flag with generation check
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-28-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit cef0d9cfe4e5b6c756c268c1b7dda7fa257336fc upstream.

The RCAR_DU_FEATURE_EXT_CTRL_REGS feature flag is missing for H1 only,
which is a first generation device, not a second generation device as
reported in the device information table. Fix the H1 generation and use
generation checks to replace the feature flag.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
[fab: backported to 4.19.y-cip]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c   | 12 +-----------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h   |  7 +++----
 drivers/gpu/drm/rcar-du/rcar_du_group.c |  4 ++--
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index a665679..d22b381 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -40,7 +40,6 @@
 static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
@@ -63,7 +62,6 @@ static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 static const struct rcar_du_device_info rzg1_du_r8a7745_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
@@ -138,7 +136,7 @@ static const struct rcar_du_device_info rcar_du_r8a774c0_info = {
 };
 
 static const struct rcar_du_device_info rcar_du_r8a7779_info = {
-	.gen = 2,
+	.gen = 1,
 	.features = RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
@@ -161,7 +159,6 @@ static const struct rcar_du_device_info rcar_du_r8a7779_info = {
 static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.quirks = RCAR_DU_QUIRK_ALIGN_128B,
@@ -191,7 +188,6 @@ static const struct rcar_du_device_info rcar_du_r8a7790_info = {
 static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
@@ -215,7 +211,6 @@ static const struct rcar_du_device_info rcar_du_r8a7791_info = {
 static const struct rcar_du_device_info rcar_du_r8a7792_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
@@ -235,7 +230,6 @@ static const struct rcar_du_device_info rcar_du_r8a7792_info = {
 static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 	.gen = 2,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
 	.channels_mask = BIT(1) | BIT(0),
@@ -258,7 +252,6 @@ static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
@@ -292,7 +285,6 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
@@ -322,7 +314,6 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
@@ -352,7 +343,6 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 static const struct rcar_du_device_info rcar_du_r8a77970_info = {
 	.gen = 3,
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
-		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE
 		  | RCAR_DU_FEATURE_INTERLACED
 		  | RCAR_DU_FEATURE_TVM_SYNC,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index eb05bbd..f16cd26 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -28,10 +28,9 @@ struct rcar_du_device;
 struct rcar_du_encoder;
 
 #define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	BIT(0)	/* Per-CRTC IRQ and clock */
-#define RCAR_DU_FEATURE_EXT_CTRL_REGS	BIT(1)	/* Has extended control registers */
-#define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(2)	/* Has inputs from VSP1 */
-#define RCAR_DU_FEATURE_INTERLACED	BIT(3)	/* HW supports interlaced */
-#define RCAR_DU_FEATURE_TVM_SYNC	BIT(4)	/* Has TV switch/sync modes */
+#define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(1)	/* Has inputs from VSP1 */
+#define RCAR_DU_FEATURE_INTERLACED	BIT(2)	/* HW supports interlaced */
+#define RCAR_DU_FEATURE_TVM_SYNC	BIT(3)	/* Has TV switch/sync modes */
 
 #define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)	/* Align pitches to 128 bytes */
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
index 7379899..3e87fbf 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
@@ -151,7 +151,7 @@ static void rcar_du_group_setup(struct rcar_du_group *rgrp)
 
 	rcar_du_group_setup_pins(rgrp);
 
-	if (rcar_du_has(rgrp->dev, RCAR_DU_FEATURE_EXT_CTRL_REGS)) {
+	if (rcdu->info->gen >= 2) {
 		rcar_du_group_setup_defr8(rgrp);
 		rcar_du_group_setup_didsr(rgrp);
 	}
@@ -251,7 +251,7 @@ int rcar_du_set_dpad0_vsp1_routing(struct rcar_du_device *rcdu)
 	unsigned int index;
 	int ret;
 
-	if (!rcar_du_has(rcdu, RCAR_DU_FEATURE_EXT_CTRL_REGS))
+	if (rcdu->info->gen < 2)
 		return 0;
 
 	/*
-- 
2.7.4
