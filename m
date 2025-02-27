Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BBEC282C1
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:57:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12486.1740668248506296267
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:57:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: ZTrBe/wqQHqzGLeeOzB8QQ==
X-CSE-MsgGUID: iue76DsZR8KfqE6kMLV1Kw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2025 23:57:32 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 86C59434774C;
	Thu, 27 Feb 2025 23:57:30 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/11] net: ravb: Factor out checksum offload enable bits
Date: Thu, 27 Feb 2025 14:57:12 +0000
Message-ID: <20250227145720.229324-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
References: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:57:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17954

commit 8e3037924a36505531999df8f5847a68b9272c41 upstream.

Introduce new constants for the CSR1 (TX) and CSR2 (RX) checksum enable
bits, removing the risk of inconsistency when we change which flags we
enable.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 4 ++++
 drivers/net/ethernet/renesas/ravb_main.c | 9 ++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index f8bf7be5f910..93d8499429cc 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -996,6 +996,8 @@ enum CSR1_BIT {
 	CSR1_TDHD	= 0x08000000,
 };
 
+#define CSR1_CSUM_ENABLE (CSR1_TIP4 | CSR1_TTCP4 | CSR1_TUDP4)
+
 enum CSR2_BIT {
 	CSR2_RIP4	= 0x00000001,
 	CSR2_RTCP4	= 0x00000010,
@@ -1010,6 +1012,8 @@ enum CSR2_BIT {
 	CSR2_RDHD	= 0x08000000,
 };
 
+#define CSR2_CSUM_ENABLE (CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4)
+
 #define DBAT_ENTRY_NUM	22
 #define RX_QUEUE_OFFSET	4
 #define NUM_RX_QUEUE	2
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f8b58995e9b6..f0b73b8dfb19 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -477,11 +477,10 @@ static void ravb_csum_init_gbeth(struct net_device *ndev)
 			ndev->features &= ~NETIF_F_RXCSUM;
 	} else {
 		if (tx_enable)
-			ravb_write(ndev, CSR1_TIP4 | CSR1_TTCP4 | CSR1_TUDP4, CSR1);
+			ravb_write(ndev, CSR1_CSUM_ENABLE, CSR1);
 
 		if (rx_enable)
-			ravb_write(ndev, CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4,
-				   CSR2);
+			ravb_write(ndev, CSR2_CSUM_ENABLE, CSR2);
 	}
 
 done:
@@ -2508,7 +2507,7 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 	spin_lock_irqsave(&priv->lock, flags);
 	if (changed & NETIF_F_RXCSUM) {
 		if (features & NETIF_F_RXCSUM)
-			val = CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4;
+			val = CSR2_CSUM_ENABLE;
 		else
 			val = 0;
 
@@ -2519,7 +2518,7 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 
 	if (changed & NETIF_F_HW_CSUM) {
 		if (features & NETIF_F_HW_CSUM)
-			val = CSR1_TIP4 | CSR1_TTCP4 | CSR1_TUDP4;
+			val = CSR1_CSUM_ENABLE;
 		else
 			val = 0;
 
-- 
2.43.0


