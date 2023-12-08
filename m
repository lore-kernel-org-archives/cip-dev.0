Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9E8C10DCE
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.35262.1702041614073951457
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:20:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="185800335"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Dec 2023 22:20:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BD486400297E;
	Fri,  8 Dec 2023 22:20:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 04/25] drm: of: Add drm_of_get_data_lanes_count and drm_of_get_data_lanes_ep
Date: Fri,  8 Dec 2023 13:19:46 +0000
Message-Id: <20231208132007.108762-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:20:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13947

From: Marek Vasut <marex@denx.de>

commit fc801750b197d0f00c09e01e59a7dcd240fddcb5 upstream.

Add helper function to count and sanitize DT "data-lanes" property
and return either error or the data-lanes count. This is useful for
both DSI and (e)DP "data-lanes" property. The later version of the
function is an extra wrapper which handles the endpoint look up by
regs, that's what majority of the drivers duplicate too, but not all
of them.

Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
To: dri-devel@lists.freedesktop.org
Link: https://patchwork.freedesktop.org/patch/msgid/20220524010522.528569-1-marex@denx.de
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_of.c | 61 ++++++++++++++++++++++++++++++++++++++++
 include/drm/drm_of.h     | 20 +++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 37c34146eea8..041af8d30857 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -402,3 +402,64 @@ int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
 		DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS;
 }
 EXPORT_SYMBOL_GPL(drm_of_lvds_get_dual_link_pixel_order);
+
+/**
+ * drm_of_get_data_lanes_count - Get DSI/(e)DP data lane count
+ * @endpoint: DT endpoint node of the DSI/(e)DP source or sink
+ * @min: minimum supported number of data lanes
+ * @max: maximum supported number of data lanes
+ *
+ * Count DT "data-lanes" property elements and check for validity.
+ *
+ * Return:
+ * * min..max - positive integer count of "data-lanes" elements
+ * * -ve - the "data-lanes" property is missing or invalid
+ * * -EINVAL - the "data-lanes" property is unsupported
+ */
+int drm_of_get_data_lanes_count(const struct device_node *endpoint,
+				const unsigned int min, const unsigned int max)
+{
+	int ret;
+
+	ret = of_property_count_u32_elems(endpoint, "data-lanes");
+	if (ret < 0)
+		return ret;
+
+	if (ret < min || ret > max)
+		return -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(drm_of_get_data_lanes_count);
+
+/**
+ * drm_of_get_data_lanes_count_ep - Get DSI/(e)DP data lane count by endpoint
+ * @port: DT port node of the DSI/(e)DP source or sink
+ * @port_reg: identifier (value of reg property) of the parent port node
+ * @reg: identifier (value of reg property) of the endpoint node
+ * @min: minimum supported number of data lanes
+ * @max: maximum supported number of data lanes
+ *
+ * Count DT "data-lanes" property elements and check for validity.
+ * This variant uses endpoint specifier.
+ *
+ * Return:
+ * * min..max - positive integer count of "data-lanes" elements
+ * * -EINVAL - the "data-mapping" property is unsupported
+ * * -ENODEV - the "data-mapping" property is missing
+ */
+int drm_of_get_data_lanes_count_ep(const struct device_node *port,
+				   int port_reg, int reg,
+				   const unsigned int min,
+				   const unsigned int max)
+{
+	struct device_node *endpoint;
+	int ret;
+
+	endpoint = of_graph_get_endpoint_by_regs(port, port_reg, reg);
+	ret = drm_of_get_data_lanes_count(endpoint, min, max);
+	of_node_put(endpoint);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(drm_of_get_data_lanes_count_ep);
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index b9b093add92e..5a6bf7146028 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -49,6 +49,12 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				struct drm_bridge **bridge);
 int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
 					  const struct device_node *port2);
+int drm_of_get_data_lanes_count(const struct device_node *endpoint,
+				const unsigned int min, const unsigned int max);
+int drm_of_get_data_lanes_count_ep(const struct device_node *port,
+				   int port_reg, int reg,
+				   const unsigned int min,
+				   const unsigned int max);
 #else
 static inline uint32_t drm_of_crtc_port_mask(struct drm_device *dev,
 					  struct device_node *port)
@@ -98,6 +104,20 @@ drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
 {
 	return -EINVAL;
 }
+
+int drm_of_get_data_lanes_count(const struct device_node *endpoint,
+				const unsigned int min, const unsigned int max)
+{
+	return -EINVAL;
+}
+
+int drm_of_get_data_lanes_count_ep(const struct device_node *port,
+				   int port_reg, int reg
+				   const unsigned int min,
+				   const unsigned int max)
+{
+	return -EINVAL;
+}
 #endif
 
 /*
-- 
2.25.1


