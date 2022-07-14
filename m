Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D189C43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 14:05:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.8039.1657807491905907383
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 07:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,271,1650898800";
   d="scan'208";a="126170505"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2022 23:04:51 +0900
Received: from localhost.localdomain (unknown [10.226.92.147])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B2FE6441C33C;
	Thu, 14 Jul 2022 23:04:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH [5.10.y-cip] 07/13] watchdog: rzg2l_wdt: Fix 32bit overflow
 issue
Date: Thu, 14 Jul 2022 15:04:26 +0100
Message-Id: <20220714140432.2210982-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714140432.2210982-1-biju.das.jz@bp.renesas.com>
References: <20220714140432.2210982-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 14:05:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8777

commit ea2949df22a533cdf75e4583c00b1ce94cd5a83b upstream.

The value of timer_cycle_us can be 0 due to 32bit overflow.
For eg:- If we assign the counter value "0xfff" for computing
maxval.

This patch fixes this issue by appending ULL to 1024, so that
it is promoted to 64bit.

This patch also fixes the warning message, 'watchdog: Invalid min and
max timeout values, resetting to 0!'.

Fixes: 2cbc5cd0b55fa2 ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220225175320.11041-2-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 6b426df34fd6..96f2a018ab62 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -53,7 +53,7 @@ static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
 
 static u32 rzg2l_wdt_get_cycle_usec(unsigned long cycle, u32 wdttime)
 {
-	u64 timer_cycle_us = 1024 * 1024 * (wdttime + 1) * MICRO;
+	u64 timer_cycle_us = 1024 * 1024ULL * (wdttime + 1) * MICRO;
 
 	return div64_ul(timer_cycle_us, cycle);
 }
-- 
2.25.1


