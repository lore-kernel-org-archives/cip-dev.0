Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C3ED6E2CB
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1409.1766076968724931098
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bALmJiTL;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47774d3536dso7764195e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076967; x=1766681767; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ov96TED9IeBTzY+mNTNcWcPWHrkGb9/KQcltvFV3zc=;
        b=bALmJiTLdb/5Q5P8djkI/25Hugh0LE4jXqVG1F7Rz+nx5lIJGRdbBlIXZDwnz9SKxX
         bUdhdZdTIIVJQcpSj5r1bjtnnHsFUcxMXAisARxNO+DGrhe143Qk38kXrneV26o3UVjH
         9Q0+ssjbOCJeTUHh1fz009VrTW0qsIyr9hoF3+9kku/u5/PzLXsv6KfnqJpZ0HuKaN6D
         0umtukWF9xQC/DEvuTzRpfFUtd+ZXpoPsNKOyjlZn3Jm919xG8xYCwKO+K7WNFNgIKBW
         ahtdkeGOkkyGKwdcMu+1Cv8uuAvkUsqdHFg9098h+8xwtfj8osdEwjdl2vaQAE0nCBDi
         YdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076967; x=1766681767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ov96TED9IeBTzY+mNTNcWcPWHrkGb9/KQcltvFV3zc=;
        b=VF7bw1bhQCVzqAxk05KxmF8qzhhVoeC0M8b4HD7aOFkNlNME+DcvOXg7sXbQZ/0OJX
         ESVasar2kVyc4jEq3G4h09aimuDe6G9lyJYrPoG+cMhNFiba/LyM3dKIT9frSmTZIOW8
         aeV7xOUxhQF9Go+FhuzvxZC19XmE5kgkpcGmCsEmQmzK70EstYEDtWJ1qqr6ymLdKIFn
         vbfWsn1trT/qQvgLLhYhHr6KM/7v9bb7JVPIY9IvyE7xf7G7p5i/2NZdPAw6LDFlV2cA
         GmOI9FFk+BGGjNSrmnZ3h+gN/JJpyCfK64p5hvMfnh8nyrbF/ahEJOMCdBv0LDhEOFKm
         lBgw==
X-Gm-Message-State: AOJu0Ywpo0LxCDDPks00SgGxPsuNV/MZ/rTbJnrmYgxRoDFhnbZVw2kL
	pGvkCaKgnLZIHHVaYLNpkZJt8sHlpyIq+HKexbyVUep7zuAlV4KhfjfH5X1F3w==
X-Gm-Gg: AY/fxX5z5asj8l1TJ0EZKXRFhg608SBXaCmZ3MHAvgboctvIhsbPp5hirATXZhD8Vav
	r5oE8ppgvBJP2KBNux0t7YldKT3xZr8fBGT67QVMVqJvp+A9fzhrFUX5qz3WF2/qsJGTnblTgCs
	DBtHzRLgbGkGJj2MknMxnpuxGVXmQTuWSSGNXZ1+LkIrFWVANxIUGbOrfP1tEbUG2JYd3CbUsf7
	CQgV/aeQdPcylOKu/dtkd7Zc+ixlue8o8G3raHqCFcbMrkK0/tzdBDN7dnZVUUZme98xvjp2DNJ
	sN75P0WlnoE2gSiubXFES3Mj42iaWIj58Tlng/AbB5SasehtbcehISrr+/57Tp8quiEwxb/QqMy
	cszGOQlesQsYRBalMQAwX/4hUVEDIORbBUgc6rYDY/Ht0yopzefZHuRjAIP2gz1t2xG2YsDT8Ja
	uGNmIkdiZV/C75qGBKiQ==
X-Google-Smtp-Source: AGHT+IFysd3oybLl1pzp3PAxQ7yJOHA4QxUF07UZst1lGK4a58GWs5cuL4miraeTJ+I1HDTEVWLzxg==
X-Received: by 2002:a05:600c:6610:b0:477:a219:cdc3 with SMTP id 5b1f17b1804b1-47d18bd56b8mr2842555e9.12.1766076966059;
        Thu, 18 Dec 2025 08:56:06 -0800 (PST)
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
Subject: [PATCH 6.1.y-cip 11/24] can: rcar_canfd: Describe channel-specific FD registers using C struct
Date: Thu, 18 Dec 2025 16:55:10 +0000
Message-ID: <20251218165600.258194-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21150

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
 drivers/net/can/rcar/rcar_canfd.c | 64 +++++++++++++------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3e32e461f0fc..6e32b1b20044 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -440,6 +440,16 @@
 
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
 
@@ -565,6 +575,7 @@ struct rcar_canfd_channel {
 struct rcar_canfd_global {
 	struct rcar_canfd_channel *ch[RCANFD_NUM_CHANNELS];
 	void __iomem *base;		/* Register base address */
+	struct rcar_canfd_f_c __iomem *fcbase;
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
@@ -804,6 +815,16 @@ static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
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
@@ -826,37 +847,6 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
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
@@ -884,8 +874,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base,
-					   rcar_canfd_f_cfdcfg(gpriv, ch), val);
+			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg, val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
@@ -1535,7 +1524,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
+	writel(cfg, &gpriv->fcbase[ch].dcfg);
 
 	/* Transceiver Delay Compensation */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
@@ -1548,8 +1537,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
 	}
 
-	rcar_canfd_update_bit(gpriv->base, rcar_canfd_f_cfdcfg(gpriv, ch), mask,
-			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
+	rcar_canfd_update_bit_reg(&gpriv->fcbase[ch].cfdcfg, mask,
+				  tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1863,7 +1852,7 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 static unsigned int rcar_canfd_get_tdcr(struct rcar_canfd_global *gpriv,
 					unsigned int ch)
 {
-	u32 sts = rcar_canfd_read(gpriv->base, rcar_canfd_f_cfdsts(gpriv, ch));
+	u32 sts = readl(&gpriv->fcbase[ch].cfdsts);
 	u32 tdcr = FIELD_GET(RCANFD_FDSTS_TDCR, sts);
 
 	return tdcr & (gpriv->info->tdc_const->tdcv_max - 1);
@@ -2172,6 +2161,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_dev;
 	}
 	gpriv->base = addr;
+	gpriv->fcbase = addr + gpriv->info->regs->coffset;
 
 	/* Request IRQ that's common for both channels */
 	if (info->shared_global_irqs) {
-- 
2.43.0


