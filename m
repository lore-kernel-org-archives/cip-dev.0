Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0347BC433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:39 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554294"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:39 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5BE9642AC9FF;
	Mon, 10 Jan 2022 21:24:38 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 51/61] ravb: Add carrier_counters to struct
 ravb_hw_info
Date: Mon, 10 Jan 2022 12:23:21 +0000
Message-Id: <20220110122331.24114-52-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7416

From: Biju Das <biju.das.jz@bp.renesas.com>

commit b6a4ee6e74ded40bc261fee28f28a5df7021af3b upstream.

RZ/G2L E-MAC supports carrier counters.
Add a carrier_counter hw feature bit to struct ravb_hw_info
to add this feature only for RZ/G2L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 3 +++
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 99164318db26..527e865dee81 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -196,6 +196,8 @@ enum ravb_reg {
 	MAHR	= 0x05c0,
 	MALR	= 0x05c8,
 	TROCR	= 0x0700,	/* R-Car Gen3 and RZ/G2L only */
+	CXR41	= 0x0708,	/* RZ/G2L only */
+	CXR42	= 0x0710,	/* RZ/G2L only */
 	CEFCR	= 0x0740,
 	FRECR	= 0x0748,
 	TSFRCR	= 0x0750,
@@ -1017,6 +1019,7 @@ struct ravb_hw_info {
 	/* hardware features */
 	unsigned internal_delay:1;	/* AVB-DMAC has internal delays */
 	unsigned tx_counters:1;		/* E-MAC has TX counters */
+	unsigned carrier_counters:1;	/* E-MAC has carrier counters */
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 	unsigned gptp:1;		/* AVB-DMAC has gPTP support */
 	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2bfb903699cf..b874a6598dd7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2051,6 +2051,13 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 		ravb_write(ndev, 0, TROCR);	/* (write clear) */
 	}
 
+	if (info->carrier_counters) {
+		nstats->collisions += ravb_read(ndev, CXR41);
+		ravb_write(ndev, 0, CXR41);	/* (write clear) */
+		nstats->tx_carrier_errors += ravb_read(ndev, CXR42);
+		ravb_write(ndev, 0, CXR42);	/* (write clear) */
+	}
+
 	nstats->rx_packets = stats0->rx_packets;
 	nstats->tx_packets = stats0->tx_packets;
 	nstats->rx_bytes = stats0->rx_bytes;
@@ -2430,6 +2437,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.rx_max_buf_size = SZ_8K,
 	.aligned_tx = 1,
 	.tx_counters = 1,
+	.carrier_counters = 1,
 	.half_duplex = 1,
 };
 
-- 
2.17.1


