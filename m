Return-Path: <SRS0=7VLG=IH=lists.cip-project.org=bounce+64572+6233+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B19C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BFE64F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BFE64F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6233+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id w7AgYY4521723xCTaSaLRpSW; Tue, 09 Mar 2021 08:37:23 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:22 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591017"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:21 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EB1D040A2EDA;
	Wed, 10 Mar 2021 01:37:20 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 17/40] media: i2c: imx219: Implement get_selection
Date: Tue,  9 Mar 2021 16:36:33 +0000
Message-Id: <20210309163656.20944-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: t8A8O0U9EWd3VTOzOerGvgeKx4520388AA=
Content-Type: multipart/mixed; boundary="zGy4i8Rh1zN72BaqZWNA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307843;
 bh=PWqiT0K4oN8pwYMZTU+ScQrWa5drDyOcwfnNW8fAaHs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rc2pd/a4+g+k9n1kKhuLTXxXE9R/Z+AxddnQzdzXWqxm+C8pOWaoIVZQlkALGpfp3Hk
 xI49W9cAEQnk84/Ry5wUD1QshmAtCfrvuhqdsBfXk4hHzsP6KsAC1TMbFFDYSZu1YiNs1
 ZFc1wzPIgLIpKIAg9e8PMzZnkB+uQhjqVz0=

--zGy4i8Rh1zN72BaqZWNA

From: Jacopo Mondi <jacopo@jmondi.org>

commit e6d4ef7d58aa7e64aa735e1b3c7b670e4fb34d6f upstream.

Implement the get_selection pad operation for the IMX219 sensor driver.
The supported targets report the sensor's native size, the crop default
rectangle and the crop rectangle.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e2db55f70cd6..c50530d2a728 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -113,6 +113,14 @@
 #define IMX219_TESTP_BLUE_DEFAULT	0
 #define IMX219_TESTP_GREENB_DEFAULT	0
 
+/* IMX219 native and active pixel array size. */
+#define IMX219_NATIVE_WIDTH		3296U
+#define IMX219_NATIVE_HEIGHT		2480U
+#define IMX219_PIXEL_ARRAY_LEFT		8U
+#define IMX219_PIXEL_ARRAY_TOP		8U
+#define IMX219_PIXEL_ARRAY_WIDTH	3280U
+#define IMX219_PIXEL_ARRAY_HEIGHT	2464U
+
 struct imx219_reg {
 	u16 address;
 	u8 val;
@@ -130,6 +138,9 @@ struct imx219_mode {
 	/* Frame height */
 	unsigned int height;
 
+	/* Analog crop rectangle. */
+	struct v4l2_rect crop;
+
 	/* V-timing */
 	unsigned int vts_def;
 
@@ -464,6 +475,12 @@ static const struct imx219_mode supported_modes[] = {
 		/* 8MPix 15fps mode */
 		.width = 3280,
 		.height = 2464,
+		.crop = {
+			.left = 0,
+			.top = 0,
+			.width = 3280,
+			.height = 2464
+		},
 		.vts_def = IMX219_VTS_15FPS,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_3280x2464_regs),
@@ -474,6 +491,12 @@ static const struct imx219_mode supported_modes[] = {
 		/* 1080P 30fps cropped */
 		.width = 1920,
 		.height = 1080,
+		.crop = {
+			.left = 680,
+			.top = 692,
+			.width = 1920,
+			.height = 1080
+		},
 		.vts_def = IMX219_VTS_30FPS_1080P,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920_1080_regs),
@@ -484,6 +507,12 @@ static const struct imx219_mode supported_modes[] = {
 		/* 2x2 binned 30fps mode */
 		.width = 1640,
 		.height = 1232,
+		.crop = {
+			.left = 0,
+			.top = 0,
+			.width = 3280,
+			.height = 2464
+		},
 		.vts_def = IMX219_VTS_30FPS_BINNED,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1640_1232_regs),
@@ -494,6 +523,12 @@ static const struct imx219_mode supported_modes[] = {
 		/* 640x480 30fps mode */
 		.width = 640,
 		.height = 480,
+		.crop = {
+			.left = 1000,
+			.top = 752,
+			.width = 1280,
+			.height = 960
+		},
 		.vts_def = IMX219_VTS_30FPS_640x480,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_640_480_regs),
@@ -655,6 +690,7 @@ static int imx219_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 	struct imx219 *imx219 = to_imx219(sd);
 	struct v4l2_mbus_framefmt *try_fmt =
 		v4l2_subdev_get_try_format(sd, fh->pad, 0);
+	struct v4l2_rect *try_crop;
 
 	mutex_lock(&imx219->mutex);
 
@@ -665,6 +701,13 @@ static int imx219_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 					       MEDIA_BUS_FMT_SRGGB10_1X10);
 	try_fmt->field = V4L2_FIELD_NONE;
 
+	/* Initialize try_crop rectangle. */
+	try_crop = v4l2_subdev_get_try_crop(sd, fh->pad, 0);
+	try_crop->top = IMX219_PIXEL_ARRAY_TOP;
+	try_crop->left = IMX219_PIXEL_ARRAY_LEFT;
+	try_crop->width = IMX219_PIXEL_ARRAY_WIDTH;
+	try_crop->height = IMX219_PIXEL_ARRAY_HEIGHT;
+
 	mutex_unlock(&imx219->mutex);
 
 	return 0;
@@ -929,6 +972,56 @@ static int imx219_set_framefmt(struct imx219 *imx219)
 	return -EINVAL;
 }
 
+static const struct v4l2_rect *
+__imx219_get_pad_crop(struct imx219 *imx219, struct v4l2_subdev_pad_config *cfg,
+		      unsigned int pad, enum v4l2_subdev_format_whence which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_get_try_crop(&imx219->sd, cfg, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &imx219->mode->crop;
+	}
+
+	return NULL;
+}
+
+static int imx219_get_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_pad_config *cfg,
+				struct v4l2_subdev_selection *sel)
+{
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP: {
+		struct imx219 *imx219 = to_imx219(sd);
+
+		mutex_lock(&imx219->mutex);
+		sel->r = *__imx219_get_pad_crop(imx219, cfg, sel->pad,
+						sel->which);
+		mutex_unlock(&imx219->mutex);
+
+		return 0;
+	}
+
+	case V4L2_SEL_TGT_NATIVE_SIZE:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = IMX219_NATIVE_WIDTH;
+		sel->r.height = IMX219_NATIVE_HEIGHT;
+
+		return 0;
+
+	case V4L2_SEL_TGT_CROP_DEFAULT:
+		sel->r.top = IMX219_PIXEL_ARRAY_TOP;
+		sel->r.left = IMX219_PIXEL_ARRAY_LEFT;
+		sel->r.width = IMX219_PIXEL_ARRAY_WIDTH;
+		sel->r.height = IMX219_PIXEL_ARRAY_HEIGHT;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static int imx219_start_streaming(struct imx219 *imx219)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
@@ -1153,6 +1246,7 @@ static const struct v4l2_subdev_pad_ops imx219_pad_ops = {
 	.enum_mbus_code = imx219_enum_mbus_code,
 	.get_fmt = imx219_get_pad_format,
 	.set_fmt = imx219_set_pad_format,
+	.get_selection = imx219_get_selection,
 	.enum_frame_size = imx219_enum_frame_size,
 };
 
-- 
2.17.1


--zGy4i8Rh1zN72BaqZWNA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6233): https://lists.cip-project.org/g/cip-dev/message=
/6233
Mute This Topic: https://lists.cip-project.org/mt/81205364/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zGy4i8Rh1zN72BaqZWNA--
