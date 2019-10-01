From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:20 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 21/32] drm: rcar-du: Fix the return
	value in case of error in 'rcar_du_crtc_set_crc_source()'
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-22-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 4d486f18d91b1876040bf87e9ad78981a08b15a6 upstream.

We return 0 unconditionally in 'rcar_du_crtc_set_crc_source()'.
However, 'ret' is set to some error codes if some function calls fail.

Return 'ret' instead to propagate the error code.

Fixes: 47a52d024e89 ("media: drm: rcar-du: Add support for CRC computation")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 1ea4bc2..0cfb015 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -936,7 +936,7 @@ static int rcar_du_crtc_set_crc_source(struct drm_crtc *crtc,
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 
-	return 0;
+	return ret;
 }
 
 static const struct drm_crtc_funcs crtc_funcs_gen2 = {
-- 
2.7.4
