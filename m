Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B2CD6E2B8
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1387.1766076963640687334
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DijRmD/X;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477632d9326so5670075e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076962; x=1766681762; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIT4ga7i2fDrGGBlqajuane7aw5kQH1VsoRS88Me55M=;
        b=DijRmD/XvJk+Hkfh1EpUnMrrClllVx5PmcRbVUwcmpqlfWMlX0yVeXsSLGovCaHRS0
         6iWqeae06YQly1JIRaTYm0HDyeeepoVE4nfE5VMwwKDADisHTe+xItglvpa5TfhE016y
         lEDrSN+WKqvasSM4sLeR5NGPt+jo5U8PjiLbl/dwyfay5uqcE9QNTcn5AiRBFu7jui9r
         cYR2iVd58YwYPt/E5gOOs9PtaegguvlLWhaNKKyuwQKW/pourHzvsDTWDZmAxCMoFY9V
         d0y3bDbuCEyBbLsLQ5E79Y4HqpezOl6+aD1gKFoa97Ol59TNci2wEl+IFWrpONxxbwh7
         RtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076962; x=1766681762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIT4ga7i2fDrGGBlqajuane7aw5kQH1VsoRS88Me55M=;
        b=JypNBpOJgkBOnlDaJGQ1BSPXedtCZ9A+N/n2a1v1tgCkiGtnUc+HGBF3Mvj8Yndk09
         4mPz7Q5Htqg2Xxj4g39CdbDh+4A2jN/FlPrkkH/qx0MpvkHFosWxh/aKrpQrVVl7Dc5a
         La0RlpVivZzIfcIaph97fYnFjCDYcV+lfQPq9E493jlJ42DCn47c1uGYTwIF3Qpk5PPl
         r0usav9uhesXqFk8NMgildbDtVNYYR07JxJaOvog2f5B5JzTRWGCOlchs95daM7iFFWo
         30PMQ8IsJjH/mPqYYA41XEF3evIoX/5evDwBJGRq2DVdbD3DERaJ6rWglCbaU9W+9and
         BNJQ==
X-Gm-Message-State: AOJu0YzrZaWrKq0+SzIUloFNGAk9nSAz7864EzQz6+jOla+lQx+Kon5L
	GJ5E6hvELo2LWVNJ8DaSihsRJDYhJqoSA4liLiLFnnHl0x9nkm1NyD6smVzPCQ==
X-Gm-Gg: AY/fxX4Gao6Jazk6S50HVLNdJVAi5on0wwo7QPLcN4CQMKMFUkX0FOJEp8niVoZVK+N
	+BmxUQRhrrESC+6KnueBpsS/Xb8A3OmiVFJVSCFyF4l6UldAwaOeNtJyH65oJ65ZOgD7EfAEHSH
	FoCS4AkPqqedGFonoDL7YeRmjpzPC/Zs+x4GtZcFf3X+REmd6zvgeDUXqmqnn5da77Y3M6oaNmT
	kmG23aEjGf+4IL0JiqG4BMQUH5cTTqrhMG4/RLqQF7IymDmxnnYv8f4lYe7nErRwvGNVDx1q1vp
	h28lwOuF4NDcrn/K7sqbwoQX7pGLxZMIX8uhz/wPCpexkhYU9vsSRqXdl2KhFQQWJZr6Xg2MvHU
	Fm1qoJqyTY7RaIiE1q+u7l0n0kc3QxqM1kMuvQ4/sZfre1x1SGxPKlqhvQc3brnwdd0J4M7lflf
	CUSxDpQWDGw+tesCVX06r8i5mc0h7N
X-Google-Smtp-Source: AGHT+IEj9YCJtUtPQcMvtDv19rTihfsB205EfseD8tizIr+WTgqdBKebsdP0Sl8n5Pwt45UdIzviRQ==
X-Received: by 2002:a05:600c:1909:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-47a8f89b626mr237473025e9.6.1766076961629;
        Thu, 18 Dec 2025 08:56:01 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:01 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 02/24] can: rcar_canfd: Remove bittiming debug prints
Date: Thu, 18 Dec 2025 16:55:01 +0000
Message-ID: <20251218165600.258194-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21140

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit a627813431600c5582e59022659f11790f94a25c ]

There is no need to have debug code to print the bittiming values, as
the user can get all values through the netlink interface.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/a8b9f2c8938dc5e63b8faf1d0cdc91dadc12117e.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e0d3031e4b4d..282187d5387c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1460,8 +1460,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-		netdev_dbg(priv->ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
@@ -1473,8 +1471,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
-		netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	} else {
 		/* Classical CAN only mode */
 		if (gpriv->info->shared_can_regs) {
@@ -1490,9 +1486,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		}
 
 		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-		netdev_dbg(priv->ndev,
-			   "rate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	}
 }
 
-- 
2.43.0


