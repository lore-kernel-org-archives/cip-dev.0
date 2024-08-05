Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6462EC3DA4A
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:43:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12805.1722876236021140179
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:43:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="214739886"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Aug 2024 01:43:57 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 06FA54020F32;
	Tue,  6 Aug 2024 01:43:55 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/30] media: i2c: ov5645: Remove software reset entry from ov5645_global_init_setting
Date: Mon,  5 Aug 2024 17:42:59 +0100
Message-ID: <20240805164342.211857-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:43:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16728

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
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index c8999fc4f26f..8e1ce1741cbe 100644
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


