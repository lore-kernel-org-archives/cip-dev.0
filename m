Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22058CF319E
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:07:53 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1145.1727888864956687856
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:07:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="220602780"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Oct 2024 02:07:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 387534007533;
	Thu,  3 Oct 2024 02:07:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/15] drm: renesas: Move RZ/G2L MIPI DSI driver to rz-du
Date: Wed,  2 Oct 2024 18:06:59 +0100
Message-ID: <20241002170712.655449-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16976

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1b5dfd1881dbe303536d4167500b94549ff2f6a7 upstream.

All the RZ/G2L DU specific components are located under the rz-du folder,
so it makes sense to move the RZ/G2L MIPI DSI driver there instead of
keeping it in the rcar-du folder. This change improves the organization
and modularity of the driver configuration by grouping related settings together.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625123244.200533-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rcar-du/Kconfig                   | 8 --------
 drivers/gpu/drm/renesas/rcar-du/Makefile                  | 2 --
 drivers/gpu/drm/renesas/rz-du/Kconfig                     | 8 ++++++++
 drivers/gpu/drm/renesas/rz-du/Makefile                    | 2 ++
 .../gpu/drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi.c   | 0
 .../drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi_regs.h  | 0
 6 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/gpu/drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi.c (100%)
 rename drivers/gpu/drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi_regs.h (100%)

diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
index 929930b4b516..3e588ddba245 100644
--- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
@@ -45,14 +45,6 @@ config DRM_RCAR_LVDS
 	select OF_FLATTREE
 	select OF_OVERLAY
 
-config DRM_RZG2L_MIPI_DSI
-	tristate "RZ/G2L MIPI DSI Encoder Support"
-	depends on DRM && DRM_BRIDGE && OF
-	depends on ARCH_RENESAS || COMPILE_TEST
-	select DRM_MIPI_DSI
-	help
-	  Enable support for the RZ/G2L Display Unit embedded MIPI DSI encoders.
-
 config DRM_RCAR_VSP
 	bool "R-Car DU VSP Compositor Support" if ARM
 	default y if ARM64
diff --git a/drivers/gpu/drm/renesas/rcar-du/Makefile b/drivers/gpu/drm/renesas/rcar-du/Makefile
index 377540b9353e..4d1187ccc3e5 100644
--- a/drivers/gpu/drm/renesas/rcar-du/Makefile
+++ b/drivers/gpu/drm/renesas/rcar-du/Makefile
@@ -26,5 +26,3 @@ DTC_FLAGS_rcar_du_of_lvds_r8a7791 += -Wno-graph_endpoint
 DTC_FLAGS_rcar_du_of_lvds_r8a7793 += -Wno-graph_endpoint
 DTC_FLAGS_rcar_du_of_lvds_r8a7795 += -Wno-graph_endpoint
 DTC_FLAGS_rcar_du_of_lvds_r8a7796 += -Wno-graph_endpoint
-
-obj-$(CONFIG_DRM_RZG2L_MIPI_DSI)	+= rzg2l_mipi_dsi.o
diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
index 156ff3bcc554..5df58df689cf 100644
--- a/drivers/gpu/drm/renesas/rz-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
@@ -11,3 +11,11 @@ config DRM_RZG2L_DU
 	help
 	  Choose this option if you have an RZ/G2L alike chipset.
 	  If M is selected the module will be called rzg2l-du-drm.
+
+config DRM_RZG2L_MIPI_DSI
+	tristate "RZ/G2L MIPI DSI Encoder Support"
+	depends on DRM && DRM_BRIDGE && OF
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select DRM_MIPI_DSI
+	help
+	  Enable support for the RZ/G2L Display Unit embedded MIPI DSI encoders.
diff --git a/drivers/gpu/drm/renesas/rz-du/Makefile b/drivers/gpu/drm/renesas/rz-du/Makefile
index 663b82a2577f..2987900ea6b6 100644
--- a/drivers/gpu/drm/renesas/rz-du/Makefile
+++ b/drivers/gpu/drm/renesas/rz-du/Makefile
@@ -6,3 +6,5 @@ rzg2l-du-drm-y := rzg2l_du_crtc.o \
 
 rzg2l-du-drm-$(CONFIG_VIDEO_RENESAS_VSP1)	+= rzg2l_du_vsp.o
 obj-$(CONFIG_DRM_RZG2L_DU)		+= rzg2l-du-drm.o
+
+obj-$(CONFIG_DRM_RZG2L_MIPI_DSI)	+= rzg2l_mipi_dsi.o
diff --git a/drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
similarity index 100%
rename from drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c
rename to drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
diff --git a/drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi_regs.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
similarity index 100%
rename from drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi_regs.h
rename to drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
-- 
2.43.0


