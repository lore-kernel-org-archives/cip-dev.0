Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73666C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162042.1692195642925975488
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100210"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:49 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 699CC4210C24;
	Wed, 16 Aug 2023 23:20:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/31] rtc: fix RTC removal
Date: Wed, 16 Aug 2023 15:19:57 +0100
Message-Id: <20230816142017.147173-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12693

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit f70cc33029fca3cf62bffb15102ea42eb4d097ac upstream.

Since the rtc_register_device, removing an RTC device will end with a
refcount_t: underflow; use-after-free warning since put_device is called
twice in the device tear down path.

Fixes: fdcfd854333b ("rtc: rework rtc_register_device() resource management")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Link: https://lore.kernel.org/r/20201205231449.610980-1-alexandre.belloni@bootlin.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 5a1de9078ae6..34ee17019895 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -344,7 +344,6 @@ static void devm_rtc_unregister_device(void *data)
 	cdev_device_del(&rtc->char_dev, &rtc->dev);
 	rtc->ops = NULL;
 	mutex_unlock(&rtc->ops_lock);
-	put_device(&rtc->dev);
 }
 
 static void devm_rtc_release_device(void *res)
-- 
2.25.1


