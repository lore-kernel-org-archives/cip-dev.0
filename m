Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8F0C3DA49
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:57:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5611.1721116617818796811
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:56:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215421573"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 16:56:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2D72741CF65A;
	Tue, 16 Jul 2024 16:56:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/23] rtc: da9063: Make IRQ as optional
Date: Tue, 16 Jul 2024 08:56:10 +0100
Message-ID: <20240716075641.32177-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:57:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16505

commit 8681de6457aa071a5982e9b20682e56a7d87e3b6 upstream.

On some platforms (eg: RZ/{G2UL,Five} SMARC EVK), there is no IRQ
populated by default. Add irq optional support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240105145344.204453-2-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-da9063.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 2f5d60622564..b3a1f852c318 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -485,25 +485,29 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtc_dev->features);
 	}
 
-	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
-	if (irq_alarm < 0)
+	irq_alarm = platform_get_irq_byname_optional(pdev, "ALARM");
+	if (irq_alarm >= 0) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
+						da9063_alarm_event,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"ALARM", rtc);
+		if (ret)
+			dev_err(&pdev->dev,
+				"Failed to request ALARM IRQ %d: %d\n",
+				irq_alarm, ret);
+
+		ret = dev_pm_set_wake_irq(&pdev->dev, irq_alarm);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "Failed to set IRQ %d as a wake IRQ: %d\n",
+				 irq_alarm, ret);
+
+		device_init_wakeup(&pdev->dev, true);
+	}  else if (irq_alarm != -ENXIO) {
 		return irq_alarm;
-
-	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
-					da9063_alarm_event,
-					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					"ALARM", rtc);
-	if (ret)
-		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
-			irq_alarm, ret);
-
-	ret = dev_pm_set_wake_irq(&pdev->dev, irq_alarm);
-	if (ret)
-		dev_warn(&pdev->dev,
-			 "Failed to set IRQ %d as a wake IRQ: %d\n",
-			 irq_alarm, ret);
-
-	device_init_wakeup(&pdev->dev, true);
+	} else {
+		clear_bit(RTC_FEATURE_ALARM, rtc->rtc_dev->features);
+	}
 
 	return devm_rtc_register_device(rtc->rtc_dev);
 }
-- 
2.43.0


