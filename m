Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50109E674A4
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78275.1766402233234820375
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UwzW0QIi;
 spf=pass (domain: gmail.com, ip: 209.85.208.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so3183327a12.0
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402231; x=1767007031; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNn8FzentyE3/sqOVmootMTp2N4dqaj/OxJhtmmytIY=;
        b=UwzW0QIii1U0pIqXx12kKvC7KLmdsRCFgQWjFeTSsqm+rXg3MCRm8Ekd7/tiQc/7i7
         hSwtH3IOSaqnpt/2xQ0kpALupRW9Y0a7uqlNhtwykU7CP/oWpv6J09o8XOz/6tJkLae0
         igyLKBd5NH9iGhMQMqkbGM/5V8xiG+xmT48hniLfsGT6OK8x+n3f8/oqan9rXAHxPtwx
         vdXuh8PEGH7zJ89BqPYJhqjjvyyugeO1CESvM6W/hkcR43rJXfAopW85jZZqdXKyIRS9
         rukn+Hu99yz7XW6to9RjAiEBZ/H7vWRYuCKLGsW2u+Q1lJmxolfZvbI6gesSUKuyQEQB
         LM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402231; x=1767007031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNn8FzentyE3/sqOVmootMTp2N4dqaj/OxJhtmmytIY=;
        b=idIGmhiz9KalT3vqIX8oaXQ8AgOuq1k7/XSok4c3RKQXj9mywkjuFfedK+zVmcE7bE
         TAeW9Rli2Ls+Ofcd27Uq9gT8qTZTkXj3hAvHpYACNiXicU8ULuSqrbOduRYXiT57ejFp
         3m8bGUMj635aiNFOkZKmndqSiYULkyxXkJNwLfplA1p9PjLAgzT9xBb6QTx1lP44uINQ
         z9mkPSdDhoFBhOlFnwDT9rMeyTB+RMZeM23bKO2ZgCumFDr6/pLung2vCS+9RnsbJYB3
         ABotrczTMl6VC1Jq2Ms9k1SnNoV4AK8SB3dH1r/N4rOrl7q22+sxggrp40tXxKNvfB3+
         BShw==
X-Gm-Message-State: AOJu0Ywe7Z2XifPrxxyta2CXjOercb0e1hzw6kzR4M6eWTBdJJYqL+E1
	vjluDbGZKLVTULKqI6vIM07NFjWbuPKTM9whpqDBtcbKTEsAkiaFWSXk2uJlng==
X-Gm-Gg: AY/fxX7FEX7AY6D87j2tHwTjfVNzaaYuQDBrod8FU3Bk1/tlDFgkPQgde+/KQIYL6M3
	J+ZflLv+Nt5NtC6D+0gXXW5GhancYKey1K33e+4+yp3peiVXtIMNyAIOza2L/C+iBs2EsnRjBVk
	vF7Toijr3ST1kmz2KYW219Lq0+VsLoqKt69QOAQX8EhCX9DemGdk/suuD6sUXA2GwOV6RwAfRMt
	TgBn1GElnNLV8u4UEiuGjm83QlTqRrdSwxqt66/qglzPWiA73Q0Rk4ruKuUx6S0FhUuVyC8EwLf
	U95f/v8Z3Sih7oL/Sm0LPRMojMJlZ96cVkfPO8zgw/SfMa/FYiFTU2nyHW+L95bdZChli1PhrII
	EW4cA4ryXxF/q9Nq1oMsb7YXdcNJ3NmzMNsEmuq0o28S9Ou7f40QaFJK2hvFFd/9xo27ZSBxpSs
	HiBVDdJv2BoKc1GhjK7yhF2kZ8RyWmOboep7c=
X-Google-Smtp-Source: AGHT+IHN7v6IAAvXU4jd+3RSMStHBqBKtXHRj4UWd/Dyrdf4Ub/dlvP/TOMvN9m1wJE1pXRzvNfQ0A==
X-Received: by 2002:a17:907:7743:b0:b7d:1372:fb1d with SMTP id a640c23a62f3a-b802043fa1bmr1065294466b.9.1766402231194;
        Mon, 22 Dec 2025 03:17:11 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:10 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/24] can: rcar_canfd: Add support for Transceiver Delay Compensation
Date: Mon, 22 Dec 2025 11:16:42 +0000
Message-ID: <20251222111705.27028-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21196

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 586d5eecdf1479b9ab861ab16438ba236fb2f383 ]

The Renesas CAN-FD hardware block supports configuring Transceiver Delay
Compensation, and reading back the Transceiver Delay Compensation
Result, which is needed to support high transfer rates like 8 Mbps.
The Secondary Sample Point is either the measured delay plus the
configured offset, or just the configured offset.

Fix the existing RCANFD_FDCFG_TDCO() macro for the intended use case
(writing instead of reading the field).  Add register definition bits
for the Channel n CAN-FD Status Register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/69db727d5f728d679ba691d20854e7d963d0f323.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[Biju: Dropped using newly introduced struct data_bittiming_params
as it requires more changes on 6.1.cip]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 85 +++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e76e5d76f836..ec6790d11fec 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -191,9 +191,19 @@
 /* RSCFDnCFDCmFDCFG */
 #define RCANFD_GEN4_FDCFG_CLOE		BIT(30)
 #define RCANFD_GEN4_FDCFG_FDOE		BIT(28)
+#define RCANFD_FDCFG_TDCO		GENMASK(23, 16)
 #define RCANFD_FDCFG_TDCE		BIT(9)
 #define RCANFD_FDCFG_TDCOC		BIT(8)
-#define RCANFD_FDCFG_TDCO(x)		(((x) & 0x7f) >> 16)
+
+/* RSCFDnCFDCmFDSTS */
+#define RCANFD_FDSTS_SOC		GENMASK(31, 24)
+#define RCANFD_FDSTS_EOC		GENMASK(23, 16)
+#define RCANFD_GEN4_FDSTS_TDCVF		BIT(15)
+#define RCANFD_GEN4_FDSTS_PNSTS		GENMASK(13, 12)
+#define RCANFD_FDSTS_SOCO		BIT(9)
+#define RCANFD_FDSTS_EOCO		BIT(8)
+#define RCANFD_FDSTS_TDCVF		BIT(7)
+#define RCANFD_FDSTS_TDCR		GENMASK(7, 0)
 
 /* RSCFDnCFDRFCCx */
 #define RCANFD_RFCC_RFIM		BIT(12)
@@ -520,6 +530,7 @@ struct rcar_canfd_shift_data {
 struct rcar_canfd_hw_info {
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
+	const struct can_tdc_const *tdc_const;
 	const struct rcar_canfd_regs *regs;
 	const struct rcar_canfd_shift_data *sh;
 	u8 rnc_field_width;
@@ -627,6 +638,25 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* CAN FD Transmission Delay Compensation constants */
+static const struct can_tdc_const rcar_canfd_gen3_tdc_const = {
+	.tdcv_min = 1,
+	.tdcv_max = 128,
+	.tdco_min = 1,
+	.tdco_max = 128,
+	.tdcf_min = 0,	/* Filter window not supported */
+	.tdcf_max = 0,
+};
+
+static const struct can_tdc_const rcar_canfd_gen4_tdc_const = {
+	.tdcv_min = 1,
+	.tdcv_max = 256,
+	.tdco_min = 1,
+	.tdco_max = 256,
+	.tdcf_min = 0,	/* Filter window not supported */
+	.tdcf_max = 0,
+};
+
 static const struct rcar_canfd_regs rcar_gen3_regs = {
 	.rfcc = 0x00b8,
 	.cfcc = 0x0118,
@@ -672,6 +702,7 @@ static const struct rcar_canfd_shift_data rcar_gen4_shift_data = {
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen3_tdc_const,
 	.regs = &rcar_gen3_regs,
 	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
@@ -688,6 +719,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
 	.regs = &rcar_gen4_regs,
 	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
@@ -704,6 +736,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen3_tdc_const,
 	.regs = &rcar_gen3_regs,
 	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
@@ -720,6 +753,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
 	.regs = &rcar_gen4_regs,
 	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
@@ -1461,12 +1495,15 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
+	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
 	struct rcar_canfd_channel *priv = netdev_priv(ndev);
 	struct rcar_canfd_global *gpriv = priv->gpriv;
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
+	const struct can_tdc_const *tdc_const = priv->can.tdc_const;
+	const struct can_tdc *tdc = &priv->can.tdc;
+	u32 cfg, tdcmode = 0, tdco = 0;
 	u16 brp, sjw, tseg1, tseg2;
-	u32 cfg;
 	u32 ch = priv->channel;
 
 	/* Nominal bit timing settings */
@@ -1498,6 +1535,20 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
+
+	/* Transceiver Delay Compensation */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
+		/* TDC enabled, measured + offset */
+		tdcmode = RCANFD_FDCFG_TDCE;
+		tdco = tdc->tdco - 1;
+	} else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		/* TDC enabled, offset only */
+		tdcmode = RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
+		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
+	}
+
+	rcar_canfd_update_bit(gpriv->base, rcar_canfd_f_cfdcfg(gpriv, ch), mask,
+			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1808,6 +1859,29 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 	return num_pkts;
 }
 
+static unsigned int rcar_canfd_get_tdcr(struct rcar_canfd_global *gpriv,
+					unsigned int ch)
+{
+	u32 sts = rcar_canfd_read(gpriv->base, rcar_canfd_f_cfdsts(gpriv, ch));
+	u32 tdcr = FIELD_GET(RCANFD_FDSTS_TDCR, sts);
+
+	return tdcr & (gpriv->info->tdc_const->tdcv_max - 1);
+}
+
+static int rcar_canfd_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
+{
+	struct rcar_canfd_channel *priv = netdev_priv(ndev);
+	u32 tdco = priv->can.tdc.tdco;
+	u32 tdcr;
+
+	/* Transceiver Delay Compensation Result */
+	tdcr = rcar_canfd_get_tdcr(priv->gpriv, priv->channel) + 1;
+
+	*tdcv = tdcr < tdco ? 0 : tdcr - tdco;
+
+	return 0;
+}
+
 static int rcar_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
 {
 	int err;
@@ -1930,12 +2004,17 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	if (gpriv->fdmode) {
 		priv->can.bittiming_const = gpriv->info->nom_bittiming;
 		priv->can.data_bittiming_const = gpriv->info->data_bittiming;
+		priv->can.tdc_const = gpriv->info->tdc_const;
 
 		/* Controller starts in CAN FD only mode */
 		err = can_set_static_ctrlmode(ndev, CAN_CTRLMODE_FD);
 		if (err)
 			goto fail;
-		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
+
+		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING |
+					       CAN_CTRLMODE_TDC_AUTO |
+					       CAN_CTRLMODE_TDC_MANUAL;
+		priv->can.do_get_auto_tdcv = rcar_canfd_get_auto_tdcv;
 	} else {
 		/* Controller starts in Classical CAN only mode */
 		priv->can.bittiming_const = &rcar_canfd_bittiming_const;
-- 
2.43.0


