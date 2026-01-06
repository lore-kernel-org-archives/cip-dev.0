Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B1FCDC176
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:18 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88218.1767699909176668651
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cOtdyVS6;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so6642265e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699907; x=1768304707; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TjbZUka7/MAR9uMWhWO6UB+Dmkd9TfPKRaLAndNqe4=;
        b=cOtdyVS6gYstuDVDirTgh4XAZYG+gmm5p3Deh6N4aJHRMTcMBUhrRGvWqmhGNXKBXG
         yCLuKT4NvgifoNF9aU2HxgX8hxD9cz4cGMC2JLFBJoJPELMunWORajyKfaOZWSdlMfOv
         m+WeZxayiDuEaU8Q/e+mW2P9N92Jppqp5GI1jU0YqV5AEgtZlsjbDTZUuFVxoAR5v9pk
         oT5c/LDW2jtBFfr+YRNTausNIyFzkk6cwkexaMcAnRwJ5NOlWhBe7M90eO9ytU7cEFz8
         wD+unCGUUoGjcIEP1xUFSdpxrorZs0/tEXo1ND4mFt8APeS04dwJ2TMSj5Rm7ZR7mUHx
         s4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699907; x=1768304707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2TjbZUka7/MAR9uMWhWO6UB+Dmkd9TfPKRaLAndNqe4=;
        b=DB0KpYyZ7SgllqNvVGDyv92EzXHjLr6AR2EogdKA9YFIRGLUVencVL6C3WvGipJnjd
         AG0npQPsXQ7i7B5siOVVv1ZjLeuW35IF8HD+berySUhTTtUQYaU+z0w2NILxSCOpk2Og
         KrFoU4a6tIxb1c1vvloIHxkuLMqs4RD8nXG1fVxLojqDImrVE1e+TvzaA4dJ0au9cpFA
         Feh4uZQbNfaI6pFj17g5wuFahvA57GzwOJgzX0EQb1WoCi5qfMcJQE/cNYkKu3wFxhyq
         i2ImvmDSSEYw4m8Dn4wiu2VLIozECOsfPbOOZmYmCcieaKO0XhtbbyA1rr+wqFImpCjV
         7//Q==
X-Gm-Message-State: AOJu0YxXk0MFx/y/9fKtxQYZxayxEH/MpKzmslDtSkjG1l7RNwWdhCzT
	0LHIIZL8FcdwUJv5MsfyU8kl7+zSmxSxlCcC0tuUUzEnl2Q5ZPNRcLnLo4ebfw==
X-Gm-Gg: AY/fxX7L/JkzbVjcV5XqQJCDKkCQgigYd1PFDHu5z+tdGrS+DFbwmfRlWg3njm4NSKY
	QZglWvwrDrMsbp6xSEIaYR8NHKRqnfFrJn1AzHlLWn+Ny440eRQSIjWxYGC6LLiNOcrhmi4Ttqo
	7kjwyP4xjdMeOt9Kxd4xg+Rwil7rmxFoKYdhqtRYzTH4us6nErlr50DnoSowG5uhipQxkhwe016
	kfHRAM2JHx1ytpDwPsH5tJpOMT1BjnnDDKcpHCsTzJ4l5G71Surr7t4KhDn4Oja01KndXe/majm
	qmhelqpfhoqG5fRB327OJ3dVWCw7gtCqQPJQAHsnGb4YBPwrV69WQPBs6FmsnJvRMK1QwfrvPAg
	agQl+g4m8Oj0BHWRlRmIr4xDOl1gcgm9SzxfDLLQ6poQIviTtK1KiN4CbZg49552gZjni995hup
	H9bCKO0sV1QoChIjbPig==
X-Google-Smtp-Source: AGHT+IGE+9/jm5G23eQ878s/TeBOvmaSfFCK0Mu1uJKvaQQ1FxbQENXPeVEI3KqnHDzhauuEFPiSqg==
X-Received: by 2002:a05:600c:8b6c:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-47d7f0929b5mr30830555e9.21.1767699907159;
        Tue, 06 Jan 2026 03:45:07 -0800 (PST)
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
Subject: [PATCH 6.12.y-cip v2 16/24] can: rcar_canfd: Simplify data bit rate config
Date: Tue,  6 Jan 2026 11:44:39 +0000
Message-ID: <20260106114458.122333-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21348

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 33815032b0a66769ca59ccdab07b45fff3bec070 ]

Introduce rcar_canfd_compute_data_bit_rate_cfg() for simplifying data bit
rate configuration by replacing function-like macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250908120940.147196-5-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index d1b7a06a46ed..e781363bcc4e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -169,15 +169,7 @@
 #define RCANFD_CERFL_ERR(x)		((x) & (0x7fff)) /* above bits 14:0 */
 
 /* RSCFDnCFDCmDCFG */
-#define RCANFD_DCFG_DSJW(gpriv, x)	(((x) & ((gpriv)->info->data_bittiming->sjw_max - 1)) << 24)
-
-#define RCANFD_DCFG_DTSEG2(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg2_max - 1)) << (gpriv)->info->sh->dtseg2)
-
-#define RCANFD_DCFG_DTSEG1(gpriv, x) \
-	(((x) & ((gpriv)->info->data_bittiming->tseg1_max - 1)) << (gpriv)->info->sh->dtseg1)
-
-#define RCANFD_DCFG_DBRP(x)		(((x) & 0xff) << 0)
+#define RCANFD_DCFG_DBRP		GENMASK(7, 0)
 
 /* RSCFDnCFDCmFDCFG */
 #define RCANFD_GEN4_FDCFG_CLOE		BIT(30)
@@ -1410,6 +1402,19 @@ static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_chan
 	return (ntseg1 | ntseg2 | nsjw | nbrp);
 }
 
+static inline u32 rcar_canfd_compute_data_bit_rate_cfg(const struct rcar_canfd_hw_info *info,
+						       u16 tseg1, u16 tseg2, u16 sjw, u16 brp)
+{
+	u32 dtseg1, dtseg2, dsjw, dbrp;
+
+	dtseg1 = (tseg1 & (info->data_bittiming->tseg1_max - 1)) << info->sh->dtseg1;
+	dtseg2 = (tseg2 & (info->data_bittiming->tseg2_max - 1)) << info->sh->dtseg2;
+	dsjw = (sjw & (info->data_bittiming->sjw_max - 1)) << 24;
+	dbrp = FIELD_PREP(RCANFD_DCFG_DBRP, brp);
+
+	return (dtseg1 | dtseg2 | dsjw | dbrp);
+}
+
 static void rcar_canfd_set_bittiming(struct net_device *ndev)
 {
 	u32 mask = RCANFD_FDCFG_TDCO | RCANFD_FDCFG_TDCE | RCANFD_FDCFG_TDCOC;
@@ -1439,10 +1444,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	sjw = dbt->sjw - 1;
 	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
 	tseg2 = dbt->phase_seg2 - 1;
-
-	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
-
+	cfg = rcar_canfd_compute_data_bit_rate_cfg(gpriv->info, tseg1, tseg2, sjw, brp);
 	writel(cfg, &gpriv->fcbase[ch].dcfg);
 
 	/* Transceiver Delay Compensation */
-- 
2.43.0


