Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B2CD6E2C3
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1404.1766076965575440143
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UJNFOyGA;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so6365915e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076964; x=1766681764; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwchDHBIlLU/2Q4UrRsXQDnVTf7h6lk3iItt3g+PRKM=;
        b=UJNFOyGABvQlPCfNXk6UeTAjvjUmqJJGL/jC54ubi1Pl34HQg58YosVsNDySyO+0Oh
         Gt2uWwUsPV9IZkvtov36HSqb7oJ8GL0d3tYwmDVUIGDUgwOIPkUar6Vc7MsB0KPmKSFi
         mrZkSR3IGixgSS5N4gERzMNmtQPpKlse1lNXGPY7iKii0VDfdTQzY6dqmrTWrsaerCuV
         JjLoXITdlTuX/HGoQWnKlcMdpboaFqhfQR6i59trikgvDBV0gqJhnIgH3JfxhXrZDzIA
         4uiT5z2gyww4/g3E6pEiQUnraLt1e88n5MoAgJWILmeriU4SBM+g1XSqcSvLQjdml01a
         Gwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076964; x=1766681764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KwchDHBIlLU/2Q4UrRsXQDnVTf7h6lk3iItt3g+PRKM=;
        b=KB26dkcU+43o8jNlER0Ir20q7Uz4qLw28QeuVxnC11pttr1WI+s5S7sTkZbDd36ICF
         eactbanIAlHia93ZvVCBuYx00xNXhB9uxF5KFzZjSaaWH/TAOQv7RMv2OjrfmFC5JTKC
         hJ1efM07eHav8MikIlrPLQUqHZZnDE42FtD7LJAs6lfBkLON7pW/Muuf6LoPhnzCbXZb
         Yu20PBNCUYjOL+/Gbc+Q7V52C6yx5T0jkn9wD7+djzkyUmm3Ow8r8bQ42sR5UNgL5A1n
         fd4a1mzb3DVpN9ZRx70z83nBXoqM4W+b2jpxYoyEZhJY7B0YKP6ONQ3YLWrd9epDYXrA
         zqFA==
X-Gm-Message-State: AOJu0Yx7oaZjITM1A3/nlt+sbcE25+4VpnsM26q1ZBtXZmJBPqF5GNCV
	4yhYyssPMVPB0dORuDsY3gZbe3sF1W+o+3Sjk25ivXZx68+2TLdiEtXiCw5rSw==
X-Gm-Gg: AY/fxX4YVa/gSoDWl7/6cjCSUFQIybH9NWkkuWUXrhpkTGawtGVP+lLTn/7A5Yu9WLs
	NVThwq1eT/GdSh0+D4QCVOmayOeg+Qj07Hm8NlHoSbAPQIYP8RQgUCp2XFKFDidlie61j1dFEI8
	4m0u6fVTLXr2b/SmlbQc7UFn9pZh4r9MlqR6vTdzNrwRGeBXx8D3i1pj6cOzqdWajYqPEj2UgPz
	kI/RQQFGuKgQ65PH3RocbAO9hVXjTRREIzAhkCODS7IXJZNnQJXJ6r6ymERJCGuyJSJLljLqWMP
	1eD8ZgGBbpvdWVkb2FW3TJ2h5KhclTonTtDDHzDq8zeFlEwkINGfbxR8P+LZGNmJU5rUyV/LwAW
	iKtOwsdylHtJWk2WaVT3u85uqm1PVB8Wx/mtRSS2xNCvpCM+Z1CXDH8G/y7/DQhfVluFhjQCCT9
	Bo77hr25S+E//7bwMwHA==
X-Google-Smtp-Source: AGHT+IFw988Qtr7WesHO4GkmbAPEbix0uovJ2NLvyhYmVQa5prlUxvLZ4PHD+KKj77db2xqA0oXcvw==
X-Received: by 2002:a05:600c:699a:b0:479:2651:3f9c with SMTP id 5b1f17b1804b1-47bda6e58d4mr90604275e9.14.1766076963665;
        Thu, 18 Dec 2025 08:56:03 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:03 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/24] can: rcar_canfd: Repurpose f_dcfg base for other registers
Date: Thu, 18 Dec 2025 16:55:05 +0000
Message-ID: <20251218165600.258194-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21144

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit e4d8eb97a469d2397d3ab23f3b32f26e7e6853f2 ]

Reuse the existing Channel Data Bitrate Configuration Register offset
member in the register configuration as the base offset for all related
channel-specific registers.
Rename the member and update the (incorrect) comment to reflect this.
Replace the function-like channel-specific register offset macros by
inline functions.

This fixes the offsets of all other (currently unused) channel-specific
registers on R-Car Gen4 and RZ/G3E, and allows us to replace
RCANFD_GEN4_FDCFG() by the more generic rcar_canfd_f_cfdcfg().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/75c8197c849fc9e360a75d4fa55bc01c1d850433.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 52 ++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 425abaad77df..b86ab6d3e9b1 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -426,19 +426,10 @@
 #define RCANFD_C_RPGACC(r)		(0x1900 + (0x04 * (r)))
 
 /* R-Car Gen4 Classical and CAN FD mode specific register map */
-#define RCANFD_GEN4_FDCFG(m)		(0x1404 + (0x20 * (m)))
-
 #define RCANFD_GEN4_GAFL_OFFSET		(0x1800)
 
 /* CAN FD mode specific register map */
 
-/* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
-#define RCANFD_F_DCFG(gpriv, m)		((gpriv)->info->regs->f_dcfg + (0x20 * (m)))
-#define RCANFD_F_CFDCFG(m)		(0x0504 + (0x20 * (m)))
-#define RCANFD_F_CFDCTR(m)		(0x0508 + (0x20 * (m)))
-#define RCANFD_F_CFDSTS(m)		(0x050c + (0x20 * (m)))
-#define RCANFD_F_CFDCRC(m)		(0x0510 + (0x20 * (m)))
-
 /* RSCFDnCFDGAFLXXXj offset */
 #define RCANFD_F_GAFL_OFFSET		(0x1000)
 
@@ -511,7 +502,7 @@ struct rcar_canfd_regs {
 	u16 cfcc;	/* Common FIFO Configuration/Control Register */
 	u16 cfsts;	/* Common FIFO Status Register */
 	u16 cfpctr;	/* Common FIFO Pointer Control Register */
-	u16 f_dcfg;	/* Global FD Configuration Register */
+	u16 coffset;	/* Channel Data Bitrate Configuration Register */
 	u16 rfoffset;	/* Receive FIFO buffer access ID register */
 	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
 };
@@ -642,7 +633,7 @@ static const struct rcar_canfd_regs rcar_gen3_regs = {
 	.cfcc = 0x0118,
 	.cfsts = 0x0178,
 	.cfpctr = 0x01d8,
-	.f_dcfg = 0x0500,
+	.coffset = 0x0500,
 	.rfoffset = 0x3000,
 	.cfoffset = 0x3400,
 };
@@ -652,7 +643,7 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
 	.cfcc = 0x0120,
 	.cfsts = 0x01e0,
 	.cfpctr = 0x0240,
-	.f_dcfg = 0x1400,
+	.coffset = 0x1400,
 	.rfoffset = 0x6000,
 	.cfoffset = 0x6400,
 };
@@ -801,6 +792,37 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
+/* RSCFDnCFDCmXXX -> rcar_canfd_f_xxx(gpriv, ch) */
+static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global *gpriv,
+					     unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
+}
+
+static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_global *gpriv,
+					       unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
+}
+
+static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_global *gpriv,
+					       unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
+}
+
+static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_global *gpriv,
+					       unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
+}
+
+static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
+					       unsigned int ch)
+{
+	return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
+}
+
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 {
 	u32 i;
@@ -828,8 +850,8 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_GEN4_FDCFG(ch),
-					   val);
+			rcar_canfd_set_bit(gpriv->base,
+					   rcar_canfd_f_cfdcfg(gpriv, ch), val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
@@ -1470,7 +1492,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
+		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
 	} else {
 		/* Classical CAN only mode */
 		if (gpriv->info->shared_can_regs) {
-- 
2.43.0


