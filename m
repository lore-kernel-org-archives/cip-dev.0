Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEF4C52CDC
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 14:30:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.57657.1722263418601965874
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 07:30:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213905627"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Jul 2024 23:30:17 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ED622400EF68;
	Mon, 29 Jul 2024 23:30:15 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y cip 01/11] ravb: Group descriptor types used in Rx ring
Date: Mon, 29 Jul 2024 14:30:01 +0000
Message-Id: <20240729143011.1920068-2-paul.barker.ct@bp.renesas.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16634

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit 4123c3fbf8632e5c553222bf1c10b3a3e0a8dc06 upstream.

The Rx ring can either be made up of normal or extended descriptors, not
a mix of the two at the same time. Make this explicit by grouping the
two variables in a rx_ring union.

The extension of the storage for more than one queue of normal
descriptors from a single to NUM_RX_QUEUE queues have no practical
effect. But aids in making the code readable as the code that uses it
already piggyback on other members of struct ravb_private that are
arrays of max length NUM_RX_QUEUE, e.g. rx_desc_dma. This will also make
further refactoring easier.

While at it, rename the normal descriptor Rx ring to make it clear it's
not strictly related to the GbEthernet E-MAC IP found in RZ/G2L, normal
descriptors could be used on R-Car SoCs too.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  6 ++-
 drivers/net/ethernet/renesas/ravb_main.c | 57 ++++++++++++------------
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 82fea6f9a3f6..bc39fe0ad50a 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1092,8 +1092,10 @@ struct ravb_private {
 	struct ravb_desc *desc_bat;
 	dma_addr_t rx_desc_dma[NUM_RX_QUEUE];
 	dma_addr_t tx_desc_dma[NUM_TX_QUEUE];
-	struct ravb_rx_desc *gbeth_rx_ring;
-	struct ravb_ex_rx_desc *rx_ring[NUM_RX_QUEUE];
+	union {
+		struct ravb_rx_desc *desc;
+		struct ravb_ex_rx_desc *ex_desc;
+	} rx_ring[NUM_RX_QUEUE];
 	struct ravb_tx_desc *tx_ring[NUM_TX_QUEUE];
 	void *tx_align[NUM_TX_QUEUE];
 	struct sk_buff *rx_1st_skb;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e86b4a006dc3..5a5023173403 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -239,11 +239,11 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
 	unsigned int ring_size;
 	unsigned int i;
 
-	if (!priv->gbeth_rx_ring)
+	if (!priv->rx_ring[q].desc)
 		return;
 
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		struct ravb_rx_desc *desc = &priv->gbeth_rx_ring[i];
+		struct ravb_rx_desc *desc = &priv->rx_ring[q].desc[i];
 
 		if (!dma_mapping_error(ndev->dev.parent,
 				       le32_to_cpu(desc->dptr)))
@@ -253,9 +253,9 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
 					 DMA_FROM_DEVICE);
 	}
 	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
-	dma_free_coherent(ndev->dev.parent, ring_size, priv->gbeth_rx_ring,
+	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].desc,
 			  priv->rx_desc_dma[q]);
-	priv->gbeth_rx_ring = NULL;
+	priv->rx_ring[q].desc = NULL;
 }
 
 static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
@@ -264,11 +264,11 @@ static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
 	unsigned int ring_size;
 	unsigned int i;
 
-	if (!priv->rx_ring[q])
+	if (!priv->rx_ring[q].ex_desc)
 		return;
 
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
-		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q][i];
+		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q].ex_desc[i];
 
 		if (!dma_mapping_error(ndev->dev.parent,
 				       le32_to_cpu(desc->dptr)))
@@ -279,9 +279,9 @@ static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
 	}
 	ring_size = sizeof(struct ravb_ex_rx_desc) *
 		    (priv->num_rx_ring[q] + 1);
-	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q],
+	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q].ex_desc,
 			  priv->rx_desc_dma[q]);
-	priv->rx_ring[q] = NULL;
+	priv->rx_ring[q].ex_desc = NULL;
 }
 
 /* Free skb's and DMA buffers for Ethernet AVB */
@@ -333,11 +333,11 @@ static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
 	unsigned int i;
 
 	rx_ring_size = sizeof(*rx_desc) * priv->num_rx_ring[q];
-	memset(priv->gbeth_rx_ring, 0, rx_ring_size);
+	memset(priv->rx_ring[q].desc, 0, rx_ring_size);
 	/* Build RX ring buffer */
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		/* RX descriptor */
-		rx_desc = &priv->gbeth_rx_ring[i];
+		rx_desc = &priv->rx_ring[q].desc[i];
 		rx_desc->ds_cc = cpu_to_le16(GBETH_RX_DESC_DATA_SIZE);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
 					  GBETH_RX_BUFF_MAX,
@@ -350,7 +350,7 @@ static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
 		rx_desc->dptr = cpu_to_le32(dma_addr);
 		rx_desc->die_dt = DT_FEMPTY;
 	}
-	rx_desc = &priv->gbeth_rx_ring[i];
+	rx_desc = &priv->rx_ring[q].desc[i];
 	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
 	rx_desc->die_dt = DT_LINKFIX; /* type */
 }
@@ -363,11 +363,11 @@ static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
 	dma_addr_t dma_addr;
 	unsigned int i;
 
-	memset(priv->rx_ring[q], 0, rx_ring_size);
+	memset(priv->rx_ring[q].ex_desc, 0, rx_ring_size);
 	/* Build RX ring buffer */
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		/* RX descriptor */
-		rx_desc = &priv->rx_ring[q][i];
+		rx_desc = &priv->rx_ring[q].ex_desc[i];
 		rx_desc->ds_cc = cpu_to_le16(RX_BUF_SZ);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
 					  RX_BUF_SZ,
@@ -380,7 +380,7 @@ static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
 		rx_desc->dptr = cpu_to_le32(dma_addr);
 		rx_desc->die_dt = DT_FEMPTY;
 	}
-	rx_desc = &priv->rx_ring[q][i];
+	rx_desc = &priv->rx_ring[q].ex_desc[i];
 	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
 	rx_desc->die_dt = DT_LINKFIX; /* type */
 }
@@ -435,10 +435,10 @@ static void *ravb_alloc_rx_desc_gbeth(struct net_device *ndev, int q)
 
 	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
 
-	priv->gbeth_rx_ring = dma_alloc_coherent(ndev->dev.parent, ring_size,
-						 &priv->rx_desc_dma[q],
-						 GFP_KERNEL);
-	return priv->gbeth_rx_ring;
+	priv->rx_ring[q].desc = dma_alloc_coherent(ndev->dev.parent, ring_size,
+						   &priv->rx_desc_dma[q],
+						   GFP_KERNEL);
+	return priv->rx_ring[q].desc;
 }
 
 static void *ravb_alloc_rx_desc_rcar(struct net_device *ndev, int q)
@@ -448,10 +448,11 @@ static void *ravb_alloc_rx_desc_rcar(struct net_device *ndev, int q)
 
 	ring_size = sizeof(struct ravb_ex_rx_desc) * (priv->num_rx_ring[q] + 1);
 
-	priv->rx_ring[q] = dma_alloc_coherent(ndev->dev.parent, ring_size,
-					      &priv->rx_desc_dma[q],
-					      GFP_KERNEL);
-	return priv->rx_ring[q];
+	priv->rx_ring[q].ex_desc = dma_alloc_coherent(ndev->dev.parent,
+						      ring_size,
+						      &priv->rx_desc_dma[q],
+						      GFP_KERNEL);
+	return priv->rx_ring[q].ex_desc;
 }
 
 /* Init skb and descriptor buffer for Ethernet AVB */
@@ -828,7 +829,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	desc = &priv->gbeth_rx_ring[entry];
+	desc = &priv->rx_ring[q].desc[entry];
 	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
@@ -899,13 +900,13 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		}
 
 		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
+		desc = &priv->rx_ring[q].desc[entry];
 	}
 
 	/* Refill the RX ring buffers. */
 	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
 		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
+		desc = &priv->rx_ring[q].desc[entry];
 		desc->ds_cc = cpu_to_le16(GBETH_RX_DESC_DATA_SIZE);
 
 		if (!priv->rx_skb[q][entry]) {
@@ -955,7 +956,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 
 	boguscnt = min(boguscnt, *quota);
 	limit = boguscnt;
-	desc = &priv->rx_ring[q][entry];
+	desc = &priv->rx_ring[q].ex_desc[entry];
 	while (desc->die_dt != DT_FEMPTY) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
@@ -1015,13 +1016,13 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 		}
 
 		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q][entry];
+		desc = &priv->rx_ring[q].ex_desc[entry];
 	}
 
 	/* Refill the RX ring buffers. */
 	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
 		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q][entry];
+		desc = &priv->rx_ring[q].ex_desc[entry];
 		desc->ds_cc = cpu_to_le16(RX_BUF_SZ);
 
 		if (!priv->rx_skb[q][entry]) {
-- 
2.25.1


