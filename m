Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E9DC83F27
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74863.1752487730286377307
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: f3e7k0FzSQCjUWzsRoDguQ==
X-CSE-MsgGUID: hog+BIzQSky0oldEpft6mQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 782B141D45A9;
	Mon, 14 Jul 2025 19:08:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 24/57] can: rcar_canfd: Add support for R-Car Gen4
Date: Mon, 14 Jul 2025 11:07:05 +0100
Message-ID: <20250714100802.80035-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19452

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8716e6e79a148f58852a393340326ad72fd62a00 upstream.

Despite the name, R-Car V3U (R8A779A0) was the first member of the R-Car
Gen4 family.  Generalize the support for R-Car V3U to other SoCs in the
R-Car Gen4 family by adding a family-specific compatible value, and by
replacing all references to "V3U" by "Gen4".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/61f6f34eb7bcc62ff604add98f1bcd2d2584187d.1674499048.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 99 ++++++++++++++++---------------
 1 file changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 2a76610bfa34..3b6863e6f6ae 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -82,8 +82,8 @@
 #define RCANFD_GERFL_DEF		BIT(0)
 
 #define RCANFD_GERFL_ERR(gpriv, x) \
-	((x) & (reg_v3u(gpriv, RCANFD_GERFL_EEF0_7, \
-			RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
+	((x) & (reg_gen4(gpriv, RCANFD_GERFL_EEF0_7, \
+			 RCANFD_GERFL_EEF(0) | RCANFD_GERFL_EEF(1)) | \
 		RCANFD_GERFL_MES | \
 		((gpriv)->fdmode ? RCANFD_GERFL_CMPOF : 0)))
 
@@ -91,16 +91,16 @@
 
 /* RSCFDnCFDGAFLCFG0 / RSCFDnGAFLCFG0 */
 #define RCANFD_GAFLCFG_SETRNC(gpriv, n, x) \
-	(((x) & reg_v3u(gpriv, 0x1ff, 0xff)) << \
-	 (reg_v3u(gpriv, 16, 24) - ((n) & 1) * reg_v3u(gpriv, 16, 8)))
+	(((x) & reg_gen4(gpriv, 0x1ff, 0xff)) << \
+	 (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8)))
 
 #define RCANFD_GAFLCFG_GETRNC(gpriv, n, x) \
-	(((x) >> (reg_v3u(gpriv, 16, 24) - ((n) & 1) * reg_v3u(gpriv, 16, 8))) & \
-	 reg_v3u(gpriv, 0x1ff, 0xff))
+	(((x) >> (reg_gen4(gpriv, 16, 24) - ((n) & 1) * reg_gen4(gpriv, 16, 8))) & \
+	 reg_gen4(gpriv, 0x1ff, 0xff))
 
 /* RSCFDnCFDGAFLECTR / RSCFDnGAFLECTR */
 #define RCANFD_GAFLECTR_AFLDAE		BIT(8)
-#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_v3u(gpriv, 0x7f, 0x1f))
+#define RCANFD_GAFLECTR_AFLPN(gpriv, x)	((x) & reg_gen4(gpriv, 0x7f, 0x1f))
 
 /* RSCFDnCFDGAFLIDj / RSCFDnGAFLIDj */
 #define RCANFD_GAFLID_GAFLLB		BIT(29)
@@ -118,13 +118,13 @@
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & reg_v3u(gpriv, 0x7f, 0x1f)) << reg_v3u(gpriv, 25, 24))
+	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 25, 24))
 
 #define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & reg_v3u(gpriv, 0xff, 0x7f)) << reg_v3u(gpriv, 17, 16))
+	(((x) & reg_gen4(gpriv, 0xff, 0x7f)) << reg_gen4(gpriv, 17, 16))
 
 #define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & reg_v3u(gpriv, 0x7f, 0x1f)) << reg_v3u(gpriv, 10, 11))
+	(((x) & reg_gen4(gpriv, 0x7f, 0x1f)) << reg_gen4(gpriv, 10, 11))
 
 #define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
 
@@ -189,16 +189,16 @@
 #define RCANFD_DCFG_DSJW(x)		(((x) & 0x7) << 24)
 
 #define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & reg_v3u(gpriv, 0x0f, 0x7)) << reg_v3u(gpriv, 16, 20))
+	(((x) & reg_gen4(gpriv, 0x0f, 0x7)) << reg_gen4(gpriv, 16, 20))
 
 #define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & reg_v3u(gpriv, 0x1f, 0xf)) << reg_v3u(gpriv, 8, 16))
+	(((x) & reg_gen4(gpriv, 0x1f, 0xf)) << reg_gen4(gpriv, 8, 16))
 
 #define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
 
 /* RSCFDnCFDCmFDCFG */
-#define RCANFD_V3U_FDCFG_CLOE		BIT(30)
-#define RCANFD_V3U_FDCFG_FDOE		BIT(28)
+#define RCANFD_GEN4_FDCFG_CLOE		BIT(30)
+#define RCANFD_GEN4_FDCFG_FDOE		BIT(28)
 #define RCANFD_FDCFG_TDCE		BIT(9)
 #define RCANFD_FDCFG_TDCOC		BIT(8)
 #define RCANFD_FDCFG_TDCO(x)		(((x) & 0x7f) >> 16)
@@ -233,10 +233,10 @@
 /* Common FIFO bits */
 
 /* RSCFDnCFDCFCCk */
-#define RCANFD_CFCC_CFTML(gpriv, x)	(((x) & 0xf) << reg_v3u(gpriv, 16, 20))
-#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_v3u(gpriv,  8, 16))
+#define RCANFD_CFCC_CFTML(gpriv, x)	(((x) & 0xf) << reg_gen4(gpriv, 16, 20))
+#define RCANFD_CFCC_CFM(gpriv, x)	(((x) & 0x3) << reg_gen4(gpriv,  8, 16))
 #define RCANFD_CFCC_CFIM		BIT(12)
-#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_v3u(gpriv, 21,  8))
+#define RCANFD_CFCC_CFDC(gpriv, x)	(((x) & 0x7) << reg_gen4(gpriv, 21,  8))
 #define RCANFD_CFCC_CFPLS(x)		(((x) & 0x7) << 4)
 #define RCANFD_CFCC_CFTXIE		BIT(2)
 #define RCANFD_CFCC_CFE			BIT(0)
@@ -304,7 +304,7 @@
 #define RCANFD_RMND(y)			(0x00a8 + (0x04 * (y)))
 
 /* RSCFDnCFDRFCCx / RSCFDnRFCCx */
-#define RCANFD_RFCC(gpriv, x)		(reg_v3u(gpriv, 0x00c0, 0x00b8) + (0x04 * (x)))
+#define RCANFD_RFCC(gpriv, x)		(reg_gen4(gpriv, 0x00c0, 0x00b8) + (0x04 * (x)))
 /* RSCFDnCFDRFSTSx / RSCFDnRFSTSx */
 #define RCANFD_RFSTS(gpriv, x)		(RCANFD_RFCC(gpriv, x) + 0x20)
 /* RSCFDnCFDRFPCTRx / RSCFDnRFPCTRx */
@@ -314,13 +314,13 @@
 
 /* RSCFDnCFDCFCCx / RSCFDnCFCCx */
 #define RCANFD_CFCC(gpriv, ch, idx) \
-	(reg_v3u(gpriv, 0x0120, 0x0118) + (0x0c * (ch)) + (0x04 * (idx)))
+	(reg_gen4(gpriv, 0x0120, 0x0118) + (0x0c * (ch)) + (0x04 * (idx)))
 /* RSCFDnCFDCFSTSx / RSCFDnCFSTSx */
 #define RCANFD_CFSTS(gpriv, ch, idx) \
-	(reg_v3u(gpriv, 0x01e0, 0x0178) + (0x0c * (ch)) + (0x04 * (idx)))
+	(reg_gen4(gpriv, 0x01e0, 0x0178) + (0x0c * (ch)) + (0x04 * (idx)))
 /* RSCFDnCFDCFPCTRx / RSCFDnCFPCTRx */
 #define RCANFD_CFPCTR(gpriv, ch, idx) \
-	(reg_v3u(gpriv, 0x0240, 0x01d8) + (0x0c * (ch)) + (0x04 * (idx)))
+	(reg_gen4(gpriv, 0x0240, 0x01d8) + (0x0c * (ch)) + (0x04 * (idx)))
 
 /* RSCFDnCFDFESTS / RSCFDnFESTS */
 #define RCANFD_FESTS			(0x0238)
@@ -428,15 +428,15 @@
 /* RSCFDnRPGACCr */
 #define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
 
-/* R-Car V3U Classical and CAN FD mode specific register map */
-#define RCANFD_V3U_FDCFG(m)		(0x1404 + (0x20 * (m)))
+/* R-Car Gen4 Classical and CAN FD mode specific register map */
+#define RCANFD_GEN4_FDCFG(m)		(0x1404 + (0x20 * (m)))
 
-#define RCANFD_V3U_GAFL_OFFSET		(0x1800)
+#define RCANFD_GEN4_GAFL_OFFSET		(0x1800)
 
 /* CAN FD mode specific register map */
 
 /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
-#define RCANFD_F_DCFG(gpriv, m)		(reg_v3u(gpriv, 0x1400, 0x0500) + (0x20 * (m)))
+#define RCANFD_F_DCFG(gpriv, m)		(reg_gen4(gpriv, 0x1400, 0x0500) + (0x20 * (m)))
 #define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
 #define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
 #define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
@@ -452,7 +452,7 @@
 #define RCANFD_F_RMDF(q, b)		(0x200c + (0x04 * (b)) + (0x20 * (q)))
 
 /* RSCFDnCFDRFXXx -> RCANFD_F_RFXX(x) */
-#define RCANFD_F_RFOFFSET(gpriv)	reg_v3u(gpriv, 0x6000, 0x3000)
+#define RCANFD_F_RFOFFSET(gpriv)	reg_gen4(gpriv, 0x6000, 0x3000)
 #define RCANFD_F_RFID(gpriv, x)		(RCANFD_F_RFOFFSET(gpriv) + (0x80 * (x)))
 #define RCANFD_F_RFPTR(gpriv, x)	(RCANFD_F_RFOFFSET(gpriv) + 0x04 + (0x80 * (x)))
 #define RCANFD_F_RFFDSTS(gpriv, x)	(RCANFD_F_RFOFFSET(gpriv) + 0x08 + (0x80 * (x)))
@@ -460,7 +460,7 @@
 	(RCANFD_F_RFOFFSET(gpriv) + 0x0c + (0x80 * (x)) + (0x04 * (df)))
 
 /* RSCFDnCFDCFXXk -> RCANFD_F_CFXX(ch, k) */
-#define RCANFD_F_CFOFFSET(gpriv)	reg_v3u(gpriv, 0x6400, 0x3400)
+#define RCANFD_F_CFOFFSET(gpriv)	reg_gen4(gpriv, 0x6400, 0x3400)
 
 #define RCANFD_F_CFID(gpriv, ch, idx) \
 	(RCANFD_F_CFOFFSET(gpriv) + (0x180 * (ch)) + (0x80 * (idx)))
@@ -596,28 +596,28 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.shared_global_irqs = 1,
 };
 
+static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
+	.max_channels = 8,
+	.postdiv = 2,
+	.shared_global_irqs = 1,
+};
+
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.max_channels = 2,
 	.postdiv = 1,
 	.multi_channel_irqs = 1,
 };
 
-static const struct rcar_canfd_hw_info r8a779a0_hw_info = {
-	.max_channels = 8,
-	.postdiv = 2,
-	.shared_global_irqs = 1,
-};
-
 /* Helper functions */
-static inline bool is_v3u(struct rcar_canfd_global *gpriv)
+static inline bool is_gen4(struct rcar_canfd_global *gpriv)
 {
-	return gpriv->info == &r8a779a0_hw_info;
+	return gpriv->info == &rcar_gen4_hw_info;
 }
 
-static inline u32 reg_v3u(struct rcar_canfd_global *gpriv,
-			  u32 v3u, u32 not_v3u)
+static inline u32 reg_gen4(struct rcar_canfd_global *gpriv,
+			   u32 gen4, u32 not_gen4)
 {
-	return is_v3u(gpriv) ? v3u : not_v3u;
+	return is_gen4(gpriv) ? gen4 : not_gen4;
 }
 
 static inline void rcar_canfd_update(u32 mask, u32 val, u32 __iomem *reg)
@@ -687,13 +687,13 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 
 static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 {
-	if (is_v3u(gpriv)) {
-		u32 ch, val = gpriv->fdmode ? RCANFD_V3U_FDCFG_FDOE
-					    : RCANFD_V3U_FDCFG_CLOE;
+	if (is_gen4(gpriv)) {
+		u32 ch, val = gpriv->fdmode ? RCANFD_GEN4_FDCFG_FDOE
+					    : RCANFD_GEN4_FDCFG_CLOE;
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_V3U_FDCFG(ch),
+			rcar_canfd_set_bit(gpriv->base, RCANFD_GEN4_FDCFG(ch),
 					   val);
 	} else {
 		if (gpriv->fdmode)
@@ -806,8 +806,8 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 	/* Write number of rules for channel */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLCFG(ch),
 			   RCANFD_GAFLCFG_SETRNC(gpriv, ch, num_rules));
-	if (is_v3u(gpriv))
-		offset = RCANFD_V3U_GAFL_OFFSET;
+	if (is_gen4(gpriv))
+		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
 		offset = RCANFD_F_GAFL_OFFSET;
 	else
@@ -1342,7 +1342,7 @@ static void rcar_canfd_set_bittiming(struct net_device *dev)
 			   brp, sjw, tseg1, tseg2);
 	} else {
 		/* Classical CAN only mode */
-		if (is_v3u(gpriv)) {
+		if (is_gen4(gpriv)) {
 			cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) |
 			       RCANFD_NCFG_NBRP(brp) |
 			       RCANFD_NCFG_NSJW(gpriv, sjw) |
@@ -1499,7 +1499,7 @@ static netdev_tx_t rcar_canfd_start_xmit(struct sk_buff *skb,
 
 	dlc = RCANFD_CFPTR_CFDLC(can_fd_len2dlc(cf->len));
 
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || is_v3u(gpriv)) {
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || is_gen4(gpriv)) {
 		rcar_canfd_write(priv->base,
 				 RCANFD_F_CFID(gpriv, ch, RCANFD_CFFIFO_IDX), id);
 		rcar_canfd_write(priv->base,
@@ -1558,7 +1558,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 	u32 ch = priv->channel;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || is_v3u(gpriv)) {
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || is_gen4(gpriv)) {
 		id = rcar_canfd_read(priv->base, RCANFD_F_RFID(gpriv, ridx));
 		dlc = rcar_canfd_read(priv->base, RCANFD_F_RFPTR(gpriv, ridx));
 
@@ -1609,7 +1609,7 @@ static void rcar_canfd_rx_pkt(struct rcar_canfd_channel *priv)
 		cf->len = can_cc_dlc2len(RCANFD_RFPTR_RFDLC(dlc));
 		if (id & RCANFD_RFID_RFRTR)
 			cf->can_id |= CAN_RTR_FLAG;
-		else if (is_v3u(gpriv))
+		else if (is_gen4(gpriv))
 			rcar_canfd_get_data(priv, cf, RCANFD_F_RFDF(gpriv, ridx, 0));
 		else
 			rcar_canfd_get_data(priv, cf, RCANFD_C_RFDF(ridx, 0));
@@ -2090,9 +2090,10 @@ static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 			 rcar_canfd_resume);
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
+	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
+	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
-	{ .compatible = "renesas,r8a779a0-canfd", .data = &r8a779a0_hw_info },
 	{ }
 };
 
-- 
2.43.0


