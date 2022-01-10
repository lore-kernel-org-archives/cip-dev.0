Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28ACC433F5
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:21 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:21 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554256"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:21 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 48C5642AC9FF;
	Mon, 10 Jan 2022 21:24:20 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 37/61] ravb: remove APSR_DM
Date: Mon, 10 Jan 2022 12:23:07 +0000
Message-Id: <20220110122331.24114-38-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7402

From: Sergey Shtylyov <s.shtylyov@omprussia.ru>

commit f4d680e5024805d52a3bbcee20581ab7b83bcfbf upstream.

According to the R-Car Series, 3rd Generation User's Manual: Hardware,
Rev. 1.50, there's no APSR.DM field, instead there are 2 independent
RX/TX clock internal delay bits. Follow the suit: remove #define APSR_DM
and rename #define's APSR_DM_{R|T}DM to APSR_{R|T}DM.

While at it, do several more things to the declaration of *enum* APSR_BIT:
- remove superfluous indentation;
- annotate APSR_MEMS as undocumented;
- annotate APSR as R-Car Gen3 only.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 11 +++++------
 drivers/net/ethernet/renesas/ravb_main.c |  6 +++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index f122ff413469..e61f08e0df59 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -242,13 +242,12 @@ enum ESR_BIT {
 	ESR_EIL		= 0x00001000,
 };
 
-/* APSR */
+/* APSR (R-Car Gen3 only) */
 enum APSR_BIT {
-	APSR_MEMS		= 0x00000002,
-	APSR_CMSW		= 0x00000010,
-	APSR_DM			= 0x00006000,	/* Undocumented? */
-	APSR_DM_RDM		= 0x00002000,
-	APSR_DM_TDM		= 0x00004000,
+	APSR_MEMS	= 0x00000002,	/* Undocumented */
+	APSR_CMSW	= 0x00000010,
+	APSR_RDM	= 0x00002000,
+	APSR_TDM	= 0x00004000,
 };
 
 /* RCR */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0cc969cf523a..97b32094beeb 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2252,10 +2252,10 @@ static void ravb_set_delay_mode(struct net_device *ndev)
 	u32 set = 0;
 
 	if (priv->rxcidm)
-		set |= APSR_DM_RDM;
+		set |= APSR_RDM;
 	if (priv->txcidm)
-		set |= APSR_DM_TDM;
-	ravb_modify(ndev, APSR, APSR_DM, set);
+		set |= APSR_TDM;
+	ravb_modify(ndev, APSR, APSR_RDM | APSR_TDM, set);
 }
 
 static int ravb_probe(struct platform_device *pdev)
-- 
2.17.1


