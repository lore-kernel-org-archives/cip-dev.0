Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D6C3DA5D
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5927.1721118184270232470
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215426007"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D32224005B53;
	Tue, 16 Jul 2024 17:23:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/31] rtc: da9063: Simplify bool comparison
Date: Tue, 16 Jul 2024 09:22:21 +0100
Message-ID: <20240716082255.56551-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16536

From: Kaixu Xia <kaixuxia@tencent.com>

commit a48c6224ae07bed02893c58073ca2942acb5c3d5 upstream.

Fix the following coccicheck warning:

./drivers/rtc/rtc-da9063.c:246:5-18: WARNING: Comparison to bool

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/1604649637-1014-1-git-send-email-kaixuxia@tencent.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-da9063.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 046b1d4c3dae..6f0a3a711135 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -243,7 +243,7 @@ static int da9063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	al_secs = rtc_tm_to_time64(&rtc->alarm_time);
 
 	/* handle the rtc synchronisation delay */
-	if (rtc->rtc_sync == true && al_secs - tm_secs == 1)
+	if (rtc->rtc_sync && al_secs - tm_secs == 1)
 		memcpy(tm, &rtc->alarm_time, sizeof(struct rtc_time));
 	else
 		rtc->rtc_sync = false;
-- 
2.43.0


