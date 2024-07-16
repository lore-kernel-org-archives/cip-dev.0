Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725F9C3DA49
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:38 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5828.1721118206600010734
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211467725"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4C81F4016D5E;
	Tue, 16 Jul 2024 17:23:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/31] rtc: da9063: Use dev_err_probe()
Date: Tue, 16 Jul 2024 09:22:26 +0100
Message-ID: <20240716082255.56551-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16541

commit f5334aa88345874d54a406e86a886a54173e1ba8 upstream.

Replace dev_err()->dev_err_probe() to simpilfy probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240105145344.204453-4-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-da9063.c | 42 ++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index b71e0920bb72..f1489127f937 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -407,57 +407,49 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 				 config->rtc_enable_reg,
 				 config->rtc_enable_mask,
 				 config->rtc_enable_mask);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to enable RTC\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Failed to enable RTC\n");
 
 	ret = regmap_update_bits(rtc->regmap,
 				 config->rtc_enable_32k_crystal_reg,
 				 config->rtc_crystal_mask,
 				 config->rtc_crystal_mask);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to run 32kHz oscillator\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to run 32kHz oscillator\n");
 
 	ret = regmap_update_bits(rtc->regmap,
 				 config->rtc_alarm_secs_reg,
 				 config->rtc_alarm_status_mask,
 				 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to access RTC alarm register\n");
 
 	ret = regmap_update_bits(rtc->regmap,
 				 config->rtc_alarm_secs_reg,
 				 DA9063_ALARM_STATUS_ALARM,
 				 DA9063_ALARM_STATUS_ALARM);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to access RTC alarm register\n");
 
 	ret = regmap_update_bits(rtc->regmap,
 				 config->rtc_alarm_year_reg,
 				 config->rtc_tick_on_mask,
 				 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to disable TICKs\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to disable TICKs\n");
 
 	data[RTC_SEC] = 0;
 	ret = regmap_bulk_read(rtc->regmap,
 			       config->rtc_alarm_secs_reg,
 			       &data[config->rtc_data_start],
 			       config->rtc_alarm_len);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to read initial alarm data: %d\n",
-			ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to read initial alarm data\n");
 
 	platform_set_drvdata(pdev, rtc);
 
-- 
2.43.0


