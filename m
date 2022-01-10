Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D67C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011179"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:10 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E4EDE42AC9F0;
	Mon, 10 Jan 2022 21:24:09 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 29/61] ravb: Factorise ravb_dmac_init function
Date: Mon, 10 Jan 2022 12:22:59 +0000
Message-Id: <20220110122331.24114-30-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7394

From: Biju Das <biju.das.jz@bp.renesas.com>

commit eb4fd127448b173df15b4e92ace016467b2fc441 upstream.

The DMAC IP on the R-Car AVB module has different initialization
parameters for RCR, TGC, TCCR, RIC0, RIC2, and TIC compared to
DMAC IP on the RZ/G2L Gigabit Ethernet module. Factorise the
ravb_dmac_init function to support the later SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 52 ++++++++++++++----------
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 262c6b9d470c..536f99b3eb08 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -987,6 +987,7 @@ struct ravb_hw_info {
 	bool (*receive)(struct net_device *ndev, int *quota, int q);
 	void (*set_rate)(struct net_device *ndev);
 	int (*set_rx_csum_feature)(struct net_device *ndev, netdev_features_t features);
+	void (*dmac_init)(struct net_device *ndev);
 	const char (*gstrings_stats)[ETH_GSTRING_LEN];
 	size_t gstrings_size;
 	netdev_features_t net_hw_features;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 862bf2715fe1..0fcedcff6444 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -450,30 +450,10 @@ static void ravb_emac_init(struct net_device *ndev)
 	ravb_write(ndev, ECSIPR_ICDIP | ECSIPR_MPDIP | ECSIPR_LCHNGIP, ECSIPR);
 }
 
-/* Device init function for Ethernet AVB */
-static int ravb_dmac_init(struct net_device *ndev)
+static void ravb_rcar_dmac_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int error;
-
-	/* Set CONFIG mode */
-	error = ravb_config(ndev);
-	if (error)
-		return error;
-
-	error = ravb_ring_init(ndev, RAVB_BE);
-	if (error)
-		return error;
-	error = ravb_ring_init(ndev, RAVB_NC);
-	if (error) {
-		ravb_ring_free(ndev, RAVB_BE);
-		return error;
-	}
-
-	/* Descriptor format */
-	ravb_ring_format(ndev, RAVB_BE);
-	ravb_ring_format(ndev, RAVB_NC);
 
 	/* Set AVB RX */
 	ravb_write(ndev,
@@ -500,6 +480,34 @@ static int ravb_dmac_init(struct net_device *ndev)
 	ravb_write(ndev, RIC2_QFE0 | RIC2_QFE1 | RIC2_RFFE, RIC2);
 	/* Frame transmitted, timestamp FIFO updated */
 	ravb_write(ndev, TIC_FTE0 | TIC_FTE1 | TIC_TFUE, TIC);
+}
+
+/* Device init function for Ethernet AVB */
+static int ravb_dmac_init(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+	int error;
+
+	/* Set CONFIG mode */
+	error = ravb_config(ndev);
+	if (error)
+		return error;
+
+	error = ravb_ring_init(ndev, RAVB_BE);
+	if (error)
+		return error;
+	error = ravb_ring_init(ndev, RAVB_NC);
+	if (error) {
+		ravb_ring_free(ndev, RAVB_BE);
+		return error;
+	}
+
+	/* Descriptor format */
+	ravb_ring_format(ndev, RAVB_BE);
+	ravb_ring_format(ndev, RAVB_NC);
+
+	info->dmac_init(ndev);
 
 	/* Setting the control will start the AVB-DMAC process. */
 	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
@@ -1988,6 +1996,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.receive = ravb_rcar_rx,
 	.set_rate = ravb_set_rate,
 	.set_rx_csum_feature = ravb_set_features_rx_csum,
+	.dmac_init = ravb_rcar_dmac_init,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
@@ -2007,6 +2016,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.receive = ravb_rcar_rx,
 	.set_rate = ravb_set_rate,
 	.set_rx_csum_feature = ravb_set_features_rx_csum,
+	.dmac_init = ravb_rcar_dmac_init,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
-- 
2.17.1


