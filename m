Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C646DC48291
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 09:03:14 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.58805.1707123791395810413
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 01:03:11 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,242,1701097200"; 
   d="scan'208";a="196808850"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 18:03:09 +0900
Received: from localhost.localdomain (unknown [10.226.93.112])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 79310400D4C8;
	Mon,  5 Feb 2024 18:03:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 4.19.y-cip] ravb: remove undocumented counter processing
Date: Mon,  5 Feb 2024 09:03:03 +0000
Message-Id: <20240205090303.34620-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 09:03:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14661

From: Simon Horman <horms+renesas@verge.net.au>

commit 009a470365b37106bbd66f1e1a53bc6c3c0072bc upstream.

This patch removes the use of the undocumented counter registers
CDCR, LCCR, CERCR, CEECR.

Offsets used for undocumented registers are considered reserved and
should not be written to. After some internal investigation with Renesas
it remains unclear why this driver accesses these fields but regardless of
what the historical reasons are the current code is considered incorrect.

Based on work by Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is depend upon[1]
 [1] https://lore.kernel.org/cip-dev/OS0PR01MB638896E67835B158BC93D8C592422@OS0PR01MB6388.jpnprd01.prod.outlook.com/T/#t
---
 drivers/net/ethernet/renesas/ravb.h      | 4 ----
 drivers/net/ethernet/renesas/ravb_main.c | 9 ---------
 2 files changed, 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index f17e7948444a..7ad35954a332 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -194,15 +194,11 @@ enum ravb_reg {
 	MAHR	= 0x05c0,
 	MALR	= 0x05c8,
 	TROCR	= 0x0700,	/* Undocumented? */
-	CDCR	= 0x0708,	/* Undocumented? */
-	LCCR	= 0x0710,	/* Undocumented? */
 	CEFCR	= 0x0740,
 	FRECR	= 0x0748,
 	TSFRCR	= 0x0750,
 	TLFRCR	= 0x0758,
 	RFCR	= 0x0760,
-	CERCR	= 0x0768,	/* Undocumented? */
-	CEECR	= 0x0770,	/* Undocumented? */
 	MAFCR	= 0x0778,
 };
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2cd14c37c36d..d9b31d49321b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1656,15 +1656,6 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 
 	nstats->tx_dropped += ravb_read(ndev, TROCR);
 	ravb_write(ndev, 0, TROCR);	/* (write clear) */
-	nstats->collisions += ravb_read(ndev, CDCR);
-	ravb_write(ndev, 0, CDCR);	/* (write clear) */
-	nstats->tx_carrier_errors += ravb_read(ndev, LCCR);
-	ravb_write(ndev, 0, LCCR);	/* (write clear) */
-
-	nstats->tx_carrier_errors += ravb_read(ndev, CERCR);
-	ravb_write(ndev, 0, CERCR);	/* (write clear) */
-	nstats->tx_carrier_errors += ravb_read(ndev, CEECR);
-	ravb_write(ndev, 0, CEECR);	/* (write clear) */
 
 	nstats->rx_packets = stats0->rx_packets + stats1->rx_packets;
 	nstats->tx_packets = stats0->tx_packets + stats1->tx_packets;
-- 
2.25.1


