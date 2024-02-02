Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1300BC48291
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 10:32:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.19929.1706869930377556114
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 02:32:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,237,1701097200"; 
   d="scan'208";a="196564141"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Feb 2024 19:32:08 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AF5F141EE62E;
	Fri,  2 Feb 2024 19:32:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4.19.y-cip 2/2] ravb: remove undocumented endianness selection
Date: Fri,  2 Feb 2024 10:32:00 +0000
Message-Id: <20240202103200.171406-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202103200.171406-1-biju.das.jz@bp.renesas.com>
References: <20240202103200.171406-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 10:32:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14611

From: Simon Horman <horms+renesas@verge.net.au>

commit 2d957a7e2a9b74eaa3243e1254724878825f95d2 upstream.

This patch removes the use of the undocumented BOC bit of the CCC register.

Current documentation for EtherAVB (ravb) describes the offset of what the
driver uses as the BOC bit as reserved and that only a value of 0 should be
written. After some internal investigation with Renesas it remains unclear
why this driver accesses these fields but regardless of what the historical
reasons are the current code is considered incorrect.

Based on work by Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 -
 drivers/net/ethernet/renesas/ravb_main.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 6eabf1ed30d1..f17e7948444a 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -220,7 +220,6 @@ enum CCC_BIT {
 	CCC_CSEL_HPB	= 0x00010000,
 	CCC_CSEL_ETH_TX	= 0x00020000,
 	CCC_CSEL_GMII_REF = 0x00030000,
-	CCC_BOC		= 0x00100000,	/* Undocumented? */
 	CCC_LBME	= 0x01000000,
 };
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f1f66faa1453..2cd14c37c36d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -447,12 +447,6 @@ static int ravb_dmac_init(struct net_device *ndev)
 	ravb_ring_format(ndev, RAVB_BE);
 	ravb_ring_format(ndev, RAVB_NC);
 
-#if defined(__LITTLE_ENDIAN)
-	ravb_modify(ndev, CCC, CCC_BOC, 0);
-#else
-	ravb_modify(ndev, CCC, CCC_BOC, CCC_BOC);
-#endif
-
 	/* Set AVB RX */
 	ravb_write(ndev,
 		   RCR_EFFS | RCR_ENCF | RCR_ETS0 | RCR_ESF | 0x18000000, RCR);
-- 
2.25.1


