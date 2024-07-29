Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60785C52CDA
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.58756.1722267075572459905
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217878567"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jul 2024 00:31:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2EF0B4006A90;
	Tue, 30 Jul 2024 00:31:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/13] reset: rzg2l-usbphy-ctrl: Move reset controller registration
Date: Mon, 29 Jul 2024 16:30:40 +0100
Message-ID: <20240729153109.510325-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
References: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:31:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16655

commit b081f13c11500bceb8ab504797a48cc7751de4b5 upstream.

As soon as the reset controller is registered, it could be used by a
reset consumer. That means hardware setup to be done first and then the
registration of the reset controller. So move the registration of reset
controller at the end of probe().

While at it, fix the issue that the reset is not re-asserted in case
devm_reset_controller_register() fails and also use goto statements to
simplify the error path in probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240610164845.89666-1-biju.das.jz@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 32 +++++++++++++++----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index a8dde4606360..bea3270fb698 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -125,25 +125,14 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	priv->rcdev.ops = &rzg2l_usbphy_ctrl_reset_ops;
-	priv->rcdev.of_reset_n_cells = 1;
-	priv->rcdev.nr_resets = NUM_PORTS;
-	priv->rcdev.of_node = dev->of_node;
-	priv->rcdev.dev = dev;
-
-	error = devm_reset_controller_register(dev, &priv->rcdev);
-	if (error)
-		return error;
-
 	spin_lock_init(&priv->lock);
 	dev_set_drvdata(dev, priv);
 
 	pm_runtime_enable(&pdev->dev);
 	error = pm_runtime_resume_and_get(&pdev->dev);
 	if (error < 0) {
-		pm_runtime_disable(&pdev->dev);
-		reset_control_assert(priv->rstc);
-		return dev_err_probe(&pdev->dev, error, "pm_runtime_resume_and_get failed");
+		dev_err_probe(&pdev->dev, error, "pm_runtime_resume_and_get failed");
+		goto err_pm_disable_reset_deassert;
 	}
 
 	/* put pll and phy into reset state */
@@ -153,7 +142,24 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
 	writel(val, priv->base + RESET);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	priv->rcdev.ops = &rzg2l_usbphy_ctrl_reset_ops;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->rcdev.nr_resets = NUM_PORTS;
+	priv->rcdev.of_node = dev->of_node;
+	priv->rcdev.dev = dev;
+
+	error = devm_reset_controller_register(dev, &priv->rcdev);
+	if (error)
+		goto err_pm_runtime_put;
+
 	return 0;
+
+err_pm_runtime_put:
+	pm_runtime_put(&pdev->dev);
+err_pm_disable_reset_deassert:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(priv->rstc);
+	return error;
 }
 
 static int rzg2l_usbphy_ctrl_remove(struct platform_device *pdev)
-- 
2.43.0


