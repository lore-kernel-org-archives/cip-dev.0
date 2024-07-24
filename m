Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42192C3DA61
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 08:01:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.5794.1721808065589771953
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 01:01:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,232,1716217200"; 
   d="scan'208";a="216491423"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Jul 2024 17:01:09 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B2CD741D149E;
	Wed, 24 Jul 2024 17:01:07 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/11] get: ravb: Count packets instead of descriptors in R-Car RX path
Date: Wed, 24 Jul 2024 08:00:44 +0000
Message-Id: <20240724080046.1500825-10-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 08:01:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16608

commit def52db470df28d6f43cacbd21137f03b9502073 upstream.

The units of "work done" in the RX path should be packets instead of
descriptors.

Descriptors which are used by the hardware to record error conditions or
are empty in the case of a DMA mapping error should not count towards
our RX work budget.

Also make the limit variable unsigned as it can never be negative.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0c0d50517d8e..ff9f059e92f0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -894,29 +894,24 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-	int boguscnt = (priv->dirty_rx[q] + priv->num_rx_ring[q]) -
-			priv->cur_rx[q];
 	struct net_device_stats *stats = &priv->stats[q];
 	struct ravb_ex_rx_desc *desc;
+	unsigned int limit, i;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
 	struct timespec64 ts;
+	int rx_packets = 0;
 	u8  desc_status;
 	u16 pkt_len;
-	int limit;
 
-	boguscnt = min(boguscnt, *quota);
-	limit = boguscnt;
+	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	desc = &priv->rx_ring[q].ex_desc[entry];
-	while (desc->die_dt != DT_FEMPTY) {
+	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
 		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
 
-		if (--boguscnt < 0)
-			break;
-
 		/* We use 0-byte descriptors to mark the DMA mapping errors */
 		if (!pkt_len)
 			continue;
@@ -962,7 +957,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 			if (ndev->features & NETIF_F_RXCSUM)
 				ravb_rx_csum(skb);
 			napi_gro_receive(&priv->napi[q], skb);
-			stats->rx_packets++;
+			rx_packets++;
 			stats->rx_bytes += pkt_len;
 		}
 
@@ -997,9 +992,9 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	*quota -= limit - (++boguscnt);
-
-	return boguscnt <= 0;
+	stats->rx_packets += rx_packets;
+	*quota -= rx_packets;
+	return *quota == 0;
 }
 
 /* Packet receive function for Ethernet AVB */
-- 
2.25.1


