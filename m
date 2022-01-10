Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE17BC433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:53 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.31021.1641817424386543755
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011139"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:52 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DB37E41E4D1E;
	Mon, 10 Jan 2022 21:23:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/61] ravb: Add gstrings_stats and gstrings_size
 to struct ravb_hw_info
Date: Mon, 10 Jan 2022 12:22:45 +0000
Message-Id: <20220110122331.24114-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7380

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 896a818e0e1d4a2065e210de88b3d0535bbeac1c upstream.

The device stats strings for R-Car and RZ/G2L are different.

R-Car provides 30 device stats, whereas RZ/G2L provides only 15. In
addition, RZ/G2L has stats "rx_queue_0_csum_offload_errors" instead of
"rx_queue_0_missed_errors".

Add structure variables gstrings_stats and gstrings_size to struct
ravb_hw_info, so that subsequent SoCs can be added without any code
changes in the ravb_get_strings function.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 2 ++
 drivers/net/ethernet/renesas/ravb_main.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b782977a837a..dccf64fcbe1f 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -990,6 +990,8 @@ enum ravb_chip_id {
 };
 
 struct ravb_hw_info {
+	const char (*gstrings_stats)[ETH_GSTRING_LEN];
+	size_t gstrings_size;
 	enum ravb_chip_id chip_id;
 	int stats_len;
 	size_t max_rx_len;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 6f89adff8bf9..8bfdc5b1d1f4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1175,9 +1175,12 @@ static void ravb_get_ethtool_stats(struct net_device *ndev,
 
 static void ravb_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 {
+	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
+
 	switch (stringset) {
 	case ETH_SS_STATS:
-		memcpy(data, ravb_gstrings_stats, sizeof(ravb_gstrings_stats));
+		memcpy(data, info->gstrings_stats, info->gstrings_size);
 		break;
 	}
 }
@@ -1924,12 +1927,16 @@ static int ravb_mdio_release(struct ravb_private *priv)
 }
 
 static const struct ravb_hw_info ravb_gen3_hw_info = {
+	.gstrings_stats = ravb_gstrings_stats,
+	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.chip_id = RCAR_GEN3,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
+	.gstrings_stats = ravb_gstrings_stats,
+	.gstrings_size = sizeof(ravb_gstrings_stats),
 	.chip_id = RCAR_GEN2,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
-- 
2.17.1


