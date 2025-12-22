Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257B1E6749E
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78279.1766402236316374322
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ApHhj/SW;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso4813683a12.1
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402234; x=1767007034; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHxRGuH6vefqlcP2YD1P1ylQGfbUrsAnWduwg9ctF8E=;
        b=ApHhj/SWpJwFFFMebhwajg7uYcTIyS1pz3fzROv5Y6CAK/6q5DU70B5E1y0w4aJdTj
         qDyr3EyRb/G3ZuQoxFosZLfzYAzZiQMzwZU46pQ2LmwPJejg4FqTagZ8c5H3qlNVoaBE
         0fzk92p+aWKZUblhH0c3MjbOCLFJMd6fKQXQi1iWSXy/mq4NmTzvOV/rluofke4xhwt4
         XOwkUjc0UQJAUUDL9TBVyRMI3aCn34XQBVrtiMuPpo76m2iqbBhUmt24dYvDt2K66C6p
         YlYaBXmMhtcCk7mIY2wPhwTb7cJ2HwXIdxMSriPjEKsFT4AZ3vlGjFaDf6+XgZgNYH0a
         hOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402234; x=1767007034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oHxRGuH6vefqlcP2YD1P1ylQGfbUrsAnWduwg9ctF8E=;
        b=xB6J6XxNvGdPVI1qQHyhsj6ABownImafdcSwHyCIRhLZi6spt2j0kvIt5pR+ixSMSg
         R17GGMIAGTQNIas3yQkf5uUe4MXhs6k73w0PLXANGQDH0mvlY7zmfnrnnAR3CY1MRlPP
         8Z26wYsDa2pdyiFJpf50iVBiDq3pJHWCJGpnTxzhIlmtd+2dZx9jimwrwEli6q2cVlXk
         8LQlVXdXzQYyENziyLvia2MQfHgkgSUrchDhq768J/5x3Lhv7LS8U8HPM37zwtIn42w7
         qC8pDYA2kS8OZLhWFUyy0Qvck6Loz5lt1HIdH0xSjJkbMXWtRA+i5dM+aKoGjnPJtAWP
         U1RA==
X-Gm-Message-State: AOJu0YzHKU+Cp1q9ENa3w5ZXbdndyhE7pXBVAV2ewd3Cmr7gHUb04AvT
	e2nmb1x7Aa23y1fSPO10IgUTBnwkU23OakCdIBoi4lW4zYZL+gRQRhSomJoCFA==
X-Gm-Gg: AY/fxX5gFHbdmXnQOTkFiPjjXC1C/5A/dVh4PXxnvGG/T6QEmmgUp183GGiNdmDmJ37
	LaZMuf/boADXBmni2zV2anABmOtl9/zbCvjciT3KP8nkBg7Qais81QRiHIGe0zcOGdfnK0NYjZA
	Wj6f6ubn6kZK5pOKbxbgwcC5yZIVWuMFr4CGMp5YG6hU2lSp6nXONG4Ytk2G2FEW0OVfZvmDZUC
	RxxWfweqaqWZB+KDMsS3fCKAGnua8HpMzYqAWSEMnohTzq7mwwV/9bdvFX+yHMYQsUxBW5kpc5P
	+itc7F6KxIDUrX/vr5YAfpUL+XgHsqIAXl7ZsYpFavqDeZ9FK0E/aKe+oVhQcqnva5YbpWq8ns9
	tyG+lf7E8DNYTkGTuCMaPjjO7IO4wEL8r4ox1agJpVHsxp8L3D9Rw8ubBGLnRzi62sbVGkp9142
	8+PINL9mFqKhOlZRdW2GbUxFw36VqKajhVaL4gDup1ceYlog==
X-Google-Smtp-Source: AGHT+IF9O5MpKqp43l9PWNrUxkz69/7Isv4MI+3fgFXxUNqzjk/rBxjA4wd4f8Rrp58AZNRms7PGcQ==
X-Received: by 2002:a17:906:6a21:b0:b76:3399:457b with SMTP id a640c23a62f3a-b80371d8c90mr1104311066b.37.1766402234264;
        Mon, 22 Dec 2025 03:17:14 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:14 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/24] can: rcar_canfd: Simplify data bit rate config
Date: Mon, 22 Dec 2025 11:16:48 +0000
Message-ID: <20251222111705.27028-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21202

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
index 1d4dbda4672d..e7f6e6b31ac5 100644
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
@@ -1402,6 +1394,19 @@ static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_chan
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
@@ -1431,10 +1436,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
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


