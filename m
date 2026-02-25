Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4E0FD3744
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:13:13 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43902.1772021574463576761
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:13:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: gBwwEALYSN+aO0UXTJdg0w==
X-CSE-MsgGUID: iJ0i63WHROyhazoinU9kkA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Feb 2026 21:13:02 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AAA98401DE35;
	Wed, 25 Feb 2026 21:13:01 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 15/24] drm: renesas: rz-du: mipi_dsi: Add feature flag for 16BPP support
Date: Wed, 25 Feb 2026 12:12:23 +0000
Message-ID: <20260225121232.129678-16-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
References: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:13:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21972

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a56a6b81d80fdf876a5ee6e441a6c8a0052f6f37 upstream.

Introduce the `RZ_MIPI_DSI_FEATURE_16BPP` flag in `rzg2l_mipi_dsi_hw_info`
to indicate support for 16BPP pixel formats. The RZ/V2H(P) SoC supports
16BPP, whereas this feature is missing on the RZ/G2L SoC.

Update the `mipi_dsi_host_attach()` function to check this flag before
allowing 16BPP formats. If the SoC does not support 16BPP, return an error
to prevent incorrect format selection.

This change enables finer-grained format support control for different
SoC variants.

Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250609225630.502888-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 7d5515d676c7..6278b8f79f4a 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -28,6 +28,8 @@
 
 #include "rzg2l_mipi_dsi_regs.h"
 
+#define RZ_MIPI_DSI_FEATURE_16BPP	BIT(0)
+
 struct rzg2l_mipi_dsi;
 
 struct rzg2l_mipi_dsi_hw_info {
@@ -37,6 +39,7 @@ struct rzg2l_mipi_dsi_hw_info {
 	u32 link_reg_offset;
 	unsigned long min_dclk;
 	unsigned long max_dclk;
+	u8 features;
 };
 
 struct rzg2l_mipi_dsi {
@@ -644,8 +647,16 @@ static int rzg2l_mipi_dsi_host_attach(struct mipi_dsi_host *host,
 
 	switch (mipi_dsi_pixel_format_to_bpp(device->format)) {
 	case 24:
+		break;
 	case 18:
 		break;
+	case 16:
+		if (!(dsi->info->features & RZ_MIPI_DSI_FEATURE_16BPP)) {
+			dev_err(dsi->dev, "Unsupported format 0x%04x\n",
+				device->format);
+			return -EINVAL;
+		}
+		break;
 	default:
 		dev_err(dsi->dev, "Unsupported format 0x%04x\n", device->format);
 		return -EINVAL;
-- 
2.51.0


