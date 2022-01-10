Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045CCC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:18 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554248"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6552B42AC9FF;
	Mon, 10 Jan 2022 21:24:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 34/61] ravb: Add nc_queue to struct ravb_hw_info
Date: Mon, 10 Jan 2022 12:23:04 +0000
Message-Id: <20220110122331.24114-35-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7399

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a92f4f0662bf2c06c77688517493d0fb48c09fbd upstream.

R-Car supports network control queue whereas RZ/G2L does not support
it. Add nc_queue to struct ravb_hw_info, so that NC queue is handled
only by R-Car.

This patch also renames ravb_rcar_dmac_init to ravb_dmac_init_rcar
to be consistent with the naming convention used in sh_eth driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |   3 +-
 drivers/net/ethernet/renesas/ravb_main.c | 140 +++++++++++++++--------
 2 files changed, 94 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 5ed22951ccf2..c343fd813cd5 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -987,7 +987,7 @@ struct ravb_hw_info {
 	bool (*receive)(struct net_device *ndev, int *quota, int q);
 	void (*set_rate)(struct net_device *ndev);
 	int (*set_feature)(struct net_device *ndev, netdev_features_t features);
-	void (*dmac_init)(struct net_device *ndev);
+	int (*dmac_init)(struct net_device *ndev);
 	void (*emac_init)(struct net_device *ndev);
 	const char (*gstrings_stats)[ETH_GSTRING_LEN];
 	size_t gstrings_size;
@@ -1003,6 +1003,7 @@ struct ravb_hw_info {
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 	unsigned gptp:1;		/* AVB-DMAC has gPTP support */
 	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
+	unsigned nc_queue:1;		/* AVB-DMAC has NC queue */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3b6e9fc39e3a..4806c07efc49 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -459,10 +459,24 @@ static void ravb_emac_init(struct net_device *ndev)
 	info->emac_init(ndev);
 }
 
-static void ravb_rcar_dmac_init(struct net_device *ndev)
+static int ravb_dmac_init_rcar(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	error = ravb_ring_init(ndev, RAVB_BE);
+	if (error)
+		return error;
+	error = ravb_ring_init(ndev, RAVB_NC);
+	if (error) {
+		ravb_ring_free(ndev, RAVB_BE);
+		return error;
+	}
+
+	/* Descriptor format */
+	ravb_ring_format(ndev, RAVB_BE);
+	ravb_ring_format(ndev, RAVB_NC);
 
 	/* Set AVB RX */
 	ravb_write(ndev,
@@ -489,6 +503,8 @@ static void ravb_rcar_dmac_init(struct net_device *ndev)
 	ravb_write(ndev, RIC2_QFE0 | RIC2_QFE1 | RIC2_RFFE, RIC2);
 	/* Frame transmitted, timestamp FIFO updated */
 	ravb_write(ndev, TIC_FTE0 | TIC_FTE1 | TIC_TFUE, TIC);
+
+	return 0;
 }
 
 /* Device init function for Ethernet AVB */
@@ -503,20 +519,9 @@ static int ravb_dmac_init(struct net_device *ndev)
 	if (error)
 		return error;
 
-	error = ravb_ring_init(ndev, RAVB_BE);
+	error = info->dmac_init(ndev);
 	if (error)
 		return error;
-	error = ravb_ring_init(ndev, RAVB_NC);
-	if (error) {
-		ravb_ring_free(ndev, RAVB_BE);
-		return error;
-	}
-
-	/* Descriptor format */
-	ravb_ring_format(ndev, RAVB_BE);
-	ravb_ring_format(ndev, RAVB_NC);
-
-	info->dmac_init(ndev);
 
 	/* Setting the control will start the AVB-DMAC process. */
 	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
@@ -857,6 +862,7 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev = dev_id;
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	irqreturn_t result = IRQ_NONE;
 	u32 iss;
 
@@ -873,8 +879,13 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 			result = IRQ_HANDLED;
 
 		/* Network control and best effort queue RX/TX */
-		for (q = RAVB_NC; q >= RAVB_BE; q--) {
-			if (ravb_queue_interrupt(ndev, q))
+		if (info->nc_queue) {
+			for (q = RAVB_NC; q >= RAVB_BE; q--) {
+				if (ravb_queue_interrupt(ndev, q))
+					result = IRQ_HANDLED;
+			}
+		} else {
+			if (ravb_queue_interrupt(ndev, RAVB_BE))
 				result = IRQ_HANDLED;
 		}
 	}
@@ -998,7 +1009,8 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 
 	/* Receive error message handling */
 	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;
-	priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
+	if (info->nc_queue)
+		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
 	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
 		ndev->stats.rx_over_errors = priv->rx_over_errors;
 	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
@@ -1206,11 +1218,14 @@ static void ravb_get_ethtool_stats(struct net_device *ndev,
 				   struct ethtool_stats *estats, u64 *data)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	int num_rx_q;
 	int i = 0;
 	int q;
 
+	num_rx_q = info->nc_queue ? NUM_RX_QUEUE : 1;
 	/* Device-specific stats */
-	for (q = RAVB_BE; q < NUM_RX_QUEUE; q++) {
+	for (q = RAVB_BE; q < num_rx_q; q++) {
 		struct net_device_stats *stats = &priv->stats[q];
 
 		data[i++] = priv->cur_rx[q];
@@ -1285,7 +1300,8 @@ static int ravb_set_ringparam(struct net_device *ndev,
 
 		/* Free all the skb's in the RX queue and the DMA buffers. */
 		ravb_ring_free(ndev, RAVB_BE);
-		ravb_ring_free(ndev, RAVB_NC);
+		if (info->nc_queue)
+			ravb_ring_free(ndev, RAVB_NC);
 	}
 
 	/* Set new parameters */
@@ -1401,7 +1417,8 @@ static int ravb_open(struct net_device *ndev)
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
-	napi_enable(&priv->napi[RAVB_NC]);
+	if (info->nc_queue)
+		napi_enable(&priv->napi[RAVB_NC]);
 
 	if (!info->multi_irqs) {
 		error = request_irq(ndev->irq, ravb_interrupt, IRQF_SHARED,
@@ -1475,7 +1492,8 @@ static int ravb_open(struct net_device *ndev)
 out_free_irq:
 	free_irq(ndev->irq, ndev);
 out_napi_off:
-	napi_disable(&priv->napi[RAVB_NC]);
+	if (info->nc_queue)
+		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
 	return error;
 }
@@ -1524,7 +1542,8 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	}
 
 	ravb_ring_free(ndev, RAVB_BE);
-	ravb_ring_free(ndev, RAVB_NC);
+	if (info->nc_queue)
+		ravb_ring_free(ndev, RAVB_NC);
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
@@ -1696,28 +1715,38 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 
 	nstats = &ndev->stats;
 	stats0 = &priv->stats[RAVB_BE];
-	stats1 = &priv->stats[RAVB_NC];
 
 	if (info->tx_counters) {
 		nstats->tx_dropped += ravb_read(ndev, TROCR);
 		ravb_write(ndev, 0, TROCR);	/* (write clear) */
 	}
 
-	nstats->rx_packets = stats0->rx_packets + stats1->rx_packets;
-	nstats->tx_packets = stats0->tx_packets + stats1->tx_packets;
-	nstats->rx_bytes = stats0->rx_bytes + stats1->rx_bytes;
-	nstats->tx_bytes = stats0->tx_bytes + stats1->tx_bytes;
-	nstats->multicast = stats0->multicast + stats1->multicast;
-	nstats->rx_errors = stats0->rx_errors + stats1->rx_errors;
-	nstats->rx_crc_errors = stats0->rx_crc_errors + stats1->rx_crc_errors;
-	nstats->rx_frame_errors =
-		stats0->rx_frame_errors + stats1->rx_frame_errors;
-	nstats->rx_length_errors =
-		stats0->rx_length_errors + stats1->rx_length_errors;
-	nstats->rx_missed_errors =
-		stats0->rx_missed_errors + stats1->rx_missed_errors;
-	nstats->rx_over_errors =
-		stats0->rx_over_errors + stats1->rx_over_errors;
+	nstats->rx_packets = stats0->rx_packets;
+	nstats->tx_packets = stats0->tx_packets;
+	nstats->rx_bytes = stats0->rx_bytes;
+	nstats->tx_bytes = stats0->tx_bytes;
+	nstats->multicast = stats0->multicast;
+	nstats->rx_errors = stats0->rx_errors;
+	nstats->rx_crc_errors = stats0->rx_crc_errors;
+	nstats->rx_frame_errors = stats0->rx_frame_errors;
+	nstats->rx_length_errors = stats0->rx_length_errors;
+	nstats->rx_missed_errors = stats0->rx_missed_errors;
+	nstats->rx_over_errors = stats0->rx_over_errors;
+	if (info->nc_queue) {
+		stats1 = &priv->stats[RAVB_NC];
+
+		nstats->rx_packets += stats1->rx_packets;
+		nstats->tx_packets += stats1->tx_packets;
+		nstats->rx_bytes += stats1->rx_bytes;
+		nstats->tx_bytes += stats1->tx_bytes;
+		nstats->multicast += stats1->multicast;
+		nstats->rx_errors += stats1->rx_errors;
+		nstats->rx_crc_errors += stats1->rx_crc_errors;
+		nstats->rx_frame_errors += stats1->rx_frame_errors;
+		nstats->rx_length_errors += stats1->rx_length_errors;
+		nstats->rx_missed_errors += stats1->rx_missed_errors;
+		nstats->rx_over_errors += stats1->rx_over_errors;
+	}
 
 	return nstats;
 }
@@ -1782,12 +1811,14 @@ static int ravb_close(struct net_device *ndev)
 	}
 	free_irq(ndev->irq, ndev);
 
-	napi_disable(&priv->napi[RAVB_NC]);
+	if (info->nc_queue)
+		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
 
 	/* Free all the skb's in the RX queue and the DMA buffers. */
 	ravb_ring_free(ndev, RAVB_BE);
-	ravb_ring_free(ndev, RAVB_NC);
+	if (info->nc_queue)
+		ravb_ring_free(ndev, RAVB_NC);
 
 	return 0;
 }
@@ -2005,7 +2036,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.receive = ravb_rcar_rx,
 	.set_rate = ravb_set_rate,
 	.set_feature = ravb_set_features_rcar,
-	.dmac_init = ravb_rcar_dmac_init,
+	.dmac_init = ravb_dmac_init_rcar,
 	.emac_init = ravb_rcar_emac_init,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
@@ -2017,6 +2048,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.ccc_gac = 1,
+	.nc_queue = 1,
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
@@ -2026,7 +2058,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.receive = ravb_rcar_rx,
 	.set_rate = ravb_set_rate,
 	.set_feature = ravb_set_features_rcar,
-	.dmac_init = ravb_rcar_dmac_init,
+	.dmac_init = ravb_dmac_init_rcar,
 	.emac_init = ravb_rcar_emac_init,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
@@ -2036,6 +2068,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.aligned_tx = 1,
 	.gptp = 1,
+	.nc_queue = 1,
 };
 
 static const struct of_device_id ravb_match_table[] = {
@@ -2190,8 +2223,11 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
-	priv->num_tx_ring[RAVB_NC] = NC_TX_RING_SIZE;
-	priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
+	if (info->nc_queue) {
+		priv->num_tx_ring[RAVB_NC] = NC_TX_RING_SIZE;
+		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
+	}
+
 	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->addr)) {
 		error = PTR_ERR(priv->addr);
@@ -2321,7 +2357,8 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 
 	netif_napi_add(ndev, &priv->napi[RAVB_BE], ravb_poll, 64);
-	netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll, 64);
+	if (info->nc_queue)
+		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll, 64);
 
 	/* Network device register */
 	error = register_netdev(ndev);
@@ -2339,7 +2376,9 @@ static int ravb_probe(struct platform_device *pdev)
 	return 0;
 
 out_napi_del:
-	netif_napi_del(&priv->napi[RAVB_NC]);
+	if (info->nc_queue)
+		netif_napi_del(&priv->napi[RAVB_NC]);
+
 	netif_napi_del(&priv->napi[RAVB_BE]);
 	ravb_mdio_release(priv);
 out_dma_free:
@@ -2378,7 +2417,8 @@ static int ravb_remove(struct platform_device *pdev)
 	ravb_write(ndev, CCC_OPC_RESET, CCC);
 	pm_runtime_put_sync(&pdev->dev);
 	unregister_netdev(ndev);
-	netif_napi_del(&priv->napi[RAVB_NC]);
+	if (info->nc_queue)
+		netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
 	ravb_mdio_release(priv);
 	pm_runtime_disable(&pdev->dev);
@@ -2392,6 +2432,7 @@ static int ravb_remove(struct platform_device *pdev)
 static int ravb_wol_setup(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 
 	/* Disable interrupts by clearing the interrupt masks. */
 	ravb_write(ndev, 0, RIC0);
@@ -2400,7 +2441,8 @@ static int ravb_wol_setup(struct net_device *ndev)
 
 	/* Only allow ECI interrupts */
 	synchronize_irq(priv->emac_irq);
-	napi_disable(&priv->napi[RAVB_NC]);
+	if (info->nc_queue)
+		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
 	ravb_write(ndev, ECSIPR_MPDIP, ECSIPR);
 
@@ -2413,9 +2455,11 @@ static int ravb_wol_setup(struct net_device *ndev)
 static int ravb_wol_restore(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	int ret;
 
-	napi_enable(&priv->napi[RAVB_NC]);
+	if (info->nc_queue)
+		napi_enable(&priv->napi[RAVB_NC]);
 	napi_enable(&priv->napi[RAVB_BE]);
 
 	/* Disable MagicPacket */
-- 
2.17.1


