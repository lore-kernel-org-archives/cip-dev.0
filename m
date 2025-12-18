Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B4AD6E2DE
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:18 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1414.1766076971585737239
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L1VpP1Ai;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso8201445e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076970; x=1766681770; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYhkJmWBkOvWPkJ/Ua9ayCgCj1HpKn8j1HZMtZ59MuY=;
        b=L1VpP1Aiwtag1Onw4DYHz22XN4J3FjxhbJoH8wn/WNubIkP8cixmgz0zub/Q845GLz
         qjDtzDY1ykaw8d0Wy1T3/ApRRbJowOiEtuIVBaaWvz7EyLpd9Wf5uQqxGBnxOV3D7KLi
         q3WnfMPbGfXaspbhlaj85ZOm+lYa5AGbFJ/FoZI+TIUuSNwT1zgJi1VNuJWiYbsULuE4
         mjQivN5yHbiqM0BWNki6lfrN+wqlIeczkEGg/7YE4lqG/n0PcnptAhe4ykDLtKtZ8MnL
         rkZ1sy3W06zBuJ4aaagwhRwvx/Bfzr47Nghms8fvhbuITyyTAcQXQLXsJPhwliCMntGq
         YWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076970; x=1766681770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYhkJmWBkOvWPkJ/Ua9ayCgCj1HpKn8j1HZMtZ59MuY=;
        b=W9bp/wUcb2T64EnekHipN8C3IEJ2cWIltX7qCKZdQzg5k7W8kbV+9lAmAwfQg/UMQl
         Bp0/LfvTukFBrg1i4ryviHKVd1hjCsyxNbsh2tz+zN/Jtv53fuY3DMMEyQFzUDTMY4yC
         JEuDddF2nPDDPcrIbsL4oXjqRw4G8l9AKqNFKpCOjO70IOu1JClhwA4qHEV7WKtTWpDd
         Mbu6jAeuxnIM726kDcqm8fTv5RNIZ5dFCxMWjbyI5PH8iyUQqqt1jLoEXPqgl8U1VbpV
         96075kfGaiOVMByOiYM8iDZ5RMxHo/oSeDiScceTvnO4UrtY/4tBGHl/wyHQH/9UIt72
         28AA==
X-Gm-Message-State: AOJu0YxgoN2PlvFquVurSnNS5lpMuLNGBeBCP3E6U+iUYVNA+2r72eoF
	ICssrj670qNdv8iF+5WJsXD2rbppIw4WLlsnAapKO5pzW86t8APfwvkEuOqmag==
X-Gm-Gg: AY/fxX50fowG/YPNZC1d7SZ7GAKwzzni/zr3rYXbRDMS1F8rK9F2UI/D1jN6ndgkJiD
	QBURDkX+JEGbJysuaD+dQogHk1yVk5D7NzMPRlRnTFY1zpSUmfAlQyS2m3bVmDEBlvSyH3Oajdw
	BMb75+7N4UVHj+nwgW9jGLrEWLj0/Ut16F8ZZwHOAL+tLU3zcl6lvrKPifICPUIauw/tWUcMzQP
	rlNaIIdeNa06F/5vkaXdCTzHiMjB8roOwW4p0OgHNOW70nidONLJfqK4jupIMv6Y7Db2IB5DmaJ
	TJZ9sYjOXSXHQAlHU4Tn92uLLlEY2yRDCeB86CFxQaXgWmHpsiiHr/1BXht03Kq2KzmzUsCbEfq
	JvHoRjnY5+kIMV+yuzlQtyrQu8teL0BuLs6t1r+OTVsTHGC2UTbHwgGk73xqPx2CINeGMuZGdrn
	SyKH08ggZFABm9q8G68Q==
X-Google-Smtp-Source: AGHT+IE1CCXJA273BfiBq4kmM8kmvXuzMas/gCWvpZKWSh8ZGOg9KXOm9XMpj9fl3bdkAMowyh98Kg==
X-Received: by 2002:a05:600c:3f18:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-47a992e2ed8mr187766635e9.10.1766076967918;
        Thu, 18 Dec 2025 08:56:07 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:07 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 15/24] can: rcar_canfd: Simplify nominal bit rate config
Date: Thu, 18 Dec 2025 16:55:14 +0000
Message-ID: <20251218165600.258194-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21156

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 02d274adf485a0b3454dbedb4b4a36d97cb98fa8 ]

Introduce rcar_canfd_compute_nominal_bit_rate_cfg() for simplifying
nominal bit rate configuration by replacing function-like macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250908120940.147196-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 43 +++++++++++++++++--------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 848fdd820438..38f679cc35ec 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -110,16 +110,7 @@
 #define RCANFD_CFG_BRP		GENMASK(9, 0)
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
-#define RCANFD_NCFG_NTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->ntseg2)
-
-#define RCANFD_NCFG_NTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->ntseg1)
-
-#define RCANFD_NCFG_NSJW(gpriv, x) \
-	(((x) & ((gpriv)->info->nom_bittiming->sjw_max - 1)) << (gpriv)->info->sh->nsjw)
-
-#define RCANFD_NCFG_NBRP(x)		(((x) & 0x3ff) << 0)
+#define RCANFD_NCFG_NBRP	GENMASK(9, 0)
 
 /* RSCFDnCFDCmCTR / RSCFDnCmCTR */
 #define RCANFD_CCTR_CTME		BIT(24)
@@ -1390,6 +1381,28 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_channel *priv,
+							  u16 tseg1, u16 tseg2, u16 sjw, u16 brp)
+{
+	struct rcar_canfd_global *gpriv = priv->gpriv;
+	const struct rcar_canfd_hw_info *info = gpriv->info;
+	u32 ntseg1, ntseg2, nsjw, nbrp;
+
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
+		ntseg1 = (tseg1 & (info->nom_bittiming->tseg1_max - 1)) << info->sh->ntseg1;
+		ntseg2 = (tseg2 & (info->nom_bittiming->tseg2_max - 1)) << info->sh->ntseg2;
+		nsjw = (sjw & (info->nom_bittiming->sjw_max - 1)) << info->sh->nsjw;
+		nbrp = FIELD_PREP(RCANFD_NCFG_NBRP, brp);
+	} else {
+		ntseg1 = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1);
+		ntseg2 = FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
+		nsjw = FIELD_PREP(RCANFD_CFG_SJW, sjw);
+		nbrp = FIELD_PREP(RCANFD_CFG_BRP, brp);
+	}
+
+	return (ntseg1 | ntseg2 | nsjw | nbrp);
+}
+
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
 	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
@@ -1408,15 +1421,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	sjw = bt->sjw - 1;
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
-
-	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
-		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
-		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-	} else {
-		cfg = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1) | FIELD_PREP(RCANFD_CFG_BRP, brp) |
-		      FIELD_PREP(RCANFD_CFG_SJW, sjw) | FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
-	}
-
+	cfg = rcar_canfd_compute_nominal_bit_rate_cfg(priv, tseg1, tseg2, sjw, brp);
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
 	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
-- 
2.43.0


