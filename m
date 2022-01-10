Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E00C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:48 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554186"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:47 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BB3A241E4D1E;
	Mon, 10 Jan 2022 21:23:46 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/61] ravb: Add struct ravb_hw_info to driver data
Date: Mon, 10 Jan 2022 12:22:41 +0000
Message-Id: <20220110122331.24114-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7376

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ebb091461a9e146f8afd750cb7eddc5b4c8d47be upstream.

The DMAC and EMAC blocks of Gigabit Ethernet IP found on RZ/G2L SoC are
similar to the R-Car Ethernet AVB IP. With a few changes in the driver we
can support both IPs.

This patch adds the struct ravb_hw_info to hold hw features, driver data
and function pointers to support both the IPs. It also replaces the driver
data chip type with struct ravb_hw_info by moving chip type to it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  6 ++++
 drivers/net/ethernet/renesas/ravb_main.c | 35 +++++++++++++++---------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index ccc9471897f3..9c228fa8e2a4 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -989,6 +989,10 @@ enum ravb_chip_id {
 	RCAR_GEN3,
 };
 
+struct ravb_hw_info {
+	enum ravb_chip_id chip_id;
+};
+
 struct ravb_private {
 	struct net_device *ndev;
 	struct platform_device *pdev;
@@ -1041,6 +1045,8 @@ struct ravb_private {
 	unsigned txcidm:1;		/* TX Clock Internal Delay Mode */
 	unsigned rgmii_override:1;	/* Deprecated rgmii-*id behavior */
 	unsigned int num_tx_desc;	/* TX descriptors per packet */
+
+	const struct ravb_hw_info *info;
 };
 
 static inline u32 ravb_read(struct net_device *ndev, enum ravb_reg reg)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1566009489e3..0bf787896521 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1922,12 +1922,20 @@ static int ravb_mdio_release(struct ravb_private *priv)
 	return 0;
 }
 
+static const struct ravb_hw_info ravb_gen3_hw_info = {
+	.chip_id = RCAR_GEN3,
+};
+
+static const struct ravb_hw_info ravb_gen2_hw_info = {
+	.chip_id = RCAR_GEN2,
+};
+
 static const struct of_device_id ravb_match_table[] = {
-	{ .compatible = "renesas,etheravb-r8a7790", .data = (void *)RCAR_GEN2 },
-	{ .compatible = "renesas,etheravb-r8a7794", .data = (void *)RCAR_GEN2 },
-	{ .compatible = "renesas,etheravb-rcar-gen2", .data = (void *)RCAR_GEN2 },
-	{ .compatible = "renesas,etheravb-r8a7795", .data = (void *)RCAR_GEN3 },
-	{ .compatible = "renesas,etheravb-rcar-gen3", .data = (void *)RCAR_GEN3 },
+	{ .compatible = "renesas,etheravb-r8a7790", .data = &ravb_gen2_hw_info },
+	{ .compatible = "renesas,etheravb-r8a7794", .data = &ravb_gen2_hw_info },
+	{ .compatible = "renesas,etheravb-rcar-gen2", .data = &ravb_gen2_hw_info },
+	{ .compatible = "renesas,etheravb-r8a7795", .data = &ravb_gen3_hw_info },
+	{ .compatible = "renesas,etheravb-rcar-gen3", .data = &ravb_gen3_hw_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
@@ -2021,8 +2029,8 @@ static void ravb_set_delay_mode(struct net_device *ndev)
 static int ravb_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct ravb_hw_info *info;
 	struct ravb_private *priv;
-	enum ravb_chip_id chip_id;
 	struct net_device *ndev;
 	int error, irq, q;
 	struct resource *res;
@@ -2045,9 +2053,9 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	chip_id = (enum ravb_chip_id)of_device_get_match_data(&pdev->dev);
+	info = of_device_get_match_data(&pdev->dev);
 
-	if (chip_id == RCAR_GEN3)
+	if (info->chip_id == RCAR_GEN3)
 		irq = platform_get_irq_byname(pdev, "ch22");
 	else
 		irq = platform_get_irq(pdev, 0);
@@ -2060,6 +2068,7 @@ static int ravb_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	priv = netdev_priv(ndev);
+	priv->info = info;
 	priv->ndev = ndev;
 	priv->pdev = pdev;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
@@ -2086,7 +2095,7 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	if (chip_id == RCAR_GEN3) {
+	if (info->chip_id == RCAR_GEN3) {
 		irq = platform_get_irq_byname(pdev, "ch24");
 		if (irq < 0) {
 			error = irq;
@@ -2111,7 +2120,7 @@ static int ravb_probe(struct platform_device *pdev)
 		}
 	}
 
-	priv->chip_id = chip_id;
+	priv->chip_id = info->chip_id;
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
@@ -2129,7 +2138,7 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->max_mtu = 2048 - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
-	priv->num_tx_desc = chip_id == RCAR_GEN2 ?
+	priv->num_tx_desc = info->chip_id == RCAR_GEN2 ?
 		NUM_TX_DESC_GEN2 : NUM_TX_DESC_GEN3;
 
 	/* Set function */
@@ -2171,7 +2180,7 @@ static int ravb_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&priv->ts_skb_list);
 
 	/* Initialise PTP Clock driver */
-	if (chip_id != RCAR_GEN2)
+	if (info->chip_id != RCAR_GEN2)
 		ravb_ptp_init(ndev, pdev);
 
 	/* Debug message level */
@@ -2219,7 +2228,7 @@ static int ravb_probe(struct platform_device *pdev)
 			  priv->desc_bat_dma);
 
 	/* Stop PTP Clock driver */
-	if (chip_id != RCAR_GEN2)
+	if (info->chip_id != RCAR_GEN2)
 		ravb_ptp_stop(ndev);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
-- 
2.17.1


