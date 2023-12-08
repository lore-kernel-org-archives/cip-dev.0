Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0FFC10DC1
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:23 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34953.1702041612066062593
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="189673946"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Dec 2023 22:20:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 661FA40116D2;
	Fri,  8 Dec 2023 22:20:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 02/25] drm/bridge: Add stubs for devm_drm_of_get_bridge when OF is disabled
Date: Fri,  8 Dec 2023 13:19:44 +0000
Message-Id: <20231208132007.108762-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:20:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13945

From: Maxime Ripard <maxime@cerno.tech>

commit 59050d783848d9b62e9d8fb6ce0cd00771c2bf87 upstream.

If CONFIG_OF is disabled, devm_drm_of_get_bridge won't be compiled in
and drivers using that function will fail to build.

Add an inline stub so that we can still build-test those cases.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Link: https://patchwork.freedesktop.org/patch/msgid/20210928181333.1176840-1-maxime@cerno.tech
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Fix the build issue with x86 by gaurding
   devm_drm_of_get_bridge() under CONFIG_OF and CONFIG_DRM_PANEL_BRIDGE.
---
 include/drm/drm_bridge.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 3c640e704186..6bfc13b69475 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -891,9 +891,20 @@ struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
 struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 						   struct drm_panel *panel,
 						   u32 connector_type);
+struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);
+#endif
+
+#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
 struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
 					  u32 port, u32 endpoint);
-struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);
+#else
+static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
+							struct device_node *node,
+							u32 port,
+							u32 endpoint)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 #endif
-- 
2.25.1


