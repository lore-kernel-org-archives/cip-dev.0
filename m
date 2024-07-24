Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3262AC52CD8
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 08:01:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5794.1721808065589771953
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 01:01:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,232,1716217200"; 
   d="scan'208";a="216491410"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Jul 2024 17:01:05 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3512541D149E;
	Wed, 24 Jul 2024 17:01:02 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 07/11] ravb: Unify Rx ring maintenance code paths
Date: Wed, 24 Jul 2024 08:00:42 +0000
Message-Id: <20240724080046.1500825-8-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 08:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16606

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit 644d037b2c44692cf81a27b79f9824ae0a8055b3 upstream.

The R-Car and RZ/G2L Rx code paths were split in two separate
implementations when support for RZ/G2L was added due to the fact that
R-Car uses the extended descriptor format while RZ/G2L uses normal
descriptors. This has led to a duplication of Rx logic with the only
difference being the different Rx descriptors types used. The
implementation however neglects to take into account that extended
descriptors are normal descriptors with additional metadata at the end
to carry hardware timestamp information.

The hardware timestamp information is only consumed in the R-Car Rx
loop and all the maintenance code around the Rx ring can be shared
between the two implementations if the difference in descriptor length
is carefully considered.

This change merges the two implementations for Rx ring maintenance by
adding a method to access both types of descriptors as normal
descriptors, as this part covers all the fields needed for Rx ring
maintenance the only difference between using normal or extended
descriptor is the size of the memory region to allocate/free and the
step size between each descriptor in the ring.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |   5 +-
 drivers/net/ethernet/renesas/ravb_main.c | 134 ++++++-----------------
 2 files changed, 33 insertions(+), 106 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b12b379baf5a..b48935ec7e28 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1039,9 +1039,6 @@ struct ravb_ptp {
 };
 
 struct ravb_hw_info {
-	void (*rx_ring_free)(struct net_device *ndev, int q);
-	void (*rx_ring_format)(struct net_device *ndev, int q);
-	void *(*alloc_rx_desc)(struct net_device *ndev, int q);
 	bool (*receive)(struct net_device *ndev, int *quota, int q);
 	void (*set_rate)(struct net_device *ndev);
 	int (*set_feature)(struct net_device *ndev, netdev_features_t features);
@@ -1055,6 +1052,7 @@ struct ravb_hw_info {
 	u32 tccr_mask;
 	u32 rx_max_frame_size;
 	u32 rx_max_desc_use;
+	u32 rx_desc_size;
 	unsigned aligned_tx: 1;
 
 	/* hardware features */
@@ -1090,6 +1088,7 @@ struct ravb_private {
 	union {
 		struct ravb_rx_desc *desc;
 		struct ravb_ex_rx_desc *ex_desc;
+		void *raw;
 	} rx_ring[NUM_RX_QUEUE];
 	struct ravb_tx_desc *tx_ring[NUM_TX_QUEUE];
 	void *tx_align[NUM_TX_QUEUE];
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fa8400c9ccd4..a085f7f44aa3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -204,6 +204,13 @@ static const struct mdiobb_ops bb_ops = {
 	.get_mdio_data = ravb_get_mdio_data,
 };
 
+static struct ravb_rx_desc *
+ravb_rx_get_desc(struct ravb_private *priv, unsigned int q,
+		 unsigned int i)
+{
+	return priv->rx_ring[q].raw + priv->info->rx_desc_size * i;
+}
+
 /* Free TX skb function for AVB-IP */
 static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 {
@@ -248,17 +255,17 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 	return free_num;
 }
 
-static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
+static void ravb_rx_ring_free(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned int ring_size;
 	unsigned int i;
 
-	if (!priv->rx_ring[q].desc)
+	if (!priv->rx_ring[q].raw)
 		return;
 
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		struct ravb_rx_desc *desc = &priv->rx_ring[q].desc[i];
+		struct ravb_rx_desc *desc = ravb_rx_get_desc(priv, q, i);
 
 		if (!dma_mapping_error(ndev->dev.parent,
 				       le32_to_cpu(desc->dptr)))
@@ -267,48 +274,21 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
 					 priv->info->rx_max_frame_size,
 					 DMA_FROM_DEVICE);
 	}
-	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
-	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].desc,
+	ring_size = priv->info->rx_desc_size * (priv->num_rx_ring[q] + 1);
+	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].raw,
 			  priv->rx_desc_dma[q]);
-	priv->rx_ring[q].desc = NULL;
-}
-
-static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	unsigned int ring_size;
-	unsigned int i;
-
-	if (!priv->rx_ring[q].ex_desc)
-		return;
-
-	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q].ex_desc[i];
-
-		if (!dma_mapping_error(ndev->dev.parent,
-				       le32_to_cpu(desc->dptr)))
-			dma_unmap_single(ndev->dev.parent,
-					 le32_to_cpu(desc->dptr),
-					 priv->info->rx_max_frame_size,
-					 DMA_FROM_DEVICE);
-	}
-	ring_size = sizeof(struct ravb_ex_rx_desc) *
-		    (priv->num_rx_ring[q] + 1);
-	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].ex_desc,
-			  priv->rx_desc_dma[q]);
-	priv->rx_ring[q].ex_desc = NULL;
+	priv->rx_ring[q].raw = NULL;
 }
 
 /* Free skb's and DMA buffers for Ethernet AVB */
 static void ravb_ring_free(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	unsigned int num_tx_desc = priv->num_tx_desc;
 	unsigned int ring_size;
 	unsigned int i;
 
-	info->rx_ring_free(ndev, q);
+	ravb_rx_ring_free(ndev, q);
 
 	if (priv->tx_ring[q]) {
 		ravb_tx_free(ndev, q, false);
@@ -339,7 +319,7 @@ static void ravb_ring_free(struct net_device *ndev, int q)
 	priv->tx_skb[q] = NULL;
 }
 
-static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
+static void ravb_rx_ring_format(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	struct ravb_rx_desc *rx_desc;
@@ -347,42 +327,12 @@ static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
 	dma_addr_t dma_addr;
 	unsigned int i;
 
-	rx_ring_size = sizeof(*rx_desc) * priv->num_rx_ring[q];
-	memset(priv->rx_ring[q].desc, 0, rx_ring_size);
-	/* Build RX ring buffer */
-	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		/* RX descriptor */
-		rx_desc = &priv->rx_ring[q].desc[i];
-		rx_desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
-		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
-					  priv->info->rx_max_frame_size,
-					  DMA_FROM_DEVICE);
-		/* We just set the data size to 0 for a failed mapping which
-		 * should prevent DMA from happening...
-		 */
-		if (dma_mapping_error(ndev->dev.parent, dma_addr))
-			rx_desc->ds_cc = cpu_to_le16(0);
-		rx_desc->dptr = cpu_to_le32(dma_addr);
-		rx_desc->die_dt = DT_FEMPTY;
-	}
-	rx_desc = &priv->rx_ring[q].desc[i];
-	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
-	rx_desc->die_dt = DT_LINKFIX; /* type */
-}
-
-static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	struct ravb_ex_rx_desc *rx_desc;
-	unsigned int rx_ring_size = sizeof(*rx_desc) * priv->num_rx_ring[q];
-	dma_addr_t dma_addr;
-	unsigned int i;
-
-	memset(priv->rx_ring[q].ex_desc, 0, rx_ring_size);
+	rx_ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
+	memset(priv->rx_ring[q].raw, 0, rx_ring_size);
 	/* Build RX ring buffer */
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		/* RX descriptor */
-		rx_desc = &priv->rx_ring[q].ex_desc[i];
+		rx_desc = ravb_rx_get_desc(priv, q, i);
 		rx_desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
 					  priv->info->rx_max_frame_size,
@@ -395,7 +345,7 @@ static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
 		rx_desc->dptr = cpu_to_le32(dma_addr);
 		rx_desc->die_dt = DT_FEMPTY;
 	}
-	rx_desc = &priv->rx_ring[q].ex_desc[i];
+	rx_desc = ravb_rx_get_desc(priv, q, i);
 	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
 	rx_desc->die_dt = DT_LINKFIX; /* type */
 }
@@ -404,7 +354,6 @@ static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
 static void ravb_ring_format(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	unsigned int num_tx_desc = priv->num_tx_desc;
 	struct ravb_tx_desc *tx_desc;
 	struct ravb_desc *desc;
@@ -417,7 +366,7 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 	priv->dirty_rx[q] = 0;
 	priv->dirty_tx[q] = 0;
 
-	info->rx_ring_format(ndev, q);
+	ravb_rx_ring_format(ndev, q);
 
 	memset(priv->tx_ring[q], 0, tx_ring_size);
 	/* Build TX ring buffer */
@@ -443,31 +392,18 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 	desc->dptr = cpu_to_le32((u32)priv->tx_desc_dma[q]);
 }
 
-static void *ravb_alloc_rx_desc_gbeth(struct net_device *ndev, int q)
+static void *ravb_alloc_rx_desc(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned int ring_size;
 
-	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
-
-	priv->rx_ring[q].desc = dma_alloc_coherent(ndev->dev.parent, ring_size,
-						   &priv->rx_desc_dma[q],
-						   GFP_KERNEL);
-	return priv->rx_ring[q].desc;
-}
-
-static void *ravb_alloc_rx_desc_rcar(struct net_device *ndev, int q)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	unsigned int ring_size;
+	ring_size = priv->info->rx_desc_size * (priv->num_rx_ring[q] + 1);
 
-	ring_size = sizeof(struct ravb_ex_rx_desc) * (priv->num_rx_ring[q] + 1);
+	priv->rx_ring[q].raw = dma_alloc_coherent(ndev->dev.parent, ring_size,
+						  &priv->rx_desc_dma[q],
+						  GFP_KERNEL);
 
-	priv->rx_ring[q].ex_desc = dma_alloc_coherent(ndev->dev.parent,
-						      ring_size,
-						      &priv->rx_desc_dma[q],
-						      GFP_KERNEL);
-	return priv->rx_ring[q].ex_desc;
+	return priv->rx_ring[q].raw;
 }
 
 /* Init skb and descriptor buffer for Ethernet AVB */
@@ -504,7 +440,7 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 	}
 
 	/* Allocate all RX descriptors. */
-	if (!info->alloc_rx_desc(ndev, q))
+	if (!ravb_alloc_rx_desc(ndev, q))
 		goto error;
 
 	priv->dirty_rx[q] = 0;
@@ -2699,9 +2635,6 @@ static int ravb_mdio_release(struct ravb_private *priv)
 }
 
 static const struct ravb_hw_info ravb_gen3_hw_info = {
-	.rx_ring_free = ravb_rx_ring_free_rcar,
-	.rx_ring_format = ravb_rx_ring_format_rcar,
-	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
@@ -2715,6 +2648,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
 	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
+	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
@@ -2725,9 +2659,6 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
-	.rx_ring_free = ravb_rx_ring_free_rcar,
-	.rx_ring_format = ravb_rx_ring_format_rcar,
-	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
@@ -2741,6 +2672,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
 	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
+	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
 	.aligned_tx = 1,
 	.gptp = 1,
 	.nc_queues = 1,
@@ -2748,9 +2680,6 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 };
 
 static const struct ravb_hw_info ravb_rzv2m_hw_info = {
-	.rx_ring_free = ravb_rx_ring_free_rcar,
-	.rx_ring_format = ravb_rx_ring_format_rcar,
-	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
@@ -2764,6 +2693,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
 	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
+	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
 	.gptp = 1,
@@ -2773,9 +2703,6 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 };
 
 static const struct ravb_hw_info gbeth_hw_info = {
-	.rx_ring_free = ravb_rx_ring_free_gbeth,
-	.rx_ring_format = ravb_rx_ring_format_gbeth,
-	.alloc_rx_desc = ravb_alloc_rx_desc_gbeth,
 	.receive = ravb_rx_gbeth,
 	.set_rate = ravb_set_rate_gbeth,
 	.set_feature = ravb_set_features_gbeth,
@@ -2789,6 +2716,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.tccr_mask = TCCR_TSRQ0,
 	.rx_max_frame_size = SZ_8K,
 	.rx_max_desc_use = 4080,
+	.rx_desc_size = sizeof(struct ravb_rx_desc),
 	.aligned_tx = 1,
 	.tx_counters = 1,
 	.carrier_counters = 1,
-- 
2.25.1


