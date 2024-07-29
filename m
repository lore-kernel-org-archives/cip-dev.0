Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8E2C52CDA
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 14:30:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.57657.1722263418601965874
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 07:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213905636"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Jul 2024 23:30:22 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 748E3400EF68;
	Mon, 29 Jul 2024 23:30:20 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y cip 03/11] ravb: Create helper to allocate skb and align it
Date: Mon, 29 Jul 2024 14:30:03 +0000
Message-Id: <20240729143011.1920068-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
References: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 14:30:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16636

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit cfbad64706c1c9d555fba5dbb545967262bd9f17 upstream.

The EtherAVB device requires the SKB data to be aligned to 128 bytes.
The alignment is done by allocating an skb 128 bytes larger than the
maximum frame size supported by the device and adjusting the headroom to
fit the requirement.

This code has been refactored a few times and small issues have been
added along the way. The issues are not harmful but prevent merging
parts of the Rx code which have been split in two implementations with
the addition of RZ/G2L support, a device that supports larger frame
sizes.

This change removes the need for duplicated and somewhat inaccurate
hardware alignment constrains stored in the hardware information struct
by creating a helper to handle the allocation of an skb and alignment of
an skb data.

For the R-Car class of devices the maximum frame size is 4K and each
descriptor is limited to 2K of data. The current implementation does not
support split descriptors, this limits the frame size to 2K. The
current hardware information however records the descriptor size just
under 2K due to bad understanding of the device when larger MTUs where
added.

For the RZ/G2L device the maximum frame size is 8K and each descriptor
is limited to 4K of data. The current hardware information records this
correctly, but it gets the alignment constrains wrong as just aligns it
by 128, it does not extend it by 128 bytes to allow the full frame to be
stored. This works because the RZ/G2L device supports split descriptors
and allocates each skb to 8K and aligns each 4K descriptor in this
space.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 -
 drivers/net/ethernet/renesas/ravb_main.c | 43 +++++++++++++-----------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 87459cc22ebd..b15360b3a008 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1057,7 +1057,6 @@ struct ravb_hw_info {
 	netdev_features_t net_hw_features;
 	netdev_features_t net_features;
 	int stats_len;
-	size_t max_rx_len;
 	u32 tccr_mask;
 	u32 rx_max_frame_size;
 	unsigned aligned_tx: 1;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 60abb0940d12..48b2305c4118 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -115,12 +115,23 @@ static void ravb_set_rate_rcar(struct net_device *ndev)
 	}
 }
 
-static void ravb_set_buffer_align(struct sk_buff *skb)
+static struct sk_buff *
+ravb_alloc_skb(struct net_device *ndev, const struct ravb_hw_info *info,
+	       gfp_t gfp_mask)
 {
-	u32 reserve = (unsigned long)skb->data & (RAVB_ALIGN - 1);
+	struct sk_buff *skb;
+	u32 reserve;
+
+	skb = __netdev_alloc_skb(ndev, info->rx_max_frame_size + RAVB_ALIGN - 1,
+				 gfp_mask);
+	if (!skb)
+		return NULL;
 
+	reserve = (unsigned long)skb->data & (RAVB_ALIGN - 1);
 	if (reserve)
 		skb_reserve(skb, RAVB_ALIGN - reserve);
+
+	return skb;
 }
 
 /* Get MAC address from the MAC address registers
@@ -249,7 +260,7 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
 				       le32_to_cpu(desc->dptr)))
 			dma_unmap_single(ndev->dev.parent,
 					 le32_to_cpu(desc->dptr),
-					 GBETH_RX_BUFF_MAX,
+					 priv->info->rx_max_frame_size,
 					 DMA_FROM_DEVICE);
 	}
 	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
@@ -274,7 +285,7 @@ static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
 				       le32_to_cpu(desc->dptr)))
 			dma_unmap_single(ndev->dev.parent,
 					 le32_to_cpu(desc->dptr),
-					 RX_BUF_SZ,
+					 priv->info->rx_max_frame_size,
 					 DMA_FROM_DEVICE);
 	}
 	ring_size = sizeof(struct ravb_ex_rx_desc) *
@@ -340,7 +351,7 @@ static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
 		rx_desc = &priv->rx_ring[q].desc[i];
 		rx_desc->ds_cc = cpu_to_le16(GBETH_RX_DESC_DATA_SIZE);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
-					  GBETH_RX_BUFF_MAX,
+					  priv->info->rx_max_frame_size,
 					  DMA_FROM_DEVICE);
 		/* We just set the data size to 0 for a failed mapping which
 		 * should prevent DMA from happening...
@@ -370,7 +381,7 @@ static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
 		rx_desc = &priv->rx_ring[q].ex_desc[i];
 		rx_desc->ds_cc = cpu_to_le16(RX_BUF_SZ);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
-					  RX_BUF_SZ,
+					  priv->info->rx_max_frame_size,
 					  DMA_FROM_DEVICE);
 		/* We just set the data size to 0 for a failed mapping which
 		 * should prevent DMA from happening...
@@ -474,10 +485,9 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 		goto error;
 
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		skb = __netdev_alloc_skb(ndev, info->max_rx_len, GFP_KERNEL);
+		skb = ravb_alloc_skb(ndev, info, GFP_KERNEL);
 		if (!skb)
 			goto error;
-		ravb_set_buffer_align(skb);
 		priv->rx_skb[q][i] = skb;
 	}
 
@@ -803,7 +813,8 @@ static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
 	skb = priv->rx_skb[RAVB_BE][entry];
 	priv->rx_skb[RAVB_BE][entry] = NULL;
 	dma_unmap_single(ndev->dev.parent, le32_to_cpu(desc->dptr),
-			 ALIGN(GBETH_RX_BUFF_MAX, 16), DMA_FROM_DEVICE);
+			 ALIGN(priv->info->rx_max_frame_size, 16),
+			 DMA_FROM_DEVICE);
 
 	return skb;
 }
@@ -910,13 +921,12 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		desc->ds_cc = cpu_to_le16(GBETH_RX_DESC_DATA_SIZE);
 
 		if (!priv->rx_skb[q][entry]) {
-			skb = netdev_alloc_skb(ndev, info->max_rx_len);
+			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
 			if (!skb)
 				break;
-			ravb_set_buffer_align(skb);
 			dma_addr = dma_map_single(ndev->dev.parent,
 						  skb->data,
-						  GBETH_RX_BUFF_MAX,
+						  priv->info->rx_max_frame_size,
 						  DMA_FROM_DEVICE);
 			skb_checksum_none_assert(skb);
 			/* We just set the data size to 0 for a failed mapping
@@ -990,7 +1000,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 			skb = priv->rx_skb[q][entry];
 			priv->rx_skb[q][entry] = NULL;
 			dma_unmap_single(ndev->dev.parent, le32_to_cpu(desc->dptr),
-					 RX_BUF_SZ,
+					 priv->info->rx_max_frame_size,
 					 DMA_FROM_DEVICE);
 			get_ts &= (q == RAVB_NC) ?
 					RAVB_RXTSTAMP_TYPE_V2_L2_EVENT :
@@ -1026,10 +1036,9 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 		desc->ds_cc = cpu_to_le16(RX_BUF_SZ);
 
 		if (!priv->rx_skb[q][entry]) {
-			skb = netdev_alloc_skb(ndev, info->max_rx_len);
+			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
 			if (!skb)
 				break;	/* Better luck next round. */
-			ravb_set_buffer_align(skb);
 			dma_addr = dma_map_single(ndev->dev.parent, skb->data,
 						  le16_to_cpu(desc->ds_cc),
 						  DMA_FROM_DEVICE);
@@ -2690,7 +2699,6 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.net_hw_features = NETIF_F_RXCSUM,
 	.net_features = NETIF_F_RXCSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
-	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
 	.internal_delay = 1,
@@ -2716,7 +2724,6 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.net_hw_features = NETIF_F_RXCSUM,
 	.net_features = NETIF_F_RXCSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
-	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
 	.aligned_tx = 1,
@@ -2739,7 +2746,6 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.net_hw_features = NETIF_F_RXCSUM,
 	.net_features = NETIF_F_RXCSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
-	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
 	.multi_irqs = 1,
@@ -2764,7 +2770,6 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.net_hw_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM,
 	.net_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
-	.max_rx_len = ALIGN(GBETH_RX_BUFF_MAX, RAVB_ALIGN),
 	.tccr_mask = TCCR_TSRQ0,
 	.rx_max_frame_size = SZ_8K,
 	.aligned_tx = 1,
-- 
2.25.1


