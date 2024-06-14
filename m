Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22754C27C79
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 10:13:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.8276.1718359994763562701
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jun 2024 03:13:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="207938150"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jun 2024 19:13:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.95])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DBEA6428BB21;
	Fri, 14 Jun 2024 19:13:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/14] drm: Place Renesas drivers in a separate dir
Date: Fri, 14 Jun 2024 11:12:55 +0100
Message-Id: <20240614101308.40407-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
References: <20240614101308.40407-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jun 2024 10:13:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16234

commit 11696c5e89245a1d360f75be3dfc4960b25a265a upstream.

Create vendor specific renesas directory and move renesas drivers
to that directory.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[ Biju: Dropped {rcar_mipi_dsi.c, rcar_mipi_dsi.h, rcar_mipi_dsi_regs.h}
        as support not available in 5.10
        Manually moved the 5.10 files rcar_du_of.{c,h} and
        rcar_du_of_lvds_r8a779{0,1,3,5,6}.dts to drivers/gpu/drm/renesas/
	directory ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/Kconfig                       |   4 +-
 drivers/gpu/drm/Makefile                      |   3 +-
 drivers/gpu/drm/renesas/Kconfig               |   4 +
 drivers/gpu/drm/renesas/Makefile              |   4 +
 drivers/gpu/drm/{ => renesas}/rcar-du/Kconfig |   0
 .../gpu/drm/{ => renesas}/rcar-du/Makefile    |   0
 .../gpu/drm/{ => renesas}/rcar-du/rcar_cmm.c  |   0
 .../gpu/drm/{ => renesas}/rcar-du/rcar_cmm.h  |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_crtc.c  |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_crtc.h  |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_drv.c   |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_drv.h   |   0
 .../{ => renesas}/rcar-du/rcar_du_encoder.c   |   0
 .../{ => renesas}/rcar-du/rcar_du_encoder.h   |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_group.c |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_group.h |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_kms.c   |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_kms.h   |   0
 drivers/gpu/drm/renesas/rcar-du/rcar_du_of.c  | 323 ++++++++++++++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_du_of.h  |  20 ++
 .../rcar-du/rcar_du_of_lvds_r8a7790.dts       |  69 ++++
 .../rcar-du/rcar_du_of_lvds_r8a7791.dts       |  43 +++
 .../rcar-du/rcar_du_of_lvds_r8a7793.dts       |  43 +++
 .../rcar-du/rcar_du_of_lvds_r8a7795.dts       |  43 +++
 .../rcar-du/rcar_du_of_lvds_r8a7796.dts       |  43 +++
 .../drm/{ => renesas}/rcar-du/rcar_du_plane.c |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_plane.h |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_regs.h  |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_vsp.c   |   0
 .../drm/{ => renesas}/rcar-du/rcar_du_vsp.h   |   0
 .../{ => renesas}/rcar-du/rcar_du_writeback.c |   0
 .../{ => renesas}/rcar-du/rcar_du_writeback.h |   0
 .../drm/{ => renesas}/rcar-du/rcar_dw_hdmi.c  |   0
 .../gpu/drm/{ => renesas}/rcar-du/rcar_lvds.c |   0
 .../gpu/drm/{ => renesas}/rcar-du/rcar_lvds.h |   0
 .../{ => renesas}/rcar-du/rcar_lvds_regs.h    |   0
 .../{ => renesas}/rcar-du/rzg2l_mipi_dsi.c    |   0
 .../rcar-du/rzg2l_mipi_dsi_regs.h             |   0
 .../gpu/drm/{ => renesas}/shmobile/Kconfig    |   0
 .../gpu/drm/{ => renesas}/shmobile/Makefile   |   0
 .../shmobile/shmob_drm_backlight.c            |   0
 .../shmobile/shmob_drm_backlight.h            |   0
 .../{ => renesas}/shmobile/shmob_drm_crtc.c   |   0
 .../{ => renesas}/shmobile/shmob_drm_crtc.h   |   0
 .../{ => renesas}/shmobile/shmob_drm_drv.c    |   0
 .../{ => renesas}/shmobile/shmob_drm_drv.h    |   0
 .../{ => renesas}/shmobile/shmob_drm_kms.c    |   0
 .../{ => renesas}/shmobile/shmob_drm_kms.h    |   0
 .../{ => renesas}/shmobile/shmob_drm_plane.c  |   0
 .../{ => renesas}/shmobile/shmob_drm_plane.h  |   0
 .../{ => renesas}/shmobile/shmob_drm_regs.h   |   0
 52 files changed, 595 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/renesas/Kconfig
 create mode 100644 drivers/gpu/drm/renesas/Makefile
 rename drivers/gpu/drm/{ => renesas}/rcar-du/Kconfig (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/Makefile (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_cmm.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_cmm.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_crtc.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_crtc.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_drv.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_drv.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_encoder.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_encoder.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_group.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_group.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_kms.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_kms.h (100%)
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of.c
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of.h
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7790.dts
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7791.dts
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7793.dts
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7795.dts
 create mode 100644 drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7796.dts
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_plane.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_plane.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_regs.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_vsp.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_vsp.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_writeback.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_du_writeback.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_dw_hdmi.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_lvds.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_lvds.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rcar_lvds_regs.h (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rzg2l_mipi_dsi.c (100%)
 rename drivers/gpu/drm/{ => renesas}/rcar-du/rzg2l_mipi_dsi_regs.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/Kconfig (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/Makefile (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_backlight.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_backlight.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_crtc.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_crtc.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_drv.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_drv.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_kms.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_kms.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_plane.c (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_plane.h (100%)
 rename drivers/gpu/drm/{ => renesas}/shmobile/shmob_drm_regs.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f2e94c0ec19..ab7997f96fed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5893,6 +5893,7 @@ F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
 F:	Documentation/devicetree/bindings/display/renesas,du.txt
 F:	drivers/gpu/drm/rcar-du/
 F:	drivers/gpu/drm/shmobile/
+F:	drivers/gpu/drm/renesas/
 F:	include/linux/platform_data/shmob_drm.h
 
 DRM DRIVERS FOR ROCKCHIP
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 4e9b3a95fa7c..f9709a2dd1f0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -319,9 +319,7 @@ source "drivers/gpu/drm/armada/Kconfig"
 
 source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
 
-source "drivers/gpu/drm/rcar-du/Kconfig"
-
-source "drivers/gpu/drm/shmobile/Kconfig"
+source "drivers/gpu/drm/renesas/Kconfig"
 
 source "drivers/gpu/drm/sun4i/Kconfig"
 
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 81569009f884..cd8b2d372b5e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -88,8 +88,7 @@ obj-$(CONFIG_DRM_UDL) += udl/
 obj-$(CONFIG_DRM_AST) += ast/
 obj-$(CONFIG_DRM_ARMADA) += armada/
 obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
-obj-y			+= rcar-du/
-obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
+obj-y			+= renesas/
 obj-y			+= omapdrm/
 obj-$(CONFIG_DRM_SUN4I) += sun4i/
 obj-y			+= tilcdc/
diff --git a/drivers/gpu/drm/renesas/Kconfig b/drivers/gpu/drm/renesas/Kconfig
new file mode 100644
index 000000000000..3777dad17f81
--- /dev/null
+++ b/drivers/gpu/drm/renesas/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+source "drivers/gpu/drm/renesas/rcar-du/Kconfig"
+source "drivers/gpu/drm/renesas/shmobile/Kconfig"
diff --git a/drivers/gpu/drm/renesas/Makefile b/drivers/gpu/drm/renesas/Makefile
new file mode 100644
index 000000000000..ec0e89e7a592
--- /dev/null
+++ b/drivers/gpu/drm/renesas/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += rcar-du/
+obj-$(CONFIG_DRM_SHMOBILE) += shmobile/
diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
similarity index 100%
rename from drivers/gpu/drm/rcar-du/Kconfig
rename to drivers/gpu/drm/renesas/rcar-du/Kconfig
diff --git a/drivers/gpu/drm/rcar-du/Makefile b/drivers/gpu/drm/renesas/rcar-du/Makefile
similarity index 100%
rename from drivers/gpu/drm/rcar-du/Makefile
rename to drivers/gpu/drm/renesas/rcar-du/Makefile
diff --git a/drivers/gpu/drm/rcar-du/rcar_cmm.c b/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_cmm.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_cmm.h b/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_cmm.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_cmm.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_crtc.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_crtc.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_drv.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_drv.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_encoder.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_encoder.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_group.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_group.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_group.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_kms.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_kms.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.h
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_of.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of.c
new file mode 100644
index 000000000000..afef69669bb4
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rcar_du_of.c - Legacy DT bindings compatibility
+ *
+ * Copyright (C) 2018 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ *
+ * Based on work from Jyri Sarha <jsarha@ti.com>
+ * Copyright (C) 2015 Texas Instruments
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/of_graph.h>
+#include <linux/slab.h>
+
+#include "rcar_du_crtc.h"
+#include "rcar_du_drv.h"
+#include "rcar_du_of.h"
+
+/* -----------------------------------------------------------------------------
+ * Generic Overlay Handling
+ */
+
+struct rcar_du_of_overlay {
+	const char *compatible;
+	void *begin;
+	void *end;
+};
+
+#define RCAR_DU_OF_DTB(type, soc)					\
+	extern char __dtb_rcar_du_of_##type##_##soc##_begin[];		\
+	extern char __dtb_rcar_du_of_##type##_##soc##_end[]
+
+#define RCAR_DU_OF_OVERLAY(type, soc)					\
+	{								\
+		.compatible = "renesas,du-" #soc,			\
+		.begin = __dtb_rcar_du_of_##type##_##soc##_begin,	\
+		.end = __dtb_rcar_du_of_##type##_##soc##_end,		\
+	}
+
+static int __init rcar_du_of_apply_overlay(const struct rcar_du_of_overlay *dtbs,
+					   const char *compatible)
+{
+	const struct rcar_du_of_overlay *dtb = NULL;
+	unsigned int i;
+	int ovcs_id;
+
+	for (i = 0; dtbs[i].compatible; ++i) {
+		if (!strcmp(dtbs[i].compatible, compatible)) {
+			dtb = &dtbs[i];
+			break;
+		}
+	}
+
+	if (!dtb)
+		return -ENODEV;
+
+	ovcs_id = 0;
+	return of_overlay_fdt_apply(dtb->begin, dtb->end - dtb->begin,
+				    &ovcs_id);
+}
+
+static int __init rcar_du_of_add_property(struct of_changeset *ocs,
+					  struct device_node *np,
+					  const char *name, const void *value,
+					  int length)
+{
+	struct property *prop;
+	int ret = -ENOMEM;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	prop->name = kstrdup(name, GFP_KERNEL);
+	if (!prop->name)
+		goto out_err;
+
+	prop->value = kmemdup(value, length, GFP_KERNEL);
+	if (!prop->value)
+		goto out_err;
+
+	of_property_set_flag(prop, OF_DYNAMIC);
+
+	prop->length = length;
+
+	ret = of_changeset_add_property(ocs, np, prop);
+	if (!ret)
+		return 0;
+
+out_err:
+	kfree(prop->value);
+	kfree(prop->name);
+	kfree(prop);
+	return ret;
+}
+
+/* -----------------------------------------------------------------------------
+ * LVDS Overlays
+ */
+
+RCAR_DU_OF_DTB(lvds, r8a7790);
+RCAR_DU_OF_DTB(lvds, r8a7791);
+RCAR_DU_OF_DTB(lvds, r8a7793);
+RCAR_DU_OF_DTB(lvds, r8a7795);
+RCAR_DU_OF_DTB(lvds, r8a7796);
+
+static const struct rcar_du_of_overlay rcar_du_lvds_overlays[] __initconst = {
+	RCAR_DU_OF_OVERLAY(lvds, r8a7790),
+	RCAR_DU_OF_OVERLAY(lvds, r8a7791),
+	RCAR_DU_OF_OVERLAY(lvds, r8a7793),
+	RCAR_DU_OF_OVERLAY(lvds, r8a7795),
+	RCAR_DU_OF_OVERLAY(lvds, r8a7796),
+	{ /* Sentinel */ },
+};
+
+static struct of_changeset rcar_du_lvds_changeset;
+
+static void __init rcar_du_of_lvds_patch_one(struct device_node *lvds,
+					     const struct of_phandle_args *clk,
+					     struct device_node *local,
+					     struct device_node *remote)
+{
+	unsigned int psize;
+	unsigned int i;
+	__be32 value[4];
+	int ret;
+
+	/*
+	 * Set the LVDS clocks property. This can't be performed by the overlay
+	 * as the structure of the clock specifier has changed over time, and we
+	 * don't know at compile time which binding version the system we will
+	 * run on uses.
+	 */
+	if (clk->args_count >= ARRAY_SIZE(value) - 1)
+		return;
+
+	of_changeset_init(&rcar_du_lvds_changeset);
+
+	value[0] = cpu_to_be32(clk->np->phandle);
+	for (i = 0; i < clk->args_count; ++i)
+		value[i + 1] = cpu_to_be32(clk->args[i]);
+
+	psize = (clk->args_count + 1) * 4;
+	ret = rcar_du_of_add_property(&rcar_du_lvds_changeset, lvds,
+				      "clocks", value, psize);
+	if (ret < 0)
+		goto done;
+
+	/*
+	 * Insert the node in the OF graph: patch the LVDS ports remote-endpoint
+	 * properties to point to the endpoints of the sibling nodes in the
+	 * graph. This can't be performed by the overlay: on the input side the
+	 * overlay would contain a phandle for the DU LVDS output port that
+	 * would clash with the system DT, and on the output side the connection
+	 * is board-specific.
+	 */
+	value[0] = cpu_to_be32(local->phandle);
+	value[1] = cpu_to_be32(remote->phandle);
+
+	for (i = 0; i < 2; ++i) {
+		struct device_node *endpoint;
+
+		endpoint = of_graph_get_endpoint_by_regs(lvds, i, 0);
+		if (!endpoint) {
+			ret = -EINVAL;
+			goto done;
+		}
+
+		ret = rcar_du_of_add_property(&rcar_du_lvds_changeset,
+					      endpoint, "remote-endpoint",
+					      &value[i], sizeof(value[i]));
+		of_node_put(endpoint);
+		if (ret < 0)
+			goto done;
+	}
+
+	ret = of_changeset_apply(&rcar_du_lvds_changeset);
+
+done:
+	if (ret < 0)
+		of_changeset_destroy(&rcar_du_lvds_changeset);
+}
+
+struct lvds_of_data {
+	struct resource res;
+	struct of_phandle_args clkspec;
+	struct device_node *local;
+	struct device_node *remote;
+};
+
+static void __init rcar_du_of_lvds_patch(const struct of_device_id *of_ids)
+{
+	const struct rcar_du_device_info *info;
+	const struct of_device_id *match;
+	struct lvds_of_data lvds_data[2] = { };
+	struct device_node *lvds_node;
+	struct device_node *soc_node;
+	struct device_node *du_node;
+	char compatible[22];
+	const char *soc_name;
+	unsigned int i;
+	int ret;
+
+	/* Get the DU node and exit if not present or disabled. */
+	du_node = of_find_matching_node_and_match(NULL, of_ids, &match);
+	if (!du_node || !of_device_is_available(du_node)) {
+		of_node_put(du_node);
+		return;
+	}
+
+	info = match->data;
+	soc_node = of_get_parent(du_node);
+
+	if (WARN_ON(info->num_lvds > ARRAY_SIZE(lvds_data)))
+		goto done;
+
+	/*
+	 * Skip if the LVDS nodes already exists.
+	 *
+	 * The nodes are searched based on the compatible string, which we
+	 * construct from the SoC name found in the DU compatible string. As a
+	 * match has been found we know the compatible string matches the
+	 * expected format and can thus skip some of the string manipulation
+	 * normal safety checks.
+	 */
+	soc_name = strchr(match->compatible, '-') + 1;
+	sprintf(compatible, "renesas,%s-lvds", soc_name);
+	lvds_node = of_find_compatible_node(NULL, NULL, compatible);
+	if (lvds_node) {
+		of_node_put(lvds_node);
+		return;
+	}
+
+	/*
+	 * Parse the DU node and store the register specifier, the clock
+	 * specifier and the local and remote endpoint of the LVDS link for
+	 * later use.
+	 */
+	for (i = 0; i < info->num_lvds; ++i) {
+		struct lvds_of_data *lvds = &lvds_data[i];
+		unsigned int port;
+		char name[7];
+		int index;
+
+		sprintf(name, "lvds.%u", i);
+		index = of_property_match_string(du_node, "clock-names", name);
+		if (index < 0)
+			continue;
+
+		ret = of_parse_phandle_with_args(du_node, "clocks",
+						 "#clock-cells", index,
+						 &lvds->clkspec);
+		if (ret < 0)
+			continue;
+
+		port = info->routes[RCAR_DU_OUTPUT_LVDS0 + i].port;
+
+		lvds->local = of_graph_get_endpoint_by_regs(du_node, port, 0);
+		if (!lvds->local)
+			continue;
+
+		lvds->remote = of_graph_get_remote_endpoint(lvds->local);
+		if (!lvds->remote)
+			continue;
+
+		index = of_property_match_string(du_node, "reg-names", name);
+		if (index < 0)
+			continue;
+
+		of_address_to_resource(du_node, index, &lvds->res);
+	}
+
+	/* Parse and apply the overlay. This will resolve phandles. */
+	ret = rcar_du_of_apply_overlay(rcar_du_lvds_overlays,
+				       match->compatible);
+	if (ret < 0)
+		goto done;
+
+	/* Patch the newly created LVDS encoder nodes. */
+	for_each_child_of_node(soc_node, lvds_node) {
+		struct resource res;
+
+		if (!of_device_is_compatible(lvds_node, compatible))
+			continue;
+
+		/* Locate the lvds_data entry based on the resource start. */
+		ret = of_address_to_resource(lvds_node, 0, &res);
+		if (ret < 0)
+			continue;
+
+		for (i = 0; i < ARRAY_SIZE(lvds_data); ++i) {
+			if (lvds_data[i].res.start == res.start)
+				break;
+		}
+
+		if (i == ARRAY_SIZE(lvds_data))
+			continue;
+
+		/* Patch the LVDS encoder. */
+		rcar_du_of_lvds_patch_one(lvds_node, &lvds_data[i].clkspec,
+					  lvds_data[i].local,
+					  lvds_data[i].remote);
+	}
+
+done:
+	for (i = 0; i < info->num_lvds; ++i) {
+		of_node_put(lvds_data[i].clkspec.np);
+		of_node_put(lvds_data[i].local);
+		of_node_put(lvds_data[i].remote);
+	}
+
+	of_node_put(soc_node);
+	of_node_put(du_node);
+}
+
+void __init rcar_du_of_init(const struct of_device_id *of_ids)
+{
+	rcar_du_of_lvds_patch(of_ids);
+}
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_of.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of.h
new file mode 100644
index 000000000000..8dd3fbe96650
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * rcar_du_of.h - Legacy DT bindings compatibility
+ *
+ * Copyright (C) 2018 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+#ifndef __RCAR_DU_OF_H__
+#define __RCAR_DU_OF_H__
+
+#include <linux/init.h>
+
+struct of_device_id;
+
+#if IS_ENABLED(CONFIG_DRM_RCAR_LVDS)
+void __init rcar_du_of_init(const struct of_device_id *of_ids);
+#else
+static inline void rcar_du_of_init(const struct of_device_id *of_ids) { }
+#endif /* CONFIG_DRM_RCAR_LVDS */
+
+#endif /* __RCAR_DU_OF_H__ */
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7790.dts b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7790.dts
new file mode 100644
index 000000000000..8bee4e787a0a
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7790.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rcar_du_of_lvds_r8a7790.dts - Legacy LVDS DT bindings conversion for R8A7790
+ *
+ * Copyright (C) 2018 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	lvds@feb90000 {
+		compatible = "renesas,r8a7790-lvds";
+		reg = <0 0xfeb90000 0 0x1c>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				lvds0_input: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				lvds0_out: endpoint {
+				};
+			};
+		};
+	};
+
+	lvds@feb94000 {
+		compatible = "renesas,r8a7790-lvds";
+		reg = <0 0xfeb94000 0 0x1c>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				lvds1_input: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				lvds1_out: endpoint {
+				};
+			};
+		};
+	};
+};
+
+&{/display@feb00000/ports} {
+	port@1 {
+		endpoint {
+			remote-endpoint = <&lvds0_input>;
+		};
+	};
+	port@2 {
+		endpoint {
+			remote-endpoint = <&lvds1_input>;
+		};
+	};
+};
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7791.dts b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7791.dts
new file mode 100644
index 000000000000..92c0509971ec
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7791.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rcar_du_of_lvds_r8a7791.dts - Legacy LVDS DT bindings conversion for R8A7791
+ *
+ * Copyright (C) 2018 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	lvds@feb90000 {
+		compatible = "renesas,r8a7791-lvds";
+		reg = <0 0xfeb90000 0 0x1c>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				lvds0_input: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				lvds0_out: endpoint {
+				};
+			};
+		};
+	};
+};
+
+&{/display@feb00000/ports} {
+	port@1 {
+		endpoint {
+			remote-endpoint = <&lvds0_input>;
+		};
+	};
+};
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7793.dts b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7793.dts
new file mode 100644
index 000000000000..c8b93f21de0f
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7793.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rcar_du_of_lvds_r8a7793.dts - Legacy LVDS DT bindings conversion for R8A7793
+ *
+ * Copyright (C) 2018 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	lvds@feb90000 {
+		compatible = "renesas,r8a7793-lvds";
+		reg = <0 0xfeb90000 0 0x1c>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				lvds0_input: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				lvds0_out: endpoint {
+				};
+			};
+		};
+	};
+};
+
+&{/display@feb00000/ports} {
+	port@1 {
+		endpoint {
+			remote-endpoint = <&lvds0_input>;
+		};
+	};
+};
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7795.dts b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7795.dts
new file mode 100644
index 000000000000..16c2d03cb016
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7795.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rcar_du_of_lvds_r8a7795.dts - Legacy LVDS DT bindings conversion for R8A7795
+ *
+ * Copyright (C) 2018 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/soc} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	lvds@feb90000 {
+		compatible = "renesas,r8a7795-lvds";
+		reg = <0 0xfeb90000 0 0x14>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				lvds0_input: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				lvds0_out: endpoint {
+				};
+			};
+		};
+	};
+};
+
+&{/soc/display@feb00000/ports} {
+	port@3 {
+		endpoint {
+			remote-endpoint = <&lvds0_input>;
+		};
+	};
+};
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7796.dts b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7796.dts
new file mode 100644
index 000000000000..680e923ac036
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_of_lvds_r8a7796.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rcar_du_of_lvds_r8a7796.dts - Legacy LVDS DT bindings conversion for R8A7796
+ *
+ * Copyright (C) 2018 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/soc} {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	lvds@feb90000 {
+		compatible = "renesas,r8a7796-lvds";
+		reg = <0 0xfeb90000 0 0x14>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				lvds0_input: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				lvds0_out: endpoint {
+				};
+			};
+		};
+	};
+};
+
+&{/soc/display@feb00000/ports} {
+	port@3 {
+		endpoint {
+			remote-endpoint = <&lvds0_input>;
+		};
+	};
+};
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_plane.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_plane.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_plane.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_regs.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_regs.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_regs.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_vsp.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_vsp.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_writeback.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_writeback.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_du_writeback.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_lvds.c
rename to drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.h b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_lvds.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_lvds.h
diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds_regs.h b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds_regs.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rcar_lvds_regs.h
rename to drivers/gpu/drm/renesas/rcar-du/rcar_lvds_regs.h
diff --git a/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c
rename to drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c
diff --git a/drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi_regs.h b/drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi_regs.h
similarity index 100%
rename from drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi_regs.h
rename to drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi_regs.h
diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/renesas/shmobile/Kconfig
similarity index 100%
rename from drivers/gpu/drm/shmobile/Kconfig
rename to drivers/gpu/drm/renesas/shmobile/Kconfig
diff --git a/drivers/gpu/drm/shmobile/Makefile b/drivers/gpu/drm/renesas/shmobile/Makefile
similarity index 100%
rename from drivers/gpu/drm/shmobile/Makefile
rename to drivers/gpu/drm/renesas/shmobile/Makefile
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.c
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_backlight.c
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.c
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_backlight.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.h
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_backlight.h
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_backlight.h
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_crtc.c
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_crtc.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_crtc.h
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.h
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_drv.c
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_drv.h
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.h
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_kms.c
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.c
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_kms.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.h
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_kms.h
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_kms.h
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_plane.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_plane.c
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_plane.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.h
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_plane.h
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.h
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_regs.h b/drivers/gpu/drm/renesas/shmobile/shmob_drm_regs.h
similarity index 100%
rename from drivers/gpu/drm/shmobile/shmob_drm_regs.h
rename to drivers/gpu/drm/renesas/shmobile/shmob_drm_regs.h
-- 
2.25.1


