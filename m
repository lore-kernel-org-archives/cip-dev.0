Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86983C52CDA
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 14:30:48 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.57667.1722263440952708916
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 07:30:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217875318"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Jul 2024 23:30:40 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A16844017D89;
	Mon, 29 Jul 2024 23:30:38 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y cip 11/11] net: ravb: Allow RX loop to move past DMA mapping errors
Date: Mon, 29 Jul 2024 14:30:11 +0000
Message-Id: <20240729143011.1920068-12-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
References: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 14:30:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16644

commit a892493a343494bd6bab9d098593932077ff3c43 upstream.

The RX loops in ravb_rx_gbeth() and ravb_rx_rcar() skip to the next loop
iteration if a zero-length descriptor is seen (indicating a DMA mapping
error). However, the current RX descriptor index `priv->cur_rx[q]` was
incremented at the end of the loop and so would not be incremented when
we skip to the next loop iteration. This would cause the loop to keep
seeing the same zero-length descriptor instead of moving on to the next
descriptor.

As the loop counter `i` still increments, the loop would eventually
terminate so there is no risk of being stuck here forever - but we
should still fix this to avoid wasting cycles.

To fix this, the RX descriptor index is incremented at the top of the
loop, in the for statement itself. The assignments of `entry` and `desc`
are brought into the loop to avoid the need for duplication.

Fixes: d8b48911fd24 ("ravb: fix ring memory allocation")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index eaf99b456166..45ad58aafb9b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -773,12 +773,15 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	int limit;
 	int i;
 
-	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	desc = &priv->rx_ring[q].desc[entry];
-	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
+	for (i = 0; i < limit; i++, priv->cur_rx[q]++) {
+		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
+		desc = &priv->rx_ring[q].desc[entry];
+		if (rx_packets == *quota || desc->die_dt == DT_FEMPTY)
+			break;
+
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
@@ -846,9 +849,6 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				break;
 			}
 		}
-
-		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q].desc[entry];
 	}
 
 	/* Refill the RX ring buffers. */
@@ -889,7 +889,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
 	struct net_device_stats *stats = &priv->stats[q];
 	struct ravb_ex_rx_desc *desc;
 	unsigned int limit, i;
@@ -899,10 +898,15 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	int rx_packets = 0;
 	u8  desc_status;
 	u16 pkt_len;
+	int entry;
 
 	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
-	desc = &priv->rx_ring[q].ex_desc[entry];
-	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
+	for (i = 0; i < limit; i++, priv->cur_rx[q]++) {
+		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
+		desc = &priv->rx_ring[q].ex_desc[entry];
+		if (rx_packets == *quota || desc->die_dt == DT_FEMPTY)
+			break;
+
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
@@ -956,9 +960,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 			rx_packets++;
 			stats->rx_bytes += pkt_len;
 		}
-
-		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
-		desc = &priv->rx_ring[q].ex_desc[entry];
 	}
 
 	/* Refill the RX ring buffers. */
-- 
2.25.1


