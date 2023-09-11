Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893E7EEB580
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 14:47:12 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.60522.1694443629451194136
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 07:47:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="179428501"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Sep 2023 23:47:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 12F044003FDD;
	Mon, 11 Sep 2023 23:47:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/15] rtc: isl1208: Fix clock tick timed out message
Date: Mon, 11 Sep 2023 15:46:48 +0100
Message-Id: <20230911144702.948246-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
References: <20230911144702.948246-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 14:47:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13025

This patch is equivalent to the commit 2023c5c8fe2e85 "rtc: isl1208: do
not advertise update interrupt feature if no interrupt specified" on the
mainline.

Without this patch, an error message 'hwclock: select() to /dev/rtc0 to
wait for clock tick timed out' is seen on 5.10.y-cip kernel as built-in
RTC found on the PMIC does not populate interrupt by default on RZ/G2L
SMARC EVK platform.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index f6101ee74cd6..a6f74cbc8c0a 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -946,10 +946,14 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (rc)
 		return rc;
 
-	if (client->irq > 0)
+	if (client->irq > 0) {
 		rc = isl1208_setup_irq(client, client->irq);
-	if (rc)
-		return rc;
+		if (rc)
+			return rc;
+
+	} else {
+		isl1208->rtc->uie_unsupported = 1;
+	}
 
 	if (evdet_irq > 0 && evdet_irq != client->irq)
 		rc = isl1208_setup_irq(client, evdet_irq);
-- 
2.25.1


