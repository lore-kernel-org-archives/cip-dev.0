Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5261EEB581
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 16:29:05 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1254.1694449742861762548
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 09:29:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="175711389"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Sep 2023 01:29:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8CCFC401D159;
	Tue, 12 Sep 2023 01:29:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/14] rtc: isl1208: Simplify probe()
Date: Mon, 11 Sep 2023 17:28:34 +0100
Message-Id: <20230911162840.1115401-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
References: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 16:29:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13048

commit b7f73b6e921b457a222e86cf53fe3950c6b5aed5 upstream.

Simplify the probe() by replacing of_device_get_match_data() and
i2c_match_id() by i2c_get_match_data() as we have similar I2C
and DT-based matching table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230710114747.106496-1-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index b8cb99810ce4..2fccfadb5564 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -862,15 +862,9 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	i2c_set_clientdata(client, isl1208);
 
 	/* Determine which chip we have */
-	if (client->dev.of_node) {
-		isl1208->config = of_device_get_match_data(&client->dev);
-		if (!isl1208->config)
-			return -ENODEV;
-	} else {
-		if (!id)
-			return -ENODEV;
-		isl1208->config = (struct isl1208_config *)id->driver_data;
-	}
+	isl1208->config = i2c_get_match_data(client);
+	if (!isl1208->config)
+		return -ENODEV;
 
 	rc = isl1208_clk_present(client, "xin");
 	if (rc < 0)
-- 
2.25.1


