Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1FAC021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 16:58:05 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.28195.1740157085116303980
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Feb 2025 08:58:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: fUQ3VknhQTO2UKEJU3zpoA==
X-CSE-MsgGUID: 5enM8QdbQROeUecLxGx0gw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Feb 2025 01:58:04 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.173])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D6012404489C;
	Sat, 22 Feb 2025 01:58:02 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 4.19.y-cip] watchdog: renesas_wdt: support handover from bootloader
Date: Fri, 21 Feb 2025 16:57:55 +0000
Message-ID: <20250221165755.357838-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Feb 2025 16:58:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17881

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 962085a2bb823d8c88c6bc706c654648407e6408 upstream.

Support an already running watchdog by checking its enable bit and set
up the status accordingly before registering the device.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200908095615.31376-1-wsa+renesas@sang-engineering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 24963979163a..3cdfaeae15ec 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -198,6 +198,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	struct clk *clk;
 	unsigned long clks_per_sec;
 	int ret, i;
+	u8 csra;
 
 	if (rwdt_blacklisted(dev))
 		return -ENODEV;
@@ -218,8 +219,8 @@ static int rwdt_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 	priv->clk_rate = clk_get_rate(clk);
-	priv->wdev.bootstatus = (readb_relaxed(priv->base + RWTCSRA) &
-				RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
+	csra = readb_relaxed(priv->base + RWTCSRA);
+	priv->wdev.bootstatus = csra & RWTCSRA_WOVF ? WDIOF_CARDRESET : 0;
 	pm_runtime_put(dev);
 
 	if (!priv->clk_rate) {
@@ -259,6 +260,13 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(dev, "Specified timeout value invalid, using default\n");
 
+	/* Check if FW enabled the watchdog */
+	if (csra & RWTCSRA_TME) {
+		/* Ensure properly initialized dividers */
+		rwdt_start(&priv->wdev);
+		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
+	}
+
 	ret = watchdog_register_device(&priv->wdev);
 	if (ret < 0)
 		goto out_pm_disable;
-- 
2.43.0


