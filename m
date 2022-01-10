Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010EFC4332F
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:03 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554207"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DCF3341E4D1E;
	Mon, 10 Jan 2022 21:24:00 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 22/61] ravb: Add ptp_cfg_active to struct
 ravb_hw_info
Date: Mon, 10 Jan 2022 12:22:52 +0000
Message-Id: <20220110122331.24114-23-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7387

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a69a3d094de38007ce54e4e1411b5769ed66a426 upstream.

There are some H/W differences for the gPTP feature between
R-Car Gen3, R-Car Gen2, and RZ/G2L as below.

1) On R-Car Gen3, gPTP support is active in config mode.
2) On R-Car Gen2, gPTP support is not active in config mode.
3) RZ/G2L does not support the gPTP feature.

Add a ptp_cfg_active hw feature bit to struct ravb_hw_info for
supporting gPTP active in config mode for R-Car Gen3.
This patch also removes enum ravb_chip_id, chip_id from both
struct ravb_hw_info and struct ravb_private, as it is unused.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  8 +-------
 drivers/net/ethernet/renesas/ravb_main.c | 12 +++++-------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 9d818c26bba5..a0220b48c122 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -980,17 +980,11 @@ struct ravb_ptp {
 	struct ravb_ptp_perout perout[N_PER_OUT];
 };
 
-enum ravb_chip_id {
-	RCAR_GEN2,
-	RCAR_GEN3,
-};
-
 struct ravb_hw_info {
 	const char (*gstrings_stats)[ETH_GSTRING_LEN];
 	size_t gstrings_size;
 	netdev_features_t net_hw_features;
 	netdev_features_t net_features;
-	enum ravb_chip_id chip_id;
 	int stats_len;
 	size_t max_rx_len;
 	unsigned aligned_tx: 1;
@@ -1000,6 +994,7 @@ struct ravb_hw_info {
 	unsigned tx_counters:1;		/* E-MAC has TX counters */
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 	unsigned no_ptp_cfg_active:1;	/* AVB-DMAC does not support gPTP active in config mode */
+	unsigned ptp_cfg_active:1;	/* AVB-DMAC has gPTP support active in config mode */
 };
 
 struct ravb_private {
@@ -1043,7 +1038,6 @@ struct ravb_private {
 	int msg_enable;
 	int speed;
 	int emac_irq;
-	enum ravb_chip_id chip_id;
 	int rx_irqs[NUM_RX_QUEUE];
 	int tx_irqs[NUM_TX_QUEUE];
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index bdeb6a757559..de691dd91cf4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1939,12 +1939,12 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
 	.net_features = NETIF_F_RXCSUM,
-	.chip_id = RCAR_GEN3,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
+	.ptp_cfg_active = 1,
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
@@ -1952,7 +1952,6 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
 	.net_features = NETIF_F_RXCSUM,
-	.chip_id = RCAR_GEN2,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.aligned_tx = 1,
@@ -2150,8 +2149,6 @@ static int ravb_probe(struct platform_device *pdev)
 		}
 	}
 
-	priv->chip_id = info->chip_id;
-
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		error = PTR_ERR(priv->clk);
@@ -2214,7 +2211,7 @@ static int ravb_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&priv->ts_skb_list);
 
 	/* Initialise PTP Clock driver */
-	if (info->chip_id != RCAR_GEN2)
+	if (info->ptp_cfg_active)
 		ravb_ptp_init(ndev, pdev);
 
 	/* Debug message level */
@@ -2262,7 +2259,7 @@ static int ravb_probe(struct platform_device *pdev)
 			  priv->desc_bat_dma);
 
 	/* Stop PTP Clock driver */
-	if (info->chip_id != RCAR_GEN2)
+	if (info->ptp_cfg_active)
 		ravb_ptp_stop(ndev);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
@@ -2278,9 +2275,10 @@ static int ravb_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 
 	/* Stop PTP Clock driver */
-	if (priv->chip_id != RCAR_GEN2)
+	if (info->ptp_cfg_active)
 		ravb_ptp_stop(ndev);
 
 	clk_disable_unprepare(priv->refclk);
-- 
2.17.1


