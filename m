Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3609EC77B7F
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20922.1684484462890095063
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963159"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:21 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E2B07419E62E;
	Fri, 19 May 2023 17:21:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 08/23] watchdog: rzg2l_wdt: Add rzv2m support
Date: Fri, 19 May 2023 09:20:43 +0100
Message-Id: <20230519082058.109760-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11540

From: Phil Edworthy <phil.edworthy@renesas.com>

commit ec122fd94eeb87b2e906360efe7447362f83e9ae upstream.

The WDT on RZ/V2M devices is basically the same as RZ/G2L, but without
the parity error registers. This means the driver has to reset the
hardware plus set the minimum timeout in order to do a restart and has
a single interrupt.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220823093233.8577-3-phil.edworthy@renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 39 ++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index d217bc54b729..ceca42db0837 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -10,7 +10,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -40,6 +40,11 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+enum rz_wdt_type {
+	WDT_RZG2L,
+	WDT_RZV2M,
+};
+
 struct rzg2l_wdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
@@ -48,6 +53,7 @@ struct rzg2l_wdt_priv {
 	unsigned long delay;
 	struct clk *pclk;
 	struct clk *osc_clk;
+	enum rz_wdt_type devtype;
 };
 
 static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
@@ -140,11 +146,29 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 	clk_prepare_enable(priv->pclk);
 	clk_prepare_enable(priv->osc_clk);
 
-	/* Generate Reset (WDTRSTB) Signal on parity error */
-	rzg2l_wdt_write(priv, 0, PECR);
+	if (priv->devtype == WDT_RZG2L) {
+		/* Generate Reset (WDTRSTB) Signal on parity error */
+		rzg2l_wdt_write(priv, 0, PECR);
+
+		/* Force parity error */
+		rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
+	} else {
+		/* RZ/V2M doesn't have parity error registers */
+
+		wdev->timeout = 0;
+
+		/* Initialize time out */
+		rzg2l_wdt_init_timeout(wdev);
 
-	/* Force parity error */
-	rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
+		/* Initialize watchdog counter register */
+		rzg2l_wdt_write(priv, 0, WDTTIM);
+
+		/* Enable watchdog timer*/
+		rzg2l_wdt_write(priv, WDTCNT_WDTEN, WDTCNT);
+
+		/* Wait 2 consecutive overflow cycles for reset */
+		mdelay(DIV_ROUND_UP(2 * 0xFFFFF * 1000, priv->osc_clk_rate));
+	}
 
 	return 0;
 }
@@ -225,6 +249,8 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to deassert");
 
+	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
+
 	pm_runtime_enable(&pdev->dev);
 
 	priv->wdev.info = &rzg2l_wdt_ident;
@@ -253,7 +279,8 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rzg2l_wdt_ids[] = {
-	{ .compatible = "renesas,rzg2l-wdt", },
+	{ .compatible = "renesas,rzg2l-wdt", .data = (void *)WDT_RZG2L },
+	{ .compatible = "renesas,rzv2m-wdt", .data = (void *)WDT_RZV2M },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
-- 
2.25.1


