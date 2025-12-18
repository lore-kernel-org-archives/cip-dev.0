Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F40D6E2BD
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1406.1766076967418578317
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HH6KLquA;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbc305552so682165f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076966; x=1766681766; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaRNSn3Y1dU40KRXTwHOW6aTrV8ojIMjX/Xw+e3gQ0U=;
        b=HH6KLquA/+YFWxPnZRJf74EteyUKLGYsHclpl6T+neQsTR6jUsGPAppZJqJxHbrl7s
         oO3lRgYxX9tNtrULBfPsebmRllPupI1uiuIpj1m2cIohkl8iCLhB6B9gL5biHU8H7y6T
         HtvwYM/tRIFD0B0M2pIXHVqOAJOXI5/BlBIV0xD2HFKpksGNwqAcLuLFHqjtPTlP2KIV
         BONLtwE/02VGvfqOtDONjcg4Ts5oQkQC1lXlh+zfSy3T25RGmBMVq4F4PBVZKfrxQcGc
         XNv2hYH87U/UTYZ55Uu/fpXk5boZ3Q21uuAtYZQ7Rf4uHo2h6rymKotMchZuqYs4d7++
         rT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076966; x=1766681766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xaRNSn3Y1dU40KRXTwHOW6aTrV8ojIMjX/Xw+e3gQ0U=;
        b=d0Ig1nPUKUoO8FKLdILY2pLzUAo485wNsTSTFuRM3rMFZTWmpAl5lg8q+r/RXesHl1
         yqnTH6kPU+nVcvTWa7KAyYoF9EF6oHI0Whqb81BZmZVpn0owF4WNMEnt9NIDQICwaZo1
         oa6oiaksXsolhj65WGJRah3/ytNN6TACGuNYjP/L+3rZpvXCU09mAdLVRYHlw1FGo14O
         uoWiM8JcfddufHcrcZYnq1BuVnGTxt9Wy1scMdnetzak9Y3T5hKxySOdS562BPWseE/z
         W6qgQ/8m+r9epJyJsFAtTrEGOdAivH2NHyxgXw7K72wNRPBJyU2t4f2/wiEM3wGg4EUW
         5dAA==
X-Gm-Message-State: AOJu0YxPtOPfPqm7JDJ6F30JCoY0jj+/r9usZp/MU9meeYGLR/TPWKwU
	Kn8wEN4ElDHCQxL4Pk/11ruqocN/thIWLKUDhAVeKT6GjwJAfPUYkz+UNiOS8g==
X-Gm-Gg: AY/fxX7DBbWL9R5nQ91IzwcPPya7DmcasabgbzMK1YvsSNO5Icwy8CK7T6ToAjgHIvM
	fgLbdhQ51buQuqatXtlSnQPWIWREpgd4nYtH6X6kx3xHxjx7D1H4zhWSpAww5Q9NW/FVNRKdJRi
	6Z/AFiGKN46++y65gIse6px2pEq3fWB8RyDsDr7v9GkHLDecDm4OqaAEI+QTaZ+vKqEMwmFg7sm
	+U/9bstNyhSqwn5rpk7dWO486rquPHLHnYT/kLnPQxL5lR25uZUFv3rYh3mj+gqrZlzN6vcZb+C
	+qOd8huiWXrIArO8f+FUp7wCeE4KWXCJddx7UCQMV6br1axhx598PtUNy7jpger29qBugvt9vjE
	9XF3wHaNMP4N1R1rfs3ih9eGM5Qu30HYpVweLbs423X1rW6IReWhOkhvoYse1+9PbCuTwsUMCEI
	do3SRouI4lAzluizbWFg==
X-Google-Smtp-Source: AGHT+IEoUEyrIRKzdJj0drijJqiWSaL/XXmdh581DcCCWwU/Ah12lxeK8o8WUrZgp9wJ/W7bY7L3Ug==
X-Received: by 2002:a05:6000:24c8:b0:431:a43:ee88 with SMTP id ffacd0b85a97d-4324e50d4f5mr183632f8f.42.1766076965449;
        Thu, 18 Dec 2025 08:56:05 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:05 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 10/24] can: rcar_canfd: Add support for Transceiver Delay Compensation
Date: Thu, 18 Dec 2025 16:55:09 +0000
Message-ID: <20251218165600.258194-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21148

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
[Biju: Dropped using struct data_bittiming_params as it requires more
changes on 6.1.cip]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 85 +++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 58d3a1ee551e..3e32e461f0fc 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -192,9 +192,19 @@
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
@@ -521,6 +531,7 @@ struct rcar_canfd_shift_data {
 struct rcar_canfd_hw_info {
 	const struct can_bittiming_const *nom_bittiming;
 	const struct can_bittiming_const *data_bittiming;
+	const struct can_tdc_const *tdc_const;
 	const struct rcar_canfd_regs *regs;
 	const struct rcar_canfd_shift_data *sh;
 	u8 rnc_field_width;
@@ -628,6 +639,25 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
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
@@ -673,6 +703,7 @@ static const struct rcar_canfd_shift_data rcar_gen4_shift_data = {
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen3_tdc_const,
 	.regs = &rcar_gen3_regs,
 	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
@@ -689,6 +720,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
 	.regs = &rcar_gen4_regs,
 	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
@@ -705,6 +737,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen3_tdc_const,
 	.regs = &rcar_gen3_regs,
 	.sh = &rcar_gen3_shift_data,
 	.rnc_field_width = 8,
@@ -721,6 +754,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
 	.regs = &rcar_gen4_regs,
 	.sh = &rcar_gen4_shift_data,
 	.rnc_field_width = 16,
@@ -1462,12 +1496,15 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 
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
@@ -1499,6 +1536,20 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
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
@@ -1809,6 +1860,29 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
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
@@ -1931,12 +2005,17 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
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


