Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E830C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 15:34:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.13399.1740670465718438509
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 07:34:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: v1U3r1RwR+icxu+tO4Wl1Q==
X-CSE-MsgGUID: Y8yBtSwoTcyhavojA6rn8w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2025 00:34:29 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CD383402CEAC;
	Fri, 28 Feb 2025 00:34:27 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 03/12] net: ravb: Factor out checksum offload enable bits
Date: Thu, 27 Feb 2025 15:34:04 +0000
Message-ID: <20250227153413.686812-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 15:34:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17967

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
index 0e3de5117bca..e3a8c3fa8d08 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -997,6 +997,8 @@ enum CSR1_BIT {
 	CSR1_TDHD	= 0x08000000,
 };
 
+#define CSR1_CSUM_ENABLE (CSR1_TIP4 | CSR1_TTCP4 | CSR1_TUDP4)
+
 enum CSR2_BIT {
 	CSR2_RIP4	= 0x00000001,
 	CSR2_RTCP4	= 0x00000010,
@@ -1011,6 +1013,8 @@ enum CSR2_BIT {
 	CSR2_RDHD	= 0x08000000,
 };
 
+#define CSR2_CSUM_ENABLE (CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4)
+
 #define DBAT_ENTRY_NUM	22
 #define RX_QUEUE_OFFSET	4
 #define NUM_RX_QUEUE	2
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5cd72098d1be..72578e84bd83 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -517,11 +517,10 @@ static void ravb_csum_init_gbeth(struct net_device *ndev)
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
@@ -2547,7 +2546,7 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 	spin_lock_irqsave(&priv->lock, flags);
 	if (changed & NETIF_F_RXCSUM) {
 		if (features & NETIF_F_RXCSUM)
-			val = CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4;
+			val = CSR2_CSUM_ENABLE;
 		else
 			val = 0;
 
@@ -2558,7 +2557,7 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 
 	if (changed & NETIF_F_HW_CSUM) {
 		if (features & NETIF_F_HW_CSUM)
-			val = CSR1_TIP4 | CSR1_TTCP4 | CSR1_TUDP4;
+			val = CSR1_CSUM_ENABLE;
 		else
 			val = 0;
 
-- 
2.43.0


