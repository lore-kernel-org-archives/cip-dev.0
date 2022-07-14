Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCD9CCA482
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 14:05:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.7920.1657807498778894233
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 07:04:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,271,1650898800";
   d="scan'208";a="126170509"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2022 23:04:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.147])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 92B27441C33C;
	Thu, 14 Jul 2022 23:04:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH [5.10.y-cip] 10/13] watchdog: rzg2l_wdt: Fix reset control
 imbalance
Date: Thu, 14 Jul 2022 15:04:29 +0100
Message-Id: <20220714140432.2210982-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714140432.2210982-1-biju.das.jz@bp.renesas.com>
References: <20220714140432.2210982-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 14:05:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8780

commit 33d04d0fdba9fae18c7d58364643d2c606a43dba upstream.

Both rzg2l_wdt_probe() and rzg2l_wdt_start() calls reset_control_
deassert() which results in a reset control imbalance.

This patch fixes reset control imbalance by removing reset_control_
deassert() from rzg2l_wdt_start() and replaces reset_control_assert with
reset_control_reset in rzg2l_wdt_stop() as watchdog module can be stopped
only by a module reset. This change will allow us to restart WDT after
stop() by configuring WDT timeout and enable registers.

Fixes: 2cbc5cd0b55fa2 ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220225175320.11041-5-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 48dfe6e5e64f..88274704b260 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -88,7 +88,6 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	reset_control_deassert(priv->rstc);
 	pm_runtime_get_sync(wdev->parent);
 
 	/* Initialize time out */
@@ -108,7 +107,7 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	pm_runtime_put(wdev->parent);
-	reset_control_assert(priv->rstc);
+	reset_control_reset(priv->rstc);
 
 	return 0;
 }
-- 
2.25.1


