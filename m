Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035D6C433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:15 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554240"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:13 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7CBE442AC9F0;
	Mon, 10 Jan 2022 21:24:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 31/61] ravb: Add reset support
Date: Mon, 10 Jan 2022 12:23:01 +0000
Message-Id: <20220110122331.24114-32-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7396

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0d13a1a464a023379291218ac051e2bf8f46b5d1 upstream.

Reset support is present on R-Car. Let's support it, if it is
available.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 5af2391d417c..b41806e58135 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1058,6 +1058,7 @@ struct ravb_private {
 	unsigned int num_tx_desc;	/* TX descriptors per packet */
 
 	const struct ravb_hw_info *info;
+	struct reset_control *rstc;
 };
 
 static inline u32 ravb_read(struct net_device *ndev, enum ravb_reg reg)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 74c49c32e778..d5f6aa782b56 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/sys_soc.h>
+#include <linux/reset.h>
 
 #include <asm/div64.h>
 
@@ -2138,6 +2139,7 @@ static int ravb_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct ravb_hw_info *info;
+	struct reset_control *rstc;
 	struct ravb_private *priv;
 	struct net_device *ndev;
 	int error, irq, q;
@@ -2150,6 +2152,11 @@ static int ravb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
+				     "failed to get cpg reset\n");
+
 	ndev = alloc_etherdev_mqs(sizeof(struct ravb_private),
 				  NUM_TX_QUEUE, NUM_RX_QUEUE);
 	if (!ndev)
@@ -2160,6 +2167,7 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 
+	reset_control_deassert(rstc);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -2177,6 +2185,7 @@ static int ravb_probe(struct platform_device *pdev)
 
 	priv = netdev_priv(ndev);
 	priv->info = info;
+	priv->rstc = rstc;
 	priv->ndev = ndev;
 	priv->pdev = pdev;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
@@ -2347,6 +2356,7 @@ static int ravb_probe(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(rstc);
 	return error;
 }
 
@@ -2372,6 +2382,7 @@ static int ravb_remove(struct platform_device *pdev)
 	netif_napi_del(&priv->napi[RAVB_BE]);
 	ravb_mdio_release(priv);
 	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
 
-- 
2.17.1


