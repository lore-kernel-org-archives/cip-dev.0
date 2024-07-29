Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B865FC3DA7E
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:35:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.58893.1722267324064889186
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:35:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217878986"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jul 2024 00:35:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DE1D8401A444;
	Tue, 30 Jul 2024 00:35:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/13] rtc: isl1208: Add a delay for clearing alarm
Date: Mon, 29 Jul 2024 16:34:57 +0100
Message-ID: <20240729153504.510443-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:35:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16680

commit 0dbd610c426ed695eef5d26584259d96b6250c76 upstream.

As per the latest HW manual[1], the INT# output is pulled low after the
alarm is triggered. After the INT# output is pulled low, it is low for at
least 250ms, even if the correct action is taken to clear it. It is
impossible to clear ALM if it is still active. The host must wait for the
RTC to progress past the alarm time plus the 250ms delay before clearing
ALM.

[1]https://www.renesas.com/us/en/document/dst/raa215300-datasheet?r=1506351

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20240618152635.48956-2-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 5b0a161f9552..c1824a76bc1c 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -7,6 +7,7 @@
 
 #include <linux/bcd.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -628,6 +629,18 @@ isl1208_rtc_interrupt(int irq, void *data)
 	struct isl1208_state *isl1208 = i2c_get_clientdata(client);
 	int handled = 0, sr, err;
 
+	if (!isl1208->config->has_tamper) {
+		/*
+		 * The INT# output is pulled low 250ms after the alarm is
+		 * triggered. After the INT# output is pulled low, it is low for
+		 * at least 250ms, even if the correct action is taken to clear
+		 * it. It is impossible to clear ALM if it is still active. The
+		 * host must wait for the RTC to progress past the alarm time
+		 * plus the 250ms delay before clearing ALM.
+		 */
+		msleep(250);
+	}
+
 	/*
 	 * I2C reads get NAK'ed if we read straight away after an interrupt?
 	 * Using a mdelay/msleep didn't seem to help either, so we work around
-- 
2.43.0


