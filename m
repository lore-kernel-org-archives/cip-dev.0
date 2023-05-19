Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA1C77B75
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20922.1684484462890095063
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963171"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:24 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 700D7419E25B;
	Fri, 19 May 2023 17:21:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 09/23] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Date: Fri, 19 May 2023 09:20:44 +0100
Message-Id: <20230519082058.109760-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11541

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit f769f97917c1e756e12ff042a93f6e3167254b5b upstream.

As per section 48.4 of the HW User Manual, IPs in the RZ/V2M
SoC need either a TYPE-A reset sequence or a TYPE-B reset
sequence. More specifically, the watchdog IP needs a TYPE-B
reset sequence.

If the proper reset sequence isn't implemented, then resetting
IPs may lead to undesired behaviour. In the restart callback of
the watchdog driver the reset has basically no effect on the
desired funcionality, as the register writes following the reset
happen before the IP manages to come out of reset.

Implement the TYPE-B reset sequence in the watchdog driver to
address the issues with the restart callback on RZ/V2M.

Fixes: ec122fd94eeb ("watchdog: rzg2l_wdt: Add rzv2m support")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20221117114907.138583-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 37 +++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index ceca42db0837..d404953d0e0f 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -35,6 +36,8 @@
 
 #define F2CYCLE_NSEC(f)			(1000000000 / (f))
 
+#define RZV2M_A_NSEC			730
+
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
@@ -51,11 +54,35 @@ struct rzg2l_wdt_priv {
 	struct reset_control *rstc;
 	unsigned long osc_clk_rate;
 	unsigned long delay;
+	unsigned long minimum_assertion_period;
 	struct clk *pclk;
 	struct clk *osc_clk;
 	enum rz_wdt_type devtype;
 };
 
+static int rzg2l_wdt_reset(struct rzg2l_wdt_priv *priv)
+{
+	int err, status;
+
+	if (priv->devtype == WDT_RZV2M) {
+		/* WDT needs TYPE-B reset control */
+		err = reset_control_assert(priv->rstc);
+		if (err)
+			return err;
+		ndelay(priv->minimum_assertion_period);
+		err = reset_control_deassert(priv->rstc);
+		if (err)
+			return err;
+		err = read_poll_timeout(reset_control_status, status,
+					status != 1, 0, 1000, false,
+					priv->rstc);
+	} else {
+		err = reset_control_reset(priv->rstc);
+	}
+
+	return err;
+}
+
 static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
 {
 	/* delay timer when change the setting register */
@@ -115,7 +142,7 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	reset_control_reset(priv->rstc);
+	rzg2l_wdt_reset(priv);
 	pm_runtime_put(wdev->parent);
 
 	return 0;
@@ -154,6 +181,7 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 		rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
 	} else {
 		/* RZ/V2M doesn't have parity error registers */
+		rzg2l_wdt_reset(priv);
 
 		wdev->timeout = 0;
 
@@ -251,6 +279,13 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
 
+	if (priv->devtype == WDT_RZV2M) {
+		priv->minimum_assertion_period = RZV2M_A_NSEC +
+			3 * F2CYCLE_NSEC(pclk_rate) + 5 *
+			max(F2CYCLE_NSEC(priv->osc_clk_rate),
+			    F2CYCLE_NSEC(pclk_rate));
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	priv->wdev.info = &rzg2l_wdt_ident;
-- 
2.25.1


