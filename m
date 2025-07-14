Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE7FC83F27
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74804.1752487788716529360
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: RSrmpVPaRiePDCLDq3Dwkw==
X-CSE-MsgGUID: 0BdHMFpKSAG1ktYr5LjSug==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:48 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9E64041D4E22;
	Mon, 14 Jul 2025 19:09:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 49/57] can: rcar_canfd: Add struct rcanfd_regs variable to struct rcar_canfd_hw_info
Date: Mon, 14 Jul 2025 11:07:30 +0100
Message-ID: <20250714100802.80035-50-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19477

commit 5026d2acaefab81857390c00c771ee6a2fa65461 upstream.

R-Car Gen3 and Gen4 have some differences in the register offsets. Add
struct rcanfd_regs variable regs to the struct rcar_canfd_hw_info to
handle these differences.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-16-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 48 ++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 12bd393597b2..ffbf96c532ee 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -301,7 +301,7 @@
 #define RCANFD_RMND(y)			(0x00a8 + (0x04 * (y)))
 
 /* RSCFDnCFDRFCCx / RSCFDnRFCCx */
-#define RCANFD_RFCC(gpriv, x)		(reg_gen4(gpriv, 0x00c0, 0x00b8) + (0x04 * (x)))
+#define RCANFD_RFCC(gpriv, x)		((gpriv)->info->regs->rfcc + (0x04 * (x)))
 /* RSCFDnCFDRFSTSx / RSCFDnRFSTSx */
 #define RCANFD_RFSTS(gpriv, x)		(RCANFD_RFCC(gpriv, x) + 0x20)
 /* RSCFDnCFDRFPCTRx / RSCFDnRFPCTRx */
@@ -311,13 +311,13 @@
 
 /* RSCFDnCFDCFCCx / RSCFDnCFCCx */
 #define RCANFD_CFCC(gpriv, ch, idx) \
-	(reg_gen4(gpriv, 0x0120, 0x0118) + (0x0c * (ch)) + (0x04 * (idx)))
+	((gpriv)->info->regs->cfcc + (0x0c * (ch)) + (0x04 * (idx)))
 /* RSCFDnCFDCFSTSx / RSCFDnCFSTSx */
 #define RCANFD_CFSTS(gpriv, ch, idx) \
-	(reg_gen4(gpriv, 0x01e0, 0x0178) + (0x0c * (ch)) + (0x04 * (idx)))
+	((gpriv)->info->regs->cfsts + (0x0c * (ch)) + (0x04 * (idx)))
 /* RSCFDnCFDCFPCTRx / RSCFDnCFPCTRx */
 #define RCANFD_CFPCTR(gpriv, ch, idx) \
-	(reg_gen4(gpriv, 0x0240, 0x01d8) + (0x0c * (ch)) + (0x04 * (idx)))
+	((gpriv)->info->regs->cfpctr + (0x0c * (ch)) + (0x04 * (idx)))
 
 /* RSCFDnCFDFESTS / RSCFDnFESTS */
 #define RCANFD_FESTS			(0x0238)
@@ -433,7 +433,7 @@
 /* CAN FD mode specific register map */
 
 /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
-#define RCANFD_F_DCFG(gpriv, m)		(reg_gen4(gpriv, 0x1400, 0x0500) + (0x20 * (m)))
+#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs->f_dcfg + (0x20 * (m)))
 #define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
 #define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
 #define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
@@ -449,7 +449,7 @@
 #define RCANFD_F_RMDF(q, b)		(0x200c + (0x04 * (b)) + (0x20 * (q)))
 
 /* RSCFDnCFDRFXXx -> RCANFD_F_RFXX(x) */
-#define RCANFD_F_RFOFFSET(gpriv)	reg_gen4(gpriv, 0x6000, 0x3000)
+#define RCANFD_F_RFOFFSET(gpriv)	((gpriv)->info->regs->rfoffset)
 #define RCANFD_F_RFID(gpriv, x)		(RCANFD_F_RFOFFSET(gpriv) + (0x80 * (x)))
 #define RCANFD_F_RFPTR(gpriv, x)	(RCANFD_F_RFOFFSET(gpriv) + 0x04 + (0x80 * (x)))
 #define RCANFD_F_RFFDSTS(gpriv, x)	(RCANFD_F_RFOFFSET(gpriv) + 0x08 + (0x80 * (x)))
@@ -457,7 +457,7 @@
 	(RCANFD_F_RFOFFSET(gpriv) + 0x0c + (0x80 * (x)) + (0x04 * (df)))
 
 /* RSCFDnCFDCFXXk -> RCANFD_F_CFXX(ch, k) */
-#define RCANFD_F_CFOFFSET(gpriv)	reg_gen4(gpriv, 0x6400, 0x3400)
+#define RCANFD_F_CFOFFSET(gpriv)	((gpriv)->info->regs->cfoffset)
 
 #define RCANFD_F_CFID(gpriv, ch, idx) \
 	(RCANFD_F_CFOFFSET(gpriv) + (0x180 * (ch)) + (0x80 * (idx)))
@@ -506,9 +506,20 @@
 
 struct rcar_canfd_global;
 
+struct rcar_canfd_regs {
+	u16 rfcc;	/* RX FIFO Configuration/Control Register */
+	u16 cfcc;	/* Common FIFO Configuration/Control Register */
+	u16 cfsts;	/* Common FIFO Status Register */
+	u16 cfpctr;	/* Common FIFO Pointer Control Register */
+	u16 f_dcfg;	/* Global FD Configuration Register */
+	u16 rfoffset;	/* Receive FIFO buffer access ID register */
+	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
+};
+
 struct rcar_canfd_hw_info {
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
+	const struct rcar_canfd_regs *regs;
 	u8 rnc_field_width;
 	u8 max_aflpn;
 	u8 max_cftml;
@@ -613,9 +624,30 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 	.brp_inc = 1,
 };
 
+static const struct rcar_canfd_regs rcar_gen3_regs = {
+	.rfcc = 0x00b8,
+	.cfcc = 0x0118,
+	.cfsts = 0x0178,
+	.cfpctr = 0x01d8,
+	.f_dcfg = 0x0500,
+	.rfoffset = 0x3000,
+	.cfoffset = 0x3400,
+};
+
+static const struct rcar_canfd_regs rcar_gen4_regs = {
+	.rfcc = 0x00c0,
+	.cfcc = 0x0120,
+	.cfsts = 0x01e0,
+	.cfpctr = 0x0240,
+	.f_dcfg = 0x1400,
+	.rfoffset = 0x6000,
+	.cfoffset = 0x6400,
+};
+
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.regs = &rcar_gen3_regs,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
@@ -629,6 +661,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.regs = &rcar_gen4_regs,
 	.rnc_field_width = 16,
 	.max_aflpn = 127,
 	.max_cftml = 31,
@@ -642,6 +675,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.regs = &rcar_gen3_regs,
 	.rnc_field_width = 8,
 	.max_aflpn = 31,
 	.max_cftml = 15,
-- 
2.43.0


