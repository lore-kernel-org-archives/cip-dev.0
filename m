Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5014BE674A5
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78278.1766402235808934014
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hyLfvyOh;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8052725de4so201519766b.0
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402234; x=1767007034; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeEOLhWOABMMOVAYruOWtLmmnkA02IZ1y6MiXR23lEE=;
        b=hyLfvyOhUGq2rvcu9bsEPOzM/q9CsQuVoKk2hDktiI9szWBzgE0TuSUFensaDtqtKe
         X5KPpA1l6acoE8VgiocZZgnHhcBymxgygOroOuSlxDSgnfGtqnYh1mzrEhjVBSrrFDHe
         C8tx1tC4SBVf2gFIOn3KGr5KlDYCIDLOKBfp7QMfYWkdWHi814+9U6e8NRq5cK6vfJal
         5OMSQAaganl0QUl3fSULSLQrrQEfvYItUxXYk+PsJkFoXReNK77uKC61rKgSFnFSmWuT
         Orv6ztxPx25OJOSFGdfWnOSTLGF9WxaOg9Vy4ZB/ipWcr8PxdLsou7B0Du5bYPha6ECH
         oPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402234; x=1767007034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FeEOLhWOABMMOVAYruOWtLmmnkA02IZ1y6MiXR23lEE=;
        b=JTv3vm2Uv7lYNdvahjxwt6O6oJ/BL0gGcfJC2qZ3T/AY6GQdp5XE5N+h50A3GhKZqR
         uhlgQoWh8y09Ary1TYZ00wGUMIrRZyb+1xvHrXLIBYMcNgsZswPM37LUUo0QKQ0haskj
         8BDyQaRoZehZAs5gCjn5OelvNmjtT96FdaxlSaodrOxP5fU7CMdXpj5JwuyT7SHEVrde
         DohUduVTyRtMXWKRlQWk83JoaFlO3yVVc4xMexiVMh1aUYFZ3MKucVUJ+C63NtpByRhb
         8uWazgkry6O381FLoDZOHq6rH+S4qQ7Fq01ZOsPUeiXIdBMQwGN5/iEWCVBbr6p0gNDp
         dsTg==
X-Gm-Message-State: AOJu0YxZEjaC1+BDMlrYpyMbriQxLDuad4dTGkUv8qvD78DFaE0A0+gc
	CdWER35BaJIGKzge4hhfVNCNYhsI19Ochvswpbop53ska1HnQHHo1+w0+LTpkQ==
X-Gm-Gg: AY/fxX5Nej6ozUYphDU5F5wYQ5SYav+apQrQCqOvXjsdovzRfT6A5VFT6x7RGkOor9n
	LU/XvlYo2tC7XCRHeqhzRVRnxygIb1tVOrX61rhUKhpVrzDBhLp28oAGKrsu2srfv7a4sbYfqeI
	oeqDPnWfe/eIc0dIFZ02mw5Smq1cMxEZdtDkQUH+OSXcTTnpuGHJ+woH16tMV/F7Gk1cZcfklVV
	Qq5Dp8duMn4oHPvy6sgewSZ3hogkgCCcvM3Xc8aYffar3wrvpe2RPKzzczTsaPc3UCaJyXHjXTk
	aaslMzGt/QE1D9kgk6fr5C7aqpVggQorVXuuB09tsltT+daSHqrjQdkcEVZwtiO5uUYnA3D9NLn
	C+4wXIrmtEjkGOdYwRZLW9tBCxFALTUF1PpCqgzP2Cx3LqLbr3To3rwJ3C3ZReDr28ISkq90cvX
	2yReUXS4GKv9ndr8DvNufx0WM+8kW3XpTu+fA=
X-Google-Smtp-Source: AGHT+IFxpwrHxWGTOQiaQ4agPByd7f5W0WEXqEUe3FE7nH7eqrf8y7klUEw7vNkWrYKFtyDxGR3k6w==
X-Received: by 2002:a17:907:608f:b0:b4f:e12e:aa24 with SMTP id a640c23a62f3a-b8036f10f3bmr1090402566b.22.1766402233845;
        Mon, 22 Dec 2025 03:17:13 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:13 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/24] can: rcar_canfd: Simplify nominal bit rate config
Date: Mon, 22 Dec 2025 11:16:47 +0000
Message-ID: <20251222111705.27028-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21201

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
index 3b93d1e40087..1d4dbda4672d 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -109,16 +109,7 @@
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
@@ -1389,6 +1380,28 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
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
@@ -1407,15 +1420,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
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


