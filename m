Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A809C83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74873.1752487753247271222
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: gBdKkJqjRCGZJCe1mLQOOA==
X-CSE-MsgGUID: 3UwS31c2SISk+iC94ryFZA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2B62E41D4BDF;
	Mon, 14 Jul 2025 19:09:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 32/57] can: rcar_canfd: Improve error messages
Date: Mon, 14 Jul 2025 11:07:13 +0100
Message-ID: <20250714100802.80035-33-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19460

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 33eced402b184b5f2127f45531099c265d34e269 upstream.

Improve printed error messages:
  - Replace numerical error codes by mnemotechnic error codes, to
    improve the user experience in case of errors,
  - Drop parentheses around printed numbers, cfr.
    Documentation/process/coding-style.rst,
  - Drop printing of an error message in case of out-of-memory, as the
    core memory allocation code already takes care of this.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/4162cc46f72257ec191007675933985b6df394b9.1679414936.git.geert+renesas@glider.be
[mkl: use colon instead of comma]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 41 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 993e1d34d843..6efedff278ec 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1416,13 +1416,13 @@ static int rcar_canfd_open(struct net_device *ndev)
 	/* Peripheral clock is already enabled in probe */
 	err = clk_prepare_enable(gpriv->can_clk);
 	if (err) {
-		netdev_err(ndev, "failed to enable CAN clock, error %d\n", err);
+		netdev_err(ndev, "failed to enable CAN clock: %pe\n", ERR_PTR(err));
 		goto out_phy;
 	}
 
 	err = open_candev(ndev);
 	if (err) {
-		netdev_err(ndev, "open_candev() failed, error %d\n", err);
+		netdev_err(ndev, "open_candev() failed: %pe\n", ERR_PTR(err));
 		goto out_can_clock;
 	}
 
@@ -1723,10 +1723,9 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	int err = -ENODEV;
 
 	ndev = alloc_candev(sizeof(*priv), RCANFD_FIFO_DEPTH);
-	if (!ndev) {
-		dev_err(dev, "alloc_candev() failed\n");
+	if (!ndev)
 		return -ENOMEM;
-	}
+
 	priv = netdev_priv(ndev);
 
 	ndev->netdev_ops = &rcar_canfd_netdev_ops;
@@ -1769,8 +1768,8 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 				       rcar_canfd_channel_err_interrupt, 0,
 				       irq_name, priv);
 		if (err) {
-			dev_err(dev, "devm_request_irq CH Err(%d) failed, error %d\n",
-				err_irq, err);
+			dev_err(dev, "devm_request_irq CH Err %d failed: %pe\n",
+				err_irq, ERR_PTR(err));
 			goto fail;
 		}
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "canfd.ch%d_trx",
@@ -1783,8 +1782,8 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 				       rcar_canfd_channel_tx_interrupt, 0,
 				       irq_name, priv);
 		if (err) {
-			dev_err(dev, "devm_request_irq Tx (%d) failed, error %d\n",
-				tx_irq, err);
+			dev_err(dev, "devm_request_irq Tx %d failed: %pe\n",
+				tx_irq, ERR_PTR(err));
 			goto fail;
 		}
 	}
@@ -1815,7 +1814,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	gpriv->ch[priv->channel] = priv;
 	err = register_candev(ndev);
 	if (err) {
-		dev_err(dev, "register_candev() failed, error %d\n", err);
+		dev_err(dev, "register_candev() failed: %pe\n", ERR_PTR(err));
 		goto fail_candev;
 	}
 	dev_info(dev, "device registered (channel %u)\n", priv->channel);
@@ -1960,16 +1959,16 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 				       rcar_canfd_channel_interrupt, 0,
 				       "canfd.ch_int", gpriv);
 		if (err) {
-			dev_err(dev, "devm_request_irq(%d) failed, error %d\n",
-				ch_irq, err);
+			dev_err(dev, "devm_request_irq %d failed: %pe\n",
+				ch_irq, ERR_PTR(err));
 			goto fail_dev;
 		}
 
 		err = devm_request_irq(dev, g_irq, rcar_canfd_global_interrupt,
 				       0, "canfd.g_int", gpriv);
 		if (err) {
-			dev_err(dev, "devm_request_irq(%d) failed, error %d\n",
-				g_irq, err);
+			dev_err(dev, "devm_request_irq %d failed: %pe\n",
+				g_irq, ERR_PTR(err));
 			goto fail_dev;
 		}
 	} else {
@@ -1978,8 +1977,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 				       "canfd.g_recc", gpriv);
 
 		if (err) {
-			dev_err(dev, "devm_request_irq(%d) failed, error %d\n",
-				g_recc_irq, err);
+			dev_err(dev, "devm_request_irq %d failed: %pe\n",
+				g_recc_irq, ERR_PTR(err));
 			goto fail_dev;
 		}
 
@@ -1987,8 +1986,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 				       rcar_canfd_global_err_interrupt, 0,
 				       "canfd.g_err", gpriv);
 		if (err) {
-			dev_err(dev, "devm_request_irq(%d) failed, error %d\n",
-				g_err_irq, err);
+			dev_err(dev, "devm_request_irq %d failed: %pe\n",
+				g_err_irq, ERR_PTR(err));
 			goto fail_dev;
 		}
 	}
@@ -2005,14 +2004,14 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	/* Enable peripheral clock for register access */
 	err = clk_prepare_enable(gpriv->clkp);
 	if (err) {
-		dev_err(dev, "failed to enable peripheral clock, error %d\n",
-			err);
+		dev_err(dev, "failed to enable peripheral clock: %pe\n",
+			ERR_PTR(err));
 		goto fail_reset;
 	}
 
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
-		dev_err(dev, "reset controller failed\n");
+		dev_err(dev, "reset controller failed: %pe\n", ERR_PTR(err));
 		goto fail_clk;
 	}
 
-- 
2.43.0


