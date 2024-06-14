Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8CC27C75
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 10:13:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.8281.1718360006029977314
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 03:13:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="211895898"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jun 2024 19:13:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B22EF428BB21;
	Fri, 14 Jun 2024 19:13:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/14] drm/crtc: add drmm_crtc_alloc_with_planes()
Date: Fri, 14 Jun 2024 11:12:59 +0100
Message-Id: <20240614101308.40407-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 10:13:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16238

From: Philipp Zabel <p.zabel@pengutronix.de>

commit 9dbb70fd663770418daab07590f4f534eb7a4931 upstream.

Add an alternative to drm_crtc_init_with_planes() that allocates
and initializes a crtc and registers drm_crtc_cleanup() with
drmm_add_action_or_reset().

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_crtc.c | 125 ++++++++++++++++++++++++++++---------
 include/drm/drm_crtc.h     |  33 ++++++++++
 2 files changed, 130 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 4ed3fc28d4da..3d73f69ce044 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -38,6 +38,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_modeset_lock.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_auth.h>
@@ -231,30 +232,12 @@ struct dma_fence *drm_crtc_create_fence(struct drm_crtc *crtc)
  * 	Setting MODE_ID to 0 will release reserved resources for the CRTC.
  */
 
-/**
- * drm_crtc_init_with_planes - Initialise a new CRTC object with
- *    specified primary and cursor planes.
- * @dev: DRM device
- * @crtc: CRTC object to init
- * @primary: Primary plane for CRTC
- * @cursor: Cursor plane for CRTC
- * @funcs: callbacks for the new CRTC
- * @name: printf style format string for the CRTC name, or NULL for default name
- *
- * Inits a new object created as base part of a driver crtc object. Drivers
- * should use this function instead of drm_crtc_init(), which is only provided
- * for backwards compatibility with drivers which do not yet support universal
- * planes). For really simple hardware which has only 1 plane look at
- * drm_simple_display_pipe_init() instead.
- *
- * Returns:
- * Zero on success, error code on failure.
- */
-int drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *crtc,
-			      struct drm_plane *primary,
-			      struct drm_plane *cursor,
-			      const struct drm_crtc_funcs *funcs,
-			      const char *name, ...)
+__printf(6, 0)
+static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *crtc,
+				       struct drm_plane *primary,
+				       struct drm_plane *cursor,
+				       const struct drm_crtc_funcs *funcs,
+				       const char *name, va_list ap)
 {
 	struct drm_mode_config *config = &dev->mode_config;
 	int ret;
@@ -282,11 +265,7 @@ int drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *crtc,
 		return ret;
 
 	if (name) {
-		va_list ap;
-
-		va_start(ap, name);
 		crtc->name = kvasprintf(GFP_KERNEL, name, ap);
-		va_end(ap);
 	} else {
 		crtc->name = kasprintf(GFP_KERNEL, "crtc-%d",
 				       drm_num_crtcs(dev));
@@ -330,8 +309,98 @@ int drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *crtc,
 
 	return 0;
 }
+
+/**
+ * drm_crtc_init_with_planes - Initialise a new CRTC object with
+ *    specified primary and cursor planes.
+ * @dev: DRM device
+ * @crtc: CRTC object to init
+ * @primary: Primary plane for CRTC
+ * @cursor: Cursor plane for CRTC
+ * @funcs: callbacks for the new CRTC
+ * @name: printf style format string for the CRTC name, or NULL for default name
+ *
+ * Inits a new object created as base part of a driver crtc object. Drivers
+ * should use this function instead of drm_crtc_init(), which is only provided
+ * for backwards compatibility with drivers which do not yet support universal
+ * planes). For really simple hardware which has only 1 plane look at
+ * drm_simple_display_pipe_init() instead.
+ * The &drm_crtc_funcs.destroy hook should call drm_crtc_cleanup() and kfree()
+ * the crtc structure. The crtc structure should not be allocated with
+ * devm_kzalloc().
+ *
+ * Note: consider using drmm_crtc_alloc_with_planes() instead of
+ * drm_crtc_init_with_planes() to let the DRM managed resource infrastructure
+ * take care of cleanup and deallocation.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *crtc,
+			      struct drm_plane *primary,
+			      struct drm_plane *cursor,
+			      const struct drm_crtc_funcs *funcs,
+			      const char *name, ...)
+{
+	va_list ap;
+	int ret;
+
+	WARN_ON(!funcs->destroy);
+
+	va_start(ap, name);
+	ret = __drm_crtc_init_with_planes(dev, crtc, primary, cursor, funcs,
+					  name, ap);
+	va_end(ap);
+
+	return ret;
+}
 EXPORT_SYMBOL(drm_crtc_init_with_planes);
 
+static void drmm_crtc_alloc_with_planes_cleanup(struct drm_device *dev,
+						void *ptr)
+{
+	struct drm_crtc *crtc = ptr;
+
+	drm_crtc_cleanup(crtc);
+}
+
+void *__drmm_crtc_alloc_with_planes(struct drm_device *dev,
+				    size_t size, size_t offset,
+				    struct drm_plane *primary,
+				    struct drm_plane *cursor,
+				    const struct drm_crtc_funcs *funcs,
+				    const char *name, ...)
+{
+	void *container;
+	struct drm_crtc *crtc;
+	va_list ap;
+	int ret;
+
+	if (WARN_ON(!funcs || funcs->destroy))
+		return ERR_PTR(-EINVAL);
+
+	container = drmm_kzalloc(dev, size, GFP_KERNEL);
+	if (!container)
+		return ERR_PTR(-ENOMEM);
+
+	crtc = container + offset;
+
+	va_start(ap, name);
+	ret = __drm_crtc_init_with_planes(dev, crtc, primary, cursor, funcs,
+					  name, ap);
+	va_end(ap);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drmm_add_action_or_reset(dev, drmm_crtc_alloc_with_planes_cleanup,
+				       crtc);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return container;
+}
+EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
+
 /**
  * drm_crtc_cleanup - Clean up the core crtc usage
  * @crtc: CRTC to cleanup
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 59b51a09cae6..b71c0a3d4126 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -1210,6 +1210,39 @@ int drm_crtc_init_with_planes(struct drm_device *dev,
 			      const char *name, ...);
 void drm_crtc_cleanup(struct drm_crtc *crtc);
 
+__printf(7, 8)
+void *__drmm_crtc_alloc_with_planes(struct drm_device *dev,
+				    size_t size, size_t offset,
+				    struct drm_plane *primary,
+				    struct drm_plane *cursor,
+				    const struct drm_crtc_funcs *funcs,
+				    const char *name, ...);
+
+/**
+ * drm_crtc_alloc_with_planes - Allocate and initialize a new CRTC object with
+ *    specified primary and cursor planes.
+ * @dev: DRM device
+ * @type: the type of the struct which contains struct &drm_crtc
+ * @member: the name of the &drm_crtc within @type.
+ * @primary: Primary plane for CRTC
+ * @cursor: Cursor plane for CRTC
+ * @funcs: callbacks for the new CRTC
+ * @name: printf style format string for the CRTC name, or NULL for default name
+ *
+ * Allocates and initializes a new crtc object. Cleanup is automatically
+ * handled through registering drmm_crtc_cleanup() with drmm_add_action().
+ *
+ * The @drm_crtc_funcs.destroy hook must be NULL.
+ *
+ * Returns:
+ * Pointer to new crtc, or ERR_PTR on failure.
+ */
+#define drmm_crtc_alloc_with_planes(dev, type, member, primary, cursor, funcs, name, ...) \
+	((type *)__drmm_crtc_alloc_with_planes(dev, sizeof(type), \
+					       offsetof(type, member), \
+					       primary, cursor, funcs, \
+					       name, ##__VA_ARGS__))
+
 /**
  * drm_crtc_index - find the index of a registered CRTC
  * @crtc: CRTC to find index for
-- 
2.25.1


