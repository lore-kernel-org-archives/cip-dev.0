Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D75C46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 14:25:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.85072.1701959152047851596
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 06:25:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185673043"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 23:25:53 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 143184004BC9;
	Thu,  7 Dec 2023 23:25:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 22/25] drm: [HACK DO NOT APPLY] add drmm_encoder_alloc()
Date: Thu,  7 Dec 2023 14:24:59 +0000
Message-Id: <20231207142502.401651-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
References: <20231207142502.401651-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 14:25:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13895

From: Philipp Zabel <p.zabel@pengutronix.de>

commit ca5092d04d86986c03b6e0042e2f1cd119c50f5d upstream.

Add an alternative to drm_encoder_init() that allocates and initializes
an encoder and registers drm_encoder_cleanup() with
drmm_add_action_or_reset().

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_encoder.c | 109 +++++++++++++++++++++++++++-------
 include/drm/drm_encoder.h     |  30 ++++++++++
 2 files changed, 116 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index e555281f43d4..24ac9a2350ea 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -26,6 +26,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_managed.h>
 
 #include "drm_crtc_internal.h"
 
@@ -91,25 +92,11 @@ void drm_encoder_unregister_all(struct drm_device *dev)
 	}
 }
 
-/**
- * drm_encoder_init - Init a preallocated encoder
- * @dev: drm device
- * @encoder: the encoder to init
- * @funcs: callbacks for this encoder
- * @encoder_type: user visible type of the encoder
- * @name: printf style format string for the encoder name, or NULL for default name
- *
- * Initialises a preallocated encoder. Encoder should be subclassed as part of
- * driver encoder objects. At driver unload time drm_encoder_cleanup() should be
- * called from the driver's &drm_encoder_funcs.destroy hook.
- *
- * Returns:
- * Zero on success, error code on failure.
- */
-int drm_encoder_init(struct drm_device *dev,
-		     struct drm_encoder *encoder,
-		     const struct drm_encoder_funcs *funcs,
-		     int encoder_type, const char *name, ...)
+__printf(5, 0)
+static int __drm_encoder_init(struct drm_device *dev,
+			      struct drm_encoder *encoder,
+			      const struct drm_encoder_funcs *funcs,
+			      int encoder_type, const char *name, va_list ap)
 {
 	int ret;
 
@@ -125,11 +112,7 @@ int drm_encoder_init(struct drm_device *dev,
 	encoder->encoder_type = encoder_type;
 	encoder->funcs = funcs;
 	if (name) {
-		va_list ap;
-
-		va_start(ap, name);
 		encoder->name = kvasprintf(GFP_KERNEL, name, ap);
-		va_end(ap);
 	} else {
 		encoder->name = kasprintf(GFP_KERNEL, "%s-%d",
 					  drm_encoder_enum_list[encoder_type].name,
@@ -150,6 +133,44 @@ int drm_encoder_init(struct drm_device *dev,
 
 	return ret;
 }
+
+/**
+ * drm_encoder_init - Init a preallocated encoder
+ * @dev: drm device
+ * @encoder: the encoder to init
+ * @funcs: callbacks for this encoder
+ * @encoder_type: user visible type of the encoder
+ * @name: printf style format string for the encoder name, or NULL for default name
+ *
+ * Initializes a preallocated encoder. Encoder should be subclassed as part of
+ * driver encoder objects. At driver unload time the driver's
+ * &drm_encoder_funcs.destroy hook should call drm_encoder_cleanup() and kfree()
+ * the encoder structure. The encoder structure should not be allocated with
+ * devm_kzalloc().
+ *
+ * Note: consider using drmm_encoder_alloc() instead of drm_encoder_init() to
+ * let the DRM managed resource infrastructure take care of cleanup and
+ * deallocation.
+ *
+ * Returns:
+ * Zero on success, error code on failure.
+ */
+int drm_encoder_init(struct drm_device *dev,
+		     struct drm_encoder *encoder,
+		     const struct drm_encoder_funcs *funcs,
+		     int encoder_type, const char *name, ...)
+{
+	va_list ap;
+	int ret;
+
+	WARN_ON(!funcs->destroy);
+
+	va_start(ap, name);
+	ret = __drm_encoder_init(dev, encoder, funcs, encoder_type, name, ap);
+	va_end(ap);
+
+	return ret;
+}
 EXPORT_SYMBOL(drm_encoder_init);
 
 /**
@@ -181,6 +202,48 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
 }
 EXPORT_SYMBOL(drm_encoder_cleanup);
 
+static void drmm_encoder_alloc_release(struct drm_device *dev, void *ptr)
+{
+	struct drm_encoder *encoder = ptr;
+
+	if (WARN_ON(!encoder->dev))
+		return;
+
+	drm_encoder_cleanup(encoder);
+}
+
+void *__drmm_encoder_alloc(struct drm_device *dev, size_t size, size_t offset,
+			   const struct drm_encoder_funcs *funcs,
+			   int encoder_type, const char *name, ...)
+{
+	void *container;
+	struct drm_encoder *encoder;
+	va_list ap;
+	int ret;
+
+	if (WARN_ON(funcs && funcs->destroy))
+		return ERR_PTR(-EINVAL);
+
+	container = drmm_kzalloc(dev, size, GFP_KERNEL);
+	if (!container)
+		return ERR_PTR(-EINVAL);
+
+	encoder = container + offset;
+
+	va_start(ap, name);
+	ret = __drm_encoder_init(dev, encoder, funcs, encoder_type, name, ap);
+	va_end(ap);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = drmm_add_action_or_reset(dev, drmm_encoder_alloc_release, encoder);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return container;
+}
+EXPORT_SYMBOL(__drmm_encoder_alloc);
+
 static struct drm_crtc *drm_encoder_get_crtc(struct drm_encoder *encoder)
 {
 	struct drm_connector *connector;
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index a60f5f1555ac..8e1316caba28 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -195,6 +195,36 @@ int drm_encoder_init(struct drm_device *dev,
 		     const struct drm_encoder_funcs *funcs,
 		     int encoder_type, const char *name, ...);
 
+__printf(6, 7)
+void *__drmm_encoder_alloc(struct drm_device *dev,
+			   size_t size, size_t offset,
+			   const struct drm_encoder_funcs *funcs,
+			   int encoder_type,
+			   const char *name, ...);
+
+/**
+ * drmm_encoder_alloc - Allocate and initialize an encoder
+ * @dev: drm device
+ * @type: the type of the struct which contains struct &drm_encoder
+ * @member: the name of the &drm_encoder within @type
+ * @funcs: callbacks for this encoder (optional)
+ * @encoder_type: user visible type of the encoder
+ * @name: printf style format string for the encoder name, or NULL for default name
+ *
+ * Allocates and initializes an encoder. Encoder should be subclassed as part of
+ * driver encoder objects. Cleanup is automatically handled through registering
+ * drm_encoder_cleanup() with drmm_add_action().
+ *
+ * The @drm_encoder_funcs.destroy hook must be NULL.
+ *
+ * Returns:
+ * Pointer to new encoder, or ERR_PTR on failure.
+ */
+#define drmm_encoder_alloc(dev, type, member, funcs, encoder_type, name, ...) \
+	((type *)__drmm_encoder_alloc(dev, sizeof(type), \
+				      offsetof(type, member), funcs, \
+				      encoder_type, name, ##__VA_ARGS__))
+
 /**
  * drm_encoder_index - find the index of a registered encoder
  * @encoder: encoder to find index for
-- 
2.25.1


