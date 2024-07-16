Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC4C3DA62
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5832.1721118220324006117
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211467740"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 14FCF4016D5E;
	Tue, 16 Jul 2024 17:23:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 18/31] Input: da9063 - add wakeup support
Date: Tue, 16 Jul 2024 09:22:29 +0100
Message-ID: <20240716082255.56551-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16544

From: Samuel Holland <samuel.holland@sifive.com>

commit d7781232b5b2d049e654d5ead9921dc49090d214 upstream.

Mark the IRQ as a wake IRQ so it will be enabled during system suspend.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://lore.kernel.org/r/20230717192004.1304287-1-samuel.holland@sifive.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/input/misc/da9063_onkey.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index 79851923ee57..b9fbc62d29ab 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -9,6 +9,7 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/workqueue.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
@@ -258,6 +259,14 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	error = dev_pm_set_wake_irq(&pdev->dev, irq);
+	if (error)
+		dev_warn(&pdev->dev,
+			 "Failed to set IRQ %d as a wake IRQ: %d\n",
+			 irq, error);
+	else
+		device_init_wakeup(&pdev->dev, true);
+
 	error = input_register_device(onkey->input);
 	if (error) {
 		dev_err(&pdev->dev,
-- 
2.43.0


