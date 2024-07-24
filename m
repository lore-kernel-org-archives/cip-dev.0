Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572B6C3DA70
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 08:01:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.5867.1721808052528588612
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 01:01:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,232,1716217200"; 
   d="scan'208";a="212533093"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Jul 2024 17:01:14 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3E72A41D15E1;
	Wed, 24 Jul 2024 17:01:11 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/11] net: ravb: Fix RX byte accounting for jumbo packets
Date: Wed, 24 Jul 2024 08:00:46 +0000
Message-Id: <20240724080046.1500825-12-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 08:01:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16610

commit 2e36c9fbc476f95a1b19e3fa0a2cdf408475ff56 upstream.

The RX byte accounting for jumbo packets was changed to fix a potential
use-after-free bug. However, that fix used the wrong variable and so
only accounted for the number of bytes in the final descriptor, not the
number of bytes in the whole packet.

To fix this, we can simply update our stats with the correct number of
bytes before calling napi_gro_receive().

Also rename pkt_len to desc_len in ravb_rx_gbeth() to avoid any future
confusion. The variable name pkt_len is correct in ravb_rx_rcar() as
that function does not handle packets spanning multiple descriptors.

Fixes: 5a5a3e564de6 ("ravb: Fix potential use-after-free in ravb_rx_gbeth()")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index cc18cb9efb98..207c2bf005c0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -771,7 +771,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	dma_addr_t dma_addr;
 	int rx_packets = 0;
 	u8  desc_status;
-	u16 pkt_len;
+	u16 desc_len;
 	u8  die_dt;
 	int entry;
 	int limit;
@@ -789,10 +789,10 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
-		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
+		desc_len = le16_to_cpu(desc->ds_cc) & RX_DS;
 
 		/* We use 0-byte descriptors to mark the DMA mapping errors */
-		if (!pkt_len)
+		if (!desc_len)
 			continue;
 
 		if (desc_status & MSC_MC)
@@ -813,25 +813,25 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 			switch (die_dt) {
 			case DT_FSINGLE:
 				skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(skb, pkt_len);
+				skb_put(skb, desc_len);
 				skb->protocol = eth_type_trans(skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(skb);
 				napi_gro_receive(&priv->napi[q], skb);
 				rx_packets++;
-				stats->rx_bytes += pkt_len;
+				stats->rx_bytes += desc_len;
 				break;
 			case DT_FSTART:
 				priv->rx_1st_skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(priv->rx_1st_skb, pkt_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				break;
 			case DT_FMID:
 				skb = ravb_get_skb_gbeth(ndev, entry, desc);
 				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
 							       priv->rx_1st_skb->len,
 							       skb->data,
-							       pkt_len);
-				skb_put(priv->rx_1st_skb, pkt_len);
+							       desc_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				dev_kfree_skb(skb);
 				break;
 			case DT_FEND:
@@ -839,17 +839,17 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
 							       priv->rx_1st_skb->len,
 							       skb->data,
-							       pkt_len);
-				skb_put(priv->rx_1st_skb, pkt_len);
+							       desc_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				dev_kfree_skb(skb);
 				priv->rx_1st_skb->protocol =
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(priv->rx_1st_skb);
+				stats->rx_bytes += priv->rx_1st_skb->len;
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				rx_packets++;
-				stats->rx_bytes += pkt_len;
 				break;
 			}
 		}
-- 
2.25.1


