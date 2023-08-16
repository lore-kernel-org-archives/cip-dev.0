Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69765C001E0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162042.1692195642925975488
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100204"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:44 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E86784210C24;
	Wed, 16 Aug 2023 23:20:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/31] rtc: shrink devm_rtc_allocate_device()
Date: Wed, 16 Aug 2023 15:19:55 +0100
Message-Id: <20230816142017.147173-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12691

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit 1bfc485b73579bff5326ac481fd9be7e24a5d5d1 upstream.

We don't need to use devres_alloc() & devres_add() manually if all we
want to manage is a single pointer. We can shrink the code by using
devm_add_action_or_reset() instead. The number of allocations stays
the same.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201109163409.24301-9-brgl@bgdev.pl
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 8f7b33a6cbe0..4fcd7014fe07 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -346,48 +346,37 @@ static void devm_rtc_unregister_device(void *data)
 	put_device(&rtc->dev);
 }
 
-static void devm_rtc_release_device(struct device *dev, void *res)
+static void devm_rtc_release_device(void *res)
 {
-	struct rtc_device *rtc = *(struct rtc_device **)res;
+	struct rtc_device *rtc = res;
 
 	put_device(&rtc->dev);
 }
 
 struct rtc_device *devm_rtc_allocate_device(struct device *dev)
 {
-	struct rtc_device **ptr, *rtc;
+	struct rtc_device *rtc;
 	int id, err;
 
 	id = rtc_device_get_id(dev);
 	if (id < 0)
 		return ERR_PTR(id);
 
-	ptr = devres_alloc(devm_rtc_release_device, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr) {
-		err = -ENOMEM;
-		goto exit_ida;
-	}
-
 	rtc = rtc_allocate_device();
 	if (!rtc) {
-		err = -ENOMEM;
-		goto exit_devres;
+		ida_simple_remove(&rtc_ida, id);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	*ptr = rtc;
-	devres_add(dev, ptr);
-
 	rtc->id = id;
 	rtc->dev.parent = dev;
 	dev_set_name(&rtc->dev, "rtc%d", id);
 
-	return rtc;
+	err = devm_add_action_or_reset(dev, devm_rtc_release_device, rtc);
+	if (err)
+		return ERR_PTR(err);
 
-exit_devres:
-	devres_free(ptr);
-exit_ida:
-	ida_simple_remove(&rtc_ida, id);
-	return ERR_PTR(err);
+	return rtc;
 }
 EXPORT_SYMBOL_GPL(devm_rtc_allocate_device);
 
-- 
2.25.1


