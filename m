Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B92C04FE0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162042.1692195642925975488
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100215"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A68654210C25;
	Wed, 16 Aug 2023 23:20:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/31] rtc: introduce features bitfield
Date: Wed, 16 Aug 2023 15:19:58 +0100
Message-Id: <20230816142017.147173-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12694

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 7ae41220ef5831674f446baef19bfe1b31358260 upstream.

Introduce a bitfield to allow the drivers to announce the available
features for an RTC.

The main use case would be to better handle alarms, that could be present
or not or have a minute resolution or may need a correct week day to be set.

Use the newly introduced RTC_FEATURE_ALARM bit to then test whether alarms
are available instead of relying on the presence of ops->set_alarm.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20210110231752.1418816-2-alexandre.belloni@bootlin.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c      |  5 +++++
 drivers/rtc/interface.c  | 12 ++++++------
 include/linux/rtc.h      |  2 ++
 include/uapi/linux/rtc.h |  5 +++++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 34ee17019895..c8f4ba8b91e7 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -235,6 +235,8 @@ static struct rtc_device *rtc_allocate_device(void)
 	rtc->pie_timer.function = rtc_pie_update_irq;
 	rtc->pie_enabled = 0;
 
+	set_bit(RTC_FEATURE_ALARM, rtc->features);
+
 	return rtc;
 }
 
@@ -390,6 +392,9 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 		return -EINVAL;
 	}
 
+	if (!rtc->ops->set_alarm)
+		clear_bit(RTC_FEATURE_ALARM, rtc->features);
+
 	rtc->owner = owner;
 	rtc_device_get_offset(rtc);
 
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 146056858135..4bd6dd09a1b5 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -186,7 +186,7 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc,
 
 	if (!rtc->ops) {
 		err = -ENODEV;
-	} else if (!rtc->ops->read_alarm) {
+	} else if (!test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->read_alarm) {
 		err = -EINVAL;
 	} else {
 		alarm->enabled = 0;
@@ -392,7 +392,7 @@ int rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 		return err;
 	if (!rtc->ops) {
 		err = -ENODEV;
-	} else if (!rtc->ops->read_alarm) {
+	} else if (!test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->read_alarm) {
 		err = -EINVAL;
 	} else {
 		memset(alarm, 0, sizeof(struct rtc_wkalrm));
@@ -436,7 +436,7 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 	if (!rtc->ops)
 		err = -ENODEV;
-	else if (!rtc->ops->set_alarm)
+	else if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
 		err = -EINVAL;
 	else
 		err = rtc->ops->set_alarm(rtc->dev.parent, alarm);
@@ -451,7 +451,7 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 	if (!rtc->ops)
 		return -ENODEV;
-	else if (!rtc->ops->set_alarm)
+	else if (!test_bit(RTC_FEATURE_ALARM, rtc->features))
 		return -EINVAL;
 
 	err = rtc_valid_tm(&alarm->time);
@@ -531,7 +531,7 @@ int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		/* nothing */;
 	else if (!rtc->ops)
 		err = -ENODEV;
-	else if (!rtc->ops->alarm_irq_enable)
+	else if (!test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->alarm_irq_enable)
 		err = -EINVAL;
 	else
 		err = rtc->ops->alarm_irq_enable(rtc->dev.parent, enabled);
@@ -846,7 +846,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 
 static void rtc_alarm_disable(struct rtc_device *rtc)
 {
-	if (!rtc->ops || !rtc->ops->alarm_irq_enable)
+	if (!rtc->ops || !test_bit(RTC_FEATURE_ALARM, rtc->features) || !rtc->ops->alarm_irq_enable)
 		return;
 
 	rtc->ops->alarm_irq_enable(rtc->dev.parent, false);
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 55e7beed066c..31d2a856041b 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -118,6 +118,8 @@ struct rtc_device {
 	 */
 	long set_offset_nsec;
 
+	unsigned long features[BITS_TO_LONGS(RTC_FEATURE_CNT)];
+
 	time64_t range_min;
 	timeu64_t range_max;
 	time64_t start_secs;
diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index fa9aff91cbf2..f950bff75e97 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -110,6 +110,11 @@ struct rtc_pll_info {
 #define RTC_AF 0x20	/* Alarm interrupt */
 #define RTC_UF 0x10	/* Update interrupt for 1Hz RTC */
 
+/* feature list */
+#define RTC_FEATURE_ALARM		0
+#define RTC_FEATURE_ALARM_RES_MINUTE	1
+#define RTC_FEATURE_NEED_WEEK_DAY	2
+#define RTC_FEATURE_CNT			3
 
 #define RTC_MAX_FREQ	8192
 
-- 
2.25.1


