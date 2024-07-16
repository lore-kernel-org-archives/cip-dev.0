Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D767C3DA61
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:56:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5540.1721116607082293588
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:56:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211463314"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 16:56:54 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DDD4F41CF65A;
	Tue, 16 Jul 2024 16:56:52 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/23] rtc: da9063: Mark the alarm IRQ as a wake IRQ
Date: Tue, 16 Jul 2024 08:56:09 +0100
Message-ID: <20240716075641.32177-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:56:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16504

From: Samuel Holland <samuel.holland@sifive.com>

commit ed17a2bcbb75505bb979e3e8ecb6c5fb2518bf3b upstream.

This keeps the IRQ enabled during system suspend, if the RTC's wakeup
source is enabled. Since the IRQ is not required to wake from shutdown,
continue to add the wakeup source even if registering the wakeirq fails.
See commit 029d3a6f2f3c ("rtc: da9063: add as wakeup source").

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://lore.kernel.org/r/20230717190937.1301509-1-samuel.holland@sifive.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-da9063.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index ee2efb496174..2f5d60622564 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -496,6 +497,12 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
 			irq_alarm, ret);
 
+	ret = dev_pm_set_wake_irq(&pdev->dev, irq_alarm);
+	if (ret)
+		dev_warn(&pdev->dev,
+			 "Failed to set IRQ %d as a wake IRQ: %d\n",
+			 irq_alarm, ret);
+
 	device_init_wakeup(&pdev->dev, true);
 
 	return devm_rtc_register_device(rtc->rtc_dev);
-- 
2.43.0


