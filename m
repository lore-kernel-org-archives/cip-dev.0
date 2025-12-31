Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB3EE645D
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:00:33 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88822.1767200430621493146
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: I06SfOA3SmGOvQbLRmvcOA==
X-CSE-MsgGUID: 6QipxRVJTKqg7x0aE4J2ZQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:32 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2E4C7402412E;
	Thu,  1 Jan 2026 02:00:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 02/17] watchdog: rzv2h: Obtain clock-divider and timeout values from OF match data
Date: Wed, 31 Dec 2025 17:00:11 +0000
Message-ID: <20251231170026.17006-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:00:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21281

commit 19f7eaec4d9d1dcd8b49e14dbad56a65810c2910 upstream.

Update the rzv2h_wdt driver to fetch clock configuration and timeout
parameters from device tree match data rather than relying on hardcoded
constants. Introduce a new structure rzv2h_of_data that encapsulates
minimum and maximum clock select values (cks_min and cks_max), clock
divider (cks_div), timeout cycle count (timeout_cycles), and the
timeout period select bits (tops). These values are provided through
the OF match table and retrieved via of_device_get_match_data() during
probe.

This change allows dynamic configuration of the watchdog timer for
different SoCs, such as the RZ/T2H, which require different settings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/watchdog/rzv2h_wdt.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 8defd02412130..755067800ebb9 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -35,9 +35,6 @@
 
 #define WDTRCR_RSTIRQS		BIT(7)
 
-#define MAX_TIMEOUT_CYCLES	16384
-#define CLOCK_DIV_BY_256	256
-
 #define WDT_DEFAULT_TIMEOUT	60U
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -45,12 +42,21 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+struct rzv2h_of_data {
+	u8 cks_min;
+	u8 cks_max;
+	u16 cks_div;
+	u8 tops;
+	u16 timeout_cycles;
+};
+
 struct rzv2h_wdt_priv {
 	void __iomem *base;
 	struct clk *pclk;
 	struct clk *oscclk;
 	struct reset_control *rstc;
 	struct watchdog_device wdev;
+	const struct rzv2h_of_data *of_data;
 };
 
 static int rzv2h_wdt_ping(struct watchdog_device *wdev)
@@ -84,6 +90,7 @@ static void rzv2h_wdt_setup(struct watchdog_device *wdev, u16 wdtcr)
 static int rzv2h_wdt_start(struct watchdog_device *wdev)
 {
 	struct rzv2h_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	const struct rzv2h_of_data *of_data = priv->of_data;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(wdev->parent);
@@ -106,8 +113,8 @@ static int rzv2h_wdt_start(struct watchdog_device *wdev)
 	 * - RPES[9:8] - Window End Position Select - 11b: 0%
 	 * - TOPS[1:0] - Timeout Period Select - 11b: 16384 cycles (3FFFh)
 	 */
-	rzv2h_wdt_setup(wdev, WDTCR_CKS_CLK_256 | WDTCR_RPSS_100 |
-			WDTCR_RPES_0 | WDTCR_TOPS_16384);
+	rzv2h_wdt_setup(wdev, of_data->cks_max | WDTCR_RPSS_100 |
+			WDTCR_RPES_0 | of_data->tops);
 
 	/*
 	 * Down counting starts after writing the sequence 00h -> FFh to the
@@ -184,7 +191,7 @@ static int rzv2h_wdt_restart(struct watchdog_device *wdev,
 	 * - RPES[9:8] - Window End Position Select - 00b: 75%
 	 * - TOPS[1:0] - Timeout Period Select - 00b: 1024 cycles (03FFh)
 	 */
-	rzv2h_wdt_setup(wdev, WDTCR_CKS_CLK_1 | WDTCR_RPSS_25 |
+	rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
 			WDTCR_RPES_75 | WDTCR_TOPS_1024);
 
 	rzv2h_wdt_ping(wdev);
@@ -213,6 +220,8 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->of_data = of_device_get_match_data(dev);
+
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
@@ -230,8 +239,8 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
 
-	priv->wdev.max_hw_heartbeat_ms = (MILLI * MAX_TIMEOUT_CYCLES * CLOCK_DIV_BY_256) /
-					 clk_get_rate(priv->oscclk);
+	priv->wdev.max_hw_heartbeat_ms = (MILLI * priv->of_data->timeout_cycles *
+					  priv->of_data->cks_div) / clk_get_rate(priv->oscclk);
 	dev_dbg(dev, "max hw timeout of %dms\n", priv->wdev.max_hw_heartbeat_ms);
 
 	ret = devm_pm_runtime_enable(dev);
@@ -254,8 +263,16 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, &priv->wdev);
 }
 
+static const struct rzv2h_of_data rzv2h_wdt_of_data = {
+	.cks_min = WDTCR_CKS_CLK_1,
+	.cks_max = WDTCR_CKS_CLK_256,
+	.cks_div = 256,
+	.tops = WDTCR_TOPS_16384,
+	.timeout_cycles = 16384,
+};
+
 static const struct of_device_id rzv2h_wdt_ids[] = {
-	{ .compatible = "renesas,r9a09g057-wdt", },
+	{ .compatible = "renesas,r9a09g057-wdt", .data = &rzv2h_wdt_of_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzv2h_wdt_ids);
-- 
2.43.0


