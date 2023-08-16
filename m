Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF2FC04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162057.1692195660973914437
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100222"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9844F4210C25;
	Wed, 16 Aug 2023 23:20:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 16/31] rtc: expose correction feature
Date: Wed, 16 Aug 2023 15:20:02 +0100
Message-Id: <20230816142017.147173-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12698

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 2268551935dbf1abcbb4d4fb7b1ad74dbe0d1be0 upstream.

Add a new feature for RTCs able to correct the oscillator imprecision. This
is also called offset or trimming. Such drivers have a .set_offset callback,
use that to set the feature bit from the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20211018151933.76865-4-alexandre.belloni@bootlin.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c      | 3 +++
 include/uapi/linux/rtc.h | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index edd84ee38005..f521b90fa182 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -398,6 +398,9 @@ int __devm_rtc_register_device(struct module *owner, struct rtc_device *rtc)
 	if (!rtc->ops->set_alarm)
 		clear_bit(RTC_FEATURE_ALARM, rtc->features);
 
+	if (rtc->ops->set_offset)
+		set_bit(RTC_FEATURE_CORRECTION, rtc->features);
+
 	rtc->owner = owner;
 	rtc_device_get_offset(rtc);
 
diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index f4037c541925..ef5113d061c4 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -116,7 +116,8 @@ struct rtc_pll_info {
 #define RTC_FEATURE_NEED_WEEK_DAY	2
 #define RTC_FEATURE_ALARM_RES_2S	3
 #define RTC_FEATURE_UPDATE_INTERRUPT	4
-#define RTC_FEATURE_CNT			5
+#define RTC_FEATURE_CORRECTION		5
+#define RTC_FEATURE_CNT			6
 
 #define RTC_MAX_FREQ	8192
 
-- 
2.25.1


