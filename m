Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F25C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:35 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011233"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7BD2D41E4D1E;
	Mon, 10 Jan 2022 21:24:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 48/61] ravb: Fillup ravb_rx_ring_free_gbeth() stub
Date: Mon, 10 Jan 2022 12:23:18 +0000
Message-Id: <20220110122331.24114-49-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7413

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 2458b8edb887108b8a6aae567b01e5e2a73bd8d8 upstream.

Fillup ravb_rx_ring_free_gbeth() function to support RZ/G2L.

This patch also renames ravb_rx_ring_free to ravb_rx_ring_free_rcar
to be consistent with the naming convention used in sh_eth driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 28 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 02e8a7761822..6f9065212791 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -234,10 +234,30 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 
 static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
 {
-	/* Place holder */
+	struct ravb_private *priv = netdev_priv(ndev);
+	unsigned int ring_size;
+	unsigned int i;
+
+	if (!priv->gbeth_rx_ring)
+		return;
+
+	for (i = 0; i < priv->num_rx_ring[q]; i++) {
+		struct ravb_rx_desc *desc = &priv->gbeth_rx_ring[i];
+
+		if (!dma_mapping_error(ndev->dev.parent,
+				       le32_to_cpu(desc->dptr)))
+			dma_unmap_single(ndev->dev.parent,
+					 le32_to_cpu(desc->dptr),
+					 GBETH_RX_BUFF_MAX,
+					 DMA_FROM_DEVICE);
+	}
+	ring_size = sizeof(struct ravb_rx_desc) * (priv->num_rx_ring[q] + 1);
+	dma_free_coherent(ndev->dev.parent, ring_size, priv->gbeth_rx_ring,
+			  priv->rx_desc_dma[q]);
+	priv->gbeth_rx_ring = NULL;
 }
 
-static void ravb_rx_ring_free(struct net_device *ndev, int q)
+static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned int ring_size;
@@ -2187,7 +2207,7 @@ static int ravb_mdio_release(struct ravb_private *priv)
 }
 
 static const struct ravb_hw_info ravb_gen3_hw_info = {
-	.rx_ring_free = ravb_rx_ring_free,
+	.rx_ring_free = ravb_rx_ring_free_rcar,
 	.rx_ring_format = ravb_rx_ring_format,
 	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
 	.receive = ravb_rcar_rx,
@@ -2212,7 +2232,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
-	.rx_ring_free = ravb_rx_ring_free,
+	.rx_ring_free = ravb_rx_ring_free_rcar,
 	.rx_ring_format = ravb_rx_ring_format,
 	.alloc_rx_desc = ravb_alloc_rx_desc_rcar,
 	.receive = ravb_rcar_rx,
-- 
2.17.1


