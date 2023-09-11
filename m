Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED28EE57DF
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 14:47:12 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.60522.1694443629451194136
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 07:47:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="179428504"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2023 23:47:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5025A4004940;
	Mon, 11 Sep 2023 23:47:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/15] rtc: destroy mutex when releasing the device
Date: Mon, 11 Sep 2023 15:46:49 +0100
Message-Id: <20230911144702.948246-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
References: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 14:47:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13026

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
index 625effe6cb65..f46160d76b65 100644
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


