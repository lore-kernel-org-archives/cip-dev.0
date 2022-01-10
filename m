Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073ACC433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011221"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:30 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5668F41E4D1E;
	Mon, 10 Jan 2022 21:24:29 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 44/61] ravb: Initialize GbEthernet E-MAC
Date: Mon, 10 Jan 2022 12:23:14 +0000
Message-Id: <20220110122331.24114-45-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7409

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 16a2351992353ca7f12824c81feed783306d7f5f upstream.

Initialize GbEthernet E-MAC found on RZ/G2L SoC.
This patch also renames ravb_set_rate to ravb_set_rate_rcar and
ravb_rcar_emac_init to ravb_emac_init_rcar to be consistent with
the naming convention used in sh_eth driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 20 +++++++--
 drivers/net/ethernet/renesas/ravb_main.c | 55 ++++++++++++++++++++----
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index d83d3b4f3f5f..5dc1324786e0 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -188,6 +188,7 @@ enum ravb_reg {
 	PIR	= 0x0520,
 	PSR	= 0x0528,
 	PIPR	= 0x052c,
+	CXR31	= 0x0530,	/* RZ/G2L only */
 	MPR	= 0x0558,
 	PFTCR	= 0x055c,
 	PFRCR	= 0x0560,
@@ -811,10 +812,11 @@ enum ECMR_BIT {
 	ECMR_TXF	= 0x00010000,	/* Documented for R-Car Gen3 only */
 	ECMR_RXF	= 0x00020000,
 	ECMR_PFR	= 0x00040000,
-	ECMR_ZPF	= 0x00080000,	/* Documented for R-Car Gen3 only */
+	ECMR_ZPF	= 0x00080000,	/* Documented for R-Car Gen3 and RZ/G2L */
 	ECMR_RZPF	= 0x00100000,
 	ECMR_DPAD	= 0x00200000,
 	ECMR_RCSC	= 0x00800000,
+	ECMR_RCPT	= 0x02000000,	/* Documented for RZ/G2L only */
 	ECMR_TRCCM	= 0x04000000,
 };
 
@@ -824,6 +826,7 @@ enum ECSR_BIT {
 	ECSR_MPD	= 0x00000002,
 	ECSR_LCHNG	= 0x00000004,
 	ECSR_PHYI	= 0x00000008,
+	ECSR_PFRI	= 0x00000010,
 };
 
 /* ECSIPR */
@@ -858,9 +861,13 @@ enum MPR_BIT {
 
 /* GECMR */
 enum GECMR_BIT {
-	GECMR_SPEED	= 0x00000001,
-	GECMR_SPEED_100	= 0x00000000,
-	GECMR_SPEED_1000 = 0x00000001,
+	GECMR_SPEED		= 0x00000001,
+	GECMR_SPEED_100		= 0x00000000,
+	GECMR_SPEED_1000	= 0x00000001,
+	GBETH_GECMR_SPEED	= 0x00000030,
+	GBETH_GECMR_SPEED_10	= 0x00000000,
+	GBETH_GECMR_SPEED_100	= 0x00000010,
+	GBETH_GECMR_SPEED_1000	= 0x00000020,
 };
 
 /* The Ethernet AVB descriptor definitions. */
@@ -950,6 +957,11 @@ enum RAVB_QUEUE {
 	RAVB_NC,	/* Network Control Queue */
 };
 
+enum CXR31_BIT {
+	CXR31_SEL_LINK0	= 0x00000001,
+	CXR31_SEL_LINK1	= 0x00000008,
+};
+
 #define DBAT_ENTRY_NUM	22
 #define RX_QUEUE_OFFSET	4
 #define NUM_RX_QUEUE	2
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index aff8ce0d1e3f..29c4d74b0f02 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -85,10 +85,22 @@ static int ravb_config(struct net_device *ndev)
 
 static void ravb_set_rate_gbeth(struct net_device *ndev)
 {
-	/* Place holder */
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	switch (priv->speed) {
+	case 10:                /* 10BASE */
+		ravb_write(ndev, GBETH_GECMR_SPEED_10, GECMR);
+		break;
+	case 100:               /* 100BASE */
+		ravb_write(ndev, GBETH_GECMR_SPEED_100, GECMR);
+		break;
+	case 1000:              /* 1000BASE */
+		ravb_write(ndev, GBETH_GECMR_SPEED_1000, GECMR);
+		break;
+	}
 }
 
-static void ravb_set_rate(struct net_device *ndev)
+static void ravb_set_rate_rcar(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 
@@ -447,10 +459,35 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 
 static void ravb_emac_init_gbeth(struct net_device *ndev)
 {
-	/* Place holder */
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	/* Receive frame limit set register */
+	ravb_write(ndev, GBETH_RX_BUFF_MAX + ETH_FCS_LEN, RFLR);
+
+	/* PAUSE prohibition */
+	ravb_write(ndev, ECMR_ZPF | ((priv->duplex > 0) ? ECMR_DM : 0) |
+			 ECMR_TE | ECMR_RE | ECMR_RCPT |
+			 ECMR_TXF | ECMR_RXF | ECMR_PRM, ECMR);
+
+	ravb_set_rate_gbeth(ndev);
+
+	/* Set MAC address */
+	ravb_write(ndev,
+		   (ndev->dev_addr[0] << 24) | (ndev->dev_addr[1] << 16) |
+		   (ndev->dev_addr[2] << 8)  | (ndev->dev_addr[3]), MAHR);
+	ravb_write(ndev, (ndev->dev_addr[4] << 8)  | (ndev->dev_addr[5]), MALR);
+
+	/* E-MAC status register clear */
+	ravb_write(ndev, ECSR_ICD | ECSR_LCHNG | ECSR_PFRI, ECSR);
+
+	/* E-MAC interrupt enable register */
+	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
+
+	ravb_modify(ndev, CXR31, CXR31_SEL_LINK1, 0);
+	ravb_modify(ndev, CXR31, CXR31_SEL_LINK0, CXR31_SEL_LINK0);
 }
 
-static void ravb_rcar_emac_init(struct net_device *ndev)
+static void ravb_emac_init_rcar(struct net_device *ndev)
 {
 	/* Receive frame limit set register */
 	ravb_write(ndev, ndev->mtu + ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN, RFLR);
@@ -460,7 +497,7 @@ static void ravb_rcar_emac_init(struct net_device *ndev)
 		   (ndev->features & NETIF_F_RXCSUM ? ECMR_RCSC : 0) |
 		   ECMR_TE | ECMR_RE, ECMR);
 
-	ravb_set_rate(ndev);
+	ravb_set_rate_rcar(ndev);
 
 	/* Set MAC address */
 	ravb_write(ndev,
@@ -2138,10 +2175,10 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.rx_ring_format = ravb_rx_ring_format,
 	.alloc_rx_desc = ravb_alloc_rx_desc,
 	.receive = ravb_rcar_rx,
-	.set_rate = ravb_set_rate,
+	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
 	.dmac_init = ravb_dmac_init_rcar,
-	.emac_init = ravb_rcar_emac_init,
+	.emac_init = ravb_emac_init_rcar,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
@@ -2162,10 +2199,10 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.rx_ring_format = ravb_rx_ring_format,
 	.alloc_rx_desc = ravb_alloc_rx_desc,
 	.receive = ravb_rcar_rx,
-	.set_rate = ravb_set_rate,
+	.set_rate = ravb_set_rate_rcar,
 	.set_feature = ravb_set_features_rcar,
 	.dmac_init = ravb_dmac_init_rcar,
-	.emac_init = ravb_rcar_emac_init,
+	.emac_init = ravb_emac_init_rcar,
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.net_hw_features = NETIF_F_RXCSUM,
-- 
2.17.1


