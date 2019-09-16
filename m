From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 16 Sep 2019 16:50:35 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 21/32] drm: rcar-du: Update framebuffer
	pitch and alignment limits for Gen3
In-Reply-To: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568649046-17420-22-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit f09e5b5d776debc2761e8d9330d60b8dcd8cb9dd upstream.

The framebuffer pitch and alignment constraints reflect the limitations
of the Gen2 DU hardware. On Gen3, the DU has no memory interface and
thus doesn't impose any constraint. The limitations come instead from
the VSP that has a limit of 65535 bytes for the pitch and no alignment
constraint. Update the checks accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index d2094ae..27783f6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -233,7 +233,6 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	const struct rcar_du_format_info *format;
 	unsigned int max_pitch;
 	unsigned int align;
-	unsigned int bpp;
 	unsigned int i;
 
 	format = rcar_du_format_info(mode_cmd->pixel_format);
@@ -243,20 +242,32 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 		return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * The pitch and alignment constraints are expressed in pixels on the
-	 * hardware side and in bytes in the DRM API.
-	 */
-	bpp = format->planes == 1 ? format->bpp / 8 : 1;
-	max_pitch =  4096 * bpp;
+	if (rcdu->info->gen < 3) {
+		/*
+		 * On Gen2 the DU limits the pitch to 4095 pixels and requires
+		 * buffers to be aligned to a 16 pixels boundary (or 128 bytes
+		 * on some platforms).
+		 */
+		unsigned int bpp = format->planes == 1 ? format->bpp / 8 : 1;
 
-	if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
-		align = 128;
-	else
-		align = 16 * bpp;
+		max_pitch = 4095 * bpp;
+
+		if (rcar_du_needs(rcdu, RCAR_DU_QUIRK_ALIGN_128B))
+			align = 128;
+		else
+			align = 16 * bpp;
+	} else {
+		/*
+		 * On Gen3 the memory interface is handled by the VSP that
+		 * limits the pitch to 65535 bytes and has no alignment
+		 * constraint.
+		 */
+		max_pitch = 65535;
+		align = 1;
+	}
 
 	if (mode_cmd->pitches[0] & (align - 1) ||
-	    mode_cmd->pitches[0] >= max_pitch) {
+	    mode_cmd->pitches[0] > max_pitch) {
 		dev_dbg(dev->dev, "invalid pitch value %u\n",
 			mode_cmd->pitches[0]);
 		return ERR_PTR(-EINVAL);
-- 
2.7.4
