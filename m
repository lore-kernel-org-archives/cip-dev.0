Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E3AE6B25D
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:58:15 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.37169.1730465882741045862
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:58:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,249,1725289200"; 
   d="scan'208";a="227643664"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Nov 2024 21:58:02 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 71B0F400720A;
	Fri,  1 Nov 2024 21:57:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 04/28] media: i2c: ov5645: Make sure to call PM functions
Date: Fri,  1 Nov 2024 12:57:22 +0000
Message-ID: <20241101125746.33222-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:58:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17140

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


