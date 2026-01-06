Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93654C9833A
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88172.1767699904378658725
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nEmFbHVC;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso4002415e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699902; x=1768304702; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPFvWScKMVCrVJ4EeKRv8ZnHgPKug8xpD/gwa3GLl+8=;
        b=nEmFbHVCHkyQQ621VWTZft+F0m9TUQ4iXt7SuO95pH8cuh+N86DUNHTnMXMl9B8r8b
         xdiUZA4MfCFHryRbQyTOhxXdUpWRgt1PWfAaSFM23Xq4KPzP2IyVuRRsdr3iOzAuytRJ
         pOB0QQybxJ6ZeD2n9yZcY53VtKj/1Ex8AkTLLeOrckp0Wy728Lhd4BrZNnTgBSewr7Oz
         rJFa2Kz5cPPcIvaihIOV90ts9gynYQjdlhelJGzW+DGu2D2PtFmlynT56wqCY9DeLySZ
         q9dCiwOWL5/nVS9QZE2s2ukddDPYc4BB9HpQ4h5fam1egXSbJOPDbxa7dbip+eEabsB7
         JkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699902; x=1768304702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XPFvWScKMVCrVJ4EeKRv8ZnHgPKug8xpD/gwa3GLl+8=;
        b=C67zd+z0EP5HmhcQHFqasA05x+J+tYgyS28Tpte64GB5QkxNE6CluRzagTqlAHR5AZ
         5SttbaNvuqQEPsxGYHG0s10SQY3OE2GeWJoK89ZHaRsQxT8qLhl2eI8ytRHlEnwNeJWI
         h6SHMXIeDHZh3pjsYr6CQzRQzI702wZgH6tausN9B4jD6pQR3OpMZWYHLB/uFxXxrA8/
         47sfGY07VLNOp1UzXTN8K8unKfKSVtCchHGlPDnRESqCEQOp0dXHRvApI5ASK8kCGRuI
         Yf5Q8ej5tOaVmUUdno6MDUoSIfOoc1mqO2KcyqAuPU2kFk2XZwFqMeiyXJ+BjATEHmqJ
         GZyQ==
X-Gm-Message-State: AOJu0YzHg6yjPuhZESPUKVDbsqkyv/1tkZNp3xWBDvD2edHf/NogPOsP
	DNVaQBNGVPZYqxGYez/3cefpH6r+VVCorC6rVAgpJ+nJ5z8WyMv/R7Kuy2JY+A==
X-Gm-Gg: AY/fxX5T+Uo4OMZB0+hcBIz8iRJybti507RJ38wVAY2Xq1SbMJ6UZnBfP7mHOW+Hz36
	J1/Zr/tL0SDN2tuCGISGVIsEIZ+uOfE84mlE1Juf1RQXpr+0I+Rhl8ysZ/Yo/hOKFnBSgMmf0uq
	jzL7AyhXFWAt5oRsycvWyulBC4uEVU7KorOu5U5vEQIiYvEJYGH2vzPJocsNpOprZgUedZxPRiX
	GmNi8/Sc6qqrZfQWT0n3OWmSm5/wTDg3Z2BaRSs507mDT/MoAahbxUpczo8BQztphGVAYPAvspB
	G1uqKlGKXNMVA4hh88mTkInTGGvTmaNGXL2n6JPsuzwQBx2x9BEk6EzebyektnfqoFCNrOR7gcu
	QyibO1KoLhbfsuDlLi/sg1uRNzlHQA8fLx3ZoPbvcfvcPjVOENAW4m4IokPN5Fl8LfxTceHUE+m
	ctRUZdHFq7WaAgVxVFrQ==
X-Google-Smtp-Source: AGHT+IG0z6N+yVaOTJELOBZIzHlwZKeR9uk9EZQAZJuBUwyDp5GNVbIw+6H/PvU4C04tudR0k8X12Q==
X-Received: by 2002:a05:600c:608a:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-47d7f0a954bmr29542525e9.36.1767699902250;
        Tue, 06 Jan 2026 03:45:02 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:02 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 06/24] can: rcar_canfd: Repurpose f_dcfg base for other registers
Date: Tue,  6 Jan 2026 11:44:29 +0000
Message-ID: <20260106114458.122333-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21338

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
 drivers/net/can/rcar/rcar_canfd.c | 48 ++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index d7ab9a7ec4c8..3133ef64f537 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -425,19 +425,10 @@
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
 
@@ -510,7 +501,7 @@ struct rcar_canfd_regs {
 	u16 cfcc;	/* Common FIFO Configuration/Control Register */
 	u16 cfsts;	/* Common FIFO Status Register */
 	u16 cfpctr;	/* Common FIFO Pointer Control Register */
-	u16 f_dcfg;	/* Global FD Configuration Register */
+	u16 coffset;	/* Channel Data Bitrate Configuration Register */
 	u16 rfoffset;	/* Receive FIFO buffer access ID register */
 	u16 cfoffset;	/* Transmit/receive FIFO buffer access ID register */
 };
@@ -641,7 +632,7 @@ static const struct rcar_canfd_regs rcar_gen3_regs = {
 	.cfcc = 0x0118,
 	.cfsts = 0x0178,
 	.cfpctr = 0x01d8,
-	.f_dcfg = 0x0500,
+	.coffset = 0x0500,
 	.rfoffset = 0x3000,
 	.cfoffset = 0x3400,
 };
@@ -651,7 +642,7 @@ static const struct rcar_canfd_regs rcar_gen4_regs = {
 	.cfcc = 0x0120,
 	.cfsts = 0x01e0,
 	.cfpctr = 0x0240,
-	.f_dcfg = 0x1400,
+	.coffset = 0x1400,
 	.rfoffset = 0x6000,
 	.cfoffset = 0x6400,
 };
@@ -800,6 +791,37 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
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
@@ -1476,7 +1498,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
+		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
 	} else {
 		/* Classical CAN only mode */
 		if (gpriv->info->shared_can_regs) {
-- 
2.43.0


