Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF3C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:41 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011242"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:40 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A1ABF41E4D1E;
	Mon, 10 Jan 2022 21:24:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 52/61] ravb: Add support to retrieve stats for
 GbEthernet
Date: Mon, 10 Jan 2022 12:23:22 +0000
Message-Id: <20220110122331.24114-53-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7417

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0ee65bc14ff2f755c83b9261c510a70bf6ba8d60 upstream.

Add support for retrieving stats information for GbEthernet.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b874a6598dd7..7225e6f70adc 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1491,6 +1491,24 @@ static void ravb_set_msglevel(struct net_device *ndev, u32 value)
 	priv->msg_enable = value;
 }
 
+static const char ravb_gstrings_stats_gbeth[][ETH_GSTRING_LEN] = {
+	"rx_queue_0_current",
+	"tx_queue_0_current",
+	"rx_queue_0_dirty",
+	"tx_queue_0_dirty",
+	"rx_queue_0_packets",
+	"tx_queue_0_packets",
+	"rx_queue_0_bytes",
+	"tx_queue_0_bytes",
+	"rx_queue_0_mcast_packets",
+	"rx_queue_0_errors",
+	"rx_queue_0_crc_errors",
+	"rx_queue_0_frame_errors",
+	"rx_queue_0_length_errors",
+	"rx_queue_0_csum_offload_errors",
+	"rx_queue_0_over_errors",
+};
+
 static const char ravb_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_queue_0_current",
 	"tx_queue_0_current",
@@ -2432,6 +2450,9 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.set_feature = ravb_set_features_gbeth,
 	.dmac_init = ravb_dmac_init_gbeth,
 	.emac_init = ravb_emac_init_gbeth,
+	.gstrings_stats = ravb_gstrings_stats_gbeth,
+	.gstrings_size = sizeof(ravb_gstrings_stats_gbeth),
+	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
 	.max_rx_len = ALIGN(GBETH_RX_BUFF_MAX, RAVB_ALIGN),
 	.tsrq = TCCR_TSRQ0,
 	.rx_max_buf_size = SZ_8K,
-- 
2.17.1


