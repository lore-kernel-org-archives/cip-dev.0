Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0584EEB581
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 16:28:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1244.1694449726915033024
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 09:28:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="179434712"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Sep 2023 01:28:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6EEB9401D15B;
	Tue, 12 Sep 2023 01:28:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/14] i2c: Add i2c_get_match_data()
Date: Mon, 11 Sep 2023 17:28:27 +0100
Message-Id: <20230911162840.1115401-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
References: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 16:28:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13041

commit 564d73c4d9201526bd976b9379d2aaf1a7133e84 upstream.

Add i2c_get_match_data() to get match data for I2C, ACPI and
DT-based matching, so that we can optimize the driver code.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[wsa: simplified var initialization]
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/i2c/i2c-core-base.c | 19 +++++++++++++++++++
 include/linux/i2c.h         |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 7539b0740351..77591a89e07b 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -113,6 +113,25 @@ const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 }
 EXPORT_SYMBOL_GPL(i2c_match_id);
 
+const void *i2c_get_match_data(const struct i2c_client *client)
+{
+	struct i2c_driver *driver = to_i2c_driver(client->dev.driver);
+	const struct i2c_device_id *match;
+	const void *data;
+
+	data = device_get_match_data(&client->dev);
+	if (!data) {
+		match = i2c_match_id(driver->id_table, client);
+		if (!match)
+			return NULL;
+
+		data = (const void *)match->driver_data;
+	}
+
+	return data;
+}
+EXPORT_SYMBOL(i2c_get_match_data);
+
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f7c49bbdb8a1..fe92fba41104 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -362,6 +362,8 @@ struct i2c_adapter *i2c_verify_adapter(struct device *dev);
 const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 					 const struct i2c_client *client);
 
+const void *i2c_get_match_data(const struct i2c_client *client);
+
 static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
 {
 	struct device * const dev = kobj_to_dev(kobj);
-- 
2.25.1


