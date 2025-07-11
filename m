Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8AC83F22
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 15:56:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.17510.1752249403067918131
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 08:56:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: KoVifyjDTqy/yejn5LbEsQ==
X-CSE-MsgGUID: pTbqoGcVR4ev9BwgCSZEpw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Jul 2025 00:56:42 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AEB004018A29;
	Sat, 12 Jul 2025 00:56:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 3/8] drm: renesas: rz-du: Add Kconfig dependency between RZG2L_DU and RZG2L_MIPI_DSI
Date: Fri, 11 Jul 2025 16:56:22 +0100
Message-ID: <20250711155633.103449-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 15:56:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19400

commit 7e6cb7290b4a92a6af096b137b84bf285801a5d6 upstream.

Add Kconfig dependency between RZG2L_DU and RZG2L_MIPI_DSI, so that
DSI module has functional dependency on DU. It is similar way that
the R-Car MIPI DSI encoder is handled.

While at it drop ARCH_RENESAS dependency as DRM_RZG2L_DU depend on
ARCH_RZG2L.

Suggested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240827163727.108405-1-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/Kconfig | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
index 89bdb598e0ae8..835d99666424d 100644
--- a/drivers/gpu/drm/renesas/rz-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
@@ -13,10 +13,15 @@ config DRM_RZG2L_DU
 	  Choose this option if you have an RZ/G2L alike chipset.
 	  If M is selected the module will be called rzg2l-du-drm.
 
-config DRM_RZG2L_MIPI_DSI
-	tristate "RZ/G2L MIPI DSI Encoder Support"
-	depends on DRM && DRM_BRIDGE && OF
-	depends on ARCH_RENESAS || COMPILE_TEST
-	select DRM_MIPI_DSI
+config DRM_RZG2L_USE_MIPI_DSI
+	bool "RZ/G2L MIPI DSI Encoder Support"
+	depends on DRM_BRIDGE && OF
+	depends on DRM_RZG2L_DU || COMPILE_TEST
+	default DRM_RZG2L_DU
 	help
 	  Enable support for the RZ/G2L Display Unit embedded MIPI DSI encoders.
+
+config DRM_RZG2L_MIPI_DSI
+	def_tristate DRM_RZG2L_DU
+	depends on DRM_RZG2L_USE_MIPI_DSI
+	select DRM_MIPI_DSI
-- 
2.43.0


