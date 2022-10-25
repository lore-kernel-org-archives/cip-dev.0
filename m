Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32F8C38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 14:42:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.7918.1666708922414508996
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 07:42:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.95,212,1661785200"; 
   d="scan'208";a="140312111"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Oct 2022 23:42:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.152])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2CE7C43684FE;
	Tue, 25 Oct 2022 23:41:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface support
Date: Tue, 25 Oct 2022 15:41:31 +0100
Message-Id: <20221025144131.1309463-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 14:42:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9833

commit 1089877ada8d2da5f173922f1061ccfe721ebf56 upstream.

EMAC IP found on RZ/G2L Gb ethernet supports MII interface.
This patch adds support for selecting MII interface mode.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20220914192604.265859-1-biju.das.jz@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 8 ++++++++
 drivers/net/ethernet/renesas/ravb_main.c | 8 +++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 0b5801f7e961..76ae3b5c568e 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -189,6 +189,7 @@ enum ravb_reg {
 	PSR	= 0x0528,
 	PIPR	= 0x052c,
 	CXR31	= 0x0530,	/* RZ/G2L only */
+	CXR35	= 0x0540,	/* RZ/G2L only */
 	MPR	= 0x0558,
 	PFTCR	= 0x055c,
 	PFRCR	= 0x0560,
@@ -965,6 +966,13 @@ enum CXR31_BIT {
 	CXR31_SEL_LINK1	= 0x00000008,
 };
 
+enum CXR35_BIT {
+	CXR35_SEL_XMII		= 0x00000003,
+	CXR35_SEL_XMII_RGMII	= 0x00000000,
+	CXR35_SEL_XMII_MII	= 0x00000002,
+	CXR35_HALFCYC_CLKSW	= 0xffff0000,
+};
+
 enum CSR0_BIT {
 	CSR0_TPE	= 0x00000010,
 	CSR0_RPE	= 0x00000020,
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ea76fd98a767..bc259105a55b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -537,7 +537,13 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 	/* E-MAC interrupt enable register */
 	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
 
-	ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1, CXR31_SEL_LINK0);
+	if (priv->phy_interface == PHY_INTERFACE_MODE_MII) {
+		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1, 0);
+		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII, CXR35);
+	} else {
+		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
+			    CXR31_SEL_LINK0);
+	}
 }
 
 static void ravb_emac_init_rcar(struct net_device *ndev)
-- 
2.25.1


