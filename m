Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7367CC52D72
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:43:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.12744.1722876227989460929
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:43:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="218711290"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Aug 2024 01:43:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CD9494020F32;
	Tue,  6 Aug 2024 01:43:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/30] media: i2c: ov5645: Make sure to call PM functions
Date: Mon,  5 Aug 2024 17:42:57 +0100
Message-ID: <20240805164342.211857-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:43:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16726

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d781dce66df8e203c6593eaa855ce6843d69819d upstream.

Make sure we call the PM functions while s_stream(0) even in case of
errors in the code flow.

v4l2-core takes care of warning the user so no need to add a warning
message in the driver.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 6897f542737a..0a889283da36 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -998,15 +998,12 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 	} else {
 		ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
 		if (ret < 0)
-			return ret;
+			goto stream_off_rpm_put;
 
 		ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
 				       OV5645_SYSTEM_CTRL0_STOP);
-		if (ret < 0)
-			return ret;
 
-		pm_runtime_mark_last_busy(ov5645->dev);
-		pm_runtime_put_autosuspend(ov5645->dev);
+		goto stream_off_rpm_put;
 	}
 
 	return 0;
@@ -1014,6 +1011,11 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
 err_rpm_put:
 	pm_runtime_put_sync(ov5645->dev);
 	return ret;
+
+stream_off_rpm_put:
+	pm_runtime_mark_last_busy(ov5645->dev);
+	pm_runtime_put_autosuspend(ov5645->dev);
+	return ret;
 }
 
 static const struct v4l2_subdev_video_ops ov5645_video_ops = {
-- 
2.43.0


