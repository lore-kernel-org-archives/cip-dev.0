Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C6FC83F21
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:10:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.74801.1752487784571804237
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: jIqlrpG8RievFxCsJPfpqQ==
X-CSE-MsgGUID: z+HF64JGQHeIakji+UzSLw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AD93641D4BDF;
	Mon, 14 Jul 2025 19:09:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 50/57] can: rcar_canfd: Add sh variable to struct rcar_canfd_hw_info
Date: Mon, 14 Jul 2025 11:07:31 +0100
Message-ID: <20250714100802.80035-51-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:10:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19478

commit c5670c23d67dd81e71262bb7c5942502cd9df62e upstream.

R-Car Gen3 and Gen4 have some differences in the shift bits. Introduce a
struct rcar_canfd_shift_data to hold these values and add the struct
rcar_canfd_shift_data variable sh to struct rcar_canfd_hw_info to handle
these differences. After this, drop the unused functions reg_gen4() and
is_gen4().

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-17-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 64 ++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ffbf96c532ee..f6215f4036c1 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -111,13 +111,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 25, 24))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->ntseg2)
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 17, 16))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->ntseg1)
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << reg_gen4(gpriv, 10, 11))
+	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << (gpriv)->info->sh->nsjw)
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -182,10 +182,10 @@
 #define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 16, 20))
+	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->dtseg2)
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 8, 16))
+	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->dtseg1)
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -229,11 +229,11 @@
 #define RCANFD_CFCC_CFTML(gpriv, cftml) \
 ({\
 	typeof(gpriv) (_gpriv) = (gpriv); \
-	(((cftml) & (_gpriv)->info->max_cftml) << reg_gen4(_gpriv, 16, 20)); \
+	(((cftml) & (_gpriv)->info->max_cftml) << (_gpriv)->info->sh->cftml); \
 })
-#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
+#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << (gpriv)->info->sh->cfm)
 #define RCANFD_CFCC_CFIM		BIT(12)
-#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
+#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << (gpriv)->info->sh->cfdc)
 #define RCANFD_CFCC_CFPLS(x)		(((x) & 0x7) << 4)
 #define RCANFD_CFCC_CFTXIE		BIT(2)
 #define RCANFD_CFCC_CFE			BIT(0)
@@ -516,10 +516,22 @@ struct rcar_canfd_regs {
 	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
 };
 
+struct rcar_canfd_shift_data {
+	u8 ntseg2;	/* Nominal Bit Rate Time Segment 2 Control */
+	u8 ntseg1;	/* Nominal Bit Rate Time Segment 1 Control */
+	u8 nsjw;	/* Nominal Bit Rate Resynchronization Jump Width Control */
+	u8 dtseg2;	/* Data Bit Rate Time Segment 2 Control */
+	u8 dtseg1;	/* Data Bit Rate Time Segment 1 Control */
+	u8 cftml;	/* Common FIFO TX Message Buffer Link */
+	u8 cfm;		/* Common FIFO Mode */
+	u8 cfdc;	/* Common FIFO Depth Configuration */
+};
+
 struct rcar_canfd_hw_info {
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
 	const struct rcar_canfd_regs *regs;
+	const struct rcar_canfd_shift_data *sh;
 	u8 rnc_field_width;
 	u8 max_aflpn;
 	u8 max_cftml;
@@ -644,10 +656,33 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
 	.cfoffset = 0x6400,
 };
 
+static const struct rcar_canfd_shift_data rcar_gen3_shift_data = {
+	.ntseg2 = 24,
+	.ntseg1 = 16,
+	.nsjw = 11,
+	.dtseg2 = 20,
+	.dtseg1 = 16,
+	.cftml = 20,
+	.cfm = 16,
+	.cfdc = 8,
+};
+
+static const struct rcar_canfd_shift_data rcar_gen4_shift_data = {
+	.ntseg2 = 25,
+	.ntseg1 = 17,
+	.nsjw = 10,
+	.dtseg2 = 16,
+	.dtseg1 = 8,
+	.cftml = 16,
+	.cfm = 8,
+	.cfdc = 21,
+};
+
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.regs = &rcar_gen3_regs,
+	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -662,6 +697,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
 	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
 	.max_cftml = 31,
@@ -676,6 +712,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.regs = &rcar_gen3_regs,
+	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -687,17 +724,6 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 };
 
 /* Helper functions */
-static inline bool is_gen4(struct rcar_canfd_global *gpriv)
-{
-	return gpriv->info == &rcar_gen4_hw_info;
-}
-
-static inline u32 reg_gen4(struct rcar_canfd_global *gpriv,
-			   u32 gen4, u32 not_gen4)
-{
-	return is_gen4(gpriv) ? gen4 : not_gen4;
-}
-
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
 {
 	u32 data = readl(reg);
-- 
2.43.0


