Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008A2C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:03 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554213"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:03 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2DA6541E4D1E;
	Mon, 10 Jan 2022 21:24:02 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 23/61] ravb: Factorise ravb_ring_free function
Date: Mon, 10 Jan 2022 12:22:53 +0000
Message-Id: <20220110122331.24114-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7388

From: Biju Das <biju.das.jz@bp.renesas.com>

commit bf46b7578404f6fbde0bc2e1ea60fe0fd6f207a8 upstream.

R-Car uses extended descriptor in RX, whereas RZ/G2L uses normal
descriptor. Factorise ravb_ring_free function so that it can
support later SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 47 +++++++++++++++---------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index a0220b48c122..0ba4d220fb9b 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -981,6 +981,7 @@ struct ravb_ptp {
 };
 
 struct ravb_hw_info {
+	void (*rx_ring_free)(struct net_device *ndev, int q);
 	const char (*gstrings_stats)[ETH_GSTRING_LEN];
 	size_t gstrings_size;
 	netdev_features_t net_hw_features;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index de691dd91cf4..c7259e103da2 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -214,31 +214,42 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 	return free_num;
 }
 
+static void ravb_rx_ring_free(struct net_device *ndev, int q)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	unsigned int ring_size;
+	unsigned int i;
+
+	if (!priv->rx_ring[q])
+		return;
+
+	for (i = 0; i < priv->num_rx_ring[q]; i++) {
+		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q][i];
+
+		if (!dma_mapping_error(ndev->dev.parent,
+				       le32_to_cpu(desc->dptr)))
+			dma_unmap_single(ndev->dev.parent,
+					 le32_to_cpu(desc->dptr),
+					 RX_BUF_SZ,
+					 DMA_FROM_DEVICE);
+	}
+	ring_size = sizeof(struct ravb_ex_rx_desc) *
+		    (priv->num_rx_ring[q] + 1);
+	dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q],
+			  priv->rx_desc_dma[q]);
+	priv->rx_ring[q] = NULL;
+}
+
 /* Free skb's and DMA buffers for Ethernet AVB */
 static void ravb_ring_free(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	unsigned int num_tx_desc = priv->num_tx_desc;
 	unsigned int ring_size;
 	unsigned int i;
 
-	if (priv->rx_ring[q]) {
-		for (i = 0; i < priv->num_rx_ring[q]; i++) {
-			struct ravb_ex_rx_desc *desc = &priv->rx_ring[q][i];
-
-			if (!dma_mapping_error(ndev->dev.parent,
-					       le32_to_cpu(desc->dptr)))
-				dma_unmap_single(ndev->dev.parent,
-						 le32_to_cpu(desc->dptr),
-						 RX_BUF_SZ,
-						 DMA_FROM_DEVICE);
-		}
-		ring_size = sizeof(struct ravb_ex_rx_desc) *
-			    (priv->num_rx_ring[q] + 1);
-		dma_free_coherent(ndev->dev.parent, ring_size, priv->rx_ring[q],
-				  priv->rx_desc_dma[q]);
-		priv->rx_ring[q] = NULL;
-	}
+	info->rx_ring_free(ndev, q);
 
 	if (priv->tx_ring[q]) {
 		ravb_tx_free(ndev, q, false);
@@ -1935,6 +1946,7 @@ static int ravb_mdio_release(struct ravb_private *priv)
 }
 
 static const struct ravb_hw_info ravb_gen3_hw_info = {
+	.rx_ring_free = ravb_rx_ring_free,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
@@ -1948,6 +1960,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
+	.rx_ring_free = ravb_rx_ring_free,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
-- 
2.17.1


