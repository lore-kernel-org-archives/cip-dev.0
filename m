Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04793C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011216"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:26 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 74C7742ACA0D;
	Mon, 10 Jan 2022 21:24:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 41/61] ravb: Add half_duplex to struct ravb_hw_info
Date: Mon, 10 Jan 2022 12:23:11 +0000
Message-Id: <20220110122331.24114-42-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7406

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 68aa0763c045aefa138b224a3524b3f5b0cf6a01 upstream.

RZ/G2L supports half duplex mode.
Add a half_duplex hw feature bit to struct ravb_hw_info for
supporting half duplex mode for RZ/G2L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  3 ++
 drivers/net/ethernet/renesas/ravb_main.c | 36 ++++++++++++++++++------
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index ea8f7b8f37de..00f234acb274 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1008,6 +1008,7 @@ struct ravb_hw_info {
 	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
 	unsigned nc_queue:1;		/* AVB-DMAC has NC queue */
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
+	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
 };
 
 struct ravb_private {
@@ -1062,6 +1063,8 @@ struct ravb_private {
 	unsigned rgmii_override:1;	/* Deprecated rgmii-*id behavior */
 	unsigned int num_tx_desc;	/* TX descriptors per packet */
 
+	int duplex;
+
 	const struct ravb_hw_info *info;
 	struct reset_control *rstc;
 };
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5d21cfd236f3..aff8ce0d1e3f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1089,6 +1089,13 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	return budget - quota;
 }
 
+static void ravb_set_duplex_gbeth(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	ravb_modify(ndev, ECMR, ECMR_DM, priv->duplex > 0 ? ECMR_DM : 0);
+}
+
 /* PHY state control function */
 static void ravb_adjust_link(struct net_device *ndev)
 {
@@ -1105,6 +1112,12 @@ static void ravb_adjust_link(struct net_device *ndev)
 		ravb_rcv_snd_disable(ndev);
 
 	if (phydev->link) {
+		if (info->half_duplex && phydev->duplex != priv->duplex) {
+			new_state = true;
+			priv->duplex = phydev->duplex;
+			ravb_set_duplex_gbeth(ndev);
+		}
+
 		if (phydev->speed != priv->speed) {
 			new_state = true;
 			priv->speed = phydev->speed;
@@ -1119,6 +1132,8 @@ static void ravb_adjust_link(struct net_device *ndev)
 		new_state = true;
 		priv->link = 0;
 		priv->speed = 0;
+		if (info->half_duplex)
+			priv->duplex = -1;
 	}
 
 	/* Enable TX and RX right over here, if E-MAC change is ignored */
@@ -1141,6 +1156,7 @@ static int ravb_phy_init(struct net_device *ndev)
 {
 	struct device_node *np = ndev->dev.parent->of_node;
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	struct phy_device *phydev;
 	struct device_node *pn;
 	phy_interface_t iface;
@@ -1148,6 +1164,7 @@ static int ravb_phy_init(struct net_device *ndev)
 
 	priv->link = 0;
 	priv->speed = 0;
+	priv->duplex = -1;
 
 	/* Try connecting to PHY */
 	pn = of_parse_phandle(np, "phy-handle", 0);
@@ -1186,15 +1203,17 @@ static int ravb_phy_init(struct net_device *ndev)
 		netdev_info(ndev, "limited PHY to 100Mbit/s\n");
 	}
 
-	/* 10BASE, Pause and Asym Pause is not supported */
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_Pause_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
+	if (!info->half_duplex) {
+		/* 10BASE, Pause and Asym Pause is not supported */
+		phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+		phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_10baseT_Full_BIT);
+		phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_Pause_BIT);
+		phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_Asym_Pause_BIT);
 
-	/* Half Duplex is not supported */
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+		/* Half Duplex is not supported */
+		phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+		phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+	}
 
 	phy_attached_info(phydev);
 
@@ -2173,6 +2192,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.tsrq = TCCR_TSRQ0,
 	.aligned_tx = 1,
 	.tx_counters = 1,
+	.half_duplex = 1,
 };
 
 static const struct of_device_id ravb_match_table[] = {
-- 
2.17.1


