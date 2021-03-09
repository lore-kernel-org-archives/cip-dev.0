Return-Path: <SRS0=Clre=IH=lists.cip-project.org=bounce+64572+6232+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DD8C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7699651BB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7699651BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6232+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bJQ5YY4521723xQVQmULB90k; Tue, 09 Mar 2021 08:37:21 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:21 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591014"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:20 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9BC3F40A2DC7;
	Wed, 10 Mar 2021 01:37:19 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 16/40] media: i2c: imx219: Add support for cropped 640x480 resolution
Date: Tue,  9 Mar 2021 16:36:32 +0000
Message-Id: <20210309163656.20944-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fqazarkggAIadYYleS6oAoimx4520388AA=
Content-Type: multipart/mixed; boundary="xJoCabcVFo69BJxPrd4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307841;
 bh=oDuV6AB+rnz3wWpkflSN5OfwC7brvCLbSoXC821nmaA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KDzcGg/GBlhOpGrq3osJlBb7630YdN2/y0HRvu0xrLLaebD+NM0iQPTCMK4+SDKXKib
 DFvlv7PPOCBQAcxPZDr0d9hbzTNErYFJ/y2/qPYTEiU5UgiIti9JdYskqr2ywcfzORVWD
 5RpZ4e68w96Yg5NSFTWXGh51M3nSBIQZ1JQ=

--xJoCabcVFo69BJxPrd4F

commit 25130b8ad409d5532f3763bcf891af74f550a70d upstream.

This patch adds mode table entry for capturing cropped 640x480 resolution

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 70 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index d94c94c38e75..e2db55f70cd6 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -55,6 +55,7 @@
 #define IMX219_VTS_15FPS		0x0dc6
 #define IMX219_VTS_30FPS_1080P		0x06e3
 #define IMX219_VTS_30FPS_BINNED		0x06e3
+#define IMX219_VTS_30FPS_640x480	0x06e3
 #define IMX219_VTS_MAX			0xffff
 
 #define IMX219_VBLANK_MIN		4
@@ -139,7 +140,7 @@ struct imx219_mode {
 /*
  * Register sets lifted off the i2C interface from the Raspberry Pi firmware
  * driver.
- * 3280x2464 = mode 2, 1920x1080 = mode 1, and 1640x1232 = mode 4.
+ * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
  */
 static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x0100, 0x00},
@@ -314,6 +315,63 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 	{0x0163, 0x78},
 };
 
+static const struct imx219_reg mode_640_480_regs[] = {
+	{0x0100, 0x00},
+	{0x30eb, 0x05},
+	{0x30eb, 0x0c},
+	{0x300a, 0xff},
+	{0x300b, 0xff},
+	{0x30eb, 0x05},
+	{0x30eb, 0x09},
+	{0x0114, 0x01},
+	{0x0128, 0x00},
+	{0x012a, 0x18},
+	{0x012b, 0x00},
+	{0x0162, 0x0d},
+	{0x0163, 0x78},
+	{0x0164, 0x03},
+	{0x0165, 0xe8},
+	{0x0166, 0x08},
+	{0x0167, 0xe7},
+	{0x0168, 0x02},
+	{0x0169, 0xf0},
+	{0x016a, 0x06},
+	{0x016b, 0xaf},
+	{0x016c, 0x02},
+	{0x016d, 0x80},
+	{0x016e, 0x01},
+	{0x016f, 0xe0},
+	{0x0170, 0x01},
+	{0x0171, 0x01},
+	{0x0174, 0x03},
+	{0x0175, 0x03},
+	{0x0301, 0x05},
+	{0x0303, 0x01},
+	{0x0304, 0x03},
+	{0x0305, 0x03},
+	{0x0306, 0x00},
+	{0x0307, 0x39},
+	{0x030b, 0x01},
+	{0x030c, 0x00},
+	{0x030d, 0x72},
+	{0x0624, 0x06},
+	{0x0625, 0x68},
+	{0x0626, 0x04},
+	{0x0627, 0xd0},
+	{0x455e, 0x00},
+	{0x471e, 0x4b},
+	{0x4767, 0x0f},
+	{0x4750, 0x14},
+	{0x4540, 0x00},
+	{0x47b4, 0x14},
+	{0x4713, 0x30},
+	{0x478b, 0x10},
+	{0x478f, 0x10},
+	{0x4793, 0x10},
+	{0x4797, 0x0e},
+	{0x479b, 0x0e},
+};
+
 static const struct imx219_reg raw8_framefmt_regs[] = {
 	{0x018c, 0x08},
 	{0x018d, 0x08},
@@ -432,6 +490,16 @@ static const struct imx219_mode supported_modes[] = {
 			.regs = mode_1640_1232_regs,
 		},
 	},
+	{
+		/* 640x480 30fps mode */
+		.width = 640,
+		.height = 480,
+		.vts_def = IMX219_VTS_30FPS_640x480,
+		.reg_list = {
+			.num_of_regs = ARRAY_SIZE(mode_640_480_regs),
+			.regs = mode_640_480_regs,
+		},
+	},
 };
 
 struct imx219 {
-- 
2.17.1


--xJoCabcVFo69BJxPrd4F
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6232): https://lists.cip-project.org/g/cip-dev/message=
/6232
Mute This Topic: https://lists.cip-project.org/mt/81205361/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--xJoCabcVFo69BJxPrd4F--
