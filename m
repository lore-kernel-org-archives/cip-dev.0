Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768FC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:34 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554287"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:34 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 35E9D42AC9F7;
	Mon, 10 Jan 2022 21:24:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 47/61] ravb: Fillup ravb_alloc_rx_desc_gbeth() stub
Date: Mon, 10 Jan 2022 12:23:17 +0000
Message-Id: <20220110122331.24114-48-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7412

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3d4e37df882b0f4f28b7223a42492650b71252c5 upstream.

Fillup ravb_alloc_rx_desc_gbeth() function to support RZ/G2L.

This patch also renames ravb_alloc_rx_desc to ravb_alloc_rx_desc_rcar
to be consistent with the naming convention used in sh_eth driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 30 ++++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b147c4a0dc0b..ed771ead61b9 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1038,6 +1038,7 @@ struct ravb_private {
 	struct ravb_desc *desc_bat;
 	dma_addr_t rx_desc_dma[NUM_RX_QUEUE];
 	dma_addr_t tx_desc_dma[NUM_TX_QUEUE];
+	struct ravb_rx_desc *gbeth_rx_ring;
 	struct ravb_ex_rx_desc *rx_ring[NUM_RX_QUEUE];
 	struct ravb_tx_desc *tx_ring[NUM_TX_QUEUE];
 	void *tx_align[NUM_TX_QUEUE];
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 786436779e9f..02e8a7761822 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -383,11 +383,18 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 
 static void *ravb_alloc_rx_desc_gbeth(struct net_device *ndev, int q)
 {
-	/* Place holder */
-	return NULL;
+	struct ravb_private *priv = netdev_priv(ndev);
+	unsigned int ring_size;
+
+	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
+
+	priv->gbeth_rx_ring = dma_alloc_coherent(ndev->dev.parent, ring_size,
+						 &priv->rx_desc_dma[q],
+						 GFP_KERNEL);
+	return priv->gbeth_rx_ring;
 }
 
-static void *ravb_alloc_rx_desc(struct net_device *ndev, int q)
+static void *ravb_alloc_rx_desc_rcar(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned int ring_size;
@@ -1082,16 +1089,25 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	struct net_device *ndev = napi->dev;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	bool gptp = info->gptp || info->ccc_gac;
+	struct ravb_rx_desc *desc;
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
+	unsigned int entry;
 
+	if (!gptp) {
+		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
+		desc = &priv->gbeth_rx_ring[entry];
+	}
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (ravb_rx(ndev, &quota, q))
-		goto out;
+	if (gptp || desc->die_dt != DT_FEMPTY) {
+		if (ravb_rx(ndev, &quota, q))
+			goto out;
+	}
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -2173,7 +2189,7 @@ static int ravb_mdio_release(struct ravb_private *priv)
 static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.rx_ring_free = ravb_rx_ring_free,
 	.rx_ring_format = ravb_rx_ring_format,
-	.alloc_rx_desc = ravb_alloc_rx_desc,
+	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
 	.receive = ravb_rcar_rx,
 	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
@@ -2198,7 +2214,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.rx_ring_free = ravb_rx_ring_free,
 	.rx_ring_format = ravb_rx_ring_format,
-	.alloc_rx_desc = ravb_alloc_rx_desc,
+	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
 	.receive = ravb_rcar_rx,
 	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
-- 
2.17.1


