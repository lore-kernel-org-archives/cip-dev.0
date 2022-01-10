Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169AC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.31021.1641817424386543755
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011130"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:46 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 71E8542AC9EE;
	Mon, 10 Jan 2022 21:23:45 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/61] ravb: Use unsigned int for num_tx_desc
 variable in struct ravb_private
Date: Mon, 10 Jan 2022 12:22:40 +0000
Message-Id: <20220110122331.24114-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7375

From: Biju Das <biju.das.jz@bp.renesas.com>

commit cb537b241725f5261e752add954e08837348edad upstream.

The number of TX descriptors per packet is an unsigned value and
the variable for holding this information should be unsigned.

This patch replaces the data type of num_tx_desc variable in struct
ravb_private from 'int' to 'unsigned int'.
This patch also updates the data type of local variables to unsigned int,
where the local variables are evaluated using num_tx_desc.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 28 ++++++++++++------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index ff363797bd2b..ccc9471897f3 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1040,7 +1040,7 @@ struct ravb_private {
 	unsigned rxcidm:1;		/* RX Clock Internal Delay Mode */
 	unsigned txcidm:1;		/* TX Clock Internal Delay Mode */
 	unsigned rgmii_override:1;	/* Deprecated rgmii-*id behavior */
-	int num_tx_desc;		/* TX descriptors per packet */
+	unsigned int num_tx_desc;	/* TX descriptors per packet */
 };
 
 static inline u32 ravb_read(struct net_device *ndev, enum ravb_reg reg)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 541f4ebf7135..1566009489e3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -175,10 +175,10 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &priv->stats[q];
-	int num_tx_desc = priv->num_tx_desc;
+	unsigned int num_tx_desc = priv->num_tx_desc;
 	struct ravb_tx_desc *desc;
+	unsigned int entry;
 	int free_num = 0;
-	int entry;
 	u32 size;
 
 	for (; priv->cur_tx[q] - priv->dirty_tx[q] > 0; priv->dirty_tx[q]++) {
@@ -218,9 +218,9 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 static void ravb_ring_free(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	int num_tx_desc = priv->num_tx_desc;
-	int ring_size;
-	int i;
+	unsigned int num_tx_desc = priv->num_tx_desc;
+	unsigned int ring_size;
+	unsigned int i;
 
 	if (priv->rx_ring[q]) {
 		for (i = 0; i < priv->num_rx_ring[q]; i++) {
@@ -273,15 +273,15 @@ static void ravb_ring_free(struct net_device *ndev, int q)
 static void ravb_ring_format(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	int num_tx_desc = priv->num_tx_desc;
+	unsigned int num_tx_desc = priv->num_tx_desc;
 	struct ravb_ex_rx_desc *rx_desc;
 	struct ravb_tx_desc *tx_desc;
 	struct ravb_desc *desc;
-	int rx_ring_size = sizeof(*rx_desc) * priv->num_rx_ring[q];
-	int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
-			   num_tx_desc;
+	unsigned int rx_ring_size = sizeof(*rx_desc) * priv->num_rx_ring[q];
+	unsigned int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
+				    num_tx_desc;
 	dma_addr_t dma_addr;
-	int i;
+	unsigned int i;
 
 	priv->cur_rx[q] = 0;
 	priv->cur_tx[q] = 0;
@@ -337,10 +337,10 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 static int ravb_ring_init(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	int num_tx_desc = priv->num_tx_desc;
+	unsigned int num_tx_desc = priv->num_tx_desc;
+	unsigned int ring_size;
 	struct sk_buff *skb;
-	int ring_size;
-	int i;
+	unsigned int i;
 
 	/* Allocate RX and TX skb rings */
 	priv->rx_skb[q] = kcalloc(priv->num_rx_ring[q],
@@ -1486,7 +1486,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	int num_tx_desc = priv->num_tx_desc;
+	unsigned int num_tx_desc = priv->num_tx_desc;
 	u16 q = skb_get_queue_mapping(skb);
 	struct ravb_tstamp_skb *ts_skb;
 	struct ravb_tx_desc *desc;
-- 
2.17.1


