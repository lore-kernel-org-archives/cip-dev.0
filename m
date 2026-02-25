Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1D3FD3747
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:13:23 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43909.1772021592408794367
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:13:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: axg7YBRrTs+3TeT6OJ1FpA==
X-CSE-MsgGUID: NKKdMA9CT0u+dwNDd7CGYQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Feb 2026 21:13:13 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7FADF400D0F2;
	Wed, 25 Feb 2026 21:13:12 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 21/24] drm: renesas: rz-du: Drop ARCH_RZG2L dependency
Date: Wed, 25 Feb 2026 12:12:29 +0000
Message-ID: <20260225121232.129678-22-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
References: <20260225121232.129678-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:13:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21978

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a31c6c50da013dcd4de4889d402b47bae552a2e2 upstream.

The RZ/G2L DU driver is now also used on other Renesas SoCs such as
RZ/V2H(P) and RZ/V2N. Restricting it to ARCH_RZG2L prevents enabling it
on these newer platforms.

Replace the ARCH_RZG2L dependency with ARCH_RENESAS to allow the driver
to be built on all relevant Renesas SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20251002123452.146610-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
index 835d99666424..85d90dabb9e7 100644
--- a/drivers/gpu/drm/renesas/rz-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config DRM_RZG2L_DU
 	tristate "DRM Support for RZ/G2L Display Unit"
-	depends on ARCH_RZG2L || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on DRM && OF
 	depends on VIDEO_RENESAS_VSP1
 	select DRM_GEM_DMA_HELPER
-- 
2.51.0


