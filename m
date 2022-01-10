Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC86EC433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.30862.1641817419552871493
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:40 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011121"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:39 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0836F42AC9F0;
	Mon, 10 Jan 2022 21:23:38 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/61] net: ethernet: ravb: Enable optional refclk
Date: Mon, 10 Jan 2022 12:22:35 +0000
Message-Id: <20220110122331.24114-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7370

From: Adam Ford <aford173@gmail.com>

commit 8ef7adc6beb2ef0bce83513dc9e4505e7b21e8c2 upstream.

For devices that use a programmable clock for the AVB reference clock,
the driver may need to enable them.  Add code to find the optional clock
and enable it when available.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 7453b17a37a2..ff363797bd2b 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -994,6 +994,7 @@ struct ravb_private {
 	struct platform_device *pdev;
 	void __iomem *addr;
 	struct clk *clk;
+	struct clk *refclk;
 	struct mdiobb_ctrl mdiobb;
 	u32 num_rx_ring[NUM_RX_QUEUE];
 	u32 num_tx_ring[NUM_TX_QUEUE];
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f96eed67e1a2..d1e32a1015eb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2137,6 +2137,13 @@ static int ravb_probe(struct platform_device *pdev)
 		goto out_release;
 	}
 
+	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
+	if (IS_ERR(priv->refclk)) {
+		error = PTR_ERR(priv->refclk);
+		goto out_release;
+	}
+	clk_prepare_enable(priv->refclk);
+
 	ndev->max_mtu = 2048 - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
@@ -2233,6 +2240,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (chip_id != RCAR_GEN2)
 		ravb_ptp_stop(ndev);
 out_release:
+	clk_disable_unprepare(priv->refclk);
 	free_netdev(ndev);
 
 	pm_runtime_put(&pdev->dev);
@@ -2249,6 +2257,8 @@ static int ravb_remove(struct platform_device *pdev)
 	if (priv->chip_id != RCAR_GEN2)
 		ravb_ptp_stop(ndev);
 
+	clk_disable_unprepare(priv->refclk);
+
 	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
 			  priv->desc_bat_dma);
 	/* Set reset mode */
-- 
2.17.1


