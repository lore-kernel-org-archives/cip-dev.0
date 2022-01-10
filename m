Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FBEC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:44 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554178"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9353742AC9EE;
	Mon, 10 Jan 2022 21:23:41 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/61] net: ethernet: ravb: Use
 devm_platform_get_and_ioremap_resource()
Date: Mon, 10 Jan 2022 12:22:37 +0000
Message-Id: <20220110122331.24114-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7372

From: Yang Yingliang <yangyingliang@huawei.com>

commit e89a2cdb1cca513a3f431c9f404fe220dfbf949c upstream.

Use devm_platform_get_and_ioremap_resource() to simplify
code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e36f52c9da42..c9233cd4a68d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2045,13 +2045,6 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Get base address */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "invalid resource\n");
-		return -EINVAL;
-	}
-
 	ndev = alloc_etherdev_mqs(sizeof(struct ravb_private),
 				  NUM_TX_QUEUE, NUM_RX_QUEUE);
 	if (!ndev)
@@ -2063,9 +2056,6 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	/* The Ether-specific entries in the device structure. */
-	ndev->base_addr = res->start;
-
 	chip_id = (enum ravb_chip_id)of_device_get_match_data(&pdev->dev);
 
 	if (chip_id == RCAR_GEN3)
@@ -2087,12 +2077,15 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
 	priv->num_tx_ring[RAVB_NC] = NC_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
-	priv->addr = devm_ioremap_resource(&pdev->dev, res);
+	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->addr)) {
 		error = PTR_ERR(priv->addr);
 		goto out_release;
 	}
 
+	/* The Ether-specific entries in the device structure. */
+	ndev->base_addr = res->start;
+
 	spin_lock_init(&priv->lock);
 	INIT_WORK(&priv->work, ravb_tx_timeout_work);
 
-- 
2.17.1


