Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F87FCCA47B
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 14:01:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.7873.1657807300814901072
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 07:01:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,271,1650898800";
   d="scan'208";a="127853563"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2022 22:56:49 +0900
Received: from localhost.localdomain (unknown [10.226.92.147])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AB4E940031FB;
	Thu, 14 Jul 2022 22:56:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH [5.10.y-cip] 08/13] watchdog: rzg2l_wdt: Fix Runtime PM usage
Date: Thu, 14 Jul 2022 14:56:22 +0100
Message-Id: <20220714135627.2163551-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714135627.2163551-1-biju.das.jz@bp.renesas.com>
References: <20220714135627.2163551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 14:01:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8767

commit 95abafe76297fa057de6c3486ef844bd446bdf18 upstream.

Both rzg2l_wdt_probe() and rzg2l_wdt_start() calls pm_runtime_get() which
results in a usage counter imbalance. This patch fixes this issue by
removing pm_runtime_get() call from probe.

Fixes: 2cbc5cd0b55fa2 ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20220225175320.11041-3-biju.das.jz@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 96f2a018ab62..0fc73b8a9567 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -151,12 +151,11 @@ static const struct watchdog_ops rzg2l_wdt_ops = {
 	.restart = rzg2l_wdt_restart,
 };
 
-static void rzg2l_wdt_reset_assert_pm_disable_put(void *data)
+static void rzg2l_wdt_reset_assert_pm_disable(void *data)
 {
 	struct watchdog_device *wdev = data;
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	pm_runtime_put(wdev->parent);
 	pm_runtime_disable(wdev->parent);
 	reset_control_assert(priv->rstc);
 }
@@ -206,11 +205,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	reset_control_deassert(priv->rstc);
 	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_resume_and_get failed ret=%pe", ERR_PTR(ret));
-		goto out_pm_get;
-	}
 
 	priv->wdev.info = &rzg2l_wdt_ident;
 	priv->wdev.ops = &rzg2l_wdt_ops;
@@ -222,7 +216,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&priv->wdev, priv);
 	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_wdt_reset_assert_pm_disable_put,
+				       rzg2l_wdt_reset_assert_pm_disable,
 				       &priv->wdev);
 	if (ret < 0)
 		return ret;
@@ -235,12 +229,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 		dev_warn(dev, "Specified timeout invalid, using default");
 
 	return devm_watchdog_register_device(&pdev->dev, &priv->wdev);
-
-out_pm_get:
-	pm_runtime_disable(dev);
-	reset_control_assert(priv->rstc);
-
-	return ret;
 }
 
 static const struct of_device_id rzg2l_wdt_ids[] = {
-- 
2.25.1


