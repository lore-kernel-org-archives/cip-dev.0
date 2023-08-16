Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5BDC04E69
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161754.1692195654103012015
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787681"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E0DF24210C28;
	Wed, 16 Aug 2023 23:20:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 13/31] rtc: class: don't call cdev_device_del() when cdev_device_add() failed
Date: Wed, 16 Aug 2023 15:19:59 +0100
Message-Id: <20230816142017.147173-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12695

From: Yang Yingliang <yangyingliang@huawei.com>

commit 789c1093f02c436b320d78a739f9610c8271cb73 upstream.

I got a null-ptr-deref report when doing fault injection test:

general protection fault, probably for non-canonical address 0xdffffc0000000022: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000110-0x0000000000000117]
RIP: 0010:device_del+0x132/0xdc0
Call Trace:
 cdev_device_del+0x1a/0x80
 devm_rtc_unregister_device+0x37/0x80
 release_nodes+0xc3/0x3b0

If cdev_device_add() fails, 'dev->p' is not set, it causes
null-ptr-deref when calling cdev_device_del(). Registering
character device is optional, we don't return error code
here, so introduce a new flag 'RTC_NO_CDEV' to indicate
if it has character device, cdev_device_del() is called
when this bit is not set.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20211011132114.3663509-1-yangyingliang@huawei.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c | 9 ++++++---
 include/linux/rtc.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index c8f4ba8b91e7..99ee40642cb6 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -343,7 +343,8 @@ static void devm_rtc_unregister_device(void *data)
 	 * letting any rtc_class_open() users access it again
 	 */
 	rtc_proc_del_device(rtc);
-	cdev_device_del(&rtc->char_dev, &rtc->dev);
+	if (!test_bit(RTC_NO_CDEV, &rtc->flags))
+		cdev_device_del(&rtc->char_dev, &rtc->dev);
 	rtc->ops = NULL;
 	mutex_unlock(&rtc->ops_lock);
 }
@@ -406,12 +407,14 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 	rtc_dev_prepare(rtc);
 
 	err = cdev_device_add(&rtc->char_dev, &rtc->dev);
-	if (err)
+	if (err) {
+		set_bit(RTC_NO_CDEV, &rtc->flags);
 		dev_warn(rtc->dev.parent, "failed to add char device %d:%d\n",
 			 MAJOR(rtc->dev.devt), rtc->id);
-	else
+	} else {
 		dev_dbg(rtc->dev.parent, "char device (%d:%d)\n",
 			MAJOR(rtc->dev.devt), rtc->id);
+	}
 
 	rtc_proc_add_device(rtc);
 
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 31d2a856041b..72851fe4f8e7 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -80,6 +80,7 @@ struct rtc_timer {
 
 /* flags */
 #define RTC_DEV_BUSY 0
+#define RTC_NO_CDEV  1
 
 struct rtc_device {
 	struct device dev;
-- 
2.25.1


