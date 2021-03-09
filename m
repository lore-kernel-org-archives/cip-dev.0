Return-Path: <SRS0=XdTG=IH=lists.cip-project.org=bounce+64572+6230+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B003C433E9
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E11664F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E11664F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6230+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MbdHYY4521723xrmaxK1uC7A; Tue, 09 Mar 2021 08:37:18 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:18 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591011"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:17 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E779040A2DC7;
	Wed, 10 Mar 2021 01:37:16 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 14/40] media: i2c: imx219: Fix power sequence
Date: Tue,  9 Mar 2021 16:36:30 +0000
Message-Id: <20210309163656.20944-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: k4wo9c53nYPIxF0dmvgSBzXjx4520388AA=
Content-Type: multipart/mixed; boundary="1SldebL0YMIF34hZHMSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307838;
 bh=9pJPujmNlRV6uxBx0yrcYxMphY4+zuTqwTVkgLRl/Ys=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OA4ZTNQJc2r2qLIg6SvuvujMOxWIuAOqijBii4o6fK6i3bcFRD8WdVtlZal1WKqhio+
 G4b68KHJBGFvoSfG+FAXdqAs6ObCsgM8u3bS0HokqP3zgc6kPkA1ODVKO4z9Q994gLiCw
 f/y1zLUcCVCjPn0zpc8zBX7S7hEORvG0cn4=

--1SldebL0YMIF34hZHMSE

commit ca45448a56659c6df6e0436188e97f6cc65dea8a upstream.

When supporting Rpi Camera v2 Module on the RZ/G2E, found the driver had
some issues with rcar mipi-csi driver. The sensor never entered into LP-11
state.

The powerup sequence in the datasheet[1] shows the sensor entering into
LP-11 in streaming mode, so to fix this issue transitions are performed
from "streaming -> standby" in the probe() after power up.

With this commit the sensor is able to enter LP-11 mode during power up,
as expected by some CSI-2 controllers.

[1] https://publiclab.org/system/images/photos/000/023/294/original/
RASPBERRY_PI_CAMERA_V2_DATASHEET_IMX219PQH5_7.0.0_Datasheet_XXX.PDF

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index c67b2cf5c32c..f1ae93569542 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1224,6 +1224,23 @@ static int imx219_probe(struct i2c_client *client)
 	/* Set default mode to max resolution */
 	imx219->mode = &supported_modes[0];
 
+	/* sensor doesn't enter LP-11 state upon power up until and unless
+	 * streaming is started, so upon power up switch the modes to:
+	 * streaming -> standby
+	 */
+	ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
+			       IMX219_REG_VALUE_08BIT, IMX219_MODE_STREAMING);
+	if (ret < 0)
+		goto error_power_off;
+	usleep_range(100, 110);
+
+	/* put sensor back to standby mode */
+	ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
+			       IMX219_REG_VALUE_08BIT, IMX219_MODE_STANDBY);
+	if (ret < 0)
+		goto error_power_off;
+	usleep_range(100, 110);
+
 	ret = imx219_init_controls(imx219);
 	if (ret)
 		goto error_power_off;
-- 
2.17.1


--1SldebL0YMIF34hZHMSE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6230): https://lists.cip-project.org/g/cip-dev/message=
/6230
Mute This Topic: https://lists.cip-project.org/mt/81205358/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1SldebL0YMIF34hZHMSE--
