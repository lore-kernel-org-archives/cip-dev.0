Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F9EC27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 10:13:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.8281.1718360006029977314
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 03:13:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="211895901"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jun 2024 19:13:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 18CAC428BB26;
	Fri, 14 Jun 2024 19:13:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/14] drm/crtc: Introduce drmm_crtc_init_with_planes
Date: Fri, 14 Jun 2024 11:13:00 +0100
Message-Id: <20240614101308.40407-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 10:13:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16239

From: Maxime Ripard <maxime@cerno.tech>

commit 917dd05418148f05d8860b8106da8dcd1d258aaf upstream.

The DRM-managed function to register a CRTC is
drmm_crtc_alloc_with_planes(), which will allocate the underlying
structure and initialisation the CRTC.

However, we might want to separate the structure creation and the CRTC
initialisation, for example if the structure is shared across multiple
DRM entities, for example an encoder and a connector.

Let's create an helper to only initialise a CRTC that would be passed as
an argument.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20220711173939.1132294-3-maxime@cerno.tech
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_crtc.c | 97 +++++++++++++++++++++++++++++++++-----
 include/drm/drm_crtc.h     |  9 ++++
 2 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 3d73f69ce044..47d7fb514d01 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -329,9 +329,13 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
  * the crtc structure. The crtc structure should not be allocated with
  * devm_kzalloc().
  *
- * Note: consider using drmm_crtc_alloc_with_planes() instead of
- * drm_crtc_init_with_planes() to let the DRM managed resource infrastructure
- * take care of cleanup and deallocation.
+ * The @primary and @cursor planes are only relevant for legacy uAPI, see
+ * &drm_crtc.primary and &drm_crtc.cursor.
+ *
+ * Note: consider using drmm_crtc_alloc_with_planes() or
+ * drmm_crtc_init_with_planes() instead of drm_crtc_init_with_planes()
+ * to let the DRM managed resource infrastructure take care of cleanup
+ * and deallocation.
  *
  * Returns:
  * Zero on success, error code on failure.
@@ -356,14 +360,88 @@ int drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_crtc_init_with_planes);
 
-static void drmm_crtc_alloc_with_planes_cleanup(struct drm_device *dev,
-						void *ptr)
+static void drmm_crtc_init_with_planes_cleanup(struct drm_device *dev,
+					       void *ptr)
 {
 	struct drm_crtc *crtc = ptr;
 
 	drm_crtc_cleanup(crtc);
 }
 
+__printf(6, 0)
+static int __drmm_crtc_init_with_planes(struct drm_device *dev,
+					struct drm_crtc *crtc,
+					struct drm_plane *primary,
+					struct drm_plane *cursor,
+					const struct drm_crtc_funcs *funcs,
+					const char *name,
+					va_list args)
+{
+	int ret;
+
+	drm_WARN_ON(dev, funcs && funcs->destroy);
+
+	ret = __drm_crtc_init_with_planes(dev, crtc, primary, cursor, funcs,
+					  name, args);
+	if (ret)
+		return ret;
+
+	ret = drmm_add_action_or_reset(dev, drmm_crtc_init_with_planes_cleanup,
+				       crtc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * drmm_crtc_init_with_planes - Initialise a new CRTC object with
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
+ *
+ * Cleanup is automatically handled through registering
+ * drmm_crtc_cleanup() with drmm_add_action(). The crtc structure should
+ * be allocated with drmm_kzalloc().
+ *
+ * The @drm_crtc_funcs.destroy hook must be NULL.
+ *
+ * The @primary and @cursor planes are only relevant for legacy uAPI, see
+ * &drm_crtc.primary and &drm_crtc.cursor.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drmm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *crtc,
+			       struct drm_plane *primary,
+			       struct drm_plane *cursor,
+			       const struct drm_crtc_funcs *funcs,
+			       const char *name, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, name);
+	ret = __drmm_crtc_init_with_planes(dev, crtc, primary, cursor, funcs,
+					   name, ap);
+	va_end(ap);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(drmm_crtc_init_with_planes);
+
 void *__drmm_crtc_alloc_with_planes(struct drm_device *dev,
 				    size_t size, size_t offset,
 				    struct drm_plane *primary,
@@ -386,17 +464,12 @@ void *__drmm_crtc_alloc_with_planes(struct drm_device *dev,
 	crtc = container + offset;
 
 	va_start(ap, name);
-	ret = __drm_crtc_init_with_planes(dev, crtc, primary, cursor, funcs,
-					  name, ap);
+	ret = __drmm_crtc_init_with_planes(dev, crtc, primary, cursor, funcs,
+					   name, ap);
 	va_end(ap);
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = drmm_add_action_or_reset(dev, drmm_crtc_alloc_with_planes_cleanup,
-				       crtc);
-	if (ret)
-		return ERR_PTR(ret);
-
 	return container;
 }
 EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index b71c0a3d4126..15495cf67ac4 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -1208,6 +1208,15 @@ int drm_crtc_init_with_planes(struct drm_device *dev,
 			      struct drm_plane *cursor,
 			      const struct drm_crtc_funcs *funcs,
 			      const char *name, ...);
+
+__printf(6, 7)
+int drmm_crtc_init_with_planes(struct drm_device *dev,
+			       struct drm_crtc *crtc,
+			       struct drm_plane *primary,
+			       struct drm_plane *cursor,
+			       const struct drm_crtc_funcs *funcs,
+			       const char *name, ...);
+
 void drm_crtc_cleanup(struct drm_crtc *crtc);
 
 __printf(7, 8)
-- 
2.25.1


