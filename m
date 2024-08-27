Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCE6C54736
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 21:06:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1384.1724792773718936280
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 14:06:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.10,181,1719846000"; 
   d="scan'208";a="220720147"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Aug 2024 06:06:14 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D314840083EA;
	Wed, 28 Aug 2024 06:06:12 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y cip v2 1/9] net: ravb: Simplify poll & receive functions
Date: Tue, 27 Aug 2024 22:06:01 +0100
Message-Id: <20240827210609.12695-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
References: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 21:06:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16820

commit 118e640af30c1355cfea1eeaa2960dc9331ee3db upstream.

We don't need to pass the work budget to ravb_rx() by reference, it's
cleaner to pass this by value and return the amount of work done. This
allows us to simplify the ravb_poll() function and use the common
`work_done` variable name seen in other network drivers for consistency
and ease of understanding.

This is a pure refactor and should not affect behaviour.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 27 +++++++++++-------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b48935ec7e28..71de2a7aa27c 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1039,7 +1039,7 @@ struct ravb_ptp {
 };
 
 struct ravb_hw_info {
-	bool (*receive)(struct net_device *ndev, int *quota, int q);
+	int (*receive)(struct net_device *ndev, int budget, int q);
 	void (*set_rate)(struct net_device *ndev);
 	int (*set_feature)(struct net_device *ndev, netdev_features_t features);
 	int (*dmac_init)(struct net_device *ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 207c2bf005c0..ac3b56629910 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -761,7 +761,7 @@ static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
 }
 
 /* Packet receive function for Gigabit Ethernet */
-static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
+static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
@@ -783,7 +783,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	for (i = 0; i < limit; i++, priv->cur_rx[q]++) {
 		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
 		desc = &priv->rx_ring[q].desc[entry];
-		if (rx_packets == *quota || desc->die_dt == DT_FEMPTY)
+		if (rx_packets == budget || desc->die_dt == DT_FEMPTY)
 			break;
 
 		/* Descriptor type must be checked before all other reads */
@@ -884,12 +884,11 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	}
 
 	stats->rx_packets += rx_packets;
-	*quota -= rx_packets;
-	return *quota == 0;
+	return rx_packets;
 }
 
 /* Packet receive function for Ethernet AVB */
-static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
+static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
@@ -908,7 +907,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	for (i = 0; i < limit; i++, priv->cur_rx[q]++) {
 		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
 		desc = &priv->rx_ring[q].ex_desc[entry];
-		if (rx_packets == *quota || desc->die_dt == DT_FEMPTY)
+		if (rx_packets == budget || desc->die_dt == DT_FEMPTY)
 			break;
 
 		/* Descriptor type must be checked before all other reads */
@@ -994,17 +993,16 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 	}
 
 	stats->rx_packets += rx_packets;
-	*quota -= rx_packets;
-	return *quota == 0;
+	return rx_packets;
 }
 
 /* Packet receive function for Ethernet AVB */
-static bool ravb_rx(struct net_device *ndev, int *quota, int q)
+static int ravb_rx(struct net_device *ndev, int budget, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 
-	return info->receive(ndev, quota, q);
+	return info->receive(ndev, budget, q);
 }
 
 static void ravb_rcv_snd_disable(struct net_device *ndev)
@@ -1321,13 +1319,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
-	int quota = budget;
-	bool unmask;
+	int work_done;
 
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	unmask = !ravb_rx(ndev, &quota, q);
+	work_done = ravb_rx(ndev, budget, q);
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -1346,7 +1343,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
 		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
 
-	if (!unmask)
+	if (work_done == budget)
 		goto out;
 
 	napi_complete(napi);
@@ -1363,7 +1360,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 out:
-	return budget - quota;
+	return work_done;
 }
 
 static void ravb_set_duplex_gbeth(struct net_device *ndev)
-- 
2.43.0


