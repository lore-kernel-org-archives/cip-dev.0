Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A24C41513
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:57:17 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5547.1721116624413327341
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:57:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215421614"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 16:57:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3984F41CF65A;
	Tue, 16 Jul 2024 16:57:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/23] Input: da9063 - drop redundant prints in probe()
Date: Tue, 16 Jul 2024 08:56:16 +0100
Message-ID: <20240716075641.32177-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:57:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16511

commit bd2334eda183a2888b5541605b39617c1e6b4b71 upstream.

The memory allocation core code already prints error message in case of
OOM. So, drop additional print messages for OOM cases.

While at it, input_register_device() is already printing error messages on
failure. Drop the redundant print.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20231213214803.9931-3-biju.das.jz@bp.renesas.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/input/misc/da9063_onkey.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 9351ce0bb405..5483a0576155 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -185,10 +185,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 
 	onkey = devm_kzalloc(&pdev->dev, sizeof(struct da9063_onkey),
 			     GFP_KERNEL);
-	if (!onkey) {
-		dev_err(&pdev->dev, "Failed to allocate memory.\n");
+	if (!onkey)
 		return -ENOMEM;
-	}
 
 	onkey->config = device_get_match_data(&pdev->dev);
 	if (!onkey->config)
@@ -206,10 +204,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 						  "dlg,disable-key-power");
 
 	onkey->input = devm_input_allocate_device(&pdev->dev);
-	if (!onkey->input) {
-		dev_err(&pdev->dev, "Failed to allocated input device.\n");
+	if (!onkey->input)
 		return -ENOMEM;
-	}
 
 	onkey->input->name = onkey->config->name;
 	snprintf(onkey->phys, sizeof(onkey->phys), "%s/input0",
@@ -221,12 +217,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 
 	error = devm_delayed_work_autocancel(&pdev->dev, &onkey->work,
 					     da9063_poll_on);
-	if (error) {
-		dev_err(&pdev->dev,
-			"Failed to add cancel poll action: %d\n",
-			error);
+	if (error)
 		return error;
-	}
 
 	irq = platform_get_irq_byname(pdev, "ONKEY");
 	if (irq < 0)
@@ -251,11 +243,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, true);
 
 	error = input_register_device(onkey->input);
-	if (error) {
-		dev_err(&pdev->dev,
-			"Failed to register input device: %d\n", error);
+	if (error)
 		return error;
-	}
 
 	return 0;
 }
-- 
2.43.0


