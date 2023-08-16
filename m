Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7923CC04FDF
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161767.1692195674774557236
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787716"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 49D034210C2B;
	Wed, 16 Aug 2023 23:21:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 25/31] rtc: isl1208: Make similar I2C and DT-based matching table
Date: Wed, 16 Aug 2023 15:20:11 +0100
Message-Id: <20230816142017.147173-26-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12707

commit fbc06a53561c64ec6d7f9a1b3bc04597de4cbb2d upstream.

The isl1208_id[].driver_data could store a pointer to the config,
like for DT-based matching, making I2C and DT-based matching
more similar.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230623140948.384762-8-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 1716c0c3b550..67487a784e58 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -90,10 +90,10 @@ static const struct isl1208_config {
 };
 
 static const struct i2c_device_id isl1208_id[] = {
-	{ "isl1208", TYPE_ISL1208 },
-	{ "isl1209", TYPE_ISL1209 },
-	{ "isl1218", TYPE_ISL1218 },
-	{ "isl1219", TYPE_ISL1219 },
+	{ "isl1208", .driver_data = (kernel_ulong_t)&isl1208_configs[TYPE_ISL1208] },
+	{ "isl1209", .driver_data = (kernel_ulong_t)&isl1208_configs[TYPE_ISL1209] },
+	{ "isl1218", .driver_data = (kernel_ulong_t)&isl1208_configs[TYPE_ISL1218] },
+	{ "isl1219", .driver_data = (kernel_ulong_t)&isl1208_configs[TYPE_ISL1219] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl1208_id);
@@ -820,9 +820,9 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (!isl1208->config)
 			return -ENODEV;
 	} else {
-		if (id->driver_data >= ISL_LAST_ID)
+		if (!id)
 			return -ENODEV;
-		isl1208->config = &isl1208_configs[id->driver_data];
+		isl1208->config = (struct isl1208_config *)id->driver_data;
 	}
 
 	isl1208->rtc = devm_rtc_allocate_device(&client->dev);
-- 
2.25.1


