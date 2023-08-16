Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF76C001E0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161754.1692195654103012015
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787689"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5DDE64210C28;
	Wed, 16 Aug 2023 23:20:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/31] rtc: add alarm related features
Date: Wed, 16 Aug 2023 15:20:01 +0100
Message-Id: <20230816142017.147173-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12697

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit 917425f71f36ce6f61841497040e10d0166106d8 upstream.

Add more alarm related features to be declared by drivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20211018151933.76865-2-alexandre.belloni@bootlin.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/uapi/linux/rtc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index f950bff75e97..f4037c541925 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -114,7 +114,9 @@ struct rtc_pll_info {
 #define RTC_FEATURE_ALARM		0
 #define RTC_FEATURE_ALARM_RES_MINUTE	1
 #define RTC_FEATURE_NEED_WEEK_DAY	2
-#define RTC_FEATURE_CNT			3
+#define RTC_FEATURE_ALARM_RES_2S	3
+#define RTC_FEATURE_UPDATE_INTERRUPT	4
+#define RTC_FEATURE_CNT			5
 
 #define RTC_MAX_FREQ	8192
 
-- 
2.25.1


