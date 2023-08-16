Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C54AC04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162057.1692195660973914437
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100243"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 250C94210C24;
	Wed, 16 Aug 2023 23:21:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 21/31] rtc: isl1208: do not advertise update interrupt feature if no interrupt specified
Date: Wed, 16 Aug 2023 15:20:07 +0100
Message-Id: <20230816142017.147173-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12703

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

commit 2023c5c8fe2e85ec7491d5a470fcca48f8144c02 upstream.

If an ISL1208 device does not have an interrupt line routed, the feature
shouldn't be advertised (it is by default in rtc core) or it'll confuse
userspace requesting that feature (such as hwclock from util-linux).

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20220523145320.123713-1-foss+kernel@0leil.net
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 182dfa605515..f448a525333e 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -880,10 +880,14 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
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
+		clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, isl1208->rtc->features);
+	}
 
 	if (evdet_irq > 0 && evdet_irq != client->irq)
 		rc = isl1208_setup_irq(client, evdet_irq);
-- 
2.25.1


