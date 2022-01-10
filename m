Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AD3C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:13 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:12 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011186"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:12 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 341FD41E4D1E;
	Mon, 10 Jan 2022 21:24:11 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 30/61] ravb: Factorise ravb_emac_init function
Date: Mon, 10 Jan 2022 12:23:00 +0000
Message-Id: <20220110122331.24114-31-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7395

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 511d74d9d86ceccb3463fd49adf9de95d4cb3772 upstream.

The E-MAC IP on the R-Car AVB module has different initialization
parameters for RX frame size, duplex settings, different offset
for transfer speed setting and has magic packet detection support
compared to E-MAC on RZ/G2L Gigabit Ethernet module. Factorise
the ravb_emac_init function to support the later SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 536f99b3eb08..5af2391d417c 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -988,6 +988,7 @@ struct ravb_hw_info {
 	void (*set_rate)(struct net_device *ndev);
 	int (*set_rx_csum_feature)(struct net_device *ndev, netdev_features_t features);
 	void (*dmac_init)(struct net_device *ndev);
+	void (*emac_init)(struct net_device *ndev);
 	const char (*gstrings_stats)[ETH_GSTRING_LEN];
 	size_t gstrings_size;
 	netdev_features_t net_hw_features;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0fcedcff6444..74c49c32e778 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -423,8 +423,7 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 	return -ENOMEM;
 }
 
-/* E-MAC init function */
-static void ravb_emac_init(struct net_device *ndev)
+static void ravb_rcar_emac_init(struct net_device *ndev)
 {
 	/* Receive frame limit set register */
 	ravb_write(ndev, ndev->mtu + ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN, RFLR);
@@ -450,6 +449,15 @@ static void ravb_emac_init(struct net_device *ndev)
 	ravb_write(ndev, ECSIPR_ICDIP | ECSIPR_MPDIP | ECSIPR_LCHNGIP, ECSIPR);
 }
 
+/* E-MAC init function */
+static void ravb_emac_init(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+
+	info->emac_init(ndev);
+}
+
 static void ravb_rcar_dmac_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -1997,6 +2005,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.set_rate = ravb_set_rate,
 	.set_rx_csum_feature = ravb_set_features_rx_csum,
 	.dmac_init = ravb_rcar_dmac_init,
+	.emac_init = ravb_rcar_emac_init,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
@@ -2017,6 +2026,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.set_rate = ravb_set_rate,
 	.set_rx_csum_feature = ravb_set_features_rx_csum,
 	.dmac_init = ravb_rcar_dmac_init,
+	.emac_init = ravb_rcar_emac_init,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
-- 
2.17.1


