Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E2C47BF9
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88173.1767699906681194282
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y0o4QJUK;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so9199695e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699905; x=1768304705; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8og/HMbETQ9V1GJjG1P78scTrs6IDhJ80M+UciyIT0=;
        b=Y0o4QJUKG2bFALEXdXrPC+wYEf6rSUnODklAbRrMecj+aLQbZplU3CIVWBFc/7eIzt
         QFdfH73SM97SVNAZf/vvByibGjZ87hyN1WkLvK1ASdmEE3iznrGPf+xTL1XDsoPD/dDy
         +FdvcXZcwWMkov4WXByZbzLjqHcTPk/YZEsiltkyiV9EUiHU4B0xppv6H8T6Y5ROTjIS
         /OSFjMTzrxy1K/vKBuJ5zUp1MO05T0Frw6RDQ4UP+DDWtU9PWS25MgXy9qYaSitrAcdW
         Op2+zS6GPczif0snaLiPrfIlVf7yVBxqsWYpgVSimeJ3yr8M4qyOG1g6d6yFuQkPA6Rh
         bq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699905; x=1768304705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8og/HMbETQ9V1GJjG1P78scTrs6IDhJ80M+UciyIT0=;
        b=SIHVSekVheO9w094dDPDhDtX2CGB6fB+CllaCPMdNhjPSw/3k5ExIbDnWtPQOWMjC9
         lDL+1f2g8gSCoiyKAqY9ykiXrzTkEgUb/3W+ZMMvdDjuCe1DYBFLTzxmB1zmPEujZdJ9
         8vN2VB4MTh0h6mHQ2UIVFtjovNwiLkgFm31suugb5ucCW0QpZDv8oNoZ1A8Lc0907ofb
         vKQgqCPaqmt2v+OGxnzQrtaW4b5nPNX4EuiCHBmZCmatESzsJaXwE3M/50ljx4/BbGHX
         DtVHHbrl4xSsiNLxfV3ft0A3begCHbMbgyfp8SA+Zeq9aYH0twTh/kESqEtRJAegWPBu
         LcTw==
X-Gm-Message-State: AOJu0Yxc745ijtUIFOpTG5z6ReJSxCESnARv0sUuB2OUnzUrJbqojIQT
	ke2hMbpr4bPGVpQaCbyaM3Tf+0qk1rjpFHCFnmE+pXDC8C8X6fTRpcs+pKggUQ==
X-Gm-Gg: AY/fxX51kCf46g/au1NMfnOdLNVGYM2ONyHKkSXafUZqwlSYGkblAitgUkEDvvnzine
	l1/QSaiBG96F21BpUO7b6ZYEdpJ77RxrFzOol6ukbIPsPECMEy5VUx6v073J0PaKsctpMU7+ksL
	cHfxtqElxFmOaZoyR5gysphRmeIZ+TLP0xBt7jIaWE2O7hpU9SQekXwnZDNV8256+g8BO6YnA9a
	d7sSXxf9v3lFEBC+nevyiLOc2VfFsFNPWjenGkgopYN0ZhjciX8GVD4cPhhT9RtSCVoSvDgNP2q
	Y7FAN3E00QvUal4dYzhnJdrULFf8eo/LWtPEtk/7lwa4y8d/lcOv09RULp6ZfZ/o7rtXaclpL6C
	VXyJ4T2OWkq0xCRdM0LJeeZLPCQvbxzAhAqHKMvgNyBmS2f/xnuAOYeLamioSXt/nT2/Er8ZYBU
	cu+de+8jvWGzTamWrAbA==
X-Google-Smtp-Source: AGHT+IGLK6wkXdbDBSdiSM8u6PwJLfr3gchfSsz7aWi+3/t1b727iJ+7ziMWc/cU7+DHHL6Fs5KHjw==
X-Received: by 2002:a05:600c:3e15:b0:479:3a87:2092 with SMTP id 5b1f17b1804b1-47d7f0a3e4fmr33817945e9.36.1767699904799;
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
Subject: [PATCH 6.12.y-cip v2 11/24] can: rcar_canfd: Describe channel-specific FD registers using C struct
Date: Tue,  6 Jan 2026 11:44:34 +0000
Message-ID: <20260106114458.122333-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21343

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit ab2aa5453bb83d05e764a1207a61109c6fd4fe4c ]

The rcar_canfd_f_*() inline functions to obtain channel-specific CAN-FD
register offsets really describe a memory layout.  Hence replace them by
a C structure, to simplify the code, and reduce kernel size.

This also gets rid of warnings about unused rcar_canfd_f_*() inline
functions, which are reported by recent versions of clang.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/20250618183827.5bebca8f@kernel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 61 +++++++++++++------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 64fec4671058..ae4c1769b02b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -439,6 +439,16 @@
 
 /* CAN FD mode specific register map */
 
+/* RSCFDnCFDCmXXX -> gpriv->fcbase[m].xxx */
+struct rcar_canfd_f_c {
+	u32 dcfg;
+	u32 cfdcfg;
+	u32 cfdctr;
+	u32 cfdsts;
+	u32 cfdcrc;
+	u32 pad[3];
+};
+
 /* RSCFDnCFDGAFLXXXj offset */
 #define RCANFD_F_GAFL_OFFSET		(0x1000)
 
@@ -564,6 +574,7 @@ struct rcar_canfd_channel {
 struct rcar_canfd_global {
 	struct rcar_canfd_channel *ch[RCANFD_NUM_CHANNELS];
 	void __iomem *base;		/* Register base address */
+	struct rcar_canfd_f_c __iomem *fcbase;
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
@@ -803,6 +814,16 @@ static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 	rcar_canfd_update(mask, val, base + reg);
 }
 
+static void rcar_canfd_set_bit_reg(void __iomem *addr, u32 val)
+{
+	rcar_canfd_update(val, val, addr);
+}
+
+static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 val)
+{
+	rcar_canfd_update(mask, val, addr);
+}
+
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
@@ -825,37 +846,6 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
-/* RSCFDnCFDCmXXX -> rcar_canfd_f_xxx(gpriv, ch) */
-static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global *gpriv,
-					     unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
-}
-
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 {
 	u32 i;
@@ -1541,7 +1531,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
+	writel(cfg, &gpriv->fcbase[ch].dcfg);
 
 	/* Transceiver Delay Compensation */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
@@ -1554,8 +1544,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
 	}
 
-	rcar_canfd_update_bit(gpriv->base, rcar_canfd_f_cfdcfg(gpriv, ch), mask,
-			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
+	rcar_canfd_update_bit_reg(&gpriv->fcbase[ch].cfdcfg, mask,
+				  tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1869,7 +1859,7 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 static unsigned int rcar_canfd_get_tdcr(struct rcar_canfd_global *gpriv,
 					unsigned int ch)
 {
-	u32 sts = rcar_canfd_read(gpriv->base, rcar_canfd_f_cfdsts(gpriv, ch));
+	u32 sts = readl(&gpriv->fcbase[ch].cfdsts);
 	u32 tdcr = FIELD_GET(RCANFD_FDSTS_TDCR, sts);
 
 	return tdcr & (gpriv->info->tdc_const->tdcv_max - 1);
@@ -2178,6 +2168,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_dev;
 	}
 	gpriv->base = addr;
+	gpriv->fcbase = addr + gpriv->info->regs->coffset;
 
 	/* Request IRQ that's common for both channels */
 	if (info->shared_global_irqs) {
-- 
2.43.0


