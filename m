Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA2C46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.83960.1701956825767216182
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185670972"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:11 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79DFF42B1D29;
	Thu,  7 Dec 2023 22:47:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/18] media: vsp1: Simplify DRM UIF handling
Date: Thu,  7 Dec 2023 13:46:44 +0000
Message-Id: <20231207134657.371420-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13848

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

commit 168c05a3e6ac4f575298abbf9a6eef7c1b024f70 upstream.

In commit 6732f3139380 ("media: v4l: vsp1: Fix uif null pointer access")
the handling of the UIF was over complicated, and the patch applied
before review.

Simplify it to keep the conditionals small.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/platform/vsp1/vsp1_drm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/vsp1/vsp1_drm.c
index 06f74d410973..0c2507dc03d6 100644
--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -455,6 +455,10 @@ static int vsp1_du_pipeline_setup_inputs(struct vsp1_device *vsp1,
 		dev_err(vsp1->dev, "%s: failed to setup UIF after %s\n",
 			__func__, BRX_NAME(pipe->brx));
 
+	/* If the DRM pipe does not have a UIF there is nothing we can update. */
+	if (!drm_pipe->uif)
+		return 0;
+
 	/*
 	 * If the UIF is not in use schedule it for removal by setting its pipe
 	 * pointer to NULL, vsp1_du_pipeline_configure() will remove it from the
@@ -462,9 +466,9 @@ static int vsp1_du_pipeline_setup_inputs(struct vsp1_device *vsp1,
 	 * make sure it is present in the pipeline's list of entities if it
 	 * wasn't already.
 	 */
-	if (drm_pipe->uif && !use_uif) {
+	if (!use_uif) {
 		drm_pipe->uif->pipe = NULL;
-	} else if (drm_pipe->uif && !drm_pipe->uif->pipe) {
+	} else if (!drm_pipe->uif->pipe) {
 		drm_pipe->uif->pipe = pipe;
 		list_add_tail(&drm_pipe->uif->list_pipe, &pipe->entities);
 	}
-- 
2.25.1


