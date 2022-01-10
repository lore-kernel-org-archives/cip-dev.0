Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330EC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:54 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.31021.1641817424386543755
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011142"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:54 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2A7F841E4D1E;
	Mon, 10 Jan 2022 21:23:52 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 16/61] ravb: Add net_features and net_hw_features
 to struct ravb_hw_info
Date: Mon, 10 Jan 2022 12:22:46 +0000
Message-Id: <20220110122331.24114-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7381

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 8912ed25daf6fc811c71ac30794822c824017c0f upstream.

On R-Car the checksum calculation on RX frames is done by the E-MAC
module, whereas on RZ/G2L it is done by the TOE.

TOE calculates the checksum of received frames from E-MAC and outputs it to
DMAC. TOE also calculates the checksum of transmission frames from DMAC and
outputs it E-MAC.

Add net_features and net_hw_features to struct ravb_hw_info, to support
subsequent SoCs without any code changes in the ravb_probe function.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 ++
 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index dccf64fcbe1f..0d0c27ad4e3b 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -992,6 +992,8 @@ enum ravb_chip_id {
 struct ravb_hw_info {
 	const char (*gstrings_stats)[ETH_GSTRING_LEN];
 	size_t gstrings_size;
+	netdev_features_t net_hw_features;
+	netdev_features_t net_features;
 	enum ravb_chip_id chip_id;
 	int stats_len;
 	size_t max_rx_len;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 8bfdc5b1d1f4..f2e6dc7b5551 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1929,6 +1929,8 @@ static int ravb_mdio_release(struct ravb_private *priv)
 static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
+	.net_hw_features = NETIF_F_RXCSUM,
+	.net_features = NETIF_F_RXCSUM,
 	.chip_id = RCAR_GEN3,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
@@ -1937,6 +1939,8 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.gstrings_stats = ravb_gstrings_stats,
 	.gstrings_size = sizeof(ravb_gstrings_stats),
+	.net_hw_features = NETIF_F_RXCSUM,
+	.net_features = NETIF_F_RXCSUM,
 	.chip_id = RCAR_GEN2,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
@@ -2060,14 +2064,14 @@ static int ravb_probe(struct platform_device *pdev)
 	if (!ndev)
 		return -ENOMEM;
 
-	ndev->features = NETIF_F_RXCSUM;
-	ndev->hw_features = NETIF_F_RXCSUM;
+	info = of_device_get_match_data(&pdev->dev);
+
+	ndev->features = info->net_features;
+	ndev->hw_features = info->net_hw_features;
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	info = of_device_get_match_data(&pdev->dev);
-
 	if (info->chip_id == RCAR_GEN3)
 		irq = platform_get_irq_byname(pdev, "ch22");
 	else
-- 
2.17.1


