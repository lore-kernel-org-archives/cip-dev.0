Return-Path: <SRS0=PWAt=IH=lists.cip-project.org=bounce+64572+6235+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2996C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A1264FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A1264FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6235+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 26GRYY4521723xObZPRzi8Xl; Tue, 09 Mar 2021 08:37:25 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:25 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591021"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:24 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9741140A2DC7;
	Wed, 10 Mar 2021 01:37:23 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 19/40] media: i2c: imx219: Selection compliance fixes
Date: Tue,  9 Mar 2021 16:36:35 +0000
Message-Id: <20210309163656.20944-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Si2UTWglMWcz1CkW2ajJaIP5x4520388AA=
Content-Type: multipart/mixed; boundary="9paOwHGdOE9sWMx0ZoRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307845;
 bh=lOgcCWL+NmpLm4yZ2xvwO73fZ8g0CnnvxRJobvqp6rI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KBndbL9PBMnu2VoxBwP86OQolPv/8PNb+dvd9YwqwjXgzhkU/kLQ6Sl6H5LMypjYVf3
 +mED2qthsBFP08PYXHxvKpZ8W23+92Kn4n77duPAR2lv6HWai9+W2RxZEgrMryw1I4MXy
 ioDi/710a0QOBx7woXpIJjbvV8qDtGrkW0w=

--9paOwHGdOE9sWMx0ZoRN

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 1ed36ecd1459b653cced8929bfb37dba94b64c5d upstream.

To comply with the intended usage of the V4L2 selection target when
used to retrieve a sensor image properties, adjust the rectangles
returned by the imx219 driver.

The top/left crop coordinates of the TGT_CROP rectangle were set to
(0, 0) instead of (8, 8) which is the offset from the larger physical
pixel array rectangle. This was also a mismatch with the default values
crop rectangle value, so this is corrected. Found with v4l2-compliance.

While at it, add V4L2_SEL_TGT_CROP_BOUNDS support: CROP_DEFAULT and
CROP_BOUNDS have the same size as the non-active pixels are not readable
using the selection API. Found with v4l2-compliance.

[reword commit message, use macros for pixel offsets]

Fixes: e6d4ef7d58aa7 ("media: i2c: imx219: Implement get_selection")
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index c92d935a87ce..386717fb2b99 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -476,8 +476,8 @@ static const struct imx219_mode supported_modes[] = {
 		.width = 3280,
 		.height = 2464,
 		.crop = {
-			.left = 0,
-			.top = 0,
+			.left = IMX219_PIXEL_ARRAY_LEFT,
+			.top = IMX219_PIXEL_ARRAY_TOP,
 			.width = 3280,
 			.height = 2464
 		},
@@ -492,8 +492,8 @@ static const struct imx219_mode supported_modes[] = {
 		.width = 1920,
 		.height = 1080,
 		.crop = {
-			.left = 680,
-			.top = 692,
+			.left = 688,
+			.top = 700,
 			.width = 1920,
 			.height = 1080
 		},
@@ -508,8 +508,8 @@ static const struct imx219_mode supported_modes[] = {
 		.width = 1640,
 		.height = 1232,
 		.crop = {
-			.left = 0,
-			.top = 0,
+			.left = IMX219_PIXEL_ARRAY_LEFT,
+			.top = IMX219_PIXEL_ARRAY_TOP,
 			.width = 3280,
 			.height = 2464
 		},
@@ -524,8 +524,8 @@ static const struct imx219_mode supported_modes[] = {
 		.width = 640,
 		.height = 480,
 		.crop = {
-			.left = 1000,
-			.top = 752,
+			.left = 1008,
+			.top = 760,
 			.width = 1280,
 			.height = 960
 		},
@@ -1011,6 +1011,7 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
 		return 0;
 
 	case V4L2_SEL_TGT_CROP_DEFAULT:
+	case V4L2_SEL_TGT_CROP_BOUNDS:
 		sel->r.top = IMX219_PIXEL_ARRAY_TOP;
 		sel->r.left = IMX219_PIXEL_ARRAY_LEFT;
 		sel->r.width = IMX219_PIXEL_ARRAY_WIDTH;
-- 
2.17.1


--9paOwHGdOE9sWMx0ZoRN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6235): https://lists.cip-project.org/g/cip-dev/message=
/6235
Mute This Topic: https://lists.cip-project.org/mt/81205366/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9paOwHGdOE9sWMx0ZoRN--
