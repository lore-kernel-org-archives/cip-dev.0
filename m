Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7223C48292
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 10:18:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.19788.1706869093664793494
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 02:18:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,237,1701097200"; 
   d="scan'208";a="192651863"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Feb 2024 19:18:13 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6B6CB41E8714;
	Fri,  2 Feb 2024 19:18:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 4.4.y-cip 1/2] ravb: update "undocumented" annotations
Date: Fri,  2 Feb 2024 10:18:06 +0000
Message-Id: <20240202101807.153140-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202101807.153140-1-biju.das.jz@bp.renesas.com>
References: <20240202101807.153140-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 10:18:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14607

From: Sergey Shtylyov <s.shtylyov@omprussia.ru>

commit 360a794323a8c29addae398fcaca40d8859c0743 upstream.

The "undocumented" annotations in the EtherAVB driver were done against
the R-Car gen2 manuals; most of these registers/bits were then described
in the R-Car gen3 manuals -- reflect  this fact in the annotations (note
that ECSIPR.LCHNGIP was documented in the recent R-Car gen2 manual)...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omprussia.ru>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 0623fff932e4..5358a8cba769 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -166,7 +166,7 @@ enum ravb_reg {
 	GTO2	= 0x03A8,
 	GIC	= 0x03AC,
 	GIS	= 0x03B0,
-	GCPT	= 0x03B4,	/* Undocumented? */
+	GCPT	= 0x03B4,	/* Documented for R-Car Gen3 only */
 	GCT0	= 0x03B8,
 	GCT1	= 0x03BC,
 	GCT2	= 0x03C0,
@@ -221,7 +221,7 @@ enum CSR_BIT {
 	CSR_OPS_RESET	= 0x00000001,
 	CSR_OPS_CONFIG	= 0x00000002,
 	CSR_OPS_OPERATION = 0x00000004,
-	CSR_OPS_STANDBY	= 0x00000008,	/* Undocumented? */
+	CSR_OPS_STANDBY	= 0x00000008,	/* Documented for R-Car Gen3 only */
 	CSR_DTS		= 0x00000100,
 	CSR_TPO0	= 0x00010000,
 	CSR_TPO1	= 0x00020000,
@@ -514,24 +514,24 @@ enum RIS2_BIT {
 
 /* TIC */
 enum TIC_BIT {
-	TIC_FTE0	= 0x00000001,	/* Undocumented? */
-	TIC_FTE1	= 0x00000002,	/* Undocumented? */
+	TIC_FTE0	= 0x00000001,	/* Documented for R-Car Gen3 only */
+	TIC_FTE1	= 0x00000002,	/* Documented for R-Car Gen3 only */
 	TIC_TFUE	= 0x00000100,
 	TIC_TFWE	= 0x00000200,
 };
 
 /* TIS */
 enum TIS_BIT {
-	TIS_FTF0	= 0x00000001,	/* Undocumented? */
-	TIS_FTF1	= 0x00000002,	/* Undocumented? */
+	TIS_FTF0	= 0x00000001,	/* Documented for R-Car Gen3 only */
+	TIS_FTF1	= 0x00000002,	/* Documented for R-Car Gen3 only */
 	TIS_TFUF	= 0x00000100,
 	TIS_TFWF	= 0x00000200,
 };
 
 /* ISS */
 enum ISS_BIT {
-	ISS_FRS		= 0x00000001,	/* Undocumented? */
-	ISS_FTS		= 0x00000004,	/* Undocumented? */
+	ISS_FRS		= 0x00000001,	/* Documented for R-Car Gen3 only */
+	ISS_FTS		= 0x00000004,	/* Documented for R-Car Gen3 only */
 	ISS_ES		= 0x00000040,
 	ISS_MS		= 0x00000080,
 	ISS_TFUS	= 0x00000100,
@@ -578,13 +578,13 @@ enum GTI_BIT {
 
 /* GIC */
 enum GIC_BIT {
-	GIC_PTCE	= 0x00000001,	/* Undocumented? */
+	GIC_PTCE	= 0x00000001,	/* Documented for R-Car Gen3 only */
 	GIC_PTME	= 0x00000004,
 };
 
 /* GIS */
 enum GIS_BIT {
-	GIS_PTCF	= 0x00000001,	/* Undocumented? */
+	GIS_PTCF	= 0x00000001,	/* Documented for R-Car Gen3 only */
 	GIS_PTMF	= 0x00000004,
 };
 
@@ -595,10 +595,10 @@ enum ECMR_BIT {
 	ECMR_TE		= 0x00000020,
 	ECMR_RE		= 0x00000040,
 	ECMR_MPDE	= 0x00000200,
-	ECMR_TXF	= 0x00010000,	/* Undocumented? */
+	ECMR_TXF	= 0x00010000,	/* Documented for R-Car Gen3 only */
 	ECMR_RXF	= 0x00020000,
 	ECMR_PFR	= 0x00040000,
-	ECMR_ZPF	= 0x00080000,	/* Undocumented? */
+	ECMR_ZPF	= 0x00080000,	/* Documented for R-Car Gen3 only */
 	ECMR_RZPF	= 0x00100000,
 	ECMR_DPAD	= 0x00200000,
 	ECMR_RCSC	= 0x00800000,
@@ -617,7 +617,7 @@ enum ECSR_BIT {
 enum ECSIPR_BIT {
 	ECSIPR_ICDIP	= 0x00000001,
 	ECSIPR_MPDIP	= 0x00000002,
-	ECSIPR_LCHNGIP	= 0x00000004,	/* Undocumented? */
+	ECSIPR_LCHNGIP	= 0x00000004,
 };
 
 /* PIR */
-- 
2.25.1


