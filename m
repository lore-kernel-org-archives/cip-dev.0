Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C3DC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.58762.1722267101575259670
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:31:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213908975"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:31:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 53CA34006A90;
	Tue, 30 Jul 2024 00:31:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 13/13] rtc: isl1208: Update correct procedure for clearing alarm
Date: Mon, 29 Jul 2024 16:30:52 +0100
Message-ID: <20240729153109.510325-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
References: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:31:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16667

commit 43696b3a9e46cf622bfeb70856b9b1cfa5a9fb23 upstream.

As per the latest HW manual[1], there is an internal delay(~250 microsec)
from setting ALME = 0 to disabling the alarm function, so the user must
add a short delay of greater than 250µs between setting ALME = 0 and
clearing ALM.

Currently setting of ALME = 0 is done after clearing the ALM, so just
reverse the operation and add a delay of 275 microsec.

[1]https://www.renesas.com/us/en/document/dst/raa215300-datasheet?r=1506351

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618152635.48956-3-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 030573ffca69..5669dbd51d67 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -663,6 +663,13 @@ isl1208_rtc_interrupt(int irq, void *data)
 
 		rtc_update_irq(isl1208->rtc, 1, RTC_IRQF | RTC_AF);
 
+		/* Disable the alarm */
+		err = isl1208_rtc_toggle_alarm(client, 0);
+		if (err)
+			return err;
+
+		fsleep(275);
+
 		/* Clear the alarm */
 		sr &= ~ISL1208_REG_SR_ALM;
 		sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR, sr);
@@ -671,11 +678,6 @@ isl1208_rtc_interrupt(int irq, void *data)
 				__func__);
 		else
 			handled = 1;
-
-		/* Disable the alarm */
-		err = isl1208_rtc_toggle_alarm(client, 0);
-		if (err)
-			return err;
 	}
 
 	if (isl1208->config->has_tamper && (sr & ISL1208_REG_SR_EVT)) {
-- 
2.43.0


