Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7562BC47BFD
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88213.1767699905745627426
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WmsCb3YW;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47aa03d3326so7349115e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699904; x=1768304704; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjSwHtZOrTqObKJl94JgpM/tpYxGyQDTgpnldA6tqbU=;
        b=WmsCb3YWqeIkq6Zft1xn/Xv5hn5Mns5qdIrnO5DCm//AIZDpxcoiPG7no1BgEnmZ3Y
         e39/8NPJM4cGQ8lbb9jqrExWU7kGxI48GNsdW8Rbgp1qfdTNQeP3ASeotPVRGPZSmFiJ
         4bhvkEujmTjP3dkYH+rfGIyIcCd1QT6cy0WQhEvQC7E0yx+SBMYAIS6f1/YwmJRp/SHX
         2LwTSC0OS3U+hwFKT3xr2VU0zsBPyFlgWg+Kqm09v1UU5ylB6svJyfumRoBAdzrq8V7a
         VCk7E27nO0vNZH6IVySF1Vyf4lgJGUrmA5DAWu1e47GVHLPeWxsqSraZDv8Q1cfGGy/I
         wTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699904; x=1768304704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjSwHtZOrTqObKJl94JgpM/tpYxGyQDTgpnldA6tqbU=;
        b=l8aymWmF+x+ZMfwKhbUnRo+fnBoCTUk2AI9gJvrhGaOL46d4n8PS/2lLof8n6kfDxd
         fV94Sj1LCOFqnaOK4AewNw08lYy5oio+aMq2iaE9gcolOS0UhqU4/IAKvWrwwv4yJMjn
         Ps+sXyQFTJ88lVqYdtqgIkaiAcTP4xQFELtq7t3UpX1KUuB6D4c7eVM1axll45bizlo6
         kTd01kNCH6jgev123156UeHm/nKH10MNcIx+C88b01Ulb1VLIu/HOzbYG1y5RaTxq+Gh
         OpiFfKEvG+fhM0XgM6H0SUDhNyXOI4zcmAgLqJ2URDB+AIpNWqo/Ng093TAwLrb1Sl5A
         /qyw==
X-Gm-Message-State: AOJu0YxWcq/m4Dbo/1PCMj0rgvrlhbnWGYmsoZz1JKjSAVfSUCEereae
	VllKXt6pXF0MakYWD1qSE8ttxCLSBUhuPAxw7IZi3Q1fhu+gs4W8aSURpLRFZQ==
X-Gm-Gg: AY/fxX6Yl5o9htARFWMvGwpTpChUXtkpvKcRChqAFgsAy2l7A6jQ9c71Usryn5KJGAH
	ZCaamb58TeGglrJMxIGqn6aLS1sYnIOl/KWWq+mJb1OufhgECm6YJFYy4HjOwBu/V/LB9qfumPb
	fHVPjwgVep/9MB4buwvnoe1AHMJl3GdItDUGK/m7dVi1VMQPX2OHmX58Ao7onQ2acch+AM3Rr/W
	o4gOSAWJjYWCPud8ZQPwvIBnXGmby2wtVJ6TLn+ZSdjiCc1bm+ZaSewSeE1akNcRwTxcd3i/DXS
	dlKOAk1xKQvCrZhxzmouAGQyh1N13lX3FEHhjEL6m/fge+wuSxX45E/L1hF4m8qc1HwKJ9Hrmv5
	mLP2F+8UtcDQQufBeoIn4e9g68w/ATwmG/mqpdHXjl1KGUc20L89dPp8CImBaKSgMgd0sPtL3Za
	p6bIgIAhU2rqp9XpgkJkwvz4Yw8myw
X-Google-Smtp-Source: AGHT+IG2erjIJDFS5NNW9gO8+efRkt+Hou3ZZy9JCAb2ypRj6yjwcAeEzrdd8qAVC9RGujU+jxWshQ==
X-Received: by 2002:a05:600c:8b72:b0:475:e007:baf1 with SMTP id 5b1f17b1804b1-47d7f0a3af9mr28655355e9.34.1767699903873;
        Tue, 06 Jan 2026 03:45:03 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:03 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 09/24] can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not FD
Date: Tue,  6 Jan 2026 11:44:32 +0000
Message-ID: <20260106114458.122333-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21341

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 0acd46190ea2157a175b4b2b8e764843e2c93b66 ]

Return early after completing all setup for non-FD mode in
rcar_canfd_set_bittiming(), to prepare for the advent of more FD-only
setup.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/35fcdcad026cfdd0fd361637f065842d99a6c19d.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c7306c93d16b..f567ed7fa8e7 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1492,18 +1492,19 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		/* Data bit timing settings */
-		brp = dbt->brp - 1;
-		sjw = dbt->sjw - 1;
-		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
-		tseg2 = dbt->phase_seg2 - 1;
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD))
+		return;
 
-		cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
-		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+	/* Data bit timing settings */
+	brp = dbt->brp - 1;
+	sjw = dbt->sjw - 1;
+	tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
+	tseg2 = dbt->phase_seg2 - 1;
 
-		rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
-	}
+	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
+	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
+
+	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
-- 
2.43.0


