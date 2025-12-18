Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3636D6E2D8
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1397.1766076970326186738
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gSAiGlv5;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so540934f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076968; x=1766681768; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkl+07wkdvmXUmZtnFbxx/TnPbROwcqeqKH9hl8Myjc=;
        b=gSAiGlv5Sf/+7r8ixvMhb+vcqa7DFXg10fbdDdbLE6fAE3mfQS3fai3lpcUH2FdEPT
         tODLaEq4hZkdwrAnvtGsJUB5NsatOnMDGB5qseCd29n/GG4WaWa8zluVWLE5/vAMgLxs
         pLwQfH4WPyKW59KYAtmE5lWT7X4UdAVLRnzQEYhCAbG7gmRIbn/SwJ2kAg1atpcrDCuu
         QW1aY7GOdwtRzta0X5A2qcRjzZmnFgdgGWSwAUxIYafrEXKOtsHDJf8+RYTsWjeLBqsz
         Uez51zXV+lG8m7xcegLSomfFOL5sUlCzgbXlaD706Q1So6R6fUSU9HrGsVIhT/cDvv+7
         mFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076968; x=1766681768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lkl+07wkdvmXUmZtnFbxx/TnPbROwcqeqKH9hl8Myjc=;
        b=BgEVyX/RAttGCj4q7R+zAFyx2F7c+fMjTvXcAaPWwISLpJIULfH9T7rTrL2shgnzNY
         KXCE0BDkxmF6MOvuFrfs0Dv/spCmmVuLG+gnNpJkKgWK/++OcneKWJtaFehi/0bF53y1
         wSk9D/7AIerowfJoeKUZ2bjnfwYpfOE7ZK71rgbBqRfYK+N4e1qFDaJXhf97031ESC/y
         6bofJQzIbfLnBnIvyPHig2rXJsQT8hh4TvLSVtiPD33rl2JlXjhx3Dpsrhh/trz8xRir
         PA/w83D09eR1xed4UxlEgbhFUTc8Sla1Q0I2OTuCFfdZuaCZf7EpI5ohNe6JxVzqgIUh
         wpGg==
X-Gm-Message-State: AOJu0Yw8Q3ncjb9brntlVhsMK9JNPMbj+9tyTi7WH203GMzTHCJnRZKz
	hKODGdIq/WiXgDsz/+4R+AZli+I7puZY3BjZllDjLdGwkvsi/viqUYE70Xo+dg==
X-Gm-Gg: AY/fxX6xU3ZI5/txp+fNaGFMKi0h/z/tAF164q9iqUJzH59bOuZRxcce93H1jCrvIIy
	w8dGCuC3c1on4XlFLy7r3AiE91uM72VTZlYXj1G9Kl7rNyWXm2EO1WQpFARQPnB7s+Li8jPoBtX
	u1hDAnfx3I8tCi2w7Itg60o3rpVh/I5jQKQ56ygbUuEfvHdCa5DF3l0mdrOFRhNUvHYYVJu0J0C
	ekKLsmE7vlWN4D0naKvgGKYZ5nxORUxCinIJTm3mPIbHzQ3EZeQlCXI/wN+1xcdBhReMv9V7cSr
	MG1E6TaK5nXdNt2qRR+HNZDvg+jh8ViBR8TRbKYfGAweX2U0OG42qmmAiXkeIE0yXQ4aoo/jJdy
	5K1xaGOACFPsPMsxUJSVDc0wwGXbtSwz6YZtA2HZEF0srBro0o+w6mgBSBed9vGRyYWCj3iV+A/
	oK0IxsizfjtuWg2chAmw==
X-Google-Smtp-Source: AGHT+IHctRnRZnDwlLQv3BmZAgGmJZLdrEIp190I7eJuFh1yNOUTkgarj9rJTPIU+lX8rZuuLjmnvg==
X-Received: by 2002:a05:6000:220b:b0:431:701:4a1a with SMTP id ffacd0b85a97d-4324e4d0f68mr203769f8f.26.1766076968357;
        Thu, 18 Dec 2025 08:56:08 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:08 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 16/24] can: rcar_canfd: Simplify data bit rate config
Date: Thu, 18 Dec 2025 16:55:15 +0000
Message-ID: <20251218165600.258194-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21153

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
index 38f679cc35ec..6bf217dea628 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -170,15 +170,7 @@
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
@@ -1403,6 +1395,19 @@ static inline u32 rcar_canfd_compute_nominal_bit_rate_cfg(struct rcar_canfd_chan
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
@@ -1432,10 +1437,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
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


