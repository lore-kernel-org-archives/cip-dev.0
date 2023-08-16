Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7200EC41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:49 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.162047.1692195647395999469
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787674"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 310D24210C24;
	Wed, 16 Aug 2023 23:20:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/31] rtc: destroy mutex when releasing the device
Date: Wed, 16 Aug 2023 15:19:56 +0100
Message-Id: <20230816142017.147173-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12692

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit 0d6d7a390b32ef23d957960d3bb8586a49d6af7c upstream.

Not destroying mutexes doesn't lead to resource leak but it's the correct
thing to do for mutex debugging accounting.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201110094205.8972-1-brgl@bgdev.pl
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 4fcd7014fe07..5a1de9078ae6 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -37,6 +37,7 @@ static void rtc_device_release(struct device *dev)
 	cancel_work_sync(&rtc->irqwork);
 
 	ida_simple_remove(&rtc_ida, rtc->id);
+	mutex_destroy(&rtc->ops_lock);
 	kfree(rtc);
 }
 
-- 
2.25.1


