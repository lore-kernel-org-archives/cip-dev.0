Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8EAC3DA59
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:57:17 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5547.1721116624413327341
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:57:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215421608"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 16:57:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D2D1941CF65A;
	Tue, 16 Jul 2024 16:57:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 10/23] Input: da9063 - simplify obtaining OF match data
Date: Tue, 16 Jul 2024 08:56:15 +0100
Message-ID: <20240716075641.32177-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:57:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16510

commit 9594f273fafe76663e502337eaf393dc4f7bf8fa upstream.

Simplify probe() by replacing of_match_node() for retrieving match data by
device_get_match_data().

Some minor cleanups:
 * Remove the trailing comma in the terminator entry for the OF
   table making code robust against (theoretical) misrebases or other
   similar things where the new entry goes _after_ the termination without
   the compiler noticing.
 * Move OF table near to the user.
 * Arrange variables in reverse xmas tree order in probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20231213214803.9931-2-biju.das.jz@bp.renesas.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/input/misc/da9063_onkey.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 74808bae326a..9351ce0bb405 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -74,13 +74,6 @@ static const struct da906x_chip_config da9062_regs = {
 	.name = "da9062-onkey",
 };
 
-static const struct of_device_id da9063_compatible_reg_id_table[] = {
-	{ .compatible = "dlg,da9063-onkey", .data = &da9063_regs },
-	{ .compatible = "dlg,da9062-onkey", .data = &da9062_regs },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, da9063_compatible_reg_id_table);
-
 static void da9063_poll_on(struct work_struct *work)
 {
 	struct da9063_onkey *onkey = container_of(work,
@@ -187,14 +180,8 @@ static irqreturn_t da9063_onkey_irq_handler(int irq, void *data)
 static int da9063_onkey_probe(struct platform_device *pdev)
 {
 	struct da9063_onkey *onkey;
-	const struct of_device_id *match;
-	int irq;
 	int error;
-
-	match = of_match_node(da9063_compatible_reg_id_table,
-			      pdev->dev.of_node);
-	if (!match)
-		return -ENXIO;
+	int irq;
 
 	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
 			     GFP_KERNEL);
@@ -203,7 +190,10 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	onkey->config = match->data;
+	onkey->config = device_get_match_data(&pdev->dev);
+	if (!onkey->config)
+		return -ENXIO;
+
 	onkey->dev = &pdev->dev;
 
 	onkey->regmap = dev_get_regmap(pdev->dev.parent, NULL);
@@ -270,6 +260,13 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id da9063_compatible_reg_id_table[] = {
+	{ .compatible = "dlg,da9063-onkey", .data = &da9063_regs },
+	{ .compatible = "dlg,da9062-onkey", .data = &da9062_regs },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da9063_compatible_reg_id_table);
+
 static struct platform_driver da9063_onkey_driver = {
 	.probe	= da9063_onkey_probe,
 	.driver	= {
-- 
2.43.0


