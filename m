Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6758CC52D1D
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 14:30:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.57657.1722263418601965874
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 07:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213905640"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Jul 2024 23:30:24 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B5D93400EF68;
	Mon, 29 Jul 2024 23:30:22 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y cip 04/11] ravb: Use the max frame size from hardware info for RZ/G2L
Date: Mon, 29 Jul 2024 14:30:04 +0000
Message-Id: <20240729143011.1920068-5-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
References: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 14:30:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16637

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit 496863388136bcba95298ab7dacaf55489af2b02 upstream.

Remove the define describing the RZ/G2L maximum frame size and only use
the information in the hardware information struct. This will make it
easier to merge the R-Car and RZ/G2L code paths.

There is no functional change as both the define and the maximum frame
length in the hardware information is set to 8K.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 -
 drivers/net/ethernet/renesas/ravb_main.c | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b15360b3a008..91253c52519c 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1017,7 +1017,6 @@ enum CSR2_BIT {
 
 #define RX_BUF_SZ	(2048 - ETH_FCS_LEN + sizeof(__sum16))
 
-#define GBETH_RX_BUFF_MAX 8192
 #define GBETH_RX_DESC_DATA_SIZE 4080
 
 struct ravb_tstamp_skb {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 48b2305c4118..4b79467702bd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -566,7 +566,7 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 	}
 
 	/* Receive frame limit set register */
-	ravb_write(ndev, GBETH_RX_BUFF_MAX + ETH_FCS_LEN, RFLR);
+	ravb_write(ndev, priv->info->rx_max_frame_size + ETH_FCS_LEN, RFLR);
 
 	/* EMAC Mode: PAUSE prohibition; Duplex; TX; RX; CRC Pass Through */
 	ravb_write(ndev, ECMR_ZPF | ((priv->duplex > 0) ? ECMR_DM : 0) |
@@ -627,6 +627,7 @@ static void ravb_emac_init(struct net_device *ndev)
 
 static int ravb_dmac_init_gbeth(struct net_device *ndev)
 {
+	struct ravb_private *priv = netdev_priv(ndev);
 	int error;
 
 	error = ravb_ring_init(ndev, RAVB_BE);
@@ -640,7 +641,7 @@ static int ravb_dmac_init_gbeth(struct net_device *ndev)
 	ravb_write(ndev, 0x60000000, RCR);
 
 	/* Set Max Frame Length (RTC) */
-	ravb_write(ndev, 0x7ffc0000 | GBETH_RX_BUFF_MAX, RTC);
+	ravb_write(ndev, 0x7ffc0000 | priv->info->rx_max_frame_size, RTC);
 
 	/* Set FIFO size */
 	ravb_write(ndev, 0x00222200, TGC);
-- 
2.25.1


