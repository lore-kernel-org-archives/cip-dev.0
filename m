Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20513C3DA7F
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 08:01:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.5867.1721808052528588612
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 01:01:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,232,1716217200"; 
   d="scan'208";a="212533050"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Jul 2024 17:01:02 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EA02441D15D7;
	Wed, 24 Jul 2024 17:01:00 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/11] ravb: Move maximum Rx descriptor data usage to info struct
Date: Wed, 24 Jul 2024 08:00:41 +0000
Message-Id: <20240724080046.1500825-7-paul.barker.ct@bp.renesas.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16605

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit 555419b2259b96b5259ea207a6b6d2e45c2d6eb3 upstream.

To make it possible to merge the R-Car and RZ/G2L code paths move the
maximum usable size of a single Rx descriptor data slice into the
hardware information instead of using two different defines in the two
different code paths.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  5 +----
 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 7fa60fccb6ea..b12b379baf5a 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1015,10 +1015,6 @@ enum CSR2_BIT {
 #define NUM_RX_QUEUE	2
 #define NUM_TX_QUEUE	2
 
-#define RX_BUF_SZ	(2048 - ETH_FCS_LEN + sizeof(__sum16))
-
-#define GBETH_RX_DESC_DATA_SIZE 4080
-
 struct ravb_tstamp_skb {
 	struct list_head list;
 	struct sk_buff *skb;
@@ -1058,6 +1054,7 @@ struct ravb_hw_info {
 	int stats_len;
 	u32 tccr_mask;
 	u32 rx_max_frame_size;
+	u32 rx_max_desc_use;
 	unsigned aligned_tx: 1;
 
 	/* hardware features */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d59237e03340..fa8400c9ccd4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -353,7 +353,7 @@ static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		/* RX descriptor */
 		rx_desc = &priv->rx_ring[q].desc[i];
-		rx_desc->ds_cc = cpu_to_le16(GBETH_RX_DESC_DATA_SIZE);
+		rx_desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
 					  priv->info->rx_max_frame_size,
 					  DMA_FROM_DEVICE);
@@ -383,7 +383,7 @@ static void ravb_rx_ring_format_rcar(struct net_device *ndev, int q)
 	for (i = 0; i < priv->num_rx_ring[q]; i++) {
 		/* RX descriptor */
 		rx_desc = &priv->rx_ring[q].ex_desc[i];
-		rx_desc->ds_cc = cpu_to_le16(RX_BUF_SZ);
+		rx_desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
 		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
 					  priv->info->rx_max_frame_size,
 					  DMA_FROM_DEVICE);
@@ -923,7 +923,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
 		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
 		desc = &priv->rx_ring[q].desc[entry];
-		desc->ds_cc = cpu_to_le16(GBETH_RX_DESC_DATA_SIZE);
+		desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
 
 		if (!priv->rx_skb[q][entry]) {
 			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
@@ -1038,7 +1038,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
 		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
 		desc = &priv->rx_ring[q].ex_desc[entry];
-		desc->ds_cc = cpu_to_le16(RX_BUF_SZ);
+		desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
 
 		if (!priv->rx_skb[q][entry]) {
 			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
@@ -2714,6 +2714,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
+	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
@@ -2739,6 +2740,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
+	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
 	.aligned_tx = 1,
 	.gptp = 1,
 	.nc_queues = 1,
@@ -2761,6 +2763,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_frame_size = SZ_2K,
+	.rx_max_desc_use = SZ_2K - ETH_FCS_LEN + sizeof(__sum16),
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
 	.gptp = 1,
@@ -2785,6 +2788,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
 	.tccr_mask = TCCR_TSRQ0,
 	.rx_max_frame_size = SZ_8K,
+	.rx_max_desc_use = 4080,
 	.aligned_tx = 1,
 	.tx_counters = 1,
 	.carrier_counters = 1,
-- 
2.25.1


