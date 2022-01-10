Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01459C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.31021.1641817424386543755
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011152"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 96FD441E4D1E;
	Mon, 10 Jan 2022 21:23:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 21/61] ravb: Add no_ptp_cfg_active to struct
 ravb_hw_info
Date: Mon, 10 Jan 2022 12:22:51 +0000
Message-Id: <20220110122331.24114-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7386

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 8f27219a6191679333e703daf8bb66e5a1241aed upstream.

There are some H/W differences for the gPTP feature between
R-Car Gen3, R-Car Gen2, and RZ/G2L as below.

1) On R-Car Gen2, gPTP support is not active in config mode.
2) On R-Car Gen3, gPTP support is active in config mode.
3) RZ/G2L does not support the gPTP feature.

Add a no_ptp_cfg_active hw feature bit to struct ravb_hw_info for
handling gPTP for R-Car Gen2.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index a74bd63ba3be..9d818c26bba5 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -999,6 +999,7 @@ struct ravb_hw_info {
 	unsigned internal_delay:1;	/* AVB-DMAC has internal delays */
 	unsigned tx_counters:1;		/* E-MAC has TX counters */
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
+	unsigned no_ptp_cfg_active:1;	/* AVB-DMAC does not support gPTP active in config mode */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5e41c2b04083..bdeb6a757559 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1203,6 +1203,7 @@ static int ravb_set_ringparam(struct net_device *ndev,
 			      struct ethtool_ringparam *ring)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	int error;
 
 	if (ring->tx_pending > BE_TX_RING_MAX ||
@@ -1216,7 +1217,7 @@ static int ravb_set_ringparam(struct net_device *ndev,
 	if (netif_running(ndev)) {
 		netif_device_detach(ndev);
 		/* Stop PTP Clock driver */
-		if (priv->chip_id == RCAR_GEN2)
+		if (info->no_ptp_cfg_active)
 			ravb_ptp_stop(ndev);
 		/* Wait for DMA stopping */
 		error = ravb_stop_dma(ndev);
@@ -1248,7 +1249,7 @@ static int ravb_set_ringparam(struct net_device *ndev,
 		ravb_emac_init(ndev);
 
 		/* Initialise PTP Clock driver */
-		if (priv->chip_id == RCAR_GEN2)
+		if (info->no_ptp_cfg_active)
 			ravb_ptp_init(ndev, priv->pdev);
 
 		netif_device_attach(ndev);
@@ -1388,7 +1389,7 @@ static int ravb_open(struct net_device *ndev)
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
-	if (priv->chip_id == RCAR_GEN2)
+	if (info->no_ptp_cfg_active)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
@@ -1402,7 +1403,7 @@ static int ravb_open(struct net_device *ndev)
 
 out_ptp_stop:
 	/* Stop PTP Clock driver */
-	if (priv->chip_id == RCAR_GEN2)
+	if (info->no_ptp_cfg_active)
 		ravb_ptp_stop(ndev);
 out_free_irq_nc_tx:
 	if (!info->multi_irqs)
@@ -1443,13 +1444,14 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 {
 	struct ravb_private *priv = container_of(work, struct ravb_private,
 						 work);
+	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	int error;
 
 	netif_tx_stop_all_queues(ndev);
 
 	/* Stop PTP Clock driver */
-	if (priv->chip_id == RCAR_GEN2)
+	if (info->no_ptp_cfg_active)
 		ravb_ptp_stop(ndev);
 
 	/* Wait for DMA stopping */
@@ -1484,7 +1486,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 
 out:
 	/* Initialise PTP Clock driver */
-	if (priv->chip_id == RCAR_GEN2)
+	if (info->no_ptp_cfg_active)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
@@ -1693,7 +1695,7 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, TIC);
 
 	/* Stop PTP Clock driver */
-	if (priv->chip_id == RCAR_GEN2)
+	if (info->no_ptp_cfg_active)
 		ravb_ptp_stop(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
@@ -1954,6 +1956,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.aligned_tx = 1,
+	.no_ptp_cfg_active = 1,
 };
 
 static const struct of_device_id ravb_match_table[] = {
@@ -1994,8 +1997,9 @@ static int ravb_set_gti(struct net_device *ndev)
 static void ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 
-	if (priv->chip_id == RCAR_GEN2) {
+	if (info->no_ptp_cfg_active) {
 		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
 		/* Set CSEL value */
 		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
-- 
2.17.1


