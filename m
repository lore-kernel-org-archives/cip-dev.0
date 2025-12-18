Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC12D6E2C8
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1393.1766076966871436489
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SRXDsbZ1;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so540898f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076965; x=1766681765; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8GxbPIFFKge+sJyrt6lwZPLUGgtYDkhcw9uTveirpw=;
        b=SRXDsbZ1mdUTJATZelTHZAFKNtJvB5Y93yL9LIUJwW9FUKP1InyRi94IWuu49ckTE5
         17+bAgaDGUxdhIMzMqMSFjuaMfQed/DwXhRn/IwStw5YhPviyTMKSYY4qwcc2US7gCFX
         KRRexE5Dqu3M/NTy7bjBM6DzJM/bKy3RcAERPQ4mlqnhwXmU24T74f6MLQS2aX4X+iiu
         3S91B0VkSsWfsKjZTQrKnZJPnRhAIPRM2efcHCM1kzKvxc0kOWUdUi0k9Gyz4M/s5RwQ
         pkmbiGK/oqPds66stMCfvliAfHwSajTNoyyKB85djfl0SdfoCCfGtz9ue5ZvNnQqtBUh
         u55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076965; x=1766681765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8GxbPIFFKge+sJyrt6lwZPLUGgtYDkhcw9uTveirpw=;
        b=w1kaerrbAymjsgB+yU6KYMmMMVH0MtRipjIYomgoW5Tp9++2wdBhwg6nu9wlgFTWqr
         Aw9JNwlsG42crRVDkQENJ1DJxelu/uP344H+qeODsHYGrUUwwYO5a2fi1DngvoaywBt7
         2CIRLmhgaU1E73sQ8dy+p8K101BkzywcYE0KS6v0oCxeFT1F1LTjrKpQH76pSYzbPiHY
         G1n78q0qlBS3Gf56CT1POIZ32vzLE/jW1J/kjguR2vcwn4YTM1QeWpk8sP0F1Qlq6Fwg
         SxnHdhhvm1cu4MJicLXXzYl6eMHAl3gBmHCdAgusDjKsfKfPXt3LkTBxfDLa+czqd6K5
         LvMQ==
X-Gm-Message-State: AOJu0YzyFzbpdETOemgVSIhVbfTGiocfiYpXsAPPbAS2/pB7MTFw5xmZ
	rhYRa0qFYzH3SK1sr02f66LEiBkQCBtR1XmWJCkjjB4fUF34u1B0QJCS/V6Z/g==
X-Gm-Gg: AY/fxX7++ONng9z3zISkiJeBJYkZTwHD0knLUb5JkubZvYQ1UBKD5C0pRmDAwoFx4cr
	BUj+jMrYU/B3J1wXycprKg4p36JJjPDmdP7EsD4FCZblrHAk5fZGnwEUsDmbgTgsx7by+udajbb
	tFBe5Req8o3FW/gHXwSOJbv87fJp1r9QzKKoHrZAE1S4nhfY80tAMlvfkjEybdpZyHUfM1z7Fxu
	keHuxyVHA+CODYkhVjPtrLKQP81uTgN10EdBJpPrOPd7+UOI/EqnZVG459vy9MZItDkTxeos6Qi
	Dyn6uJHBeXzSU6GYZvpU6v1Qa4xR0cYqZuXrFWBeBT+XmL0+IEQTZQmGilGPG+p3wnpt6syCauA
	UfABSj/ZOoaN8DiIyv5T8NrtNQKHP4YmnBLRL/A+0GcQK+76G8FCnY9mXWSqZ2xT5yzqaGLqhdu
	sjTIJD9dNqswA9qVdBQg==
X-Google-Smtp-Source: AGHT+IETyNJKF6yfLnI96ANiDxp8NgCqxjmi/ZXepSnbpvZmqdQeGliCztT2lZRt7g7+3zVQUUFxIg==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr170065f8f.8.1766076964964;
        Thu, 18 Dec 2025 08:56:04 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:04 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/24] can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not FD
Date: Thu, 18 Dec 2025 16:55:08 +0000
Message-ID: <20251218165600.258194-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21147

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
index 1543952014d4..58d3a1ee551e 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1486,18 +1486,19 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 
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


