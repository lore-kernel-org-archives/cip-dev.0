Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBD4C3DA5D
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5938.1721118211284299661
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215426026"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DF9CF4016D5E;
	Tue, 16 Jul 2024 17:23:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/31] rtc: da9063: Use device_get_match_data()
Date: Tue, 16 Jul 2024 09:22:25 +0100
Message-ID: <20240716082255.56551-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16540

commit 4b60c32e979ac84a715c329161ddf42b0790be4e upstream.

Replace of_match_node()->device_get_match_data() for
the data associated with device match.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240105145344.204453-3-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-da9063.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index baedcd15d8f2..b71e0920bb72 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -377,7 +377,6 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 {
 	struct da9063_compatible_rtc *rtc;
 	const struct da9063_compatible_rtc_regmap *config;
-	const struct of_device_id *match;
 	int irq_alarm;
 	u8 data[RTC_DATA_LEN];
 	int ret;
@@ -385,14 +384,11 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 	if (!pdev->dev.of_node)
 		return -ENXIO;
 
-	match = of_match_node(da9063_compatible_reg_id_table,
-			      pdev->dev.of_node);
-
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
-	rtc->config = match->data;
+	rtc->config = device_get_match_data(&pdev->dev);
 	if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
 		struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
 
-- 
2.43.0


