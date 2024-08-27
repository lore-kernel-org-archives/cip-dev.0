Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A045FC54736
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 21:06:30 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1428.1724792780365255921
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 14:06:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.10,181,1719846000"; 
   d="scan'208";a="216747513"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Aug 2024 06:06:19 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B4B7940031E3;
	Wed, 28 Aug 2024 06:06:17 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y cip v2 3/9] net: ravb: Refactor RX ring refill
Date: Tue, 27 Aug 2024 22:06:03 +0100
Message-Id: <20240827210609.12695-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
References: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 21:06:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16822

commit 37a01c12e9e89fe2545657d7b42ca2de9c780c45 upstream.

To reduce code duplication, we add a new RX ring refill function which
can handle both the initial RX ring population (which was split between
ravb_ring_init() and ravb_ring_format()) and the RX ring refill after
polling (in ravb_rx()).

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 150 +++++++++--------------
 1 file changed, 57 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 3e4769af3c84..04df3c93bb54 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -319,35 +319,43 @@ static void ravb_ring_free(struct net_device *ndev, int q)
 	priv->tx_skb[q] = NULL;
 }
 
-static void ravb_rx_ring_format(struct net_device *ndev, int q)
+static u32
+ravb_rx_ring_refill(struct net_device *ndev, int q, u32 count, gfp_t gfp_mask)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	struct ravb_rx_desc *rx_desc;
-	unsigned int rx_ring_size;
 	dma_addr_t dma_addr;
-	unsigned int i;
+	u32 i, entry;
 
-	rx_ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
-	memset(priv->rx_ring[q].raw, 0, rx_ring_size);
-	/* Build RX ring buffer */
-	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		/* RX descriptor */
-		rx_desc = ravb_rx_get_desc(priv, q, i);
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
+	for (i = 0; i < count; i++) {
+		entry = (priv->dirty_rx[q] + i) % priv->num_rx_ring[q];
+		rx_desc = ravb_rx_get_desc(priv, q, entry);
+		rx_desc->ds_cc = cpu_to_le16(info->rx_max_desc_use);
+
+		if (!priv->rx_skb[q][entry]) {
+			priv->rx_skb[q][entry] = ravb_alloc_skb(ndev, info,
+								gfp_mask);
+			if (!priv->rx_skb[q][entry])
+				break;
+			dma_addr = dma_map_single(ndev->dev.parent,
+						  priv->rx_skb[q][entry]->data,
+						  priv->info->rx_max_frame_size,
+						  DMA_FROM_DEVICE);
+			skb_checksum_none_assert(priv->rx_skb[q][entry]);
+			/* We just set the data size to 0 for a failed mapping
+			 * which should prevent DMA from happening...
+			 */
+			if (dma_mapping_error(ndev->dev.parent, dma_addr))
+				rx_desc->ds_cc = cpu_to_le16(0);
+			rx_desc->dptr = cpu_to_le32(dma_addr);
+		}
+		/* Descriptor type must be set after all the above writes */
+		dma_wmb();
 		rx_desc->die_dt = DT_FEMPTY;
 	}
-	rx_desc = ravb_rx_get_desc(priv, q, i);
-	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
-	rx_desc->die_dt = DT_LINKFIX; /* type */
+
+	return i;
 }
 
 /* Format skb and descriptor buffer for Ethernet AVB */
@@ -355,6 +363,7 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned int num_tx_desc = priv->num_tx_desc;
+	struct ravb_rx_desc *rx_desc;
 	struct ravb_tx_desc *tx_desc;
 	struct ravb_desc *desc;
 	unsigned int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
@@ -366,7 +375,13 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 	priv->dirty_rx[q] = 0;
 	priv->dirty_tx[q] = 0;
 
-	ravb_rx_ring_format(ndev, q);
+	/* Regular RX descriptors have already been initialized by
+	 * ravb_rx_ring_refill(), we just need to initialize the final link
+	 * descriptor.
+	 */
+	rx_desc = ravb_rx_get_desc(priv, q, priv->num_rx_ring[q]);
+	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
+	rx_desc->die_dt = DT_LINKFIX; /* type */
 
 	memset(priv->tx_ring[q], 0, tx_ring_size);
 	/* Build TX ring buffer */
@@ -410,11 +425,9 @@ static void *ravb_alloc_rx_desc(struct net_device *ndev, int q)
 static int ravb_ring_init(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	unsigned int num_tx_desc = priv->num_tx_desc;
 	unsigned int ring_size;
-	struct sk_buff *skb;
-	unsigned int i;
+	u32 num_filled;
 
 	/* Allocate RX and TX skb rings */
 	priv->rx_skb[q] = kcalloc(priv->num_rx_ring[q],
@@ -424,12 +437,18 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 	if (!priv->rx_skb[q] || !priv->tx_skb[q])
 		goto error;
 
-	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		skb = ravb_alloc_skb(ndev, info, GFP_KERNEL);
-		if (!skb)
-			goto error;
-		priv->rx_skb[q][i] = skb;
-	}
+	/* Allocate all RX descriptors. */
+	if (!ravb_alloc_rx_desc(ndev, q))
+		goto error;
+
+	/* Populate RX ring buffer. */
+	priv->dirty_rx[q] = 0;
+	ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
+	memset(priv->rx_ring[q].raw, 0, ring_size);
+	num_filled = ravb_rx_ring_refill(ndev, q, priv->num_rx_ring[q],
+					 GFP_KERNEL);
+	if (num_filled != priv->num_rx_ring[q])
+		goto error;
 
 	if (num_tx_desc > 1) {
 		/* Allocate rings for the aligned buffers */
@@ -439,12 +458,6 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 			goto error;
 	}
 
-	/* Allocate all RX descriptors. */
-	if (!ravb_alloc_rx_desc(ndev, q))
-		goto error;
-
-	priv->dirty_rx[q] = 0;
-
 	/* Allocate all TX descriptors. */
 	ring_size = sizeof(struct ravb_tx_desc) *
 		    (priv->num_tx_ring[q] * num_tx_desc + 1);
@@ -764,11 +777,9 @@ static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
 static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *stats;
 	struct ravb_rx_desc *desc;
 	struct sk_buff *skb;
-	dma_addr_t dma_addr;
 	int rx_packets = 0;
 	u8  desc_status;
 	u16 desc_len;
@@ -856,32 +867,9 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 	}
 
 	/* Refill the RX ring buffers. */
-	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
-		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q].desc[entry];
-		desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
-
-		if (!priv->rx_skb[q][entry]) {
-			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
-			if (!skb)
-				break;
-			dma_addr = dma_map_single(ndev->dev.parent,
-						  skb->data,
-						  priv->info->rx_max_frame_size,
-						  DMA_FROM_DEVICE);
-			skb_checksum_none_assert(skb);
-			/* We just set the data size to 0 for a failed mapping
-			 * which should prevent DMA  from happening...
-			 */
-			if (dma_mapping_error(ndev->dev.parent, dma_addr))
-				desc->ds_cc = cpu_to_le16(0);
-			desc->dptr = cpu_to_le32(dma_addr);
-			priv->rx_skb[q][entry] = skb;
-		}
-		/* Descriptor type must be set after all the above writes */
-		dma_wmb();
-		desc->die_dt = DT_FEMPTY;
-	}
+	priv->dirty_rx[q] += ravb_rx_ring_refill(ndev, q,
+						 priv->cur_rx[q] - priv->dirty_rx[q],
+						 GFP_ATOMIC);
 
 	stats->rx_packets += rx_packets;
 	return rx_packets;
@@ -891,12 +879,10 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *stats = &priv->stats[q];
 	struct ravb_ex_rx_desc *desc;
 	unsigned int limit, i;
 	struct sk_buff *skb;
-	dma_addr_t dma_addr;
 	struct timespec64 ts;
 	int rx_packets = 0;
 	u8  desc_status;
@@ -966,31 +952,9 @@ static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 	}
 
 	/* Refill the RX ring buffers. */
-	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
-		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q].ex_desc[entry];
-		desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
-
-		if (!priv->rx_skb[q][entry]) {
-			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
-			if (!skb)
-				break;	/* Better luck next round. */
-			dma_addr = dma_map_single(ndev->dev.parent, skb->data,
-						  priv->info->rx_max_frame_size,
-						  DMA_FROM_DEVICE);
-			skb_checksum_none_assert(skb);
-			/* We just set the data size to 0 for a failed mapping
-			 * which should prevent DMA  from happening...
-			 */
-			if (dma_mapping_error(ndev->dev.parent, dma_addr))
-				desc->ds_cc = cpu_to_le16(0);
-			desc->dptr = cpu_to_le32(dma_addr);
-			priv->rx_skb[q][entry] = skb;
-		}
-		/* Descriptor type must be set after all the above writes */
-		dma_wmb();
-		desc->die_dt = DT_FEMPTY;
-	}
+	priv->dirty_rx[q] += ravb_rx_ring_refill(ndev, q,
+						 priv->cur_rx[q] - priv->dirty_rx[q],
+						 GFP_ATOMIC);
 
 	stats->rx_packets += rx_packets;
 	return rx_packets;
-- 
2.43.0


