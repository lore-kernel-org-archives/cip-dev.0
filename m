Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064A0C3DA70
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 08:00:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.5867.1721808052528588612
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 01:00:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,232,1716217200"; 
   d="scan'208";a="212533004"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Jul 2024 17:00:51 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A66CD41D0C91;
	Wed, 24 Jul 2024 17:00:49 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/11] net: ravb: Count packets instead of descriptors in GbEth RX path
Date: Wed, 24 Jul 2024 08:00:36 +0000
Message-Id: <20240724080046.1500825-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 08:00:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16600

commit ed4adc07207d9165a4b3b36199231a22e9f51a55 upstream.

The units of "work done" in the RX path should be packets instead of
descriptors, as large packets can be spread over multiple descriptors.

Fixes: 1c59eb678cbd ("ravb: Fillup ravb_rx_gbeth() stub")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20240214151204.2976-1-paul.barker.ct@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 07771bdf0fc7..92fe9a244fd1 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -820,29 +820,25 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	struct ravb_rx_desc *desc;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
+	int rx_packets = 0;
 	u8  desc_status;
-	int boguscnt;
 	u16 pkt_len;
 	u8  die_dt;
 	int entry;
 	int limit;
+	int i;
 
 	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-	boguscnt = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
+	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	boguscnt = min(boguscnt, *quota);
-	limit = boguscnt;
 	desc = &priv->gbeth_rx_ring[entry];
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
@@ -870,7 +866,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(skb);
 				napi_gro_receive(&priv->napi[q], skb);
-				stats->rx_packets++;
+				rx_packets++;
 				stats->rx_bytes += pkt_len;
 				break;
 			case DT_FSTART:
@@ -900,7 +896,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 					ravb_rx_csum_gbeth(priv->rx_1st_skb);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
-				stats->rx_packets++;
+				rx_packets++;
 				stats->rx_bytes += pkt_len;
 				break;
 			}
@@ -939,9 +935,9 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
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


