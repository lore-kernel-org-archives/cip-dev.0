Return-Path: <SRS0=9JHk=KH=lists.cip-project.org=bounce+64572+6451+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E6C433ED
	for <cip-dev@archiver.kernel.org>; Wed, 12 May 2021 17:01:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B617611F1
	for <cip-dev@archiver.kernel.org>; Wed, 12 May 2021 17:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B617611F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6451+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aGFYYY4521723xKJKJDItpdz; Wed, 12 May 2021 10:01:34 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.573.1620838892738192140
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 May 2021 10:01:33 -0700
X-IronPort-AV: E=Sophos;i="5.82,293,1613401200"; 
   d="scan'208";a="81095266"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 May 2021 02:01:32 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 34D5A40AB2F2;
	Thu, 13 May 2021 02:01:31 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/2] media: i2c: imx219: Balance runtime PM use-count
Date: Wed, 12 May 2021 18:01:27 +0100
Message-Id: <20210512170127.16390-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210512170127.16390-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210512170127.16390-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 2EeTOCoDcpR4qOZqOkK5lFHYx4520388AA=
Content-Type: multipart/mixed; boundary="4tVxvAcg1qdI67VCBQ2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620838894;
 bh=iY25Ab5oKvJkMvVVenWBjgKEu3A6KdiBwa+7MxuEsYI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=gvw+b2VzCSAXvih0DGv1ziTFl/qxFeGs103+OEIbox97SpD/s5Oc0GGFjaGHiyThieu
 IDsuPal43rr5v9uYymqgFICMMM5t0hHT/S9j8oYJDBowROFoAmO7DTaEl+JuxRtoBUGH9
 udGOl6wl3pEUhq9h7iTqq0tW7dHp8iJxl3c=

--4tVxvAcg1qdI67VCBQ2S

commit dd90caa0111e178b52b21e56364bc2244a3973b3 upstream.

Move incrementing/decrementing runtime PM count to
imx219_start_streaming()/imx219_stop_streaming() functions respectively.

This fixes an issue of unbalanced runtime PM count in resume callback
error path where streaming is stopped and runtime PM count is left
unbalanced.

Fixes: 1283b3b8f82b9 ("media: i2c: Add driver for Sony IMX219 sensor")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index d856019cb070..27df9d87f392 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1035,37 +1035,47 @@ static int imx219_start_streaming(struct imx219 *imx219)
 	const struct imx219_reg_list *reg_list;
 	int ret;
 
+	ret = pm_runtime_get_sync(&client->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&client->dev);
+		return ret;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx219->mode->reg_list;
 	ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
 	if (ret) {
 		dev_err(&client->dev, "%s failed to set mode\n", __func__);
-		return ret;
+		goto err_rpm_put;
 	}
 
 	ret = imx219_set_framefmt(imx219);
 	if (ret) {
 		dev_err(&client->dev, "%s failed to set frame format: %d\n",
 			__func__, ret);
-		return ret;
+		goto err_rpm_put;
 	}
 
 	/* Apply customized values from user */
 	ret =  __v4l2_ctrl_handler_setup(imx219->sd.ctrl_handler);
 	if (ret)
-		return ret;
+		goto err_rpm_put;
 
 	/* set stream on register */
 	ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
 			       IMX219_REG_VALUE_08BIT, IMX219_MODE_STREAMING);
 	if (ret)
-		return ret;
+		goto err_rpm_put;
 
 	/* vflip and hflip cannot change during streaming */
 	__v4l2_ctrl_grab(imx219->vflip, true);
 	__v4l2_ctrl_grab(imx219->hflip, true);
 
 	return 0;
+
+err_rpm_put:
+	pm_runtime_put(&client->dev);
+	return ret;
 }
 
 static void imx219_stop_streaming(struct imx219 *imx219)
@@ -1081,12 +1091,13 @@ static void imx219_stop_streaming(struct imx219 *imx219)
 
 	__v4l2_ctrl_grab(imx219->vflip, false);
 	__v4l2_ctrl_grab(imx219->hflip, false);
+
+	pm_runtime_put(&client->dev);
 }
 
 static int imx219_set_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct imx219 *imx219 = to_imx219(sd);
-	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	int ret = 0;
 
 	mutex_lock(&imx219->mutex);
@@ -1096,22 +1107,15 @@ static int imx219_set_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 	if (enable) {
-		ret = pm_runtime_get_sync(&client->dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(&client->dev);
-			goto err_unlock;
-		}
-
 		/*
 		 * Apply default & customized values
 		 * and then start streaming.
 		 */
 		ret = imx219_start_streaming(imx219);
 		if (ret)
-			goto err_rpm_put;
+			goto err_unlock;
 	} else {
 		imx219_stop_streaming(imx219);
-		pm_runtime_put(&client->dev);
 	}
 
 	imx219->streaming = enable;
@@ -1120,8 +1124,6 @@ static int imx219_set_stream(struct v4l2_subdev *sd, int enable)
 
 	return ret;
 
-err_rpm_put:
-	pm_runtime_put(&client->dev);
 err_unlock:
 	mutex_unlock(&imx219->mutex);
 
-- 
2.17.1


--4tVxvAcg1qdI67VCBQ2S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6451): https://lists.cip-project.org/g/cip-dev/message=
/6451
Mute This Topic: https://lists.cip-project.org/mt/82777616/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4tVxvAcg1qdI67VCBQ2S--
