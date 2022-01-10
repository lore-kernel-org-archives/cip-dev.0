Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BDC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:52 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.31021.1641817424386543755
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:52 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011136"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:51 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 95BFB420C2EE;
	Mon, 10 Jan 2022 21:23:50 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/61] ravb: Add stats_len to struct ravb_hw_info
Date: Mon, 10 Jan 2022 12:22:44 +0000
Message-Id: <20220110122331.24114-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7379

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 25154301fc2bcc1d949a42218e4dfb870f0f1794 upstream.

R-Car provides 30 device stats, whereas RZ/G2L provides only 15. In
addition, RZ/G2L has stats "rx_queue_0_csum_offload_errors" instead of
"rx_queue_0_missed_errors".

Replace RAVB_STATS_LEN macro with a structure variable stats_len to
struct ravb_hw_info, to support subsequent SoCs without any code changes
to the ravb_get_sset_count function.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 546d662b1935..b782977a837a 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -991,6 +991,7 @@ enum ravb_chip_id {
 
 struct ravb_hw_info {
 	enum ravb_chip_id chip_id;
+	int stats_len;
 	size_t max_rx_len;
 	unsigned aligned_tx: 1;
 };
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 62708c838ae9..6f89adff8bf9 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1131,13 +1131,14 @@ static const char ravb_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_queue_1_over_errors",
 };
 
-#define RAVB_STATS_LEN	ARRAY_SIZE(ravb_gstrings_stats)
-
 static int ravb_get_sset_count(struct net_device *netdev, int sset)
 {
+	struct ravb_private *priv = netdev_priv(netdev);
+	const struct ravb_hw_info *info = priv->info;
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return RAVB_STATS_LEN;
+		return info->stats_len;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1924,11 +1925,13 @@ static int ravb_mdio_release(struct ravb_private *priv)
 
 static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.chip_id = RCAR_GEN3,
+	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.chip_id = RCAR_GEN2,
+	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.aligned_tx = 1,
 };
-- 
2.17.1


