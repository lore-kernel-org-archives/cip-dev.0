Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D980C47BFC
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88212.1767699905219901460
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dy6oGE1K;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so7306945e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699903; x=1768304703; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onFEcyP8+N8HP3XCVMuLIs6Opk/yTGFLcJlecqmdl4Y=;
        b=dy6oGE1KcxxMwm0X2FbSV0FtQLtJ5kfqo9MFkg6gbnLiZbIveRra1KAq2C4khsPe3F
         paNKrCzyOMg84q15CltkcYTeLzCvlxPcew9swohK/eK2QlTlYdLlIkMWYU5b/WZFrr26
         5T08nzILffo7ghHwCky5X+jg9tFT+5tBtko7AdHH8sHGnyTq08wK9g1oMdDJO7HhUuuS
         Mnj7XRfGxn7KE+r1S5ss6ajZFMEZvEEr92L3DzujkqhfA8/RJZhXhQovtbOFc8Pyxn/N
         4XJaW9Y4E8xB/UTrpLn1CuriNsYm5Gfj3lucX7FSFBLdxRP63NGvNJ9nCnvSUN9lXI//
         Io8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699903; x=1768304703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onFEcyP8+N8HP3XCVMuLIs6Opk/yTGFLcJlecqmdl4Y=;
        b=v1mAHESniekZsRat4qB0ukBNCqruTQIzudhdRqo6Yf8pRZ8YGxyR8LxFF/1CDELSYu
         f348arwBpsfPkTUdYMwT9QBiigdYi/krtyUwd3RnLm0K7/IlK0AyZliMfa/PG/fThsMR
         CLBYan5WlCC+7E3rCB+MZRgfeXsiVvoYgEzOwB91WbHcfG+q7IQYPx4IkWR2c2Z3m+Fc
         g61ZSJY+g+vRp10CmXSvldtxwQe7KD0rgYGUxjhDNUgtV20mtggc54U9sjFvE+J/qlmc
         OQRwe033baC/H/3KICQ51aOwWXCU7pYVNXH8Ccut4DLJAtRKE8mId60Bj8MC4omzCEtw
         gaWQ==
X-Gm-Message-State: AOJu0Yxqw77PhjNv+IykevvMrPWLVgP7S2rjiE1KcYoJgH7R02h6GnKJ
	s64ExETG6xDsTta2G29HE3+GXxHj/PNbaKJYn7CXfJFBr722uttR2nCtBhVqtA==
X-Gm-Gg: AY/fxX4UNBQqOD+b0LYPSBxR8rM40HgtEJfAzt/fJFWbGIR4LEh9jb8smAByitcjUxq
	JAMGggKyFfiKe+EXOEjpbygHsf3y3E7aPVRccgQ7JwLV826dxSLlJZFy7eaj5qmT8zWqYFugXsg
	3FUTaBu7xmDocw+G2I2Jy5RSOldt8cfimCD3O/n1w9MOmTlQt8h+a/pT9Dgh9TanTioi6s9Ljot
	KkumHDVRX0ihJ7zGsKBRuGtPvG0TBM5VplcuCx+nuLXdl1pA4jRmskAMH9l5rU3/o645aRaKAOC
	SWismYiaRvgGXXzwP2KXOp3vr5dygdQ4vt4vPwgeSNbxWPz996py+QDeuz+tjehbIHHScDkr4NY
	P7nlS07zLul4IOLrfScGuI476x/YbGLfBRWd2/eV2VpO0o28Lp6+qlPzbO8rODXPZGnXszbHKU4
	EMWttX69HpqQ5SkINvWg==
X-Google-Smtp-Source: AGHT+IFOIyllXSOKB39A8jFU24vEaIJF0F9YLok6B5b438mftZSOu5gzAmrxTRN27mRhtBwhyCozzw==
X-Received: by 2002:a05:600c:1f8b:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-47d7f098aabmr28930735e9.19.1767699903298;
        Tue, 06 Jan 2026 03:45:03 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:02 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 08/24] can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
Date: Tue,  6 Jan 2026 11:44:31 +0000
Message-ID: <20260106114458.122333-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21340

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0a0c94c682fd2606b65a512ba24478a3b5e73d7d ]

The configuration register format for nominal bit timings in CAN-FD mode
and the format for bit timings in CAN mode on CAN-FD controllers with
shared Classical CAN registers are the same.

Restructure the code to make this clear, also reducing kernel size by 80
bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/b7643a3c49777989d02145a85b85cf773ec2123f.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 2f84393d95c1..c7306c93d16b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1482,13 +1482,17 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	tseg1 = bt->prop_seg + bt->phase_seg1 - 1;
 	tseg2 = bt->phase_seg2 - 1;
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* CAN FD only mode */
+	if ((priv->can.ctrlmode & CAN_CTRLMODE_FD) || gpriv->info->shared_can_regs) {
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
+	} else {
+		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
+		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+	}
 
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
+	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
 		sjw = dbt->sjw - 1;
@@ -1499,21 +1503,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	} else {
-		/* Classical CAN only mode */
-		if (gpriv->info->shared_can_regs) {
-			cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) |
-			       RCANFD_NCFG_NBRP(brp) |
-			       RCANFD_NCFG_NSJW(gpriv, sjw) |
-			       RCANFD_NCFG_NTSEG2(gpriv, tseg2));
-		} else {
-			cfg = (RCANFD_CFG_TSEG1(tseg1) |
-			       RCANFD_CFG_BRP(brp) |
-			       RCANFD_CFG_SJW(sjw) |
-			       RCANFD_CFG_TSEG2(tseg2));
-		}
-
-		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 	}
 }
 
-- 
2.43.0


