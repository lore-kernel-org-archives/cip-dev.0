Return-Path: <SRS0=BnZg=KH=lists.cip-project.org=bounce+64572+6449+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80620C433B4
	for <cip-dev@archiver.kernel.org>; Wed, 12 May 2021 17:01:38 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C8F611BF
	for <cip-dev@archiver.kernel.org>; Wed, 12 May 2021 17:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C8F611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6449+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id I3V7YY4521723x7wInoP93z4; Wed, 12 May 2021 10:01:35 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.572.1620838892338979272
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 May 2021 10:01:32 -0700
X-IronPort-AV: E=Sophos;i="5.82,293,1613401200"; 
   d="scan'208";a="80896438"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 May 2021 02:01:30 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DAE8140AB2F2;
	Thu, 13 May 2021 02:01:29 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/2] media: i2c: imx219: Move out locking/unlocking of vflip and hflip controls from imx219_set_stream
Date: Wed, 12 May 2021 18:01:26 +0100
Message-Id: <20210512170127.16390-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
X-Gm-Message-State: htxxNpYhXGKX5eNd4fCvBKnsx4520388AA=
Content-Type: multipart/mixed; boundary="nMcUrrqug26SbJrUm9UC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620838895;
 bh=aBNfmoEPe1xUgha1Qt5UCEQ0V26sBKGo5Pkrhd6dfAQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qRKmorR+s2oaJ97uZLh83Y5eObIUBw6WJXHVtjDTWNl3vqtnjXxcgiRrPMxiotkx4KI
 kb4Eoydd1bjwB3g5CPhNSQyiT5RZECtRtxewPJxvzjWedcmz1CY/sBZFLKBccbzHdktcj
 IYeQYujadNtrTx4tnFUaeGNqpsY961O5MtQ=

--nMcUrrqug26SbJrUm9UC

commit 745d4612d2c853c00abadbf69799c8aee7f99c39 upstream.

Move out locking/unlocking of vflip and hflip controls from
imx219_set_stream() to the imx219_start_streaming()/
imx219_stop_streaming() respectively.

This fixes an issue in resume callback error path where streaming is
stopped and the controls are left in locked state.

Fixes: 1283b3b8f82b9 ("media: i2c: Add driver for Sony IMX219 sensor")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index a2829c7012aa..d856019cb070 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1056,8 +1056,16 @@ static int imx219_start_streaming(struct imx219 *imx219)
 		return ret;
 
 	/* set stream on register */
-	return imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
-				IMX219_REG_VALUE_08BIT, IMX219_MODE_STREAMING);
+	ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
+			       IMX219_REG_VALUE_08BIT, IMX219_MODE_STREAMING);
+	if (ret)
+		return ret;
+
+	/* vflip and hflip cannot change during streaming */
+	__v4l2_ctrl_grab(imx219->vflip, true);
+	__v4l2_ctrl_grab(imx219->hflip, true);
+
+	return 0;
 }
 
 static void imx219_stop_streaming(struct imx219 *imx219)
@@ -1070,6 +1078,9 @@ static void imx219_stop_streaming(struct imx219 *imx219)
 			       IMX219_REG_VALUE_08BIT, IMX219_MODE_STANDBY);
 	if (ret)
 		dev_err(&client->dev, "%s failed to set stream\n", __func__);
+
+	__v4l2_ctrl_grab(imx219->vflip, false);
+	__v4l2_ctrl_grab(imx219->hflip, false);
 }
 
 static int imx219_set_stream(struct v4l2_subdev *sd, int enable)
@@ -1105,10 +1116,6 @@ static int imx219_set_stream(struct v4l2_subdev *sd, int enable)
 
 	imx219->streaming = enable;
 
-	/* vflip and hflip cannot change during streaming */
-	__v4l2_ctrl_grab(imx219->vflip, enable);
-	__v4l2_ctrl_grab(imx219->hflip, enable);
-
 	mutex_unlock(&imx219->mutex);
 
 	return ret;
-- 
2.17.1


--nMcUrrqug26SbJrUm9UC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6449): https://lists.cip-project.org/g/cip-dev/message=
/6449
Mute This Topic: https://lists.cip-project.org/mt/82777614/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nMcUrrqug26SbJrUm9UC--
