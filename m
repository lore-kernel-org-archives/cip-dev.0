Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4B2C43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 14:02:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.7873.1657807300814901072
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 07:02:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,271,1650898800";
   d="scan'208";a="127853584"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2022 22:56:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.147])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B66094012253;
	Thu, 14 Jul 2022 22:56:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH [5.10.y-cip] 12/13] watchdog: rzg2l_wdt: Use force reset for
 WDT reset
Date: Thu, 14 Jul 2022 14:56:26 +0100
Message-Id: <20220714135627.2163551-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714135627.2163551-1-biju.das.jz@bp.renesas.com>
References: <20220714135627.2163551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 14:02:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8769

commit f43e6ddbd7d7b63b9e71927a1f50860f8d55f9cc upstream.

This patch uses the force reset(WDTRSTB) for triggering WDT reset for
restart callback. This method(ie, Generate Reset (WDTRSTB) Signal on
parity error)is faster compared to the overflow method for triggering
watchdog reset.

Overflow method:
	reboot: Restarting system
	Reboot failed -- System halted
	NOTICE:  BL2: v2.5(release):v2.5/rzg2l-1.00-27-gf48f1440c

Parity error method:
	reboot: Restarting system
	NOTICE:  BL2: v2.5(release):v2.5/rzg2l-1.00-27-gf48f1440c

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220225175320.11041-7-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 73b667ed3e99..4e7107655cc2 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -21,8 +21,11 @@
 #define WDTSET		0x04
 #define WDTTIM		0x08
 #define WDTINT		0x0C
+#define PECR		0x10
+#define PEEN		0x14
 #define WDTCNT_WDTEN	BIT(0)
 #define WDTINT_INTDISP	BIT(0)
+#define PEEN_FORCE	BIT(0)
 
 #define WDT_DEFAULT_TIMEOUT		60U
 
@@ -117,17 +120,14 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	/* Reset the module before we modify any register */
-	reset_control_reset(priv->rstc);
-
 	clk_prepare_enable(priv->pclk);
 	clk_prepare_enable(priv->osc_clk);
 
-	/* smallest counter value to reboot soon */
-	rzg2l_wdt_write(priv, WDTSET_COUNTER_VAL(1), WDTSET);
+	/* Generate Reset (WDTRSTB) Signal on parity error */
+	rzg2l_wdt_write(priv, 0, PECR);
 
-	/* Enable watchdog timer*/
-	rzg2l_wdt_write(priv, WDTCNT_WDTEN, WDTCNT);
+	/* Force parity error */
+	rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
 
 	return 0;
 }
-- 
2.25.1


