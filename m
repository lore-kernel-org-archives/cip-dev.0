Return-Path: <SRS0=gV1T=BB=lists.cip-project.org=bounce+64572+4967+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF6C433E8
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91D0207E8
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EjK/l6yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91D0207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4967+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id km63YY4521723xJm39M3swAj; Wed, 22 Jul 2020 10:47:07 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.23134.1595435708098355441
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:13 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52620967"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:13 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AEE044006CC9;
	Thu, 23 Jul 2020 01:35:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 11/17] drm: of: Add drm_of_lvds_get_dual_link_pixel_order
Date: Wed, 22 Jul 2020 17:34:43 +0100
Message-Id: <20200722163449.3513-12-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mD9rDDfhBqJEWYxFYFcGZuTJx4520388AA=
Content-Type: multipart/mixed; boundary="BHzpst9MQ1YzRk5dasqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440027;
 bh=qnkQG5Oaa0ne4F+zxcWdqmi8zZCDFJ9eGbV3WKIuC98=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EjK/l6yvvdFnqhkj1tMhJ5i4xRIsPrrJTArTu30HN8R5ftjWi+wkrhJDu9QU+ZgPWEY
 eYryf48ppaJxt3L53FkX2uG1ZT+09BbNUcNmO/LEvjPvG6YCiN3pPTdxvVUaJo4Imt94V
 Ug+YWuTdhXRCJKTDg1VFSdK26Hh5VXSlRJo=

--BHzpst9MQ1YzRk5dasqJ

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 6529007522ded00b8912c079250620fa7a732166 upstream.

An LVDS dual-link connection is made of two links, with even
pixels transitting on one link, and odd pixels on the other
link. The device tree can be used to fully describe dual-link
LVDS connections between encoders and bridges/panels.
The sink of an LVDS dual-link connection is made of two ports,
the corresponding OF graph port nodes can be marked
with either dual-lvds-even-pixels or dual-lvds-odd-pixels,
and that fully describes an LVDS dual-link connection,
including pixel order.

drm_of_lvds_get_dual_link_pixel_order is a new helper
added by this patch, given the source port nodes it
returns DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS if the source
port nodes belong to an LVDS dual-link connection, with even
pixels expected to be generated from the first port, and odd
pixels expected to be generated from the second port.
If the new helper returns DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS,
odd pixels are expected to be generated from the first port,
and even pixels from the other port.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_of.c | 116 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_of.h     |  20 +++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 2763a5ec845b..4f0bc1363fbe 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -275,3 +275,119 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(drm_of_find_panel_or_bridge);
+
+enum drm_of_lvds_pixels {
+	DRM_OF_LVDS_EVEN = BIT(0),
+	DRM_OF_LVDS_ODD = BIT(1),
+};
+
+static int drm_of_lvds_get_port_pixels_type(struct device_node *port_node)
+{
+	bool even_pixels =
+		of_property_read_bool(port_node, "dual-lvds-even-pixels");
+	bool odd_pixels =
+		of_property_read_bool(port_node, "dual-lvds-odd-pixels");
+
+	return (even_pixels ? DRM_OF_LVDS_EVEN : 0) |
+	       (odd_pixels ? DRM_OF_LVDS_ODD : 0);
+}
+
+static int drm_of_lvds_get_remote_pixels_type(
+			const struct device_node *port_node)
+{
+	struct device_node *endpoint = NULL;
+	int pixels_type = -EPIPE;
+
+	for_each_child_of_node(port_node, endpoint) {
+		struct device_node *remote_port;
+		int current_pt;
+
+		if (!of_node_name_eq(endpoint, "endpoint"))
+			continue;
+
+		remote_port = of_graph_get_remote_port(endpoint);
+		if (!remote_port) {
+			of_node_put(remote_port);
+			return -EPIPE;
+		}
+
+		current_pt = drm_of_lvds_get_port_pixels_type(remote_port);
+		of_node_put(remote_port);
+		if (pixels_type < 0)
+			pixels_type = current_pt;
+
+		/*
+		 * Sanity check, ensure that all remote endpoints have the same
+		 * pixel type. We may lift this restriction later if we need to
+		 * support multiple sinks with different dual-link
+		 * configurations by passing the endpoints explicitly to
+		 * drm_of_lvds_get_dual_link_pixel_order().
+		 */
+		if (!current_pt || pixels_type != current_pt) {
+			of_node_put(remote_port);
+			return -EINVAL;
+		}
+	}
+
+	return pixels_type;
+}
+
+/**
+ * drm_of_lvds_get_dual_link_pixel_order - Get LVDS dual-link pixel order
+ * @port1: First DT port node of the Dual-link LVDS source
+ * @port2: Second DT port node of the Dual-link LVDS source
+ *
+ * An LVDS dual-link connection is made of two links, with even pixels
+ * transitting on one link, and odd pixels on the other link. This function
+ * returns, for two ports of an LVDS dual-link source, which port shall transmit
+ * the even and odd pixels, based on the requirements of the connected sink.
+ *
+ * The pixel order is determined from the dual-lvds-even-pixels and
+ * dual-lvds-odd-pixels properties in the sink's DT port nodes. If those
+ * properties are not present, or if their usage is not valid, this function
+ * returns -EINVAL.
+ *
+ * If either port is not connected, this function returns -EPIPE.
+ *
+ * @port1 and @port2 are typically DT sibling nodes, but may have different
+ * parents when, for instance, two separate LVDS encoders carry the even and odd
+ * pixels.
+ *
+ * Return:
+ * * DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS - @port1 carries even pixels and @port2
+ *   carries odd pixels
+ * * DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS - @port1 carries odd pixels and @port2
+ *   carries even pixels
+ * * -EINVAL - @port1 and @port2 are not connected to a dual-link LVDS sink, or
+ *   the sink configuration is invalid
+ * * -EPIPE - when @port1 or @port2 are not connected
+ */
+int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
+					  const struct device_node *port2)
+{
+	int remote_p1_pt, remote_p2_pt;
+
+	if (!port1 || !port2)
+		return -EINVAL;
+
+	remote_p1_pt = drm_of_lvds_get_remote_pixels_type(port1);
+	if (remote_p1_pt < 0)
+		return remote_p1_pt;
+
+	remote_p2_pt = drm_of_lvds_get_remote_pixels_type(port2);
+	if (remote_p2_pt < 0)
+		return remote_p2_pt;
+
+	/*
+	 * A valid dual-lVDS bus is found when one remote port is marked with
+	 * "dual-lvds-even-pixels", and the other remote port is marked with
+	 * "dual-lvds-odd-pixels", bail out if the markers are not right.
+	 */
+	if (remote_p1_pt + remote_p2_pt != DRM_OF_LVDS_EVEN + DRM_OF_LVDS_ODD)
+		return -EINVAL;
+
+	return remote_p1_pt == DRM_OF_LVDS_EVEN ?
+		DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS :
+		DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS;
+}
+EXPORT_SYMBOL_GPL(drm_of_lvds_get_dual_link_pixel_order);
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index ead34ab5ca4e..8ec7ca6d2369 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -16,6 +16,18 @@ struct drm_panel;
 struct drm_bridge;
 struct device_node;
 
+/**
+ * enum drm_lvds_dual_link_pixels - Pixel order of an LVDS dual-link connection
+ * @DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS: Even pixels are expected to be generated
+ *    from the first port, odd pixels from the second port
+ * @DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS: Odd pixels are expected to be generated
+ *    from the first port, even pixels from the second port
+ */
+enum drm_lvds_dual_link_pixels {
+	DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS = 0,
+	DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS = 1,
+};
+
 #ifdef CONFIG_OF
 uint32_t drm_of_crtc_port_mask(struct drm_device *dev,
 			    struct device_node *port);
@@ -35,6 +47,8 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				int port, int endpoint,
 				struct drm_panel **panel,
 				struct drm_bridge **bridge);
+int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
+					  const struct device_node *port2);
 #else
 static inline uint32_t drm_of_crtc_port_mask(struct drm_device *dev,
 					  struct device_node *port)
@@ -77,6 +91,12 @@ static inline int drm_of_find_panel_or_bridge(const struct device_node *np,
 {
 	return -EINVAL;
 }
+
+int drm_of_lvds_get_dual_link_pixel_order(const struct device_node *port1,
+					  const struct device_node *port2)
+{
+	return -EINVAL;
+}
 #endif
 
 /*
-- 
2.17.1


--BHzpst9MQ1YzRk5dasqJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4967): https://lists.cip-project.org/g/cip-dev/message=
/4967
Mute This Topic: https://lists.cip-project.org/mt/75730029/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--BHzpst9MQ1YzRk5dasqJ--
