Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AFCC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:06 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.83960.1701956825767216182
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185670958"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:04 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 01FF242B1D15;
	Thu,  7 Dec 2023 22:47:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/18] media: vsp1: use pm_runtime_resume_and_get()
Date: Thu,  7 Dec 2023 13:46:41 +0000
Message-Id: <20231207134657.371420-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13845

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit 71aeaedc968343c644b3c073b715b24b909ef088 upstream.

Commit dd8088d5a896 ("PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter")
added pm_runtime_resume_and_get() in order to automatically handle
dev->power.usage_count decrement on errors.

Use the new API, in order to cleanup the error check logic.

As a bonus, pm_runtime_resume_and_get() always return 0 on success.
So, the code can be simplified.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index aa66e4f5f3f3..de442d6c9926 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -559,15 +559,7 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
  */
 int vsp1_device_get(struct vsp1_device *vsp1)
 {
-	int ret;
-
-	ret = pm_runtime_get_sync(vsp1->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(vsp1->dev);
-		return ret;
-	}
-
-	return 0;
+	return pm_runtime_resume_and_get(vsp1->dev);
 }
 
 /*
-- 
2.25.1


