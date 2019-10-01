From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:24 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 25/32] drm/rcar-du: Use
	drm_fbdev_generic_setup()
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-26-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Noralf Tr?nnes <noralf@tronnes.org>

commit 2f690fad237adea1bdce8ed9026cbf43cd9d8c46 upstream.

The CMA helper is already using the drm_fb_helper_generic_probe part of
the generic fbdev emulation. This patch makes full use of the generic
fbdev emulation by using its drm_client callbacks. This means that
drm_mode_config_funcs->output_poll_changed and drm_driver->lastclose are
now handled by the emulation code. Additionally fbdev unregister happens
automatically on drm_dev_unregister().

The drm_fbdev_generic_setup() call is put after drm_dev_register() in the
driver. This is done to highlight the fact that fbdev emulation is an
internal client that makes use of the driver, it is not part of the
driver as such. If fbdev setup fails, an error is printed, but the driver
succeeds probing.

drm_fbdev_generic_setup() handles mode_config.num_connector being zero.
In that case it retries fbdev setup on the next .output_poll_changed.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181128212713.43500-4-noralf at tronnes.org
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 14 +++-----------
 drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 -
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 21 ---------------------
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c |  1 -
 4 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 94d0213..a665679 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -25,6 +25,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 
 #include "rcar_du_drv.h"
@@ -394,19 +395,11 @@ MODULE_DEVICE_TABLE(of, rcar_du_of_table);
  * DRM operations
  */
 
-static void rcar_du_lastclose(struct drm_device *dev)
-{
-	struct rcar_du_device *rcdu = dev->dev_private;
-
-	drm_fbdev_cma_restore_mode(rcdu->fbdev);
-}
-
 DEFINE_DRM_GEM_CMA_FOPS(rcar_du_fops);
 
 static struct drm_driver rcar_du_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME
 				| DRIVER_ATOMIC,
-	.lastclose		= rcar_du_lastclose,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
 	.gem_vm_ops		= &drm_gem_cma_vm_ops,
 	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
@@ -479,9 +472,6 @@ static int rcar_du_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(ddev);
 
-	if (rcdu->fbdev)
-		drm_fbdev_cma_fini(rcdu->fbdev);
-
 	drm_kms_helper_poll_fini(ddev);
 	drm_mode_config_cleanup(ddev);
 
@@ -541,6 +531,8 @@ static int rcar_du_probe(struct platform_device *pdev)
 
 	DRM_INFO("Device %s probed\n", dev_name(&pdev->dev));
 
+	drm_fbdev_generic_setup(ddev, 32);
+
 	return 0;
 
 error:
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
index b8c4abd..eb05bbd 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
@@ -24,7 +24,6 @@
 struct clk;
 struct device;
 struct drm_device;
-struct drm_fbdev_cma;
 struct rcar_du_device;
 struct rcar_du_encoder;
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 2c2d57c..3257aca 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -284,13 +284,6 @@ rcar_du_fb_create(struct drm_device *dev, struct drm_file *file_priv,
 	return drm_gem_fb_create(dev, file_priv, mode_cmd);
 }
 
-static void rcar_du_output_poll_changed(struct drm_device *dev)
-{
-	struct rcar_du_device *rcdu = dev->dev_private;
-
-	drm_fbdev_cma_hotplug_event(rcdu->fbdev);
-}
-
 /* -----------------------------------------------------------------------------
  * Atomic Check and Update
  */
@@ -359,7 +352,6 @@ static const struct drm_mode_config_helper_funcs rcar_du_mode_config_helper = {
 
 static const struct drm_mode_config_funcs rcar_du_mode_config_funcs = {
 	.fb_create = rcar_du_fb_create,
-	.output_poll_changed = rcar_du_output_poll_changed,
 	.atomic_check = rcar_du_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
@@ -552,7 +544,6 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	struct drm_device *dev = rcdu->ddev;
 	struct drm_encoder *encoder;
-	struct drm_fbdev_cma *fbdev;
 	unsigned int dpad0_sources;
 	unsigned int num_encoders;
 	unsigned int num_groups;
@@ -691,17 +682,5 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 
 	drm_kms_helper_poll_init(dev);
 
-	if (dev->mode_config.num_connector) {
-		fbdev = drm_fbdev_cma_init(dev, 32,
-					   dev->mode_config.num_connector);
-		if (IS_ERR(fbdev))
-			return PTR_ERR(fbdev);
-
-		rcdu->fbdev = fbdev;
-	} else {
-		dev_info(rcdu->dev,
-			 "no connector found, disabling fbdev emulation\n");
-	}
-
 	return 0;
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index e325c965..173a47f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -129,7 +129,6 @@ static const u32 rcar_du_vsp_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_UYVY,
-	DRM_FORMAT_VYUY,
 	DRM_FORMAT_YUYV,
 	DRM_FORMAT_YVYU,
 	DRM_FORMAT_NV12,
-- 
2.7.4
