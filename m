Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A88EC83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74863.1752487730286377307
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: /Vm4QZ54R0uKwEpN+3OXMQ==
X-CSE-MsgGUID: IHc0zbm2Q/GS2MSAEeDeWg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D449741D4BF2;
	Mon, 14 Jul 2025 19:09:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 28/57] can: rcar_canfd: Add helper variable dev
Date: Mon, 14 Jul 2025 11:07:09 +0100
Message-ID: <20250714100802.80035-29-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19456

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 114246e81fc6e6f3c092ba1cc1dec9f0a91c3cbd upstream.

rcar_canfd_channel_probe() and rcar_canfd_probe() have many users of
"pdev->dev".  Introduce shorthands to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/2965edc7992ab54dc6c862910775f3466fca6b29.1674499048.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 86 +++++++++++++++----------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3ecdae5a4c14..a2b0f657dc76 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1707,13 +1707,14 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 {
 	const struct rcar_canfd_hw_info *info = gpriv->info;
 	struct platform_device *pdev = gpriv->pdev;
+	struct device *dev = &pdev->dev;
 	struct rcar_canfd_channel *priv;
 	struct net_device *ndev;
 	int err = -ENODEV;
 
 	ndev = alloc_candev(sizeof(*priv), RCANFD_FIFO_DEPTH);
 	if (!ndev) {
-		dev_err(&pdev->dev, "alloc_candev() failed\n");
+		dev_err(dev, "alloc_candev() failed\n");
 		return -ENOMEM;
 	}
 	priv = netdev_priv(ndev);
@@ -1726,7 +1727,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv->channel = ch;
 	priv->gpriv = gpriv;
 	priv->can.clock.freq = fcan_freq;
-	dev_info(&pdev->dev, "can_clk rate is %u\n", priv->can.clock.freq);
+	dev_info(dev, "can_clk rate is %u\n", priv->can.clock.freq);
 
 	if (info->multi_channel_irqs) {
 		char *irq_name;
@@ -1745,31 +1746,31 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 			goto fail;
 		}
 
-		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-					  "canfd.ch%d_err", ch);
+		irq_name = devm_kasprintf(dev, GFP_KERNEL, "canfd.ch%d_err",
+					  ch);
 		if (!irq_name) {
 			err = -ENOMEM;
 			goto fail;
 		}
-		err = devm_request_irq(&pdev->dev, err_irq,
+		err = devm_request_irq(dev, err_irq,
 				       rcar_canfd_channel_err_interrupt, 0,
 				       irq_name, priv);
 		if (err) {
-			dev_err(&pdev->dev, "devm_request_irq CH Err(%d) failed, error %d\n",
+			dev_err(dev, "devm_request_irq CH Err(%d) failed, error %d\n",
 				err_irq, err);
 			goto fail;
 		}
-		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-					  "canfd.ch%d_trx", ch);
+		irq_name = devm_kasprintf(dev, GFP_KERNEL, "canfd.ch%d_trx",
+					  ch);
 		if (!irq_name) {
 			err = -ENOMEM;
 			goto fail;
 		}
-		err = devm_request_irq(&pdev->dev, tx_irq,
+		err = devm_request_irq(dev, tx_irq,
 				       rcar_canfd_channel_tx_interrupt, 0,
 				       irq_name, priv);
 		if (err) {
-			dev_err(&pdev->dev, "devm_request_irq Tx (%d) failed, error %d\n",
+			dev_err(dev, "devm_request_irq Tx (%d) failed, error %d\n",
 				tx_irq, err);
 			goto fail;
 		}
@@ -1793,7 +1794,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	priv->can.do_set_mode = rcar_canfd_do_set_mode;
 	priv->can.do_get_berr_counter = rcar_canfd_get_berr_counter;
-	SET_NETDEV_DEV(ndev, &pdev->dev);
+	SET_NETDEV_DEV(ndev, dev);
 
 	netif_napi_add_weight(ndev, &priv->napi, rcar_canfd_rx_poll,
 			      RCANFD_NAPI_WEIGHT);
@@ -1801,11 +1802,10 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	gpriv->ch[priv->channel] = priv;
 	err = register_candev(ndev);
 	if (err) {
-		dev_err(&pdev->dev,
-			"register_candev() failed, error %d\n", err);
+		dev_err(dev, "register_candev() failed, error %d\n", err);
 		goto fail_candev;
 	}
-	dev_info(&pdev->dev, "device registered (channel %u)\n", priv->channel);
+	dev_info(dev, "device registered (channel %u)\n", priv->channel);
 	return 0;
 
 fail_candev:
@@ -1829,6 +1829,7 @@ static void rcar_canfd_channel_remove(struct rcar_canfd_global *gpriv, u32 ch)
 static int rcar_canfd_probe(struct platform_device *pdev)
 {
 	const struct rcar_canfd_hw_info *info;
+	struct device *dev = &pdev->dev;
 	void __iomem *addr;
 	u32 sts, ch, fcan_freq;
 	struct rcar_canfd_global *gpriv;
@@ -1841,14 +1842,14 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	char name[9] = "channelX";
 	int i;
 
-	info = of_device_get_match_data(&pdev->dev);
+	info = of_device_get_match_data(dev);
 
-	if (of_property_read_bool(pdev->dev.of_node, "renesas,no-can-fd"))
+	if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
 		fdmode = false;			/* Classical CAN only mode */
 
 	for (i = 0; i < info->max_channels; ++i) {
 		name[7] = '0' + i;
-		of_child = of_get_child_by_name(pdev->dev.of_node, name);
+		of_child = of_get_child_by_name(dev->of_node, name);
 		if (of_child && of_device_is_available(of_child))
 			channels_mask |= BIT(i);
 		of_node_put(of_child);
@@ -1881,7 +1882,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	}
 
 	/* Global controller context */
-	gpriv = devm_kzalloc(&pdev->dev, sizeof(*gpriv), GFP_KERNEL);
+	gpriv = devm_kzalloc(dev, sizeof(*gpriv), GFP_KERNEL);
 	if (!gpriv)
 		return -ENOMEM;
 
@@ -1890,32 +1891,30 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->fdmode = fdmode;
 	gpriv->info = info;
 
-	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(&pdev->dev,
-								 "rstp_n");
+	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
 	if (IS_ERR(gpriv->rstc1))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc1),
+		return dev_err_probe(dev, PTR_ERR(gpriv->rstc1),
 				     "failed to get rstp_n\n");
 
-	gpriv->rstc2 = devm_reset_control_get_optional_exclusive(&pdev->dev,
-								 "rstc_n");
+	gpriv->rstc2 = devm_reset_control_get_optional_exclusive(dev, "rstc_n");
 	if (IS_ERR(gpriv->rstc2))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc2),
+		return dev_err_probe(dev, PTR_ERR(gpriv->rstc2),
 				     "failed to get rstc_n\n");
 
 	/* Peripheral clock */
-	gpriv->clkp = devm_clk_get(&pdev->dev, "fck");
+	gpriv->clkp = devm_clk_get(dev, "fck");
 	if (IS_ERR(gpriv->clkp))
-		return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->clkp),
+		return dev_err_probe(dev, PTR_ERR(gpriv->clkp),
 				     "cannot get peripheral clock\n");
 
 	/* fCAN clock: Pick External clock. If not available fallback to
 	 * CANFD clock
 	 */
-	gpriv->can_clk = devm_clk_get(&pdev->dev, "can_clk");
+	gpriv->can_clk = devm_clk_get(dev, "can_clk");
 	if (IS_ERR(gpriv->can_clk) || (clk_get_rate(gpriv->can_clk) == 0)) {
-		gpriv->can_clk = devm_clk_get(&pdev->dev, "canfd");
+		gpriv->can_clk = devm_clk_get(dev, "canfd");
 		if (IS_ERR(gpriv->can_clk))
-			return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->can_clk),
+			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
 					     "cannot get canfd clock\n");
 
 		gpriv->fcan = RCANFD_CANFDCLK;
@@ -1938,39 +1937,38 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	/* Request IRQ that's common for both channels */
 	if (info->shared_global_irqs) {
-		err = devm_request_irq(&pdev->dev, ch_irq,
+		err = devm_request_irq(dev, ch_irq,
 				       rcar_canfd_channel_interrupt, 0,
 				       "canfd.ch_int", gpriv);
 		if (err) {
-			dev_err(&pdev->dev, "devm_request_irq(%d) failed, error %d\n",
+			dev_err(dev, "devm_request_irq(%d) failed, error %d\n",
 				ch_irq, err);
 			goto fail_dev;
 		}
 
-		err = devm_request_irq(&pdev->dev, g_irq,
-				       rcar_canfd_global_interrupt, 0,
-				       "canfd.g_int", gpriv);
+		err = devm_request_irq(dev, g_irq, rcar_canfd_global_interrupt,
+				       0, "canfd.g_int", gpriv);
 		if (err) {
-			dev_err(&pdev->dev, "devm_request_irq(%d) failed, error %d\n",
+			dev_err(dev, "devm_request_irq(%d) failed, error %d\n",
 				g_irq, err);
 			goto fail_dev;
 		}
 	} else {
-		err = devm_request_irq(&pdev->dev, g_recc_irq,
+		err = devm_request_irq(dev, g_recc_irq,
 				       rcar_canfd_global_receive_fifo_interrupt, 0,
 				       "canfd.g_recc", gpriv);
 
 		if (err) {
-			dev_err(&pdev->dev, "devm_request_irq(%d) failed, error %d\n",
+			dev_err(dev, "devm_request_irq(%d) failed, error %d\n",
 				g_recc_irq, err);
 			goto fail_dev;
 		}
 
-		err = devm_request_irq(&pdev->dev, g_err_irq,
+		err = devm_request_irq(dev, g_err_irq,
 				       rcar_canfd_global_err_interrupt, 0,
 				       "canfd.g_err", gpriv);
 		if (err) {
-			dev_err(&pdev->dev, "devm_request_irq(%d) failed, error %d\n",
+			dev_err(dev, "devm_request_irq(%d) failed, error %d\n",
 				g_err_irq, err);
 			goto fail_dev;
 		}
@@ -1988,14 +1986,14 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	/* Enable peripheral clock for register access */
 	err = clk_prepare_enable(gpriv->clkp);
 	if (err) {
-		dev_err(&pdev->dev,
-			"failed to enable peripheral clock, error %d\n", err);
+		dev_err(dev, "failed to enable peripheral clock, error %d\n",
+			err);
 		goto fail_reset;
 	}
 
 	err = rcar_canfd_reset_controller(gpriv);
 	if (err) {
-		dev_err(&pdev->dev, "reset controller failed\n");
+		dev_err(dev, "reset controller failed\n");
 		goto fail_clk;
 	}
 
@@ -2026,7 +2024,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	err = readl_poll_timeout((gpriv->base + RCANFD_GSTS), sts,
 				 !(sts & RCANFD_GSTS_GNOPM), 2, 500000);
 	if (err) {
-		dev_err(&pdev->dev, "global operational mode failed\n");
+		dev_err(dev, "global operational mode failed\n");
 		goto fail_mode;
 	}
 
@@ -2037,7 +2035,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, gpriv);
-	dev_info(&pdev->dev, "global operational state (clk %d, fdmode %d)\n",
+	dev_info(dev, "global operational state (clk %d, fdmode %d)\n",
 		 gpriv->fcan, gpriv->fdmode);
 	return 0;
 
-- 
2.43.0


