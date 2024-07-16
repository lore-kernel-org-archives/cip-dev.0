Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8ABC3DA49
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5927.1721118184270232470
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215426015"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1EBB24016D5E;
	Tue, 16 Jul 2024 17:23:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/31] rtc: da9063: add as wakeup source
Date: Tue, 16 Jul 2024 09:22:22 +0100
Message-ID: <20240716082255.56551-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16537

From: Nikita Shubin <nikita.shubin@maquefel.me>

commit 029d3a6f2f3c73ac29a7460d8007798e940488fd upstream.

As da9063 RTC is not a real I2C client, but relies on da9063 MFD
driver, we need to explicitly mark da9063 RTC as a wakeup source
to be able to access class/rtc/rtcN/wakealarm sysfs entry
to set alarms, so we can wakeup from SHUTDOWN/RTC/DELIVERY mode.

As da9063 driver refuses to load without irq, we simply add it
as a wakeup source before registering rtc device.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20211129072650.22686-1-nikita.shubin@maquefel.me
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-da9063.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 6f0a3a711135..490ba89efa41 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -494,6 +494,8 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
 			irq_alarm, ret);
 
+	device_init_wakeup(&pdev->dev, true);
+
 	return rtc_register_device(rtc->rtc_dev);
 }
 
-- 
2.43.0


