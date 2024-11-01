Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18636E6B260
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:58:05 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.36849.1730465882716997335
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:58:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,249,1725289200"; 
   d="scan'208";a="223655293"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Nov 2024 21:58:02 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2FA9540078C4;
	Fri,  1 Nov 2024 21:57:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 06/28] media: i2c: ov5645: Remove software reset entry from ov5645_global_init_setting
Date: Fri,  1 Nov 2024 12:57:24 +0000
Message-ID: <20241101125746.33222-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17137

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 25a3c0c7d0221465da5d89f9b6551a26ac12f9fd upstream.

The SYSTEM_CTRL0 register in ov5645 is almost similar to ov5640. But the
hard reset control is mandatory for the ov5645 device, so there is no
need for soft reset in the driver.

Add a 1msec delay for the software power up (OV5645_SYSTEM_CTRL0_START)
register in ov5645_global_init_setting. Without this delay sometimes the
image is not captured at all when the i2c frequency is 400kHz.

The changes are fixing both the greenish issue and image capture at 400kHz
i2c frequency on Renesas RZ/G2L SMARC EVK platforms.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 40e15a573964f..f681531a5df7c 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -118,7 +118,6 @@ static inline struct ov5645 *to_ov5645(struct v4l2_subdev *sd)
 
 static const struct reg_value ov5645_global_init_setting[] = {
 	{ 0x3103, 0x11 },
-	{ 0x3008, 0x82 },
 	{ 0x3008, 0x42 },
 	{ 0x3103, 0x03 },
 	{ 0x3503, 0x07 },
@@ -627,6 +626,10 @@ static int ov5645_set_register_array(struct ov5645 *ov5645,
 		ret = ov5645_write_reg(ov5645, settings->reg, settings->val);
 		if (ret < 0)
 			return ret;
+
+		if (settings->reg == OV5645_SYSTEM_CTRL0 &&
+		    settings->val == OV5645_SYSTEM_CTRL0_START)
+			usleep_range(1000, 2000);
 	}
 
 	return 0;
-- 
2.43.0


