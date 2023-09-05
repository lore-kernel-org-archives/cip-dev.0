Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9875DCA0FE2
	for <webhook@archiver.kernel.org>; Tue,  5 Sep 2023 16:07:53 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.25749.1693930062988095764
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 09:07:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,229,1688396400"; 
   d="scan'208";a="175102528"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Sep 2023 01:07:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.194])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B4BAE401CC90;
	Wed,  6 Sep 2023 01:07:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/20] drm: rcar-du: Fix Kconfig dependency between DRM and RZG2L_MIPI_DSI
Date: Tue,  5 Sep 2023 17:07:21 +0100
Message-Id: <20230905160737.167877-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
References: <20230905160737.167877-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Sep 2023 16:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12946

commit ff6d979454ee21bf2d21040c8f2996b8f66726f2 upstream.

When CONFIG_DRM=m and CONFIG_DRM_RZG2L_MIPI_DSI=y, it results in a
build failure. This patch fixes the build issue by adding dependency
to DRM.

Fixes: 7a043f978ed1 ("drm: rcar-du: Add RZ/G2L DSI driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index 1065dca885ef..b2bddbeca878 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -56,7 +56,7 @@ config DRM_RCAR_MIPI_DSI
 
 config DRM_RZG2L_MIPI_DSI
 	tristate "RZ/G2L MIPI DSI Encoder Support"
-	depends on DRM_BRIDGE && OF
+	depends on DRM && DRM_BRIDGE && OF
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select DRM_MIPI_DSI
 	help
-- 
2.25.1


