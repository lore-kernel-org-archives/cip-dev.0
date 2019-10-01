From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:19 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 20/32] drm/rcar-du: Replace
	drm_dev_unref with drm_dev_put
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-21-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 06fa0d46b181e762f22d0742839200e7235d32ce upstream.

This patch unifies the naming of DRM functions for reference counting
of struct drm_device. The resulting code is more aligned with the rest
of the Linux kernel interfaces.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 708ebd9..94d0213 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -485,7 +485,7 @@ static int rcar_du_remove(struct platform_device *pdev)
 	drm_kms_helper_poll_fini(ddev);
 	drm_mode_config_cleanup(ddev);
 
-	drm_dev_unref(ddev);
+	drm_dev_put(ddev);
 
 	return 0;
 }
-- 
2.7.4
