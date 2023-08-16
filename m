Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC66C04E69
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162057.1692195660973914437
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100225"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 01DCA4210C24;
	Wed, 16 Aug 2023 23:21:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/31] rtc: rtc_update_irq_enable: rework UIE emulation
Date: Wed, 16 Aug 2023 15:20:03 +0100
Message-Id: <20230816142017.147173-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12699

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit c55c3a516ceff3a041d5e3253d4d9a1b75fbb1d8 upstream.

Now that the core is aware of whether alarms are available, it is possible
to decide whether UIE emulation is required before actually trying to set
the alarm.

This greatly simplifies rtc_update_irq_enable because there is now only one
error value to track and is not relying on the return value of
__rtc_set_alarm anymore.

Tested-by: Łukasz Stelmach <l.stelmach@samsung.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20210418000023.995758-3-alexandre.belloni@bootlin.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/interface.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 4bd6dd09a1b5..3ee17c4d7298 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -545,7 +545,7 @@ EXPORT_SYMBOL_GPL(rtc_alarm_irq_enable);
 
 int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 {
-	int rc = 0, err;
+	int err;
 
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
@@ -561,17 +561,21 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 	if (rtc->uie_rtctimer.enabled == enabled)
 		goto out;
 
-	if (rtc->uie_unsupported) {
-		err = -EINVAL;
-		goto out;
+	if (rtc->uie_unsupported || !test_bit(RTC_FEATURE_ALARM, rtc->features)) {
+		mutex_unlock(&rtc->ops_lock);
+#ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
+		return rtc_dev_update_irq_enable_emul(rtc, enabled);
+#else
+		return -EINVAL;
+#endif
 	}
 
 	if (enabled) {
 		struct rtc_time tm;
 		ktime_t now, onesec;
 
-		rc = __rtc_read_time(rtc, &tm);
-		if (rc)
+		err = __rtc_read_time(rtc, &tm);
+		if (err)
 			goto out;
 		onesec = ktime_set(1, 0);
 		now = rtc_tm_to_ktime(tm);
@@ -585,24 +589,6 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 out:
 	mutex_unlock(&rtc->ops_lock);
 
-	/*
-	 * __rtc_read_time() failed, this probably means that the RTC time has
-	 * never been set or less probably there is a transient error on the
-	 * bus. In any case, avoid enabling emulation has this will fail when
-	 * reading the time too.
-	 */
-	if (rc)
-		return rc;
-
-#ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
-	/*
-	 * Enable emulation if the driver returned -EINVAL to signal that it has
-	 * been configured without interrupts or they are not available at the
-	 * moment.
-	 */
-	if (err == -EINVAL)
-		err = rtc_dev_update_irq_enable_emul(rtc, enabled);
-#endif
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_update_irq_enable);
-- 
2.25.1


