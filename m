Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA9D3E2CE
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:14 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.2529.1730145845810430532
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:04:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="223233426"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Oct 2024 05:04:05 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A8DF7408D1FF;
	Tue, 29 Oct 2024 05:03:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/27] media: i2c: ov5645: Make sure to call PM functions
Date: Mon, 28 Oct 2024 20:03:26 +0000
Message-ID: <20241028200349.9620-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17088

commit d781dce66df8e203c6593eaa855ce6843d69819d upstream.

Make sure we call the PM functions while s_stream(0) even in case of
errors in the code flow.

v4l2-core takes care of warning the user so no need to add a warning
message in the driver.

Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index a5b6719c4dacb..7c49b169781d7 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -996,15 +996,12 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
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
@@ -1012,6 +1009,11 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
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


