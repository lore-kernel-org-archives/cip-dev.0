Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047F8C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554243"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C3E2842AC9F7;
	Mon, 10 Jan 2022 21:24:13 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 32/61] ravb: Rename "ravb_set_features_rx_csum"
 function to "ravb_set_features_rcar"
Date: Mon, 10 Jan 2022 12:23:02 +0000
Message-Id: <20220110122331.24114-33-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7397

From: Biju Das <biju.das.jz@bp.renesas.com>

commit d9bc9ec45e015baf5cd8f055e6a6f85b133b4fe3 upstream.

Rename "ravb_set_features_rx_csum" function to "ravb_set_features_rcar" and
replace the function pointer "set_rx_csum_feature" with "set_feature".

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b41806e58135..b24cfbab4b4d 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -986,7 +986,7 @@ struct ravb_hw_info {
 	void *(*alloc_rx_desc)(struct net_device *ndev, int q);
 	bool (*receive)(struct net_device *ndev, int *quota, int q);
 	void (*set_rate)(struct net_device *ndev);
-	int (*set_rx_csum_feature)(struct net_device *ndev, netdev_features_t features);
+	int (*set_feature)(struct net_device *ndev, netdev_features_t features);
 	void (*dmac_init)(struct net_device *ndev);
 	void (*emac_init)(struct net_device *ndev);
 	const char (*gstrings_stats)[ETH_GSTRING_LEN];
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d5f6aa782b56..4a1732ff8f57 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1916,8 +1916,8 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-static int ravb_set_features_rx_csum(struct net_device *ndev,
-				     netdev_features_t features)
+static int ravb_set_features_rcar(struct net_device *ndev,
+				  netdev_features_t features)
 {
 	netdev_features_t changed = ndev->features ^ features;
 
@@ -1935,7 +1935,7 @@ static int ravb_set_features(struct net_device *ndev,
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 
-	return info->set_rx_csum_feature(ndev, features);
+	return info->set_feature(ndev, features);
 }
 
 static const struct net_device_ops ravb_netdev_ops = {
@@ -2004,7 +2004,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.alloc_rx_desc = ravb_alloc_rx_desc,
 	.receive = ravb_rcar_rx,
 	.set_rate = ravb_set_rate,
-	.set_rx_csum_feature = ravb_set_features_rx_csum,
+	.set_feature = ravb_set_features_rcar,
 	.dmac_init = ravb_rcar_dmac_init,
 	.emac_init = ravb_rcar_emac_init,
 	.gstrings_stats = ravb_gstrings_stats,
@@ -2025,7 +2025,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.alloc_rx_desc = ravb_alloc_rx_desc,
 	.receive = ravb_rcar_rx,
 	.set_rate = ravb_set_rate,
-	.set_rx_csum_feature = ravb_set_features_rx_csum,
+	.set_feature = ravb_set_features_rcar,
 	.dmac_init = ravb_rcar_dmac_init,
 	.emac_init = ravb_rcar_emac_init,
 	.gstrings_stats = ravb_gstrings_stats,
-- 
2.17.1


