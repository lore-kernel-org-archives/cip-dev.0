Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EB7C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.30713.1641817451428133826
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011248"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:45 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C496542AC9F7;
	Mon, 10 Jan 2022 21:24:44 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 56/61] ravb: Update ravb_emac_init_gbeth()
Date: Mon, 10 Jan 2022 12:23:26 +0000
Message-Id: <20220110122331.24114-57-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7421

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3d6b24a2ada3d53f7da9362d03856bdec74806e5 upstream.

This patch enables Receive/Transmit port of TOE and removes
the setting of promiscuous bit from EMAC configuration mode register.

This patch also update EMAC configuration mode comment from
"PAUSE prohibition" to "EMAC Mode: PAUSE prohibition; Duplex; TX;
RX; CRC Pass Through".

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 6 ++++++
 drivers/net/ethernet/renesas/ravb_main.c | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 5d07732ef35a..0b5801f7e961 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -204,6 +204,7 @@ enum ravb_reg {
 	TLFRCR	= 0x0758,
 	RFCR	= 0x0760,
 	MAFCR	= 0x0778,
+	CSR0    = 0x0800,	/* RZ/G2L only */
 };
 
 
@@ -964,6 +965,11 @@ enum CXR31_BIT {
 	CXR31_SEL_LINK1	= 0x00000008,
 };
 
+enum CSR0_BIT {
+	CSR0_TPE	= 0x00000010,
+	CSR0_RPE	= 0x00000020,
+};
+
 #define DBAT_ENTRY_NUM	22
 #define RX_QUEUE_OFFSET	4
 #define NUM_RX_QUEUE	2
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a02ea91c81f5..dc639ff1a395 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -517,10 +517,10 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 	/* Receive frame limit set register */
 	ravb_write(ndev, GBETH_RX_BUFF_MAX + ETH_FCS_LEN, RFLR);
 
-	/* PAUSE prohibition */
+	/* EMAC Mode: PAUSE prohibition; Duplex; TX; RX; CRC Pass Through */
 	ravb_write(ndev, ECMR_ZPF | ((priv->duplex > 0) ? ECMR_DM : 0) |
 			 ECMR_TE | ECMR_RE | ECMR_RCPT |
-			 ECMR_TXF | ECMR_RXF | ECMR_PRM, ECMR);
+			 ECMR_TXF | ECMR_RXF, ECMR);
 
 	ravb_set_rate_gbeth(ndev);
 
@@ -532,6 +532,7 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 
 	/* E-MAC status register clear */
 	ravb_write(ndev, ECSR_ICD | ECSR_LCHNG | ECSR_PFRI, ECSR);
+	ravb_write(ndev, CSR0_TPE | CSR0_RPE, CSR0);
 
 	/* E-MAC interrupt enable register */
 	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
-- 
2.17.1


