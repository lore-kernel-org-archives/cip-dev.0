Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C3E674A7
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78195.1766402231289550757
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y+JSli3p;
 spf=pass (domain: gmail.com, ip: 209.85.218.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so872415166b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402229; x=1767007029; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAtTBdKzsxOsOVr4atbb2dwTJjX3hCGLyVen256jQBk=;
        b=Y+JSli3pohU2ZOl5Rb0+d6Y8OmhhnWgo0xfMGsYeHrZA7JXTYoxqn7C1BnkY8lzUqB
         dnyiAG/fmLRO1B7Gj4DAn/byK7ACsXG8i+HyQq2MnO4YaqxghkfX80yDz+2/y6ATFUGb
         LYWf3jgc7NSM5f5/NpyAbIiw5TbsV7g/ZPNwPU4+/apKzuyUdjy7SHEfcLrTfbtfGpXx
         N4Vy3FzosQSueYntvGlVICWyxXLXgLNRzyYpyShZ0juO5NW2GgYP5w1YDeYIZDOuGvYM
         gMu/4Zyvu1QrREDDlTUpfXSNYMtRToZawuX98q526GGlKln2LWdfZrbagvM8crPBMAia
         vPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402229; x=1767007029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CAtTBdKzsxOsOVr4atbb2dwTJjX3hCGLyVen256jQBk=;
        b=Gt/abMCL5zX8zje2s3TOjkqrbBhd8hMsPfRL/u2V/UQNn7wbdULNfw6TbEcm1kO9rK
         B2J6DjT9WtbP2QAE9NAg7duFudHPJWTkkXt+SV7/ryrmyROzRapxl6iXwSXWLeDw4Mbe
         jZRPY1Ax9L+qb+2r6k4nU+5Tlu0LniNMLl7HsfztZ6ZSzo6PLnouOm5E0jrFJVlfqWkP
         tpeh1FKCgy8S6XQ6SB9wucuHSJgYZyFyjsLjTY61Bu569q43CqS04pqnd9IoxDEJIB55
         4JwLqXr6zgagqVwZeKhm7Re1ew8Pa+qFCDG+3lj7kCLkmEfv0V0t6xSDNG7ObXz5JU/u
         HBWQ==
X-Gm-Message-State: AOJu0Ywr7PAZFdDjnZUPgZyeT/C7RXnbH/gCeyMbflzmZf/YZtWKRuk4
	XPZztn6D0JUVLIPbR0ZqQiTc9oDpR2W9wSWwtGse4eZ+gMOBFC2AqWY+HZqGGg==
X-Gm-Gg: AY/fxX4tGEFhqcsn5E8nEWyismUrY1lHOa6aWmnWADoMdIL5N43HQXs+sYQODUnCplG
	hxak7dysecACt7UP6fmMGvOJWQPUzJKu0lLfmSspAh2Keuc5f3NsvS6hYbPm6vIW2x/2Ka2aZxY
	w8+dYKsv7/Nzfltc6hBZB2SbdZAMgD/U5kMixzQY1oa5EtO0BNADM/NC1B2h062QnRzt14OpCYW
	1+zaZPj11jEIzW6c1TWDiCP6bd52JIjEkPtgUY6k286uwMA9/Tl9Qo1xJkw9LmXCVg6dbUGLRGd
	EFRGadL/CfN9VhuT5iZy6/4AyfHLpVLW6X6V7sveflv/u3sKdMRTcqCutHWOotJr50Z4DfbOIXg
	Ay9qrohkKn9X//XgpucRbka1GSd+RttZfuPfa3xV3m8gEYhdVo/08iwDj8Sr5bs1PTwAWcZ1kn2
	65kkn2mokRsz95fnKG7jW4k7qKjls4VHn6ynI=
X-Google-Smtp-Source: AGHT+IHYCnNALb3SnGfSPOaaozZVjts31tuUqNda7OykLSQkeQkVOP5DMU6HE6fEqE+AewtN3KzV4A==
X-Received: by 2002:a17:906:9f88:b0:b73:6d3c:e0f2 with SMTP id a640c23a62f3a-b8037152a24mr1193271066b.37.1766402229274;
        Mon, 22 Dec 2025 03:17:09 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/24] can: rcar_canfd: Repurpose f_dcfg base for other registers
Date: Mon, 22 Dec 2025 11:16:38 +0000
Message-ID: <20251222111705.27028-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21192

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
index 1e37f685d9b5..6bdac418795c 100644
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
@@ -827,8 +849,8 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base, RCANFD_GEN4_FDCFG(ch),
-					   val);
+			rcar_canfd_set_bit(gpriv->base,
+					   rcar_canfd_f_cfdcfg(gpriv, ch), val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
@@ -1469,7 +1491,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
+		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
 	} else {
 		/* Classical CAN only mode */
 		if (gpriv->info->shared_can_regs) {
-- 
2.43.0


