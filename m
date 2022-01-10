Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED2BC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:56 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554194"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:55 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6FB3F420C2EE;
	Mon, 10 Jan 2022 21:23:54 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/61] ravb: Add internal delay hw feature to
 struct ravb_hw_info
Date: Mon, 10 Jan 2022 12:22:47 +0000
Message-Id: <20220110122331.24114-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7382

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 8bc4caa0abafd83e25df2a3b1b03480aab071ee1 upstream.

R-Car Gen3 supports TX and RX clock internal delay modes, whereas R-Car
Gen2 and RZ/G2L do not support it.
Add an internal_delay hw feature bit to struct ravb_hw_info to enable this
only for R-Car Gen3.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 3 +++
 drivers/net/ethernet/renesas/ravb_main.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 0d0c27ad4e3b..9aee46e23105 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -998,6 +998,9 @@ struct ravb_hw_info {
 	int stats_len;
 	size_t max_rx_len;
 	unsigned aligned_tx: 1;
+
+	/* hardware features */
+	unsigned internal_delay:1;	/* AVB-DMAC has internal delays */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f2e6dc7b5551..838badff3c19 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1934,6 +1934,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.chip_id = RCAR_GEN3,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats),
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
+	.internal_delay = 1,
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
@@ -2173,7 +2174,7 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Request GTI loading */
 	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
 
-	if (priv->chip_id != RCAR_GEN2) {
+	if (info->internal_delay) {
 		ravb_parse_delay_mode(np, ndev);
 		ravb_set_delay_mode(ndev);
 	}
@@ -2346,6 +2347,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	int ret = 0;
 
 	/* If WoL is enabled set reset mode to rearm the WoL logic */
@@ -2368,7 +2370,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	/* Request GTI loading */
 	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
 
-	if (priv->chip_id != RCAR_GEN2)
+	if (info->internal_delay)
 		ravb_set_delay_mode(ndev);
 
 	/* Restore descriptor base address table */
-- 
2.17.1


