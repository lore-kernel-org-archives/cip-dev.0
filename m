From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:14 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 15/32] drm: rcar-du: Turn LVDS clock
	output on/off for DPAD0 output on D3/E3
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit a6cc417d3eee4ac37aa9547cf82d4ff155d1780c upstream.

On the D3 and E3 SoCs the LVDS PLL clock output provides the dot clock
to the DU channels, even when the LVDS outputs are not in use. Enable
and disable the LVDS clock output when enabling or disabling a CRTC
connected to the DPAD0 output.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    | 34 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.h     |  3 +++
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index d679818..7079d94 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -31,6 +31,7 @@
 #include "rcar_du_plane.h"
 #include "rcar_du_regs.h"
 #include "rcar_du_vsp.h"
+#include "rcar_lvds.h"
 
 static u32 rcar_du_crtc_read(struct rcar_du_crtc *rcrtc, u32 reg)
 {
@@ -643,8 +644,27 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 				       struct drm_crtc_state *old_state)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(crtc->state);
+	struct rcar_du_device *rcdu = rcrtc->group->dev;
 
 	rcar_du_crtc_get(rcrtc);
+
+	/*
+	 * On D3/E3 the dot clock is provided by the LVDS encoder attached to
+	 * the DU channel. We need to enable its clock output explicitly if
+	 * the LVDS output is disabled.
+	 */
+	if (rcdu->info->lvds_clk_mask & BIT(rcrtc->index) &&
+	    rstate->outputs == BIT(RCAR_DU_OUTPUT_DPAD0)) {
+		struct rcar_du_encoder *encoder =
+			rcdu->encoders[RCAR_DU_OUTPUT_LVDS0 + rcrtc->index];
+		const struct drm_display_mode *mode =
+			&crtc->state->adjusted_mode;
+
+		rcar_lvds_clk_enable(encoder->base.bridge,
+				     mode->clock * 1000);
+	}
+
 	rcar_du_crtc_start(rcrtc);
 }
 
@@ -652,10 +672,24 @@ static void rcar_du_crtc_atomic_disable(struct drm_crtc *crtc,
 					struct drm_crtc_state *old_state)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(old_state);
+	struct rcar_du_device *rcdu = rcrtc->group->dev;
 
 	rcar_du_crtc_stop(rcrtc);
 	rcar_du_crtc_put(rcrtc);
 
+	if (rcdu->info->lvds_clk_mask & BIT(rcrtc->index) &&
+	    rstate->outputs == BIT(RCAR_DU_OUTPUT_DPAD0)) {
+		struct rcar_du_encoder *encoder =
+			rcdu->encoders[RCAR_DU_OUTPUT_LVDS0 + rcrtc->index];
+
+		/*
+		 * Disable the LVDS clock output, see
+		 * rcar_du_crtc_atomic_enable().
+		 */
+		rcar_lvds_clk_disable(encoder->base.bridge);
+	}
+
 	spin_lock_irq(&crtc->dev->event_lock);
 	if (crtc->state->event) {
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index d9cf398..b8c4abd 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -26,6 +26,7 @@ struct device;
 struct drm_device;
 struct drm_fbdev_cma;
 struct rcar_du_device;
+struct rcar_du_encoder;
 
 #define RCAR_DU_FEATURE_CRTC_IRQ_CLOCK	BIT(0)	/* Per-CRTC IRQ and clock */
 #define RCAR_DU_FEATURE_EXT_CTRL_REGS	BIT(1)	/* Has extended control registers */
@@ -88,6 +89,8 @@ struct rcar_du_device {
 	struct rcar_du_crtc crtcs[RCAR_DU_MAX_CRTCS];
 	unsigned int num_crtcs;
 
+	struct rcar_du_encoder *encoders[RCAR_DU_OUTPUT_MAX];
+
 	struct rcar_du_group groups[RCAR_DU_MAX_GROUPS];
 	struct rcar_du_vsp vsps[RCAR_DU_MAX_VSPS];
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index dc2750e..5cca7f7 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -46,6 +46,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 	if (renc == NULL)
 		return -ENOMEM;
 
+	rcdu->encoders[output] = renc;
 	renc->output = output;
 	encoder = rcar_encoder_to_drm_encoder(renc);
 
-- 
2.7.4
