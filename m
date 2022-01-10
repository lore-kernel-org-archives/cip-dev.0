Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B509C433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:26 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011212"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2FD0242ACA04;
	Mon, 10 Jan 2022 21:24:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 40/61] ravb: Add magic_pkt to struct ravb_hw_info
Date: Mon, 10 Jan 2022 12:23:10 +0000
Message-Id: <20220110122331.24114-41-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7405

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ebd5df063ce4a98553875e5b75eb8c0ab0584936 upstream.

E-MAC on R-Car supports magic packet detection, whereas RZ/G2L
does not support this feature. Add magic_pkt to struct ravb_hw_info
and enable this feature only for R-Car.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 1772f0fe3cb5..ea8f7b8f37de 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1007,6 +1007,7 @@ struct ravb_hw_info {
 	unsigned gptp:1;		/* AVB-DMAC has gPTP support */
 	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
 	unsigned nc_queue:1;		/* AVB-DMAC has NC queue */
+	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7ee3cd39c86e..5d21cfd236f3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1434,8 +1434,9 @@ static void ravb_get_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
 static int ravb_set_wol(struct net_device *ndev, struct ethtool_wolinfo *wol)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 
-	if (wol->wolopts & ~WAKE_MAGIC)
+	if (!info->magic_pkt || (wol->wolopts & ~WAKE_MAGIC))
 		return -EOPNOTSUPP;
 
 	priv->wol_enabled = !!(wol->wolopts & WAKE_MAGIC);
@@ -2134,6 +2135,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.multi_irqs = 1,
 	.ccc_gac = 1,
 	.nc_queue = 1,
+	.magic_pkt = 1,
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
@@ -2155,6 +2157,7 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.aligned_tx = 1,
 	.gptp = 1,
 	.nc_queue = 1,
+	.magic_pkt = 1,
 };
 
 static const struct ravb_hw_info gbeth_hw_info = {
-- 
2.17.1


