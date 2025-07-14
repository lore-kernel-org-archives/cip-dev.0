Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D80C83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.74880.1752487774498628932
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: cF4YVIsgSFyUHuPYZXZpTw==
X-CSE-MsgGUID: 3M1oZwozSVmenmpoF6Wdog==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:41 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 74E0341D4BDF;
	Mon, 14 Jul 2025 19:09:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 46/57] can: rcar_canfd: Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info
Date: Mon, 14 Jul 2025 11:07:27 +0100
Message-ID: <20250714100802.80035-47-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19474

commit b5a9f2ec427cbdfe915c377fdd61812636b2cdc2 upstream.

Both R-Car Gen4 and R-Car Gen3 have different bit timing parameters
Add {nom,data}_bittiming variables to struct rcar_canfd_hw_info to
handle this difference.

Since the mask used in the macros are max value - 1, replace that
as well.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-13-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 53 ++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 82ae42213a19..1e8f1c971835 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -111,13 +111,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 25, 24))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 25, 24))
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0xff, 0x7f)) << reg_gen4(gpriv, 17, 16))
+	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 17, 16))
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 10, 11))
+	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << reg_gen4(gpriv, 10, 11))
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -179,13 +179,13 @@
 #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
 
 /* RSCFDnCFDCmDCFG */
-#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & reg_gen4(gpriv, 0xf, 0x7)) << 24)
+#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x0f, 0x7)) << reg_gen4(gpriv, 16, 20))
+	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << reg_gen4(gpriv, 16, 20))
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 8, 16))
+	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << reg_gen4(gpriv, 8, 16))
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
@@ -507,6 +507,8 @@
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
+	const struct can_bittiming_const *nom_bittiming;
+	const struct can_bittiming_const *data_bittiming;
 	u8 rnc_field_width;
 	u8 max_aflpn;
 	u8 max_cftml;
@@ -547,7 +549,7 @@ struct rcar_canfd_global {
 };
 
 /* CAN FD mode nominal rate constants */
-static const struct can_bittiming_const rcar_canfd_nom_bittiming_const = {
+static const struct can_bittiming_const rcar_canfd_gen3_nom_bittiming_const = {
 	.name = RCANFD_DRV_NAME,
 	.tseg1_min = 2,
 	.tseg1_max = 128,
@@ -559,8 +561,20 @@ static const struct can_bittiming_const rcar_canfd_nom_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const rcar_canfd_gen4_nom_bittiming_const = {
+	.name = RCANFD_DRV_NAME,
+	.tseg1_min = 2,
+	.tseg1_max = 256,
+	.tseg2_min = 2,
+	.tseg2_max = 128,
+	.sjw_max = 128,
+	.brp_min = 1,
+	.brp_max = 1024,
+	.brp_inc = 1,
+};
+
 /* CAN FD mode data rate constants */
-static const struct can_bittiming_const rcar_canfd_data_bittiming_const = {
+static const struct can_bittiming_const rcar_canfd_gen3_data_bittiming_const = {
 	.name = RCANFD_DRV_NAME,
 	.tseg1_min = 2,
 	.tseg1_max = 16,
@@ -572,6 +586,18 @@ static const struct can_bittiming_const rcar_canfd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static const struct can_bittiming_const rcar_canfd_gen4_data_bittiming_const = {
+	.name = RCANFD_DRV_NAME,
+	.tseg1_min = 2,
+	.tseg1_max = 32,
+	.tseg2_min = 2,
+	.tseg2_max = 16,
+	.sjw_max = 16,
+	.brp_min = 1,
+	.brp_max = 256,
+	.brp_inc = 1,
+};
+
 /* Classical CAN mode bitrate constants */
 static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 	.name = RCANFD_DRV_NAME,
@@ -586,6 +612,8 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -595,6 +623,8 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
 	.max_cftml = 31,
@@ -604,6 +634,8 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -1800,9 +1832,8 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	}
 
 	if (gpriv->fdmode) {
-		priv->can.bittiming_const = &rcar_canfd_nom_bittiming_const;
-		priv->can.data_bittiming_const =
-			&rcar_canfd_data_bittiming_const;
+		priv->can.bittiming_const = gpriv->info->nom_bittiming;
+		priv->can.data_bittiming_const = gpriv->info->data_bittiming;
 
 		/* Controller starts in CAN FD only mode */
 		err = can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
-- 
2.43.0


