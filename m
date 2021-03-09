Return-Path: <SRS0=pG8p=IH=lists.cip-project.org=bounce+64572+6231+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB84C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A349E64F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A349E64F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6231+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gz5oYY4521723xnni0zvKYXn; Tue, 09 Mar 2021 08:37:20 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:20 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342238"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:19 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4902F40A2EDA;
	Wed, 10 Mar 2021 01:37:18 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 15/40] media: i2c: imx219: Add support for RAW8 bit bayer format
Date: Tue,  9 Mar 2021 16:36:31 +0000
Message-Id: <20210309163656.20944-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KqDBEUcJH6oXRdb3Tf6zvVXIx4520388AA=
Content-Type: multipart/mixed; boundary="PNZWD9D0A4qvoVpTB5iF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307840;
 bh=CquzjKOnyhcP2XbAySncpMQ0UrkraajK2qQZyXlqseA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cVeoY/P9Jdqkgc8WFXpr8zXiEUG6blGBnw//eeyONymHDIf1S4BX1ZeOCvgyXyr9hEy
 eMHknKe11uQcrjCqk6S+qklws7vwESOn3pBVTQzKZpixpnNPFdSWYBJG941Fg/POuJrSx
 ogFpePDNIFufWIvcsCT99XrQ6JbHJl5v5N0=

--PNZWD9D0A4qvoVpTB5iF

commit 22da1d56e982151e0bdfafe9de6fe94098a51356 upstream.

IMX219 sensor is capable for RAW8/RAW10 modes. This commit adds support
for RAW8 bayer format.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 148 +++++++++++++++++++++++++++++--------
 1 file changed, 116 insertions(+), 32 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index f1ae93569542..d94c94c38e75 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -169,15 +169,12 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x0171, 0x01},
 	{0x0174, 0x00},
 	{0x0175, 0x00},
-	{0x018c, 0x0a},
-	{0x018d, 0x0a},
 	{0x0301, 0x05},
 	{0x0303, 0x01},
 	{0x0304, 0x03},
 	{0x0305, 0x03},
 	{0x0306, 0x00},
 	{0x0307, 0x39},
-	{0x0309, 0x0a},
 	{0x030b, 0x01},
 	{0x030c, 0x00},
 	{0x030d, 0x72},
@@ -231,15 +228,12 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 	{0x0171, 0x01},
 	{0x0174, 0x00},
 	{0x0175, 0x00},
-	{0x018c, 0x0a},
-	{0x018d, 0x0a},
 	{0x0301, 0x05},
 	{0x0303, 0x01},
 	{0x0304, 0x03},
 	{0x0305, 0x03},
 	{0x0306, 0x00},
 	{0x0307, 0x39},
-	{0x0309, 0x0a},
 	{0x030b, 0x01},
 	{0x030c, 0x00},
 	{0x030d, 0x72},
@@ -291,15 +285,12 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 	{0x0171, 0x01},
 	{0x0174, 0x01},
 	{0x0175, 0x01},
-	{0x018c, 0x0a},
-	{0x018d, 0x0a},
 	{0x0301, 0x05},
 	{0x0303, 0x01},
 	{0x0304, 0x03},
 	{0x0305, 0x03},
 	{0x0306, 0x00},
 	{0x0307, 0x39},
-	{0x0309, 0x0a},
 	{0x030b, 0x01},
 	{0x030c, 0x00},
 	{0x030d, 0x72},
@@ -323,6 +314,18 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 	{0x0163, 0x78},
 };
 
+static const struct imx219_reg raw8_framefmt_regs[] = {
+	{0x018c, 0x08},
+	{0x018d, 0x08},
+	{0x0309, 0x08},
+};
+
+static const struct imx219_reg raw10_framefmt_regs[] = {
+	{0x018c, 0x0a},
+	{0x018d, 0x0a},
+	{0x0309, 0x0a},
+};
+
 static const char * const imx219_test_pattern_menu[] = {
 	"Disabled",
 	"Color Bars",
@@ -349,6 +352,27 @@ static const char * const imx219_supply_name[] = {
 
 #define IMX219_NUM_SUPPLIES ARRAY_SIZE(imx219_supply_name)
 
+/*
+ * The supported formats.
+ * This table MUST contain 4 entries per format, to cover the various flip
+ * combinations in the order
+ * - no flip
+ * - h flip
+ * - v flip
+ * - h&v flips
+ */
+static const u32 codes[] = {
+	MEDIA_BUS_FMT_SRGGB10_1X10,
+	MEDIA_BUS_FMT_SGRBG10_1X10,
+	MEDIA_BUS_FMT_SGBRG10_1X10,
+	MEDIA_BUS_FMT_SBGGR10_1X10,
+
+	MEDIA_BUS_FMT_SRGGB8_1X8,
+	MEDIA_BUS_FMT_SGRBG8_1X8,
+	MEDIA_BUS_FMT_SGBRG8_1X8,
+	MEDIA_BUS_FMT_SBGGR8_1X8,
+};
+
 /*
  * Initialisation delay between XCLR low->high and the moment when the sensor
  * can start capture (i.e. can leave software stanby) must be not less than:
@@ -414,6 +438,8 @@ struct imx219 {
 	struct v4l2_subdev sd;
 	struct media_pad pad;
 
+	struct v4l2_mbus_framefmt fmt;
+
 	struct clk *xclk; /* system clock to IMX219 */
 	u32 xclk_freq;
 
@@ -520,19 +546,40 @@ static int imx219_write_regs(struct imx219 *imx219,
 }
 
 /* Get bayer order based on flip setting. */
-static u32 imx219_get_format_code(struct imx219 *imx219)
+static u32 imx219_get_format_code(struct imx219 *imx219, u32 code)
 {
-	/*
-	 * Only one bayer order is supported.
-	 * It depends on the flip settings.
-	 */
-	static const u32 codes[2][2] = {
-		{ MEDIA_BUS_FMT_SRGGB10_1X10, MEDIA_BUS_FMT_SGRBG10_1X10, },
-		{ MEDIA_BUS_FMT_SGBRG10_1X10, MEDIA_BUS_FMT_SBGGR10_1X10, },
-	};
+	unsigned int i;
 
 	lockdep_assert_held(&imx219->mutex);
-	return codes[imx219->vflip->val][imx219->hflip->val];
+
+	for (i = 0; i < ARRAY_SIZE(codes); i++)
+		if (codes[i] == code)
+			break;
+
+	if (i >= ARRAY_SIZE(codes))
+		i = 0;
+
+	i = (i & ~3) | (imx219->vflip->val ? 2 : 0) |
+	    (imx219->hflip->val ? 1 : 0);
+
+	return codes[i];
+}
+
+static void imx219_set_default_format(struct imx219 *imx219)
+{
+	struct v4l2_mbus_framefmt *fmt;
+
+	fmt = &imx219->fmt;
+	fmt->code = MEDIA_BUS_FMT_SRGGB10_1X10;
+	fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
+	fmt->quantization = V4L2_MAP_QUANTIZATION_DEFAULT(true,
+							  fmt->colorspace,
+							  fmt->ycbcr_enc);
+	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
+	fmt->width = supported_modes[0].width;
+	fmt->height = supported_modes[0].height;
+	fmt->field = V4L2_FIELD_NONE;
 }
 
 static int imx219_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
@@ -546,7 +593,8 @@ static int imx219_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 	/* Initialize try_fmt */
 	try_fmt->width = supported_modes[0].width;
 	try_fmt->height = supported_modes[0].height;
-	try_fmt->code = imx219_get_format_code(imx219);
+	try_fmt->code = imx219_get_format_code(imx219,
+					       MEDIA_BUS_FMT_SRGGB10_1X10);
 	try_fmt->field = V4L2_FIELD_NONE;
 
 	mutex_unlock(&imx219->mutex);
@@ -649,14 +697,10 @@ static int imx219_enum_mbus_code(struct v4l2_subdev *sd,
 {
 	struct imx219 *imx219 = to_imx219(sd);
 
-	/*
-	 * Only one bayer order is supported (though it depends on the flip
-	 * settings)
-	 */
-	if (code->index > 0)
+	if (code->index >= (ARRAY_SIZE(codes) / 4))
 		return -EINVAL;
 
-	code->code = imx219_get_format_code(imx219);
+	code->code = imx219_get_format_code(imx219, codes[code->index * 4]);
 
 	return 0;
 }
@@ -670,7 +714,7 @@ static int imx219_enum_frame_size(struct v4l2_subdev *sd,
 	if (fse->index >= ARRAY_SIZE(supported_modes))
 		return -EINVAL;
 
-	if (fse->code != imx219_get_format_code(imx219))
+	if (fse->code != imx219_get_format_code(imx219, imx219->fmt.code))
 		return -EINVAL;
 
 	fse->min_width = supported_modes[fse->index].width;
@@ -697,9 +741,7 @@ static void imx219_update_pad_format(struct imx219 *imx219,
 {
 	fmt->format.width = mode->width;
 	fmt->format.height = mode->height;
-	fmt->format.code = imx219_get_format_code(imx219);
 	fmt->format.field = V4L2_FIELD_NONE;
-
 	imx219_reset_colorspace(&fmt->format);
 }
 
@@ -711,10 +753,12 @@ static int __imx219_get_pad_format(struct imx219 *imx219,
 		struct v4l2_mbus_framefmt *try_fmt =
 			v4l2_subdev_get_try_format(&imx219->sd, cfg, fmt->pad);
 		/* update the code which could change due to vflip or hflip: */
-		try_fmt->code = imx219_get_format_code(imx219);
+		try_fmt->code = imx219_get_format_code(imx219, try_fmt->code);
 		fmt->format = *try_fmt;
 	} else {
 		imx219_update_pad_format(imx219, imx219->mode, fmt);
+		fmt->format.code = imx219_get_format_code(imx219,
+							  imx219->fmt.code);
 	}
 
 	return 0;
@@ -742,11 +786,18 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	const struct imx219_mode *mode;
 	struct v4l2_mbus_framefmt *framefmt;
 	int exposure_max, exposure_def, hblank;
+	unsigned int i;
 
 	mutex_lock(&imx219->mutex);
 
+	for (i = 0; i < ARRAY_SIZE(codes); i++)
+		if (codes[i] == fmt->format.code)
+			break;
+	if (i >= ARRAY_SIZE(codes))
+		i = 0;
+
 	/* Bayer order varies with flips */
-	fmt->format.code = imx219_get_format_code(imx219);
+	fmt->format.code = imx219_get_format_code(imx219, codes[i]);
 
 	mode = v4l2_find_nearest_size(supported_modes,
 				      ARRAY_SIZE(supported_modes),
@@ -756,7 +807,9 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
 		framefmt = v4l2_subdev_get_try_format(sd, cfg, fmt->pad);
 		*framefmt = fmt->format;
-	} else if (imx219->mode != mode) {
+	} else if (imx219->mode != mode ||
+		   imx219->fmt.code != fmt->format.code) {
+		imx219->fmt = fmt->format;
 		imx219->mode = mode;
 		/* Update limits and set FPS to default */
 		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
@@ -787,6 +840,27 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static int imx219_set_framefmt(struct imx219 *imx219)
+{
+	switch (imx219->fmt.code) {
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+	case MEDIA_BUS_FMT_SGRBG8_1X8:
+	case MEDIA_BUS_FMT_SGBRG8_1X8:
+	case MEDIA_BUS_FMT_SBGGR8_1X8:
+		return imx219_write_regs(imx219, raw8_framefmt_regs,
+					ARRAY_SIZE(raw8_framefmt_regs));
+
+	case MEDIA_BUS_FMT_SRGGB10_1X10:
+	case MEDIA_BUS_FMT_SGRBG10_1X10:
+	case MEDIA_BUS_FMT_SGBRG10_1X10:
+	case MEDIA_BUS_FMT_SBGGR10_1X10:
+		return imx219_write_regs(imx219, raw10_framefmt_regs,
+					ARRAY_SIZE(raw10_framefmt_regs));
+	}
+
+	return -EINVAL;
+}
+
 static int imx219_start_streaming(struct imx219 *imx219)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx219->sd);
@@ -801,6 +875,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
 		return ret;
 	}
 
+	ret = imx219_set_framefmt(imx219);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to set frame format: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	/* Apply customized values from user */
 	ret =  __v4l2_ctrl_handler_setup(imx219->sd.ctrl_handler);
 	if (ret)
@@ -1253,6 +1334,9 @@ static int imx219_probe(struct i2c_client *client)
 	/* Initialize source pad */
 	imx219->pad.flags = MEDIA_PAD_FL_SOURCE;
 
+	/* Initialize default format */
+	imx219_set_default_format(imx219);
+
 	ret = media_entity_pads_init(&imx219->sd.entity, 1, &imx219->pad);
 	if (ret) {
 		dev_err(dev, "failed to init entity pads: %d\n", ret);
-- 
2.17.1


--PNZWD9D0A4qvoVpTB5iF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6231): https://lists.cip-project.org/g/cip-dev/message=
/6231
Mute This Topic: https://lists.cip-project.org/mt/81205359/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PNZWD9D0A4qvoVpTB5iF--
