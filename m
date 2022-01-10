Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F1C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:06 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554217"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 72E6D42AC9EE;
	Mon, 10 Jan 2022 21:24:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 24/61] ravb: Factorise ravb_ring_format function
Date: Mon, 10 Jan 2022 12:22:54 +0000
Message-Id: <20220110122331.24114-25-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7389

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1ae22c19e75cfbd36b24b43f9d8649b1988a4dff upstream.

The ravb_ring_format function uses an extended descriptor in RX
for R-Car compared to the normal descriptor for RZ/G2L. Factorise
RX ring buffer buildup to extend the support for later SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 35 ++++++++++++++++--------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 0ba4d220fb9b..f9e54be7fd67 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -982,6 +982,7 @@ struct ravb_ptp {
 
 struct ravb_hw_info {
 	void (*rx_ring_free)(struct net_device *ndev, int q);
+	void (*rx_ring_format)(struct net_device *ndev, int q);
 	const char (*gstrings_stats)[ETH_GSTRING_LEN];
 	size_t gstrings_size;
 	netdev_features_t net_hw_features;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c7259e103da2..5722b0235cef 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -280,25 +280,14 @@ static void ravb_ring_free(struct net_device *ndev, int q)
 	priv->tx_skb[q] = NULL;
 }
 
-/* Format skb and descriptor buffer for Ethernet AVB */
-static void ravb_ring_format(struct net_device *ndev, int q)
+static void ravb_rx_ring_format(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	unsigned int num_tx_desc = priv->num_tx_desc;
 	struct ravb_ex_rx_desc *rx_desc;
-	struct ravb_tx_desc *tx_desc;
-	struct ravb_desc *desc;
 	unsigned int rx_ring_size = sizeof(*rx_desc) * priv->num_rx_ring[q];
-	unsigned int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
-				    num_tx_desc;
 	dma_addr_t dma_addr;
 	unsigned int i;
 
-	priv->cur_rx[q] = 0;
-	priv->cur_tx[q] = 0;
-	priv->dirty_rx[q] = 0;
-	priv->dirty_tx[q] = 0;
-
 	memset(priv->rx_ring[q], 0, rx_ring_size);
 	/* Build RX ring buffer */
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
@@ -319,6 +308,26 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 	rx_desc = &priv->rx_ring[q][i];
 	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
 	rx_desc->die_dt = DT_LINKFIX; /* type */
+}
+
+/* Format skb and descriptor buffer for Ethernet AVB */
+static void ravb_ring_format(struct net_device *ndev, int q)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	unsigned int num_tx_desc = priv->num_tx_desc;
+	struct ravb_tx_desc *tx_desc;
+	struct ravb_desc *desc;
+	unsigned int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
+				    num_tx_desc;
+	unsigned int i;
+
+	priv->cur_rx[q] = 0;
+	priv->cur_tx[q] = 0;
+	priv->dirty_rx[q] = 0;
+	priv->dirty_tx[q] = 0;
+
+	info->rx_ring_format(ndev, q);
 
 	memset(priv->tx_ring[q], 0, tx_ring_size);
 	/* Build TX ring buffer */
@@ -1947,6 +1956,7 @@ static int ravb_mdio_release(struct ravb_private *priv)
 
 static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.rx_ring_free = ravb_rx_ring_free,
+	.rx_ring_format = ravb_rx_ring_format,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
@@ -1961,6 +1971,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.rx_ring_free = ravb_rx_ring_free,
+	.rx_ring_format = ravb_rx_ring_format,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
-- 
2.17.1


