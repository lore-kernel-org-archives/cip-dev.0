Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD87EF36FC
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:51:22 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9082.1773042681271582873
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 00:51:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WCRrcfGw;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c56e822eso5733641f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 00:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773042679; x=1773647479; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JllUGxkDiz3RL/Gf0aCGP+Y8r5xYGyK7oOGMJ/2lY1E=;
        b=WCRrcfGwydyEJoa8slHgYvBWhDbZ/hifpxur7MF7MGoeWDIWZzjol2bs54eqbn1flh
         oh6ZtaG3vvH65O3QT4ZojkmhCJ2SAeoNVg31O8xggL8dEqC5ruUQDvgYMBqTOV3jxKvk
         tLWvks4Q7TQcz37gE8ULaZh6/4sqN/O+f5vLFSizbKG58IdeINxb0/S5+Q2LstW55gWI
         rGJ3jZkr4kONYA3w7aAzscpKMlm8/1biWUWRsnC4A6rY8MonO3JPx+Gh92xo5wbd+oTD
         wAhpmtocFPfA86jzZIppvf7DeGnnAVzVe+qi2cXugUOIedj5iBxH1KONu0gbB/xJj5Lx
         IKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773042679; x=1773647479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JllUGxkDiz3RL/Gf0aCGP+Y8r5xYGyK7oOGMJ/2lY1E=;
        b=UhFrgOJxEkYfFAcZQjfSs+N0NtX7VbdHiTAwOBebN8TxdfOC3zCUB5+KZ/CElPBKRV
         8K1gcWllPUEIN9NcecI5KEy2vMcjNryB5EnmH6v38+TZuXUJuLpPjS4SuoTE3FDtfBNP
         sNokHklapcZdOjCmsxOVaK3IZFQcAnpNNGgjT/PKN1bKWwTd7PM09LjwlXJhL7Y0ZAz3
         psuHn4Sztttt9kbM75xWP33D7asxQLzKuq4pIh4uuDSZnJqUaTgQrdLkuFJwY1iUypaS
         OSr3KIRACP6nnFzEax2NPoyyHwg7eh2nELdMnR4aCukL0PL9LGL2Ga/Adl//ei2o/Wr7
         tJUQ==
X-Gm-Message-State: AOJu0YxYeqHuY9s7vT68O6v4alhAk3hgUcSO3S13RZDCVN4Q8W1kNYO7
	Uot/UB+6rBRbPNgnsyIPUa7KFW+DkMyHCtdvPvjL0GccNeMV+41ImhRsWBUqpw==
X-Gm-Gg: ATEYQzxrs91c+ItI8bbGPGAuBPDbnGf9a8iA08C+STp+85d32pZhqPYTRosCYZ7951t
	w+wloCVwgR5e5tpCD26x2Ybv3FTBm0lEOOXkKSqlh81CmoXaZxmjcvjPRUnl+yNe5YVAqT2QO4C
	sFlkLcCaVxGaip3e/C0dZOYLRH5qbOi7cNu130O4R0eiIdXunwecTHr8sNkU6cVjzfFtVjZK87F
	7vmmamITvRa5LhuAi2aJcoFQL5Kt2+Omo6N7N8psFBnrpp1glD98UoFCaGrAmcPrwKWCwKx339p
	yMkmUmfC4YA6AoNpJSvi3tAfvEP1I3lnuTRW3o5u5NcAtQNWHqKNczt87BOcrRegFfDLczWoGgD
	qdeqIuo/08UZJpH21IlsYVNHLQ+BQBtmYftFqueIAGehT4Iwz52hu3P8c1HfEEH74Eqvwdrydl3
	RX1P+wQwUd52ex1V8cf+0ZslHyntXlxiuqUkdJXCkEfhf4xTDf
X-Received: by 2002:a05:6000:2388:b0:439:b3d2:3766 with SMTP id ffacd0b85a97d-439da657049mr17911715f8f.19.1773042679119;
        Mon, 09 Mar 2026 00:51:19 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2ba06sm25639376f8f.24.2026.03.09.00.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:51:18 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 6/6] can: rcar_canfd: Add support for FD-Only mode
Date: Mon,  9 Mar 2026 07:51:08 +0000
Message-ID: <20260309075112.35445-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
References: <20260309075112.35445-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:51:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22154

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 9a2b56a48c219d189366dd9bf4c2b42afde2f361 ]

The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode called
FD-only mode. In this mode, communication in Classical CAN frame format is
disabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251126155911.320563-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 68e6c7ac6649..4bfc7b5ac0ae 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -472,6 +472,7 @@ struct rcar_canfd_global {
 	unsigned long channels_mask;	/* Enabled channels mask */
 	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
+	bool fd_only_mode;		/* FD-Only mode for CAN-FD */
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
 	const struct rcar_canfd_hw_info *info;
@@ -829,12 +830,20 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 							 RCANFD_GEN4_FDCFG_FDOE);
 				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 						       RCANFD_GEN4_FDCFG_CLOE);
+			} else if (gpriv->fd_only_mode) {
+				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+							 RCANFD_GEN4_FDCFG_CLOE);
+				rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+						       RCANFD_GEN4_FDCFG_FDOE);
 			} else {
 				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 							 RCANFD_GEN4_FDCFG_FDOE);
 				rcar_canfd_clear_bit_reg(&gpriv->fcbase[ch].cfdcfg,
 							 RCANFD_GEN4_FDCFG_CLOE);
 			}
+		} else if (gpriv->fd_only_mode) {
+			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg,
+					       RCANFD_GEN4_FDCFG_FDOE);
 		}
 	}
 
@@ -2141,6 +2150,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->fdmode = fdmode;
 	gpriv->info = info;
 
+	if (of_property_read_bool(dev->of_node, "renesas,fd-only"))
+		gpriv->fd_only_mode = true; /* FD-Only mode for CAN-FD */
+
 	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(dev, "rstp_n");
 	if (IS_ERR(gpriv->rstc1))
 		return dev_err_probe(dev, PTR_ERR(gpriv->rstc1),
@@ -2240,7 +2252,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
 		 gpriv->extclk ? "ext" : "canfd",
-		 gpriv->fdmode ? "fd" : "classical");
+		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
 	return 0;
 
 fail_channel:
-- 
2.43.0


