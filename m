Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D33C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:19 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011198"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:18 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ADBCB42AC9FF;
	Mon, 10 Jan 2022 21:24:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 35/61] ravb: Add support for RZ/G2L SoC
Date: Mon, 10 Jan 2022 12:23:05 +0000
Message-Id: <20220110122331.24114-36-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7400

From: Biju Das <biju.das.jz@bp.renesas.com>

commit feab85c7cceac1dfbff18cce3d089b0ca5ead565 upstream.

RZ/G2L SoC has Gigabit Ethernet IP consisting of Ethernet controller
(E-MAC), Internal TCP/IP Offload Engine (TOE) and Dedicated Direct
memory access controller (DMAC).

This patch adds compatible string for RZ/G2L and fills up the
ravb_hw_info struct. Function stubs are added which will be used by
gbeth_hw_info and will be filled incrementally.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +
 drivers/net/ethernet/renesas/ravb_main.c | 62 ++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index c343fd813cd5..b185f1bb351d 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -957,6 +957,8 @@ enum RAVB_QUEUE {
 
 #define RX_BUF_SZ	(2048 - ETH_FCS_LEN + sizeof(__sum16))
 
+#define GBETH_RX_BUFF_MAX 8192
+
 struct ravb_tstamp_skb {
 	struct list_head list;
 	struct sk_buff *skb;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 4806c07efc49..f4211afe5e68 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -83,6 +83,11 @@ static int ravb_config(struct net_device *ndev)
 	return error;
 }
 
+static void ravb_set_rate_gbeth(struct net_device *ndev)
+{
+	/* Place holder */
+}
+
 static void ravb_set_rate(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -215,6 +220,11 @@ static int ravb_tx_free(struct net_device *ndev, int q, bool free_txed_only)
 	return free_num;
 }
 
+static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
+{
+	/* Place holder */
+}
+
 static void ravb_rx_ring_free(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -281,6 +291,11 @@ static void ravb_ring_free(struct net_device *ndev, int q)
 	priv->tx_skb[q] = NULL;
 }
 
+static void ravb_rx_ring_format_gbeth(struct net_device *ndev, int q)
+{
+	/* Place holder */
+}
+
 static void ravb_rx_ring_format(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -354,6 +369,12 @@ static void ravb_ring_format(struct net_device *ndev, int q)
 	desc->dptr = cpu_to_le32((u32)priv->tx_desc_dma[q]);
 }
 
+static void *ravb_alloc_rx_desc_gbeth(struct net_device *ndev, int q)
+{
+	/* Place holder */
+	return NULL;
+}
+
 static void *ravb_alloc_rx_desc(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -424,6 +445,11 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 	return -ENOMEM;
 }
 
+static void ravb_emac_init_gbeth(struct net_device *ndev)
+{
+	/* Place holder */
+}
+
 static void ravb_rcar_emac_init(struct net_device *ndev)
 {
 	/* Receive frame limit set register */
@@ -459,6 +485,12 @@ static void ravb_emac_init(struct net_device *ndev)
 	info->emac_init(ndev);
 }
 
+static int ravb_dmac_init_gbeth(struct net_device *ndev)
+{
+	/* Place holder */
+	return 0;
+}
+
 static int ravb_dmac_init_rcar(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -582,6 +614,14 @@ static void ravb_rx_csum(struct sk_buff *skb)
 	skb_trim(skb, skb->len - sizeof(__sum16));
 }
 
+/* Packet receive function for Gigabit Ethernet */
+static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
+{
+	/* Place holder */
+	return true;
+}
+
+/* Packet receive function for Ethernet AVB */
 static bool ravb_rcar_rx(struct net_device *ndev, int *quota, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -1947,6 +1987,13 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
+static int ravb_set_features_gbeth(struct net_device *ndev,
+				   netdev_features_t features)
+{
+	/* Place holder */
+	return 0;
+}
+
 static int ravb_set_features_rcar(struct net_device *ndev,
 				  netdev_features_t features)
 {
@@ -2071,12 +2118,27 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.nc_queue = 1,
 };
 
+static const struct ravb_hw_info gbeth_hw_info = {
+	.rx_ring_free = ravb_rx_ring_free_gbeth,
+	.rx_ring_format = ravb_rx_ring_format_gbeth,
+	.alloc_rx_desc = ravb_alloc_rx_desc_gbeth,
+	.receive = ravb_rx_gbeth,
+	.set_rate = ravb_set_rate_gbeth,
+	.set_feature = ravb_set_features_gbeth,
+	.dmac_init = ravb_dmac_init_gbeth,
+	.emac_init = ravb_emac_init_gbeth,
+	.max_rx_len = GBETH_RX_BUFF_MAX + RAVB_ALIGN - 1,
+	.aligned_tx = 1,
+	.tx_counters = 1,
+};
+
 static const struct of_device_id ravb_match_table[] = {
 	{ .compatible = "renesas,etheravb-r8a7790", .data = &ravb_gen2_hw_info },
 	{ .compatible = "renesas,etheravb-r8a7794", .data = &ravb_gen2_hw_info },
 	{ .compatible = "renesas,etheravb-rcar-gen2", .data = &ravb_gen2_hw_info },
 	{ .compatible = "renesas,etheravb-r8a7795", .data = &ravb_gen3_hw_info },
 	{ .compatible = "renesas,etheravb-rcar-gen3", .data = &ravb_gen3_hw_info },
+	{ .compatible = "renesas,rzg2l-gbeth", .data = &gbeth_hw_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
-- 
2.17.1


