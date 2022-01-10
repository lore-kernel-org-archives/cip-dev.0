Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0286DC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:43 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554299"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E70E541E4D1E;
	Mon, 10 Jan 2022 21:24:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 53/61] ravb: Rename "tsrq" variable
Date: Mon, 10 Jan 2022 12:23:23 +0000
Message-Id: <20220110122331.24114-54-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7418

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 4ea3167bad275afda5a0b5a794831b312112ec29 upstream.

Rename the variable "tsrq" with "tccr_mask" as we are passing
TCCR mask to the ravb_wait() function.

There is no functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 527e865dee81..99d666a5fb49 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1012,7 +1012,7 @@ struct ravb_hw_info {
 	netdev_features_t net_features;
 	int stats_len;
 	size_t max_rx_len;
-	u32 tsrq;
+	u32 tccr_mask;
 	u32 rx_max_buf_size;
 	unsigned aligned_tx: 1;
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7225e6f70adc..ab57b72ea1cc 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1019,7 +1019,7 @@ static int ravb_stop_dma(struct net_device *ndev)
 	int error;
 
 	/* Wait for stopping the hardware TX process */
-	error = ravb_wait(ndev, TCCR, info->tsrq, 0);
+	error = ravb_wait(ndev, TCCR, info->tccr_mask, 0);
 
 	if (error)
 		return error;
@@ -2408,7 +2408,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.net_features = NETIF_F_RXCSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
-	.tsrq = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
+	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_buf_size = SZ_2K,
 	.internal_delay = 1,
 	.tx_counters = 1,
@@ -2433,7 +2433,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.net_features = NETIF_F_RXCSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
-	.tsrq = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
+	.tccr_mask = TCCR_TSRQ0 | TCCR_TSRQ1 | TCCR_TSRQ2 | TCCR_TSRQ3,
 	.rx_max_buf_size = SZ_2K,
 	.aligned_tx = 1,
 	.gptp = 1,
@@ -2454,7 +2454,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.gstrings_size = sizeof(ravb_gstrings_stats_gbeth),
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
 	.max_rx_len = ALIGN(GBETH_RX_BUFF_MAX, RAVB_ALIGN),
-	.tsrq = TCCR_TSRQ0,
+	.tccr_mask = TCCR_TSRQ0,
 	.rx_max_buf_size = SZ_8K,
 	.aligned_tx = 1,
 	.tx_counters = 1,
-- 
2.17.1


