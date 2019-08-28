From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:13 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 26/57] ravb: remove tx buffer addr
	4byte alilgnment restriction for R-Car Gen3
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-27-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

commit f543305da9b5a5efaf6fa61606e8bbc8977f406d upstream.

This patch sets from two descriptor to one descriptor because R-Car Gen3
does not have the 4 bytes alignment restriction of the transmission buffer.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |   6 +-
 drivers/net/ethernet/renesas/ravb_main.c | 143 +++++++++++++++++++------------
 2 files changed, 92 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 9b6bf55..1c6e4df 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -959,7 +959,10 @@ enum RAVB_QUEUE {
 #define RX_QUEUE_OFFSET	4
 #define NUM_RX_QUEUE	2
 #define NUM_TX_QUEUE	2
-#define NUM_TX_DESC	2	/* TX descriptors per packet */
+
+/* TX descriptors per packet */
+#define NUM_TX_DESC_GEN2	2
+#define NUM_TX_DESC_GEN3	1
 
 struct ravb_tstamp_skb {
 	struct list_head list;
@@ -1038,6 +1041,7 @@ struct ravb_private {
 	unsigned no_avb_link:1;
 	unsigned avb_link_active_low:1;
 	unsigned wol_enabled:1;
+	int num_tx_desc;	/* TX descriptors per packet */
 };
 
 static inline u32 ravb_read(struct net_device *ndev, enum ravb_reg reg)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5f092bb..037a0ad 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -182,6 +182,7 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &priv->stats[q];
+	int num_tx_desc = priv->num_tx_desc;
 	struct ravb_tx_desc *desc;
 	int free_num = 0;
 	int entry;
@@ -191,7 +192,7 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 		bool txed;
 
 		entry = priv->dirty_tx[q] % (priv->num_tx_ring[q] *
-					     NUM_TX_DESC);
+					     num_tx_desc);
 		desc = &priv->tx_ring[q][entry];
 		txed = desc->die_dt == DT_FEMPTY;
 		if (free_txed_only && !txed)
@@ -200,12 +201,12 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 		dma_rmb();
 		size = le16_to_cpu(desc->ds_tagl) & TX_DS;
 		/* Free the original skb. */
-		if (priv->tx_skb[q][entry / NUM_TX_DESC]) {
+		if (priv->tx_skb[q][entry / num_tx_desc]) {
 			dma_unmap_single(ndev->dev.parent, le32_to_cpu(desc->dptr),
 					 size, DMA_TO_DEVICE);
 			/* Last packet descriptor? */
-			if (entry % NUM_TX_DESC == NUM_TX_DESC - 1) {
-				entry /= NUM_TX_DESC;
+			if (entry % num_tx_desc == num_tx_desc - 1) {
+				entry /= num_tx_desc;
 				dev_kfree_skb_any(priv->tx_skb[q][entry]);
 				priv->tx_skb[q][entry] = NULL;
 				if (txed)
@@ -224,6 +225,7 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 static void ravb_ring_free(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	int num_tx_desc = priv->num_tx_desc;
 	int ring_size;
 	int i;
 
@@ -249,7 +251,7 @@ static void ravb_ring_free(struct net_device *ndev, int q)
 		ravb_tx_free(ndev, q, false);
 
 		ring_size = sizeof(struct ravb_tx_desc) *
-			    (priv->num_tx_ring[q] * NUM_TX_DESC + 1);
+			    (priv->num_tx_ring[q] * num_tx_desc + 1);
 		dma_free_coherent(ndev->dev.parent, ring_size, priv->tx_ring[q],
 				  priv->tx_desc_dma[q]);
 		priv->tx_ring[q] = NULL;
@@ -278,12 +280,13 @@ static void ravb_ring_free(struct net_device *ndev, int q)
 static void ravb_ring_format(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	int num_tx_desc = priv->num_tx_desc;
 	struct ravb_ex_rx_desc *rx_desc;
 	struct ravb_tx_desc *tx_desc;
 	struct ravb_desc *desc;
 	int rx_ring_size = sizeof(*rx_desc) * priv->num_rx_ring[q];
 	int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
-			   NUM_TX_DESC;
+			   num_tx_desc;
 	dma_addr_t dma_addr;
 	int i;
 
@@ -318,8 +321,10 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 	for (i = 0, tx_desc = priv->tx_ring[q]; i < priv->num_tx_ring[q];
 	     i++, tx_desc++) {
 		tx_desc->die_dt = DT_EEMPTY;
-		tx_desc++;
-		tx_desc->die_dt = DT_EEMPTY;
+		if (num_tx_desc > 1) {
+			tx_desc++;
+			tx_desc->die_dt = DT_EEMPTY;
+		}
 	}
 	tx_desc->dptr = cpu_to_le32((u32)priv->tx_desc_dma[q]);
 	tx_desc->die_dt = DT_LINKFIX; /* type */
@@ -339,6 +344,7 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 static int ravb_ring_init(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	int num_tx_desc = priv->num_tx_desc;
 	struct sk_buff *skb;
 	int ring_size;
 	int i;
@@ -362,11 +368,13 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 		priv->rx_skb[q][i] = skb;
 	}
 
-	/* Allocate rings for the aligned buffers */
-	priv->tx_align[q] = kmalloc(DPTR_ALIGN * priv->num_tx_ring[q] +
-				    DPTR_ALIGN - 1, GFP_KERNEL);
-	if (!priv->tx_align[q])
-		goto error;
+	if (num_tx_desc > 1) {
+		/* Allocate rings for the aligned buffers */
+		priv->tx_align[q] = kmalloc(DPTR_ALIGN * priv->num_tx_ring[q] +
+					    DPTR_ALIGN - 1, GFP_KERNEL);
+		if (!priv->tx_align[q])
+			goto error;
+	}
 
 	/* Allocate all RX descriptors. */
 	ring_size = sizeof(struct ravb_ex_rx_desc) * (priv->num_rx_ring[q] + 1);
@@ -380,7 +388,7 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 
 	/* Allocate all TX descriptors. */
 	ring_size = sizeof(struct ravb_tx_desc) *
-		    (priv->num_tx_ring[q] * NUM_TX_DESC + 1);
+		    (priv->num_tx_ring[q] * num_tx_desc + 1);
 	priv->tx_ring[q] = dma_alloc_coherent(ndev->dev.parent, ring_size,
 					      &priv->tx_desc_dma[q],
 					      GFP_KERNEL);
@@ -1487,6 +1495,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	int num_tx_desc = priv->num_tx_desc;
 	u16 q = skb_get_queue_mapping(skb);
 	struct ravb_tstamp_skb *ts_skb;
 	struct ravb_tx_desc *desc;
@@ -1498,7 +1507,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	spin_lock_irqsave(&priv->lock, flags);
 	if (priv->cur_tx[q] - priv->dirty_tx[q] > (priv->num_tx_ring[q] - 1) *
-	    NUM_TX_DESC) {
+	    num_tx_desc) {
 		netif_err(priv, tx_queued, ndev,
 			  "still transmitting with the full ring!\n");
 		netif_stop_subqueue(ndev, q);
@@ -1509,41 +1518,55 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (skb_put_padto(skb, ETH_ZLEN))
 		goto exit;
 
-	entry = priv->cur_tx[q] % (priv->num_tx_ring[q] * NUM_TX_DESC);
-	priv->tx_skb[q][entry / NUM_TX_DESC] = skb;
-
-	buffer = PTR_ALIGN(priv->tx_align[q], DPTR_ALIGN) +
-		 entry / NUM_TX_DESC * DPTR_ALIGN;
-	len = PTR_ALIGN(skb->data, DPTR_ALIGN) - skb->data;
-	/* Zero length DMA descriptors are problematic as they seem to
-	 * terminate DMA transfers. Avoid them by simply using a length of
-	 * DPTR_ALIGN (4) when skb data is aligned to DPTR_ALIGN.
-	 *
-	 * As skb is guaranteed to have at least ETH_ZLEN (60) bytes of
-	 * data by the call to skb_put_padto() above this is safe with
-	 * respect to both the length of the first DMA descriptor (len)
-	 * overflowing the available data and the length of the second DMA
-	 * descriptor (skb->len - len) being negative.
-	 */
-	if (len == 0)
-		len = DPTR_ALIGN;
+	entry = priv->cur_tx[q] % (priv->num_tx_ring[q] * num_tx_desc);
+	priv->tx_skb[q][entry / num_tx_desc] = skb;
+
+	if (num_tx_desc > 1) {
+		buffer = PTR_ALIGN(priv->tx_align[q], DPTR_ALIGN) +
+			 entry / num_tx_desc * DPTR_ALIGN;
+		len = PTR_ALIGN(skb->data, DPTR_ALIGN) - skb->data;
+
+		/* Zero length DMA descriptors are problematic as they seem
+		 * to terminate DMA transfers. Avoid them by simply using a
+		 * length of DPTR_ALIGN (4) when skb data is aligned to
+		 * DPTR_ALIGN.
+		 *
+		 * As skb is guaranteed to have at least ETH_ZLEN (60)
+		 * bytes of data by the call to skb_put_padto() above this
+		 * is safe with respect to both the length of the first DMA
+		 * descriptor (len) overflowing the available data and the
+		 * length of the second DMA descriptor (skb->len - len)
+		 * being negative.
+		 */
+		if (len == 0)
+			len = DPTR_ALIGN;
 
-	memcpy(buffer, skb->data, len);
-	dma_addr = dma_map_single(ndev->dev.parent, buffer, len, DMA_TO_DEVICE);
-	if (dma_mapping_error(ndev->dev.parent, dma_addr))
-		goto drop;
+		memcpy(buffer, skb->data, len);
+		dma_addr = dma_map_single(ndev->dev.parent, buffer, len,
+					  DMA_TO_DEVICE);
+		if (dma_mapping_error(ndev->dev.parent, dma_addr))
+			goto drop;
 
-	desc = &priv->tx_ring[q][entry];
-	desc->ds_tagl = cpu_to_le16(len);
-	desc->dptr = cpu_to_le32(dma_addr);
+		desc = &priv->tx_ring[q][entry];
+		desc->ds_tagl = cpu_to_le16(len);
+		desc->dptr = cpu_to_le32(dma_addr);
 
-	buffer = skb->data + len;
-	len = skb->len - len;
-	dma_addr = dma_map_single(ndev->dev.parent, buffer, len, DMA_TO_DEVICE);
-	if (dma_mapping_error(ndev->dev.parent, dma_addr))
-		goto unmap;
+		buffer = skb->data + len;
+		len = skb->len - len;
+		dma_addr = dma_map_single(ndev->dev.parent, buffer, len,
+					  DMA_TO_DEVICE);
+		if (dma_mapping_error(ndev->dev.parent, dma_addr))
+			goto unmap;
 
-	desc++;
+		desc++;
+	} else {
+		desc = &priv->tx_ring[q][entry];
+		len = skb->len;
+		dma_addr = dma_map_single(ndev->dev.parent, skb->data, skb->len,
+					  DMA_TO_DEVICE);
+		if (dma_mapping_error(ndev->dev.parent, dma_addr))
+			goto drop;
+	}
 	desc->ds_tagl = cpu_to_le16(len);
 	desc->dptr = cpu_to_le32(dma_addr);
 
@@ -1551,9 +1574,11 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (q == RAVB_NC) {
 		ts_skb = kmalloc(sizeof(*ts_skb), GFP_ATOMIC);
 		if (!ts_skb) {
-			desc--;
-			dma_unmap_single(ndev->dev.parent, dma_addr, len,
-					 DMA_TO_DEVICE);
+			if (num_tx_desc > 1) {
+				desc--;
+				dma_unmap_single(ndev->dev.parent, dma_addr,
+						 len, DMA_TO_DEVICE);
+			}
 			goto unmap;
 		}
 		ts_skb->skb = skb;
@@ -1570,15 +1595,18 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	skb_tx_timestamp(skb);
 	/* Descriptor type must be set after all the above writes */
 	dma_wmb();
-	desc->die_dt = DT_FEND;
-	desc--;
-	desc->die_dt = DT_FSTART;
-
+	if (num_tx_desc > 1) {
+		desc->die_dt = DT_FEND;
+		desc--;
+		desc->die_dt = DT_FSTART;
+	} else {
+		desc->die_dt = DT_FSINGLE;
+	}
 	ravb_modify(ndev, TCCR, TCCR_TSRQ0 << q, TCCR_TSRQ0 << q);
 
-	priv->cur_tx[q] += NUM_TX_DESC;
+	priv->cur_tx[q] += num_tx_desc;
 	if (priv->cur_tx[q] - priv->dirty_tx[q] >
-	    (priv->num_tx_ring[q] - 1) * NUM_TX_DESC &&
+	    (priv->num_tx_ring[q] - 1) * num_tx_desc &&
 	    !ravb_tx_free(ndev, q, true))
 		netif_stop_subqueue(ndev, q);
 
@@ -1592,7 +1620,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			 le16_to_cpu(desc->ds_tagl), DMA_TO_DEVICE);
 drop:
 	dev_kfree_skb_any(skb);
-	priv->tx_skb[q][entry / NUM_TX_DESC] = NULL;
+	priv->tx_skb[q][entry / num_tx_desc] = NULL;
 	goto exit;
 }
 
@@ -2078,6 +2106,9 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->max_mtu = 2048 - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
+	priv->num_tx_desc = chip_id == RCAR_GEN2 ?
+		NUM_TX_DESC_GEN2 : NUM_TX_DESC_GEN3;
+
 	/* Set function */
 	ndev->netdev_ops = &ravb_netdev_ops;
 	ndev->ethtool_ops = &ravb_ethtool_ops;
-- 
2.7.4
