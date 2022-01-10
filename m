Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095BFC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:46 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:45 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554305"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7E39E42AC9F0;
	Mon, 10 Jan 2022 21:24:43 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 55/61] ravb: Rename "nc_queue" feature bit
Date: Mon, 10 Jan 2022 12:23:25 +0000
Message-Id: <20220110122331.24114-56-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7420

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1091da579d7ccdba887bdfd11e31a23be694bbd0 upstream.

Rename the feature bit "nc_queue" with "nc_queues" as AVB DMAC has
RX and TX NC queues.

There is no functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 36 ++++++++++++------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 99d666a5fb49..5d07732ef35a 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1023,7 +1023,7 @@ struct ravb_hw_info {
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 	unsigned gptp:1;		/* AVB-DMAC has gPTP support */
 	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
-	unsigned nc_queue:1;		/* AVB-DMAC has NC queue */
+	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
 	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
 };
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 9de47566feef..a02ea91c81f5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1174,7 +1174,7 @@ static irqreturn_t ravb_interrupt(int irq, void *dev_id)
 			result = IRQ_HANDLED;
 
 		/* Network control and best effort queue RX/TX */
-		if (info->nc_queue) {
+		if (info->nc_queues) {
 			for (q = RAVB_NC; q >= RAVB_BE; q--) {
 				if (ravb_queue_interrupt(ndev, q))
 					result = IRQ_HANDLED;
@@ -1313,7 +1313,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 
 	/* Receive error message handling */
 	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;
-	if (info->nc_queue)
+	if (info->nc_queues)
 		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
 	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
 		ndev->stats.rx_over_errors = priv->rx_over_errors;
@@ -1564,7 +1564,7 @@ static void ravb_get_ethtool_stats(struct net_device *ndev,
 	int i = 0;
 	int q;
 
-	num_rx_q = info->nc_queue ? NUM_RX_QUEUE : 1;
+	num_rx_q = info->nc_queues ? NUM_RX_QUEUE : 1;
 	/* Device-specific stats */
 	for (q = RAVB_BE; q < num_rx_q; q++) {
 		struct net_device_stats *stats = &priv->stats[q];
@@ -1641,7 +1641,7 @@ static int ravb_set_ringparam(struct net_device *ndev,
 
 		/* Free all the skb's in the RX queue and the DMA buffers. */
 		ravb_ring_free(ndev, RAVB_BE);
-		if (info->nc_queue)
+		if (info->nc_queues)
 			ravb_ring_free(ndev, RAVB_NC);
 	}
 
@@ -1761,7 +1761,7 @@ static int ravb_open(struct net_device *ndev)
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
-	if (info->nc_queue)
+	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
 	if (!info->multi_irqs) {
@@ -1836,7 +1836,7 @@ static int ravb_open(struct net_device *ndev)
 out_free_irq:
 	free_irq(ndev->irq, ndev);
 out_napi_off:
-	if (info->nc_queue)
+	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
 	return error;
@@ -1886,7 +1886,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	}
 
 	ravb_ring_free(ndev, RAVB_BE);
-	if (info->nc_queue)
+	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
 	/* Device init */
@@ -2086,7 +2086,7 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 	nstats->rx_length_errors = stats0->rx_length_errors;
 	nstats->rx_missed_errors = stats0->rx_missed_errors;
 	nstats->rx_over_errors = stats0->rx_over_errors;
-	if (info->nc_queue) {
+	if (info->nc_queues) {
 		stats1 = &priv->stats[RAVB_NC];
 
 		nstats->rx_packets += stats1->rx_packets;
@@ -2167,13 +2167,13 @@ static int ravb_close(struct net_device *ndev)
 	}
 	free_irq(ndev->irq, ndev);
 
-	if (info->nc_queue)
+	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
 
 	/* Free all the skb's in the RX queue and the DMA buffers. */
 	ravb_ring_free(ndev, RAVB_BE);
-	if (info->nc_queue)
+	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
 	return 0;
@@ -2413,7 +2413,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.ccc_gac = 1,
-	.nc_queue = 1,
+	.nc_queues = 1,
 	.magic_pkt = 1,
 };
 
@@ -2436,7 +2436,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.rx_max_buf_size = SZ_2K,
 	.aligned_tx = 1,
 	.gptp = 1,
-	.nc_queue = 1,
+	.nc_queues = 1,
 	.magic_pkt = 1,
 };
 
@@ -2616,7 +2616,7 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
-	if (info->nc_queue) {
+	if (info->nc_queues) {
 		priv->num_tx_ring[RAVB_NC] = NC_TX_RING_SIZE;
 		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
 	}
@@ -2752,7 +2752,7 @@ static int ravb_probe(struct platform_device *pdev)
 	}
 
 	netif_napi_add(ndev, &priv->napi[RAVB_BE], ravb_poll, 64);
-	if (info->nc_queue)
+	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll, 64);
 
 	/* Network device register */
@@ -2771,7 +2771,7 @@ static int ravb_probe(struct platform_device *pdev)
 	return 0;
 
 out_napi_del:
-	if (info->nc_queue)
+	if (info->nc_queues)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 
 	netif_napi_del(&priv->napi[RAVB_BE]);
@@ -2812,7 +2812,7 @@ static int ravb_remove(struct platform_device *pdev)
 	ravb_write(ndev, CCC_OPC_RESET, CCC);
 	pm_runtime_put_sync(&pdev->dev);
 	unregister_netdev(ndev);
-	if (info->nc_queue)
+	if (info->nc_queues)
 		netif_napi_del(&priv->napi[RAVB_NC]);
 	netif_napi_del(&priv->napi[RAVB_BE]);
 	ravb_mdio_release(priv);
@@ -2836,7 +2836,7 @@ static int ravb_wol_setup(struct net_device *ndev)
 
 	/* Only allow ECI interrupts */
 	synchronize_irq(priv->emac_irq);
-	if (info->nc_queue)
+	if (info->nc_queues)
 		napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
 	ravb_write(ndev, ECSIPR_MPDIP, ECSIPR);
@@ -2853,7 +2853,7 @@ static int ravb_wol_restore(struct net_device *ndev)
 	const struct ravb_hw_info *info = priv->info;
 	int ret;
 
-	if (info->nc_queue)
+	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 	napi_enable(&priv->napi[RAVB_BE]);
 
-- 
2.17.1


