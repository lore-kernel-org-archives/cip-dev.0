Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD170C3DA61
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:57:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.5616.1721116633873208043
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211463357"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 16:57:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8A74F41CF909;
	Tue, 16 Jul 2024 16:57:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 12/23] Input: da9063 - use dev_err_probe()
Date: Tue, 16 Jul 2024 08:56:17 +0100
Message-ID: <20240716075641.32177-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:57:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16512

commit c67f8a13be4e9ffc862c7f60ec97a799a1547486 upstream.

Replace dev_err()->dev_err_probe() to simplify probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20231213214803.9931-4-biju.das.jz@bp.renesas.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/input/misc/da9063_onkey.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 5483a0576155..a8b7f1cd0ec2 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -195,10 +195,9 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 	onkey->dev = &pdev->dev;
 
 	onkey->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!onkey->regmap) {
-		dev_err(&pdev->dev, "Parent regmap unavailable.\n");
-		return -ENXIO;
-	}
+	if (!onkey->regmap)
+		return dev_err_probe(&pdev->dev, -ENXIO,
+				     "Parent regmap unavailable.\n");
 
 	onkey->key_power = !of_property_read_bool(pdev->dev.of_node,
 						  "dlg,disable-key-power");
@@ -228,11 +227,9 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 					  NULL, da9063_onkey_irq_handler,
 					  IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 					  "ONKEY", onkey);
-	if (error) {
-		dev_err(&pdev->dev,
-			"Failed to request IRQ %d: %d\n", irq, error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "Failed to allocate onkey IRQ\n");
 
 	error = dev_pm_set_wake_irq(&pdev->dev, irq);
 	if (error)
-- 
2.43.0


