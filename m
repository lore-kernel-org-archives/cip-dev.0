Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9575BC46CA3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.35262.1702041614073951457
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:20:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="185800317"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Dec 2023 22:20:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3A7D640065A7;
	Fri,  8 Dec 2023 22:20:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 01/25] drm/bridge: Add a function to abstract away panels
Date: Fri,  8 Dec 2023 13:19:43 +0000
Message-Id: <20231208132007.108762-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:20:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13944

From: Maxime Ripard <maxime@cerno.tech>

commit 87ea95808d53e56b03e620e8f8f3add48899a88d upstream.

Display drivers so far need to have a lot of boilerplate to first
retrieve either the panel or bridge that they are connected to using
drm_of_find_panel_or_bridge(), and then either deal with each with ad-hoc
functions or create a drm panel bridge through drm_panel_bridge_add.

In order to reduce the boilerplate and hopefully create a path of least
resistance towards using the DRM panel bridge layer, let's create the
function devm_drm_of_get_bridge() to reduce that boilerplate.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20210910130941.1740182-2-maxime@cerno.tech
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_bridge.c | 42 ++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/drm_of.c     |  3 +++
 include/drm/drm_bridge.h     |  2 ++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d799ec14fd7f..f0f0a4efd200 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -28,6 +28,8 @@
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_of.h>
+#include <drm/drm_print.h>
 
 #include "drm_crtc_internal.h"
 
@@ -50,10 +52,8 @@
  *
  * Display drivers are responsible for linking encoders with the first bridge
  * in the chains. This is done by acquiring the appropriate bridge with
- * of_drm_find_bridge() or drm_of_find_panel_or_bridge(), or creating it for a
- * panel with drm_panel_bridge_add_typed() (or the managed version
- * devm_drm_panel_bridge_add_typed()). Once acquired, the bridge shall be
- * attached to the encoder with a call to drm_bridge_attach().
+ * devm_drm_of_get_bridge(). Once acquired, the bridge shall be attached to the
+ * encoder with a call to drm_bridge_attach().
  *
  * Bridges are responsible for linking themselves with the next bridge in the
  * chain, if any. This is done the same way as for encoders, with the call to
@@ -1223,6 +1223,40 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL(of_drm_find_bridge);
+
+/**
+ * devm_drm_of_get_bridge - Return next bridge in the chain
+ * @dev: device to tie the bridge lifetime to
+ * @np: device tree node containing encoder output ports
+ * @port: port in the device tree node
+ * @endpoint: endpoint in the device tree node
+ *
+ * Given a DT node's port and endpoint number, finds the connected node
+ * and returns the associated bridge if any, or creates and returns a
+ * drm panel bridge instance if a panel is connected.
+ *
+ * Returns a pointer to the bridge if successful, or an error pointer
+ * otherwise.
+ */
+struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
+					  struct device_node *np,
+					  u32 port, u32 endpoint)
+{
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
+	int ret;
+
+	ret = drm_of_find_panel_or_bridge(np, port, endpoint,
+					  &panel, &bridge);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (panel)
+		bridge = devm_drm_panel_bridge_add(dev, panel);
+
+	return bridge;
+}
+EXPORT_SYMBOL(devm_drm_of_get_bridge);
 #endif
 
 MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 997b8827fed2..37c34146eea8 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -231,6 +231,9 @@ EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
  * return either the associated struct drm_panel or drm_bridge device. Either
  * @panel or @bridge must not be NULL.
  *
+ * This function is deprecated and should not be used in new drivers. Use
+ * devm_drm_of_get_bridge() instead.
+ *
  * Returns zero if successful, or one of the standard error codes if it fails.
  */
 int drm_of_find_panel_or_bridge(const struct device_node *np,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 055486e35e68..3c640e704186 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -891,6 +891,8 @@ struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 						   struct drm_panel *panel,
 						   u32 connector_type);
+struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
+					  u32 port, u32 endpoint);
 struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);
 #endif
 
-- 
2.25.1


