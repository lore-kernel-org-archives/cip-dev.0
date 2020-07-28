Return-Path: <SRS0=CyBO=BH=lists.cip-project.org=bounce+64572+5039+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687DCC433F1
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7FA206D7
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="eP+niw5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7FA206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5039+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id pItsYY4521723xu4fnihqHap; Tue, 28 Jul 2020 04:52:29 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.9579.1595933019852967366
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:43 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53033321"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:43 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9A6E140062A4;
	Tue, 28 Jul 2020 19:43:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 5/9] drm: rcar-du: Support panels connected directly to the DPAD outputs
Date: Tue, 28 Jul 2020 11:43:26 +0100
Message-Id: <20200728104330.6182-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 60RyFiIsHQcxg0A16anMyUQex4520388AA=
Content-Type: multipart/mixed; boundary="FS44PXj89Tnua5w3Of8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937149;
 bh=X29Yz2NYEndHDo2enDgZqmkX9vhWLoAjesPxKb2aaOE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eP+niw5Vt+Ljj/UQ8m39wHQfGzabLBqYtQGePszBWcr91X9ZkJpkMKNgXKe4ob2rT2N
 CC63detLOrlGXnYc1kPYfbQemSJTKawj9LkLrTABJGEj8Qu95bcyCHbQ3rgHf56uEVaYS
 bdiXa556TDRpc8i4HdCthj8e53M6PuBUUyg=

--FS44PXj89Tnua5w3Of8W

The DPAD outputs can be connected directly to a panel. To support this
use case, detect whether the entities connected to the DU DPAD outputs
are panels based on the number of ports of their DT node, and retrieve
the corresponding type of DRM objects.

This patch is based on the commit 73eb5476df72
("Support panels connected directly to the DPAD outputs") and
commit 56c5dd00f8db ("drm/rcar-du: Split LVDS encoder and connector")

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/Makefile          |   1 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c |  36 ++++++++
 drivers/gpu/drm/rcar-du/rcar_du_rgbcon.c  | 105 ++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_rgbcon.h  |  22 +++++
 4 files changed, 164 insertions(+)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_rgbcon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_rgbcon.h

diff --git a/drivers/gpu/drm/rcar-du/Makefile b/drivers/gpu/drm/rcar-du/Makefile
index 05de1c4097af..51b7ccc66cb7 100644
--- a/drivers/gpu/drm/rcar-du/Makefile
+++ b/drivers/gpu/drm/rcar-du/Makefile
@@ -4,6 +4,7 @@ rcar-du-drm-y := rcar_du_crtc.o \
 		 rcar_du_group.o \
 		 rcar_du_kms.o \
 		 rcar_du_lvdscon.o \
+		 rcar_du_rgbcon.o \
 		 rcar_du_plane.o \
 		 rcar_du_vgacon.o
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index d0ae1e8009c6..c407fd4c98ce 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -16,6 +16,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_panel.h>
 
 #include "rcar_du_drv.h"
 #include "rcar_du_encoder.h"
@@ -23,6 +24,7 @@
 #include "rcar_du_hdmienc.h"
 #include "rcar_du_kms.h"
 #include "rcar_du_lvdscon.h"
+#include "rcar_du_rgbcon.h"
 #include "rcar_du_lvdsenc.h"
 #include "rcar_du_vgacon.h"
 
@@ -42,6 +44,26 @@ rcar_du_connector_best_encoder(struct drm_connector *connector)
  * Encoder
  */
 
+static unsigned int rcar_du_encoder_count_ports(struct device_node *node)
+{
+	struct device_node *ports;
+	struct device_node *port;
+	unsigned int num_ports = 0;
+
+	ports = of_get_child_by_name(node, "ports");
+	if (!ports)
+		ports = of_node_get(node);
+
+	for_each_child_of_node(ports, port) {
+		if (of_node_name_eq(port, "port"))
+			num_ports++;
+	}
+
+	of_node_put(ports);
+
+	return num_ports;
+}
+
 static void rcar_du_encoder_disable(struct drm_encoder *encoder)
 {
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
@@ -127,6 +149,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 {
 	struct rcar_du_encoder *renc;
 	struct drm_encoder *encoder;
+	struct drm_panel *panel;
 	unsigned int encoder_type;
 	int ret;
 
@@ -193,6 +216,19 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 		ret = rcar_du_hdmi_connector_init(rcdu, renc);
 		break;
 
+	case DRM_MODE_ENCODER_NONE:
+		if ((output == RCAR_DU_OUTPUT_DPAD0 ||
+		     output == RCAR_DU_OUTPUT_DPAD1) &&
+		    rcar_du_encoder_count_ports(con_node) == 1) {
+			panel = of_drm_find_panel(con_node);
+			if (!panel)
+				ret = -EPROBE_DEFER;
+			else
+				ret = rcar_du_rgb_connector_init(rcdu, renc,
+								 panel);
+		}
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_rgbcon.c b/drivers/gpu/drm/rcar-du/rcar_du_rgbcon.c
new file mode 100644
index 000000000000..f62073e65f03
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_rgbcon.c
@@ -0,0 +1,105 @@
+/*
+ * rcar_du_rgbcon.c  --  R-Car Display Unit RGB Connector
+ *
+ * Copyright (C) 2013-2020 Renesas Electronics Corporation
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_panel.h>
+
+#include "rcar_du_drv.h"
+#include "rcar_du_encoder.h"
+#include "rcar_du_kms.h"
+#include "rcar_du_rgbcon.h"
+
+struct rcar_du_rgb_connector {
+	struct rcar_du_connector connector;
+	struct drm_panel *drmpanel;
+};
+
+#define to_rcar_rgb_connector(c) \
+	container_of(c, struct rcar_du_rgb_connector, connector.connector)
+
+static int rcar_du_rgb_connector_get_modes(struct drm_connector *connector)
+{
+	struct rcar_du_rgb_connector *rgbcon =
+		to_rcar_rgb_connector(connector);
+
+	return drm_panel_get_modes(rgbcon->drmpanel);
+}
+
+static const struct drm_connector_helper_funcs connector_helper_funcs = {
+	.get_modes = rcar_du_rgb_connector_get_modes,
+	.best_encoder = rcar_du_connector_best_encoder,
+};
+
+static enum drm_connector_status
+rcar_du_rgb_connector_detect(struct drm_connector *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static void rcar_du_rgb_connector_destroy(struct drm_connector *connector)
+{
+	struct rcar_du_rgb_connector *rgbcon =
+		to_rcar_rgb_connector(connector);
+
+	drm_panel_detach(rgbcon->drmpanel);
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs connector_funcs = {
+	.dpms = drm_atomic_helper_connector_dpms,
+	.reset = drm_atomic_helper_connector_reset,
+	.detect = rcar_du_rgb_connector_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = rcar_du_rgb_connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+int rcar_du_rgb_connector_init(struct rcar_du_device *rcdu,
+			       struct rcar_du_encoder *renc,
+			       struct drm_panel *drmpanel)
+{
+	struct drm_encoder *encoder = rcar_encoder_to_drm_encoder(renc);
+	struct rcar_du_rgb_connector *rgbcon;
+	struct drm_connector *connector;
+	int ret;
+
+	rgbcon = devm_kzalloc(rcdu->dev, sizeof(*rgbcon), GFP_KERNEL);
+	if (!rgbcon)
+		return -ENOMEM;
+
+	rgbcon->drmpanel = drmpanel;
+	connector = &rgbcon->connector.connector;
+	ret = drm_connector_init(rcdu->ddev, connector, &connector_funcs,
+				 DRM_MODE_CONNECTOR_DPI);
+	if (ret < 0)
+		return ret;
+
+	drm_connector_helper_add(connector, &connector_helper_funcs);
+
+	connector->dpms = DRM_MODE_DPMS_OFF;
+	drm_object_property_set_value(&connector->base,
+				      rcdu->ddev->mode_config.dpms_property,
+				      DRM_MODE_DPMS_OFF);
+
+	ret = drm_mode_connector_attach_encoder(connector, encoder);
+	if (ret < 0)
+		return ret;
+
+	drm_panel_attach(rgbcon->drmpanel, connector);
+	rgbcon->connector.encoder = renc;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_rgbcon.h b/drivers/gpu/drm/rcar-du/rcar_du_rgbcon.h
new file mode 100644
index 000000000000..b3bfad52f589
--- /dev/null
+++ b/drivers/gpu/drm/rcar-du/rcar_du_rgbcon.h
@@ -0,0 +1,22 @@
+/*
+ * rcar_du_rgbcon.h  --  R-Car Display Unit RGB Connector
+ *
+ * Copyright (C) 2013-2020 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __RCAR_DU_RGBCON_H__
+#define __RCAR_DU_RGBCON_H__
+
+struct rcar_du_device;
+struct rcar_du_encoder;
+
+int rcar_du_rgb_connector_init(struct rcar_du_device *rcdu,
+			       struct rcar_du_encoder *renc,
+			       struct drm_panel *drmpanel);
+
+#endif /* __RCAR_DU_RGBCON_H__ */
-- 
2.17.1


--FS44PXj89Tnua5w3Of8W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5039): https://lists.cip-project.org/g/cip-dev/message=
/5039
Mute This Topic: https://lists.cip-project.org/mt/75842044/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--FS44PXj89Tnua5w3Of8W--
