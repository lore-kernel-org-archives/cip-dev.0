Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45721C83F1A
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 16:32:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.18309.1752251547448211862
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Jul 2025 09:32:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: ziiGQUW8R6qbJUUtjh+IBw==
X-CSE-MsgGUID: ba2JYL3sTgOoM9rUqJh5uQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Jul 2025 01:32:36 +0900
Received: from localhost.localdomain (unknown [10.226.93.74])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E2462402AA23;
	Sat, 12 Jul 2025 01:32:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 5/8] drm: renesas: rz-du: Drop bpp variable from struct rzg2l_du_format_info
Date: Fri, 11 Jul 2025 17:32:15 +0100
Message-ID: <20250711163222.191633-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
References: <20250711163222.191633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 16:32:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19411

commit 2f31808bc75072a819c7dbf28bf273d2940f360b upstream.

Drop the unused variable bpp from struct rzg2l_du_format_info.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20250330102357.56010-2-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 3 ---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index b99217b4e05d..a875023cbf13 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -38,19 +38,16 @@ static const struct rzg2l_du_format_info rzg2l_du_format_infos[] = {
 	{
 		.fourcc = DRM_FORMAT_XRGB8888,
 		.v4l2 = V4L2_PIX_FMT_XBGR32,
-		.bpp = 32,
 		.planes = 1,
 		.hsub = 1,
 	}, {
 		.fourcc = DRM_FORMAT_ARGB8888,
 		.v4l2 = V4L2_PIX_FMT_ABGR32,
-		.bpp = 32,
 		.planes = 1,
 		.hsub = 1,
 	}, {
 		.fourcc = DRM_FORMAT_RGB888,
 		.v4l2 = V4L2_PIX_FMT_BGR24,
-		.bpp = 24,
 		.planes = 1,
 		.hsub = 1,
 	}
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
index 876e97cfbf45..e2c599f115c6 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h
@@ -23,7 +23,6 @@ struct sg_table;
 struct rzg2l_du_format_info {
 	u32 fourcc;
 	u32 v4l2;
-	unsigned int bpp;
 	unsigned int planes;
 	unsigned int hsub;
 };
-- 
2.43.0


