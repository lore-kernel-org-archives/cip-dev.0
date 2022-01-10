Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBA3C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:23:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30861.1641817416053116503
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:58 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554197"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 09CC4420C2EE;
	Mon, 10 Jan 2022 21:23:56 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 19/61] ravb: Remove the macros NUM_TX_DESC_GEN[23]
Date: Mon, 10 Jan 2022 12:22:49 +0000
Message-Id: <20220110122331.24114-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:23:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7384

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c81d894226b94439c543e9cfac406c8024172fd7 upstream.

For addressing 4 bytes alignment restriction on transmission
buffer for R-Car Gen2 we use 2 descriptors whereas it is a single
descriptor for other cases.
Replace the macros NUM_TX_DESC_GEN[23] with magic number and
add a comment to explain it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 4 ----
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 3d87fb40b5c8..a0e19a45b2a0 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -957,10 +957,6 @@ enum RAVB_QUEUE {
 
 #define RX_BUF_SZ	(2048 - ETH_FCS_LEN + sizeof(__sum16))
 
-/* TX descriptors per packet */
-#define NUM_TX_DESC_GEN2	2
-#define NUM_TX_DESC_GEN3	1
-
 struct ravb_tstamp_skb {
 	struct list_head list;
 	struct sk_buff *skb;
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b16c179ba44c..a8007c5cdd35 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2158,8 +2158,12 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->max_mtu = 2048 - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
-	priv->num_tx_desc = info->aligned_tx ?
-		NUM_TX_DESC_GEN2 : NUM_TX_DESC_GEN3;
+	/* FIXME: R-Car Gen2 has 4byte alignment restriction for tx buffer
+	 * Use two descriptor to handle such situation. First descriptor to
+	 * handle aligned data buffer and second descriptor to handle the
+	 * overflow data because of alignment.
+	 */
+	priv->num_tx_desc = info->aligned_tx ? 2 : 1;
 
 	/* Set function */
 	ndev->netdev_ops = &ravb_netdev_ops;
-- 
2.17.1


