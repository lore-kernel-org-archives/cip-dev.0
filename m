Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5B7C47BFB
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88215.1767699906292023886
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RCom8hkF;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so9199615e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699904; x=1768304704; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6sgfqjJd4XVtAQCCx/rIfnaC3LOmBamunXkDmSqj3I=;
        b=RCom8hkFsTpCYWs3j/XFObD3KELcroubm5TrBE1wFLknT/Z1RQpcqcft67Te89D+4/
         fTGhnQSTDhCiLDN2/HksYXex4YJkciqD0JZhkiYof5F3pVyz3tA4Tt6Xtrxmtq400XQU
         9GAqd+h6c+V9h6Muuofhm5jPI9kzAQ14gczPhKpirYh3YZzV8ryiwE6DMDEREU1NSBsD
         KKc81SyEL0eVWNUBEB2g8LqdWTQk2LHhrnPtHoEw1nDRm8M8i6Qtm7ONm1pdHg6ETdfl
         BN/dzZ9BdV1k4v+e+oZ4KzyR8JaihP28AGlb3OPdC/+6pQ8X5lGyDKcSmhn7W32muYb6
         vr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699904; x=1768304704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B6sgfqjJd4XVtAQCCx/rIfnaC3LOmBamunXkDmSqj3I=;
        b=qP/gm8GHYixYwTy9QlM6svGNZA7miH7r4aw5CzTqvxxzwLqKjUxF4q500jFuIi/ari
         0WDhrgjuCTftXyWZ0+2H+untS6zro5VFTMszI0CduasIVeRnLEtpC/KKC/Eztqii2jh9
         nrFCEvkQdsLAFne0MtPw4djV6dePrHg7zmDF2SPt37xK3vs14cAoTY5NJag+SsdhT//M
         RIj9LlIqhSDdCAimZpSjxZJFsu7q+b6qq+HztivCLXGIz+1rpdx6qz0ltcrG28vybsyb
         mWUwWZUXep2iOXgCwdS6B6esyRSIRDM9rAjzGbLmZB91zjkgwOAbUSuonupmF2+6jgpo
         Bnag==
X-Gm-Message-State: AOJu0YyORaiEafs4bqcGElLWg1uZDgu3pDXo9G/MrkQcQMRfJCjSltiw
	WRw5YczlmXdTmAlo7Nu+9Q6HwICKo1T47TftC0+CLtc1wRZeYgf9p5IYPbAumA==
X-Gm-Gg: AY/fxX4cBlhAXTqMX/tMRBpyJ6LlISvsiNu6GUhHqVWeU45BzacmXA/xOBbUMRlh10j
	RreM9LbL/w/hxf4TMqgG9Og53oZ/My61lGMd0LYKNfaqsE9cIDv5jE0K/l2x8C/25usZ463fqKD
	sQ3pF2uCyUcGVT1e6Mmup+t7Kn+M4zMqCcxNFTy0V95l/crqGFLFZzhMn7R/O/CpB4Y4GmWuJwE
	I1xt5Gi7ywxTE8koSbvXFgq9T0JkmRH2mMz7/essnetE6Db9BNPHHYwbFz9DR64fmubwW1r/eXj
	VS6tqJ9WdaOBskBD7nt7p0RxWfF+iyYK7XeccaBgOrdU0vQINVW3K8vq8uAaCKKKeygX+Isz2k4
	XI/ItCAiZQSNH5E2SsRgtHcH/k4JEz+zc07MkawIHYub7ah/AY8Ina+CvnIzmtxtop38YB5M/nq
	CjXeh2vR6/IrZeSV3AmA==
X-Google-Smtp-Source: AGHT+IEh5H8f4ucLFN76/qjx+TQV1A7K8btE+csLV5Su46qPkDGKDlvKed/uNMi42RNMuZWuXnTzoQ==
X-Received: by 2002:a05:600c:1f94:b0:47d:5089:a476 with SMTP id 5b1f17b1804b1-47d7f0a02e5mr35741035e9.31.1767699904388;
        Tue, 06 Jan 2026 03:45:04 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:04 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 10/24] can: rcar_canfd: Add support for Transceiver Delay Compensation
Date: Tue,  6 Jan 2026 11:44:33 +0000
Message-ID: <20260106114458.122333-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21342

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
index f567ed7fa8e7..64fec4671058 100644
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
@@ -1468,12 +1502,15 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 
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
@@ -1505,6 +1542,20 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
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
@@ -1815,6 +1866,29 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
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
@@ -1937,12 +2011,17 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
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


