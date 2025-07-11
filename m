Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D6C83F1A
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 15:56:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.17510.1752249403067918131
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 08:56:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: NZCZFcf1Q5WuDLjm8HSjUA==
X-CSE-MsgGUID: oXA4oRDLQuehLxyeHQU51g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Jul 2025 00:56:52 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F341B4018C7F;
	Sat, 12 Jul 2025 00:56:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 8/8] drm: renesas: rz-du: rzg2l_mipi_dsi: Update the comment in rzg2l_mipi_dsi_start_video()
Date: Fri, 11 Jul 2025 16:56:27 +0100
Message-ID: <20250711155633.103449-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
References: <20250711155633.103449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 15:56:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19405

commit b1d6a89d7b75435da9c541c5f9d4df8268291c6e upstream.

Add missing space in the comment in rzg2l_mipi_dsi_start_video().

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZPg7STHDn4LbLy7f@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20250412061258.5447-1-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 10febea473cde..9b5cfdd3e1c57 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -479,7 +479,7 @@ static int rzg2l_mipi_dsi_start_video(struct rzg2l_mipi_dsi *dsi)
 	u32 status;
 	int ret;
 
-	/* Configuration for Blanking sequence and start video input*/
+	/* Configuration for Blanking sequence and start video input */
 	vich1set0r = VICH1SET0R_HFPNOLP | VICH1SET0R_HBPNOLP |
 		     VICH1SET0R_HSANOLP | VICH1SET0R_VSTART;
 	rzg2l_mipi_dsi_link_write(dsi, VICH1SET0R, vich1set0r);
-- 
2.43.0


