Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE06CCDC164
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88209.1767699902349445610
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q8GR8RAc;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so7194305e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699900; x=1768304700; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39hAjG6tj6MZcrN5t0o8MWb+YCruGvcngWa2/v0yUE4=;
        b=Q8GR8RAcVb4dwf03mi+19aYjPLdT+rVkfMYv2ZiWwydqerpVC0rKybt5+guHkGZ9d0
         VIrfT/laKZYqzQ/mtbW5+S4MXPYHshp+uKTmlYoiSy6VLPnvjaVXY90FlNn9sNrjWLLP
         SBGT61A01Qt2wu428CrR5MDBMGmvTCWkELTDdmJ5ZZxnlP6VJ8Cqza7wv4F3R7w26OX4
         4qaxXoMbRXxQdqz34vutJoyVdYTA/htzIGKqiGie/JZKR+53pcsx1oRO54judnUOPb4r
         oHMDSIp9YZLItQMrhWCEQQBThdCPHft1eaU6JF1kIabldaG/gjlRlY3i1EAcWHi0pST6
         C/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699900; x=1768304700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=39hAjG6tj6MZcrN5t0o8MWb+YCruGvcngWa2/v0yUE4=;
        b=JA36pcmw4nLJAHBusYSgBbJPFdY+j5xOwv6DxSXsPkJvWnRtMCUD9U85tUHj3tS2qK
         8FbkOPHPySztsOcpBr9Cy8whklf8DCUz+Pu6oMgvw/0A9qzugvXYo+0RvqULYEqzEmBR
         O4tlK9Atjfl+UacqGHqnlI0O29NYthZaSjo0HKrSN8xrhH/dWeMSkIXxdHxIzHqb1Std
         KtZpIsCDuqZG+tcSliM2CQA5ISllGmusOHOp+CQ1qFflajiu6lXQ1xzPERX/R8NcZl2y
         OqxQ78EUivV/+ZH7iTG2+JjdFXhMdGE/cCZFHRW3K1pcE+RGjpsytdygE435RxsZLEts
         eVUA==
X-Gm-Message-State: AOJu0YxY1qNoF5OGSB1tV9+6uqahziGrCvsO5PKiFx2IfQK+Odr6sAoL
	x/oUWIgVXnWCVQbHVVeie3cOCGANJv1gaDvOLiq1kQL2833LyiKejYBv7GMiQw==
X-Gm-Gg: AY/fxX6u9WXXd9crBSalDKFhOrb+h44K0Qgy17VlJXZPqXvJpMOzJpJyW1PqRy2fCcl
	m80axqAmjyiDNk9KrxOdiKbxyHI/BlGkLzyC8yN2D0lmHw7AWGj789GWhatQUzLiIOWxE788oXP
	vdeADRtO7iHE5XsF9zJB4q9Pd53WZBfzzgLl/2uYWfkvkD2gFRdrfp4/326/UaWUhCkzU9+0a9E
	6vC/Q49edgDXd8RDKhPlWmz6np6/N7Wa3vgmwi1Kbhffbgt7dtsKn9pQC31PDEiyzwDIqN0+wLE
	aM5lZoG8lxtPIrHK9dvBlMf7OZXSbu88QUFnw+XDkvS1p9gxrw9JzyFral1XTmvT65oz1DPzl6s
	6OcW6U0sD1FzNdi2oBdp25jk0LM1fixdB7S8C7mrLZsafZKckQpvmtjmysnuSyzZCMCTqEV6sBV
	D0MS80v2fecLsRCEiU+Q==
X-Google-Smtp-Source: AGHT+IHyZkD7zcw8PwNZqiADCazfQApSPD1eoPQiPvM8BQulHnTX8l2XXnPuhwvfISj0QrpI5TAXwQ==
X-Received: by 2002:a05:600c:5306:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-47d7f067283mr28124995e9.4.1767699900353;
        Tue, 06 Jan 2026 03:45:00 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:00 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 02/24] can: rcar_canfd: Remove bittiming debug prints
Date: Tue,  6 Jan 2026 11:44:25 +0000
Message-ID: <20260106114458.122333-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21334

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
index 423343671bb4..fe72f7680fbd 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1466,8 +1466,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-		netdev_dbg(priv->ndev, "nrate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 
 		/* Data bit timing settings */
 		brp = dbt->brp - 1;
@@ -1479,8 +1477,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
 		rcar_canfd_write(priv->base, RCANFD_F_DCFG(gpriv, ch), cfg);
-		netdev_dbg(priv->ndev, "drate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	} else {
 		/* Classical CAN only mode */
 		if (gpriv->info->shared_can_regs) {
@@ -1496,9 +1492,6 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		}
 
 		rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-		netdev_dbg(priv->ndev,
-			   "rate: brp %u, sjw %u, tseg1 %u, tseg2 %u\n",
-			   brp, sjw, tseg1, tseg2);
 	}
 }
 
-- 
2.43.0


