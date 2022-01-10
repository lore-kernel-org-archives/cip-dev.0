Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2453C433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554253"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F327742ACA04;
	Mon, 10 Jan 2022 21:24:18 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 36/61] ravb: Initialize GbEthernet DMAC
Date: Mon, 10 Jan 2022 12:23:06 +0000
Message-Id: <20220110122331.24114-37-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7401

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 660e3d95e21a929d8a718dcbefe5a63bc4418412 upstream.

Initialize GbEthernet DMAC found on RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  3 ++-
 drivers/net/ethernet/renesas/ravb_main.c | 30 +++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b185f1bb351d..f122ff413469 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -81,6 +81,7 @@ enum ravb_reg {
 	RQC3	= 0x00A0,
 	RQC4	= 0x00A4,
 	RPC	= 0x00B0,
+	RTC	= 0x00B4,	/* R-Car Gen3 and RZ/G2L only */
 	UFCW	= 0x00BC,
 	UFCS	= 0x00C0,
 	UFCV0	= 0x00C4,
@@ -193,7 +194,7 @@ enum ravb_reg {
 	GECMR	= 0x05b0,
 	MAHR	= 0x05c0,
 	MALR	= 0x05c8,
-	TROCR	= 0x0700,	/* R-Car Gen3 only */
+	TROCR	= 0x0700,	/* R-Car Gen3 and RZ/G2L only */
 	CEFCR	= 0x0740,
 	FRECR	= 0x0748,
 	TSFRCR	= 0x0750,
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f4211afe5e68..0cc969cf523a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -487,7 +487,35 @@ static void ravb_emac_init(struct net_device *ndev)
 
 static int ravb_dmac_init_gbeth(struct net_device *ndev)
 {
-	/* Place holder */
+	int error;
+
+	error = ravb_ring_init(ndev, RAVB_BE);
+	if (error)
+		return error;
+
+	/* Descriptor format */
+	ravb_ring_format(ndev, RAVB_BE);
+
+	/* Set AVB RX */
+	ravb_write(ndev, 0x60000000, RCR);
+
+	/* Set Max Frame Length (RTC) */
+	ravb_write(ndev, 0x7ffc0000 | GBETH_RX_BUFF_MAX, RTC);
+
+	/* Set FIFO size */
+	ravb_write(ndev, 0x00222200, TGC);
+
+	ravb_write(ndev, 0, TCCR);
+
+	/* Frame receive */
+	ravb_write(ndev, RIC0_FRE0, RIC0);
+	/* Disable FIFO full warning */
+	ravb_write(ndev, 0x0, RIC1);
+	/* Receive FIFO full error, descriptor empty */
+	ravb_write(ndev, RIC2_QFE0 | RIC2_RFFE, RIC2);
+
+	ravb_write(ndev, TIC_FTE0, TIC);
+
 	return 0;
 }
 
-- 
2.17.1


