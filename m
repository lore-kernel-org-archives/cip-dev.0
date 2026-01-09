Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A5D1A606
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:16:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8762.1767960986846098294
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 04:16:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Dok0fvElQ3G/evbiG0B6rw==
X-CSE-MsgGUID: sEgnW9clQ6yf6rGdnu6NgQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2026 21:16:30 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.57])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4A00F401D73A;
	Fri,  9 Jan 2026 21:16:29 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 3/8] rtc: renesas-rtca3: Disable interrupts only if the RTC is enabled
Date: Fri,  9 Jan 2026 12:16:17 +0000
Message-ID: <20260109121622.46030-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
References: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 12:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21510

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 27b2fcbd6b98204b0dce62e9aa9540ca0a2b70f1 upstream.

If the RTC is not enabled and the code attempts to disable the interrupt,
the readb_poll_timeout_atomic() function in the
rtca3_alarm_irq_set_helper() may timeout, leading to probe failures.
This issue is reproducible on some devices because the initial values of
the PIE and AIE bits in the RCR1 register are undefined.

To prevent probe failures in this scenario, disable RTC interrupts only
when the RTC is actually enabled.

Fixes: d4488377609e ("rtc: renesas-rtca3: Add driver for RTCA-3 available on Renesas RZ/G3S SoC")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250205095519.2031742-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca3.c
index 4bc28680f650..bd9f809a04ad 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -586,17 +586,14 @@ static int rtca3_initial_setup(struct clk *clk, struct rtca3_priv *priv)
 	 */
 	usleep_range(sleep_us, sleep_us + 10);
 
-	/* Disable all interrupts. */
-	mask = RTCA3_RCR1_AIE | RTCA3_RCR1_CIE | RTCA3_RCR1_PIE;
-	ret = rtca3_alarm_irq_set_helper(priv, mask, 0);
-	if (ret)
-		return ret;
-
 	mask = RTCA3_RCR2_START | RTCA3_RCR2_HR24;
 	val = readb(priv->base + RTCA3_RCR2);
-	/* Nothing to do if already started in 24 hours and calendar count mode. */
-	if ((val & mask) == mask)
-		return 0;
+	/* Only disable the interrupts if already started in 24 hours and calendar count mode. */
+	if ((val & mask) == mask) {
+		/* Disable all interrupts. */
+		mask = RTCA3_RCR1_AIE | RTCA3_RCR1_CIE | RTCA3_RCR1_PIE;
+		return rtca3_alarm_irq_set_helper(priv, mask, 0);
+	}
 
 	/* Reconfigure the RTC in 24 hours and calendar count mode. */
 	mask = RTCA3_RCR2_START | RTCA3_RCR2_CNTMD;
-- 
2.51.0


