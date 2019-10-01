From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:23 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 24/32] drm: rcar-du: Reject modes that
	fail CRTC timing requirements
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-25-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 256856efb8cc2b5468c69edf45eb0ab579833ce7 upstream.

The hardware requires the HDSR and VDSR registers to be set to 1 or
higher. This translates to a minimum combined horizontal sync and back
porch of 20 pixels and a minimum vertical back porch of 3 lines. Reject
modes that fail those requirements.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 3763f8c..cec4b5c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -771,10 +771,22 @@ enum drm_mode_status rcar_du_crtc_mode_valid(struct drm_crtc *crtc,
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 	struct rcar_du_device *rcdu = rcrtc->group->dev;
 	bool interlaced = mode->flags & DRM_MODE_FLAG_INTERLACE;
+	unsigned int vbp;
 
 	if (interlaced && !rcar_du_has(rcdu, RCAR_DU_FEATURE_INTERLACED))
 		return MODE_NO_INTERLACE;
 
+	/*
+	 * The hardware requires a minimum combined horizontal sync and back
+	 * porch of 20 pixels and a minimum vertical back porch of 3 lines.
+	 */
+	if (mode->htotal - mode->hsync_start < 20)
+		return MODE_HBLANK_NARROW;
+
+	vbp = (mode->vtotal - mode->vsync_end) / (interlaced ? 2 : 1);
+	if (vbp < 3)
+		return MODE_VBLANK_NARROW;
+
 	return MODE_OK;
 }
 
-- 
2.7.4
