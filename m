Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE90C3DA61
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:57:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5547.1721116624413327341
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:57:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215421595"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 16:57:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 198D341CFC51;
	Tue, 16 Jul 2024 16:57:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/23] pinctrl: da9062: Add OF table
Date: Tue, 16 Jul 2024 08:56:13 +0100
Message-ID: <20240716075641.32177-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:57:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16508

commit 26fea220ad5b97b448741eb6103bb49830b67eb2 upstream.

Add OF table as per the binding so that driver get instantiated and
bind automatically when the driver is built as a module.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240226191607.397386-1-biju.das.jz@bp.renesas.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/pinctrl-da9062.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-da9062.c b/drivers/pinctrl/pinctrl-da9062.c
index 0e0ac3f3ffef..e5c0ad22b759 100644
--- a/drivers/pinctrl/pinctrl-da9062.c
+++ b/drivers/pinctrl/pinctrl-da9062.c
@@ -286,10 +286,17 @@ static int da9062_pctl_probe(struct platform_device *pdev)
 	return devm_gpiochip_add_data(&pdev->dev, &pctl->gc, pctl);
 }
 
+static const struct of_device_id da9062_compatible_reg_id_table[] = {
+	{ .compatible = "dlg,da9062-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da9062_compatible_reg_id_table);
+
 static struct platform_driver da9062_pctl_driver = {
 	.probe = da9062_pctl_probe,
 	.driver = {
 		.name	= "da9062-gpio",
+		.of_match_table = da9062_compatible_reg_id_table,
 	},
 };
 module_platform_driver(da9062_pctl_driver);
-- 
2.43.0


