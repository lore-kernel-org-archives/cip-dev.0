Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CCAC41513
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5823.1721118199820537896
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211467700"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 947FC4005B53;
	Tue, 16 Jul 2024 17:23:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/31] mfd: da9062: Simplify obtaining I2C match data
Date: Tue, 16 Jul 2024 09:22:20 +0100
Message-ID: <20240716082255.56551-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16535

commit 9b413e3c07d251191410976d669260079b48e7b1 upstream.

Simplify probe() by replacing of_device_get_match_data() and ID lookup for
retrieving match data by i2c_get_match_data().

Some minor cleanups:
 * Remove the trailing comma in the terminator entry for the ID
   table making code robust against (theoretical) misrebases or other
   similar things where the new entry goes _after_ the termination without
   the compiler noticing.
 * Move OF table near to the user.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231204124507.124758-1-biju.das.jz@bp.renesas.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/da9062-core.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index f821ef4909ec..3ee320160d4d 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -588,13 +588,6 @@ static struct regmap_config da9062_regmap_config = {
 	.volatile_table = &da9062_aa_volatile_table,
 };
 
-static const struct of_device_id da9062_dt_ids[] = {
-	{ .compatible = "dlg,da9061", .data = (void *)COMPAT_TYPE_DA9061, },
-	{ .compatible = "dlg,da9062", .data = (void *)COMPAT_TYPE_DA9062, },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, da9062_dt_ids);
-
 static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
@@ -611,10 +604,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (!chip)
 		return -ENOMEM;
 
-	if (i2c->dev.of_node)
-		chip->chip_type = (uintptr_t)of_device_get_match_data(&i2c->dev);
-	else
-		chip->chip_type = id->driver_data;
+	chip->chip_type = (uintptr_t)i2c_get_match_data(i2c);
 
 	i2c_set_clientdata(i2c, chip);
 	chip->dev = &i2c->dev;
@@ -716,10 +706,17 @@ static int da9062_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+static const struct of_device_id da9062_dt_ids[] = {
+	{ .compatible = "dlg,da9061", .data = (void *)COMPAT_TYPE_DA9061 },
+	{ .compatible = "dlg,da9062", .data = (void *)COMPAT_TYPE_DA9062 },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da9062_dt_ids);
+
 static const struct i2c_device_id da9062_i2c_id[] = {
 	{ "da9061", COMPAT_TYPE_DA9061 },
 	{ "da9062", COMPAT_TYPE_DA9062 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9062_i2c_id);
 
-- 
2.43.0


