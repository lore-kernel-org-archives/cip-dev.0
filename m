Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1BBC001E0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162057.1692195660973914437
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100229"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3B79E4210C30;
	Wed, 16 Aug 2023 23:21:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 18/31] rtc: expose RTC_FEATURE_UPDATE_INTERRUPT
Date: Wed, 16 Aug 2023 15:20:04 +0100
Message-Id: <20230816142017.147173-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12700

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit adb17a053e460f20740d713c4843d6966e66b1b1 upstream.

Set RTC_FEATURE_UPDATE_INTERRUPT by default and clear it when it is not
supported.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20211018152337.78732-1-alexandre.belloni@bootlin.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c     | 4 ++++
 drivers/rtc/interface.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index f521b90fa182..431f16efed2d 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -236,6 +236,7 @@ static struct rtc_device *rtc_allocate_device(void)
 	rtc->pie_enabled = 0;
 
 	set_bit(RTC_FEATURE_ALARM, rtc->features);
+	set_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 
 	return rtc;
 }
@@ -398,6 +399,9 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 	if (!rtc->ops->set_alarm)
 		clear_bit(RTC_FEATURE_ALARM, rtc->features);
 
+	if (rtc->uie_unsupported)
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
+
 	if (rtc->ops->set_offset)
 		set_bit(RTC_FEATURE_CORRECTION, rtc->features);
 
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 3ee17c4d7298..e95b06aa8fd7 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -561,7 +561,8 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 	if (rtc->uie_rtctimer.enabled == enabled)
 		goto out;
 
-	if (rtc->uie_unsupported || !test_bit(RTC_FEATURE_ALARM, rtc->features)) {
+	if (!test_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features) ||
+	    !test_bit(RTC_FEATURE_ALARM, rtc->features)) {
 		mutex_unlock(&rtc->ops_lock);
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 		return rtc_dev_update_irq_enable_emul(rtc, enabled);
-- 
2.25.1


