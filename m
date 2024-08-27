Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FEC54731
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 21:06:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1384.1724792773718936280
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 14:06:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.10,181,1719846000"; 
   d="scan'208";a="220720157"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Aug 2024 06:06:22 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3164740031E0;
	Wed, 28 Aug 2024 06:06:19 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y cip v2 4/9] net: ravb: Refactor GbEth RX code path
Date: Tue, 27 Aug 2024 22:06:04 +0100
Message-Id: <20240827210609.12695-5-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
References: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 21:06:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16823

commit 3ee43f09cb2cd7643d5a4bfbc78a9f75f6a563af upstream.

We can reduce code duplication in ravb_rx_gbeth().

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 59 +++++++++++++-----------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 04df3c93bb54..ba3c6150f360 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -821,47 +821,52 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 				stats->rx_missed_errors++;
 		} else {
 			die_dt = desc->die_dt & 0xF0;
+			skb = ravb_get_skb_gbeth(ndev, entry, desc);
 			switch (die_dt) {
 			case DT_FSINGLE:
-				skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(skb, desc_len);
-				skb->protocol = eth_type_trans(skb, ndev);
-				if (ndev->features & NETIF_F_RXCSUM)
-					ravb_rx_csum_gbeth(skb);
-				napi_gro_receive(&priv->napi[q], skb);
-				rx_packets++;
-				stats->rx_bytes += desc_len;
-				break;
 			case DT_FSTART:
-				priv->rx_1st_skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(priv->rx_1st_skb, desc_len);
+				/* Start of packet: Set initial data length. */
+				skb_put(skb, desc_len);
+
+				/* Save this skb if the packet spans multiple
+				 * descriptors.
+				 */
+				if (die_dt == DT_FSTART)
+					priv->rx_1st_skb = skb;
 				break;
+
 			case DT_FMID:
-				skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
-							       priv->rx_1st_skb->len,
-							       skb->data,
-							       desc_len);
-				skb_put(priv->rx_1st_skb, desc_len);
-				dev_kfree_skb(skb);
-				break;
 			case DT_FEND:
-				skb = ravb_get_skb_gbeth(ndev, entry, desc);
+				/* Continuing a packet: Move data into the saved
+				 * skb.
+				 */
 				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
 							       priv->rx_1st_skb->len,
 							       skb->data,
 							       desc_len);
 				skb_put(priv->rx_1st_skb, desc_len);
 				dev_kfree_skb(skb);
-				priv->rx_1st_skb->protocol =
-					eth_type_trans(priv->rx_1st_skb, ndev);
+
+				/* Set skb to point at the whole packet so that
+				 * we only need one code path for finishing a
+				 * packet.
+				 */
+				skb = priv->rx_1st_skb;
+			}
+
+			switch (die_dt) {
+			case DT_FSINGLE:
+			case DT_FEND:
+				/* Finishing a packet: Determine protocol &
+				 * checksum, hand off to NAPI and update our
+				 * stats.
+				 */
+				skb->protocol = eth_type_trans(skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
-					ravb_rx_csum_gbeth(priv->rx_1st_skb);
-				stats->rx_bytes += priv->rx_1st_skb->len;
-				napi_gro_receive(&priv->napi[q],
-						 priv->rx_1st_skb);
+					ravb_rx_csum_gbeth(skb);
+				stats->rx_bytes += skb->len;
+				napi_gro_receive(&priv->napi[q], skb);
 				rx_packets++;
-				break;
 			}
 		}
 	}
-- 
2.43.0


