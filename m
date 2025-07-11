Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A58C83F20
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 15:56:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.17507.1752249399155426659
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 08:56:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: RKpvLSLiQcS1B4E2yuTrjA==
X-CSE-MsgGUID: OOBoRLGiTNO7AILco4bzuA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Jul 2025 00:56:38 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9579B4018E68;
	Sat, 12 Jul 2025 00:56:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 1/8] drm: renesas: rz-du: Drop DU_MCR0_DPI_OE macro
Date: Fri, 11 Jul 2025 16:56:20 +0100
Message-ID: <20250711155633.103449-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 15:56:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19397

commit e22c857aed59ed3f5f3e144039ef095521f15179 upstream.

The DPI_OE bit is removed from the latest RZ/G2UL and RZ/G2L hardware
manual. So, drop this macro.

Fixes: b330f1480172 ("drm: renesas: rz-du: Add RZ/G2UL DU Support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241022082433.32513-2-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index c4c1474d487e7..6e7aac6219bed 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -28,7 +28,6 @@
 #include "rzg2l_du_vsp.h"
 
 #define DU_MCR0			0x00
-#define DU_MCR0_DPI_OE		BIT(0)
 #define DU_MCR0_DI_EN		BIT(8)
 
 #define DU_DITR0		0x10
@@ -217,14 +216,9 @@ static void rzg2l_du_crtc_put(struct rzg2l_du_crtc *rcrtc)
 
 static void rzg2l_du_start_stop(struct rzg2l_du_crtc *rcrtc, bool start)
 {
-	struct rzg2l_du_crtc_state *rstate = to_rzg2l_crtc_state(rcrtc->crtc.state);
 	struct rzg2l_du_device *rcdu = rcrtc->dev;
-	u32 val = DU_MCR0_DI_EN;
 
-	if (rstate->outputs & BIT(RZG2L_DU_OUTPUT_DPAD0))
-		val |= DU_MCR0_DPI_OE;
-
-	writel(start ? val : 0, rcdu->mmio + DU_MCR0);
+	writel(start ? DU_MCR0_DI_EN : 0, rcdu->mmio + DU_MCR0);
 }
 
 static void rzg2l_du_crtc_start(struct rzg2l_du_crtc *rcrtc)
-- 
2.43.0


