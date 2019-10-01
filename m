From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:21 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 22/32] drm: rcar-du: Fix vblank
	initialization
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-23-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 3d61fe5f59dd3e6f96fc0772156d257cb04dc656 upstream.

The drm_vblank_init() takes the total number of CRTCs as an argument,
but the rcar-du driver passes a bitmask of the CRTC indices. Fix it.

Fixes: 4bf8e1962f91 ("drm: Renesas R-Car Display Unit DRM driver")
Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 3fd12ab..2c2d57c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -591,7 +591,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	 * Initialize vertical blanking interrupts handling. Start with vblank
 	 * disabled for all CRTCs.
 	 */
-	ret = drm_vblank_init(dev, (1 << rcdu->num_crtcs) - 1);
+	ret = drm_vblank_init(dev, rcdu->num_crtcs);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4
