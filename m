Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE309E67499
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:20 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78203.1766402238913194010
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FxZu0X3p;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b736d883ac4so687548266b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402237; x=1767007037; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab5spm0jeKsHYpreS7uO+ZHgExHJ82DUIPD7a7zcq5k=;
        b=FxZu0X3pHPVf664l70YYqekoaFkYgJSfuEKWJjiPoDBxw3O3yXRpbUnAmsq75QexJU
         QT3k9LDKCvaOsuipadHQ4D3LQbPwoZI9IPSTPkeIueItDd8RM1WmSc9is5bmeRo5PsqC
         CfktGqINCjtQgFLYuqBkMBleW1foypjg0iHYLH3jPiEt68krimfiCexc4Chhh+en3ftk
         SKoeDfPSrBEKn5e8+C1WzcJPvEKfRqzoCL1Y1yqfrq7HE1x2gSilvha2G6CnZO7aNCBy
         0v6vhos7LfBRdFvI+fj8XgbosTZQyEJ1DeFOYtaBeS/hdkaGs4O+mZO++ZoYvw7KtVar
         a+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402237; x=1767007037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ab5spm0jeKsHYpreS7uO+ZHgExHJ82DUIPD7a7zcq5k=;
        b=smV5zFcYE/8sIK3pjiJRSv+tjAv1nd19cHuklUq7kPNcD2iJqk2Rhuhq8OtVeOh1Z8
         8HQwh4FMrjcbMAWJmdv0izJWBduAuPIohwo9k17L/pi5alNr11cP8noClcV+KJPbVtam
         Y+Y9Rf8NbcWBlWqFJsllSwI9q3c/2XtA2j7bE4Lsfa0FpOvBlLiL6UrPRg4Gc9gd/L1w
         njiK1rKaVxHqT2fMlpITMQ70+KtDyMmJlvXYraNAXIDFf/dcqqwRUdS/LAEMBWQEhHLv
         3fV0aFM3p/tfm1Zo7nwy2PiiRzrFKXiLmdOqwd+tkXMO496Q6PLi5sgtJ7rBerSlIi1n
         oGcA==
X-Gm-Message-State: AOJu0YzYioi41seyrvKquTAh14GDpuZ/aPqC6Mxo03yBxCFfWsIKcqPD
	+kO+0VIdJFat0pCyqRHZwRUikSXI689ab2JUj5f8qZxBo2wtNBKQm0POyYgN7g==
X-Gm-Gg: AY/fxX47Sd0oH+oJZEg+UjVaxAVXf3b7dDdaW41ti1wCKL8blzmJlp6ptssEYpK4yAq
	6/VgjVUp/fWhgTBFaHzPK9Pwy1NkVcWXgqHezuGgU2EYdSm0WmG4ICGXYqqcHSw67HADBR26xaQ
	ZXw12EV9UOGw1Y0kAkGNzzRUHtH/NbLpAJuHAx4SCXgQ2yJxMOmCzlE9zDk0eB4A2lqtu200S/w
	HajoAmTDgzzudcavoIyGymPiXGstuEXmZP1Hy2wW1aCNIXu4YuCZ5jOaMz9P/8c38Sm78l+gIhz
	cLaVpS5UqT+yO0mWSNwf9M8Rf1BaFHuQFo8+8jyZRnOduUBOFzDmFlZDiFlVC4BSRY4Jzl9h37T
	HtI5EuPpySZV9KJCxHMfyIE4sU7P8YtdnyTm8+t3WfKiI1kZ6DXr8J0uYC+TYyv54h50B3t2EK4
	bKkzphJZu6vJ5QEnnSWYa/PypgeD88TRi19kU=
X-Google-Smtp-Source: AGHT+IH8fwjZBskBLsM6wl0NM7/SEFK/H4cx/l0barUNh4dBGPJ6oJyZFJSE9I3Rw/RXXqHdroVBQQ==
X-Received: by 2002:a17:907:7e83:b0:b73:7b97:5bfb with SMTP id a640c23a62f3a-b803717d9e7mr985565866b.33.1766402236919;
        Mon, 22 Dec 2025 03:17:16 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:16 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 21/24] can: rcar_canfd: Invert CAN clock and close_candev() order
Date: Mon, 22 Dec 2025 11:16:53 +0000
Message-ID: <20251222111705.27028-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21207

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
index 06806bd7e7ea..3b06145e0057 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1570,8 +1570,8 @@ static int rcar_canfd_close(struct net_device *ndev)
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


