Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10DEC27C79
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 10:13:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.8276.1718359994763562701
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 03:13:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="207938166"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jun 2024 19:13:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 571FA428BB21;
	Fri, 14 Jun 2024 19:13:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/14] drm/plane: add drmm_universal_plane_alloc()
Date: Fri, 14 Jun 2024 11:12:58 +0100
Message-Id: <20240614101308.40407-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 10:13:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16237

From: Philipp Zabel <p.zabel@pengutronix.de>

commit 0a1b813f06f1009d1d44d48888e92e3a59ea0be3 upstream.

Add an alternative to drm_universal_plane_init() that allocates
and initializes a plane and registers drm_plane_cleanup() with
drmm_add_action_or_reset().

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_plane.c | 134 ++++++++++++++++++++++++++++--------
 include/drm/drm_plane.h     |  42 +++++++++++
 2 files changed, 147 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 79249568bdec..27456ba2443c 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -30,6 +30,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_vblank.h>
 
 #include "drm_crtc_internal.h"
@@ -152,31 +153,16 @@ static int create_in_format_blob(struct drm_device *dev, struct drm_plane *plane
 	return 0;
 }
 
-/**
- * drm_universal_plane_init - Initialize a new universal plane object
- * @dev: DRM device
- * @plane: plane object to init
- * @possible_crtcs: bitmask of possible CRTCs
- * @funcs: callbacks for the new plane
- * @formats: array of supported formats (DRM_FORMAT\_\*)
- * @format_count: number of elements in @formats
- * @format_modifiers: array of struct drm_format modifiers terminated by
- *                    DRM_FORMAT_MOD_INVALID
- * @type: type of plane (overlay, primary, cursor)
- * @name: printf style format string for the plane name, or NULL for default name
- *
- * Initializes a plane object of type @type.
- *
- * Returns:
- * Zero on success, error code on failure.
- */
-int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
-			     uint32_t possible_crtcs,
-			     const struct drm_plane_funcs *funcs,
-			     const uint32_t *formats, unsigned int format_count,
-			     const uint64_t *format_modifiers,
-			     enum drm_plane_type type,
-			     const char *name, ...)
+__printf(9, 0)
+static int __drm_universal_plane_init(struct drm_device *dev,
+				      struct drm_plane *plane,
+				      uint32_t possible_crtcs,
+				      const struct drm_plane_funcs *funcs,
+				      const uint32_t *formats,
+				      unsigned int format_count,
+				      const uint64_t *format_modifiers,
+				      enum drm_plane_type type,
+				      const char *name, va_list ap)
 {
 	struct drm_mode_config *config = &dev->mode_config;
 	unsigned int format_modifier_count = 0;
@@ -237,11 +223,7 @@ int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
 	}
 
 	if (name) {
-		va_list ap;
-
-		va_start(ap, name);
 		plane->name = kvasprintf(GFP_KERNEL, name, ap);
-		va_end(ap);
 	} else {
 		plane->name = kasprintf(GFP_KERNEL, "plane-%d",
 					drm_num_planes(dev));
@@ -286,8 +268,102 @@ int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
 
 	return 0;
 }
+
+/**
+ * drm_universal_plane_init - Initialize a new universal plane object
+ * @dev: DRM device
+ * @plane: plane object to init
+ * @possible_crtcs: bitmask of possible CRTCs
+ * @funcs: callbacks for the new plane
+ * @formats: array of supported formats (DRM_FORMAT\_\*)
+ * @format_count: number of elements in @formats
+ * @format_modifiers: array of struct drm_format modifiers terminated by
+ *                    DRM_FORMAT_MOD_INVALID
+ * @type: type of plane (overlay, primary, cursor)
+ * @name: printf style format string for the plane name, or NULL for default name
+ *
+ * Initializes a plane object of type @type. The &drm_plane_funcs.destroy hook
+ * should call drm_plane_cleanup() and kfree() the plane structure. The plane
+ * structure should not be allocated with devm_kzalloc().
+ *
+ * Note: consider using drmm_universal_plane_alloc() instead of
+ * drm_universal_plane_init() to let the DRM managed resource infrastructure
+ * take care of cleanup and deallocation.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drm_universal_plane_init(struct drm_device *dev, struct drm_plane *plane,
+			     uint32_t possible_crtcs,
+			     const struct drm_plane_funcs *funcs,
+			     const uint32_t *formats, unsigned int format_count,
+			     const uint64_t *format_modifiers,
+			     enum drm_plane_type type,
+			     const char *name, ...)
+{
+	va_list ap;
+	int ret;
+
+	WARN_ON(!funcs->destroy);
+
+	va_start(ap, name);
+	ret = __drm_universal_plane_init(dev, plane, possible_crtcs, funcs,
+					 formats, format_count, format_modifiers,
+					 type, name, ap);
+	va_end(ap);
+	return ret;
+}
 EXPORT_SYMBOL(drm_universal_plane_init);
 
+static void drmm_universal_plane_alloc_release(struct drm_device *dev, void *ptr)
+{
+	struct drm_plane *plane = ptr;
+
+	if (WARN_ON(!plane->dev))
+		return;
+
+	drm_plane_cleanup(plane);
+}
+
+void *__drmm_universal_plane_alloc(struct drm_device *dev, size_t size,
+				   size_t offset, uint32_t possible_crtcs,
+				   const struct drm_plane_funcs *funcs,
+				   const uint32_t *formats, unsigned int format_count,
+				   const uint64_t *format_modifiers,
+				   enum drm_plane_type type,
+				   const char *name, ...)
+{
+	void *container;
+	struct drm_plane *plane;
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
+	plane = container + offset;
+
+	va_start(ap, name);
+	ret = __drm_universal_plane_init(dev, plane, possible_crtcs, funcs,
+					 formats, format_count, format_modifiers,
+					 type, name, ap);
+	va_end(ap);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drmm_add_action_or_reset(dev, drmm_universal_plane_alloc_release,
+				       plane);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return container;
+}
+EXPORT_SYMBOL(__drmm_universal_plane_alloc);
+
 int drm_plane_register_all(struct drm_device *dev)
 {
 	unsigned int num_planes = 0;
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 3f396d94afe4..82bd63710a39 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -746,6 +746,48 @@ int drm_plane_init(struct drm_device *dev,
 		   bool is_primary);
 void drm_plane_cleanup(struct drm_plane *plane);
 
+__printf(10, 11)
+void *__drmm_universal_plane_alloc(struct drm_device *dev,
+				   size_t size, size_t offset,
+				   uint32_t possible_crtcs,
+				   const struct drm_plane_funcs *funcs,
+				   const uint32_t *formats,
+				   unsigned int format_count,
+				   const uint64_t *format_modifiers,
+				   enum drm_plane_type plane_type,
+				   const char *name, ...);
+
+/**
+ * drmm_universal_plane_alloc - Allocate and initialize an universal plane object
+ * @dev: DRM device
+ * @type: the type of the struct which contains struct &drm_plane
+ * @member: the name of the &drm_plane within @type
+ * @possible_crtcs: bitmask of possible CRTCs
+ * @funcs: callbacks for the new plane
+ * @formats: array of supported formats (DRM_FORMAT\_\*)
+ * @format_count: number of elements in @formats
+ * @format_modifiers: array of struct drm_format modifiers terminated by
+ *                    DRM_FORMAT_MOD_INVALID
+ * @plane_type: type of plane (overlay, primary, cursor)
+ * @name: printf style format string for the plane name, or NULL for default name
+ *
+ * Allocates and initializes a plane object of type @type. Cleanup is
+ * automatically handled through registering drm_plane_cleanup() with
+ * drmm_add_action().
+ *
+ * The @drm_plane_funcs.destroy hook must be NULL.
+ *
+ * Returns:
+ * Pointer to new plane, or ERR_PTR on failure.
+ */
+#define drmm_universal_plane_alloc(dev, type, member, possible_crtcs, funcs, formats, \
+				   format_count, format_modifiers, plane_type, name, ...) \
+	((type *)__drmm_universal_plane_alloc(dev, sizeof(type), \
+					      offsetof(type, member), \
+					      possible_crtcs, funcs, formats, \
+					      format_count, format_modifiers, \
+					      plane_type, name, ##__VA_ARGS__))
+
 /**
  * drm_plane_index - find the index of a registered plane
  * @plane: plane to find index for
-- 
2.25.1


