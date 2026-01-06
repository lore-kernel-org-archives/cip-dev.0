Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0EDCDC165
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:18 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88175.1767699908552729860
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b/TLv5Cz;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so8565455e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699907; x=1768304707; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQw1G0x1r0WOr+idqjoyxscSGxahQvQksq96u7zGAKM=;
        b=b/TLv5Cz4x3TbbPcV8N04aUdfUX6VcKuGFgXE86iWtRWPVfVhqA8ocAwG5v0JTzg/v
         JsdipWPc2eVjP/T7W7jYNUY/veeDYvyquroqpAqgrZefaR+kMrAxzXk/zdw+ge+luJUo
         jK3SCA077JEB9KHTjE6E8vKEAB8WQqJPAD2PIfiW4ov8aEJAZmiZB9PpeAOk4To7AYGe
         ngumqZcQ9+cmYN9OF7J0K6rnwVjlgzD9Q1IFD3ipu/TafmhTuzMyhh1q9xdv897YEFP5
         Udw624qCKgHeyptL8FNlgTxMJzINl/RYZxVAd/cueJJOZ/PRNFUykvpO9lwtQ8LnbaXt
         BBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699907; x=1768304707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQw1G0x1r0WOr+idqjoyxscSGxahQvQksq96u7zGAKM=;
        b=YzBAXivSMsFrysOkUAz24Ebm1avibTs5EU/d8k1TrcJjWXPV0f1ZV7QX0EIgHvhi7J
         b2HSGAzLBa1+nBVJ5K6Ob6+n/sDE3kvFoHpvsvIC84hmxV2niDUAYpBAXUEw51CGkbfG
         ZPCOwGGhDBYhQBvFAQLnob7WljZPRF/oj0t1kIgOJ1k19fTJ1K8w6pHmZVCjZr5IqvZg
         jNcZSI8KaYlqkV+mhiiK6YFd+Xy5OILoSl43jh2noh8fdGL3u/5xl6lnOQpfp+JllmEz
         WJ7H29dhNV3qqRY86Pno9Ko3UmHwG76hh0hFhlIUoiF3Mh0Y9pjpKZ8brOilSFpVSXgI
         yE0g==
X-Gm-Message-State: AOJu0YzZSGLt+Y58mqKjVyIgv+Ya7KxsR8mJRUMJDHSWw0Ffuox1pzd0
	8w8VfYZ7G7IiUvxXom/Ghu9HFQZOsapqwET+XleuBRLahuWQW1nFra9LZX4fMQ==
X-Gm-Gg: AY/fxX5ocaQ4dXxy5NjV6hdlIBRRcTD1qE5dnJkhI8N0htNd3bmDEjxiIksE9yo9vzy
	a6JX9Gp6X4EKlHAXJOGEd1bYWoaLXSYJOaq0+dOA1QqZy1e4VT94nhsfuoyRmQKCEv7sVb+FmdR
	LRTnaXRSMm3/zzxFIFnxuMeeNa75bGJS1EfkfF8AKkCWBtAj3csuubCreYa0F/fVVSvjzXAY7S0
	H/ysdbR3e3wd5twgymE4s+ZEq5PgDuPWJltsSNblJFq8aZf+Yu7cYyxtxq/zUKQexcvs9xqC8R7
	BfGO/ef97W6sKBSUQ5J1chjQGtkSoVseMZ8+8QSZp3Dl7VlNoyRr6WNOzD48an2uhWsGdEN9VDP
	qwpydHtRR7a/bIqANn4pmQGZngif/bmH7o9H6nCY6RFa8tUeCkriNgKjloYCezIviV2USoveFgx
	QSAKz39WzBk/feSEicuw==
X-Google-Smtp-Source: AGHT+IE4C4k0oDWYIq2s5IM49TL1itF+mPqUWapsHEI/RB8lpOt79qBXI7WNxiZeqlQP8tOUFo0nPQ==
X-Received: by 2002:a05:600c:5488:b0:47a:9560:5944 with SMTP id 5b1f17b1804b1-47d7f0a8342mr32538265e9.34.1767699906723;
        Tue, 06 Jan 2026 03:45:06 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:06 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 15/24] can: rcar_canfd: Simplify nominal bit rate config
Date: Tue,  6 Jan 2026 11:44:38 +0000
Message-ID: <20260106114458.122333-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21347

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
index 7b17845e9b0f..d1b7a06a46ed 100644
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
@@ -1397,6 +1388,28 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
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
@@ -1415,15 +1428,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
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


