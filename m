Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC220D6E2CD
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1418.1766076972929788372
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GA1O4iKo;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fb2314f52so527366f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076971; x=1766681771; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lEtBSCZDcx5QCbThpVO+h7D8IVxPTd8/qBbQc0ejPw=;
        b=GA1O4iKofK7zlOvdapcJRx2+oOw1pFAQSX6wpiNr8B2HANcIJdgIQ8Nfolt19nTPGD
         QBVrmgnqAC6bsD1y0RkS2JogmAcvWZIfyh287H58mWTNx8q5DJkHgs59R0aGEoFeTrcy
         KUg2qy3AFgrkbhGcb9JJ8lGTB/3njZE2wztSrxRvSzUkdu3Iwf3+ragH2v4yZq84rTyz
         UbdGoVAaPsPLXSHlQm2IsB9qkK2+mKyDZVS/5NmDYJTRaqWQB2xjkEwuUe8lqttHJBS0
         xNHZLpiBZikXRBPpXdBjEDkXFBzxITF5gqA4MmA2hXcxPZQyiux4jReWQklzf2x7x2Bk
         MHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076971; x=1766681771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lEtBSCZDcx5QCbThpVO+h7D8IVxPTd8/qBbQc0ejPw=;
        b=wcK44kpm8dV6EIV2JY9Xkfx9yCt1B6H7cqSTB3kFVe49CzBUtA98xU+/xrKXemTTik
         IvgpajplGZvrHhZTkUOYp3yUitjAWh0b/HXBjgARaNbaeq04uV0XYSBw0oGOyjIgXQ2S
         uBUYbk+7mhgSqPbEhkBX5EhN0AAPjm4QuWx0w2zBGaJXn/d33RnqjB7E/hOs83IPIOkN
         bVis1O2TxTnSc84UgOLCBp9kPz+MnkWO0kuLMt3w1MskcQVtAuAxXLALCO57adrmX747
         ut6c+7HfM9RUMk0h4Gc2VQtrOyXUQ275y2aKE5T723KJmRDPP+2g833JSnZ0D+I5Nfyt
         pqVQ==
X-Gm-Message-State: AOJu0YwtoMeLNmyRTgIo4YKz2mQNYYJ6dYRzHG1XpTt83K/Lko2dNJty
	X74OOiJQlBT48MT47KOjHmYhsm8gaM7h3OgAyb96+Hyk+jHf3OGtri4a87+KIA==
X-Gm-Gg: AY/fxX4r78Sxf0a2ECsvSPwmiYi3MIC/bFWhZ1BcER33IPOIUi3xuf4pDA9d+DxB/ay
	3x7Dd4/7vprGePoz0mpMPQvPvsb6NwTVyug6ybxo8wQMweoppjVXXOPnbyVyCW5HDKCQsfWyeZE
	Idsu13Bw8QtySDOmWsFrM2bnDyUj+bvuHN7tGZQf9Q3XGheDJWiyo/mwDdkv5H72sPvZAORtQF3
	bajxoZGzaCAzsrayT4C+80kJnSWmMCnIp/mkT9Wr4hy7gIMDXh6Oqfw6CDLHN5+N4HWFjF+Pa3r
	6LF1ZC7LhhAzhYLURUFLqnxeE4lSIGgmaUAh3wldgLtXd7hUDac4z+hVjVnE9Mvsw3k3uf3dzZK
	VTQeSbJpWg6rC+g0sYQx0Ht7ZCS73mgd5Tt11LEwEgzkEzEAGUkCYES+BY3y4xW0NqaWabPGnru
	NoEsjke4Ne5yPb9vNouA==
X-Google-Smtp-Source: AGHT+IHKe8VgEtykRp0rdLy1yAufnCo84FH6YqCrlot31CtN1La+aZFzv9aFZ72tpQS4l5X6D3l8tA==
X-Received: by 2002:a05:6000:2305:b0:430:f68f:ee82 with SMTP id ffacd0b85a97d-4324e709bf7mr188594f8f.54.1766076970989;
        Thu, 18 Dec 2025 08:56:10 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:10 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 21/24] can: rcar_canfd: Invert CAN clock and close_candev() order
Date: Thu, 18 Dec 2025 16:55:20 +0000
Message-ID: <20251218165600.258194-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21159

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit ddf9bbf22b70d6b1a10e7d45de8ec3b94de7c54c ]

The CAN clock is enabled before calling open_candev(), and disabled
before calling close_candev().  Invert the order of the latter, to
restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-6-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a3d1f6a2940d..9f47367c155b 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1571,8 +1571,8 @@ static int rcar_canfd_close(struct net_device *ndev)
 	netif_stop_queue(ndev);
 	rcar_canfd_stop(ndev);
 	napi_disable(&priv->napi);
-	clk_disable_unprepare(gpriv->can_clk);
 	close_candev(ndev);
+	clk_disable_unprepare(gpriv->can_clk);
 	phy_power_off(priv->transceiver);
 	return 0;
 }
-- 
2.43.0


