Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E38E67498
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:20 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78204.1766402239314083016
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OoL7f+Nt;
 spf=pass (domain: gmail.com, ip: 209.85.218.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8010b8f078so431625166b.0
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402237; x=1767007037; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ab6JOzuLwlwcJP0zDmDJjf1ALA4R5CWtA/kSD2JFIw=;
        b=OoL7f+Nt+Rwe62VdndpFEsojUPOrFXVI6g1jLrFPagJSV/RKXzrW0Re6e5hW0UhXKi
         mDu1Ki1CzXaN4p4mpBC1xdUhRkKgLRbePH3S+tgokzcuEdV2L9wqqCXKlLE2lS3ve7zy
         V9cpf5CNkz5ZuozrpGHD3KdvLPIqOsKgi8E9Bz0BmLEXLQCvZyZOAzsRzpUMt2trFt99
         VdWYt5z/WeTIceDDoPwhR5qV+LD0LbkvDg+vRZOvjf/U2q7HlKFKXuvObv7GlSNfc7Tv
         7rPgYVcei+Ars9LjwngztlITdRqFopuwC3mxYbSEuuVccFB3WFkDRLbNWMSCGFdRpFgy
         gsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402237; x=1767007037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ab6JOzuLwlwcJP0zDmDJjf1ALA4R5CWtA/kSD2JFIw=;
        b=VOX9gOcYrOOJTuNWTR75PYifk1baiCP0Yp7TPKzIUDs4NgZmrRFqayDfXhu5A1srbT
         5sFisqXwIgi4B0qJF1sgys2IczQN/yU2N9iBsArUvxfrPVzlUlO76ZTfv9o0b/+kbpUw
         /qjxNvpmi9nmSNHw5WeDFxS45ncMBkMyw08/Fc8mjjmRoDKaqsaiNt/SKHIqadlujyKS
         /rkaIZQKSEDShYHAUGSTBH8NYyLEO9w97flnIyr2df9mN3PYCTLamFOkz81r/gHN7hRw
         rXFX6NbHnDf3vtF8S6pHtvntBS7Zj4wzcL+0bhD2G2JXeULWSPQF9vRQHtMiRSXgj1yz
         Z2fA==
X-Gm-Message-State: AOJu0YzK1672DtI1TNXYkh4gnlBnAR6sLdS5kYCxU0o8EFdFpYwehM9m
	XVyaiHQ8IcrFxZvzgZKbAcJuLGJNGL5XOD2OlspBCGIEby2fYq471/44/nk1sA==
X-Gm-Gg: AY/fxX766Sapensi6aRU7qt3z3cD5PB1vVZ7gWpVqpl9hpBsUAlEU3j6m7meo4K7on7
	H12WQLH2Vw9jVCJIjIAyLGBhfQ39bBSiqC1vqYNcBF0jJFHF9WFZw00RfPXXT3zwEpdQdGHE1t6
	H02vwsI/N5K54fAyTzCuAJnyH6JKQIKg3oBnfoE2q3YrIi393NzXJtAuHwclBnKbq98DmEiNxL4
	YG2c/j0o/7iVFfjwo30NfR/K7n88+diKxN9CKDvyv+0CnSHjeUZjUMTnOzRDP8bHC5+1tNVEBfM
	wrzkDLvfJXKW9is5ZT0tRjbf7l3lJmUA4QFJ9fV63SyjvYMsuBG7Ddr7qr3z1HqMZN6KwjCb2My
	p0jEj1Vzj9EFwaaVMEknMHpgjCx8G0Xz3mv9v5oDVxFSo2oMaC2gOxnIR56BzgagfAet5kI82Fo
	0Ril0TL2RTuvVLe19fj56r5EBz+d26BqMM4R0=
X-Google-Smtp-Source: AGHT+IFNhyaroLmF6UtZ5cP3/8PRzSlObvvfEY9KghJWCMaaI5y41EOLKekjk5UdJJ6Nnnx9Zh0ulA==
X-Received: by 2002:a17:906:c147:b0:b80:751:ee5f with SMTP id a640c23a62f3a-b80371d448amr1131602166b.52.1766402237395;
        Mon, 22 Dec 2025 03:17:17 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:17 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 22/24] can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 22 Dec 2025 11:16:54 +0000
Message-ID: <20251222111705.27028-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21208

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 161266c754e71d979be994967984c9fdcab74090 ]

Convert the Renesas R-Car CAN-FD driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotations from its suspend and resume callbacks, and
reduces kernel size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-7-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3b06145e0057..a8f7096ac818 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2256,18 +2256,18 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	rcar_canfd_global_deinit(gpriv, true);
 }
 
-static int __maybe_unused rcar_canfd_suspend(struct device *dev)
+static int rcar_canfd_suspend(struct device *dev)
 {
 	return 0;
 }
 
-static int __maybe_unused rcar_canfd_resume(struct device *dev)
+static int rcar_canfd_resume(struct device *dev)
 {
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
-			 rcar_canfd_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
+				rcar_canfd_resume);
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
@@ -2284,7 +2284,7 @@ static struct platform_driver rcar_canfd_driver = {
 	.driver = {
 		.name = RCANFD_DRV_NAME,
 		.of_match_table = of_match_ptr(rcar_canfd_of_table),
-		.pm = &rcar_canfd_pm_ops,
+		.pm = pm_sleep_ptr(&rcar_canfd_pm_ops),
 	},
 	.probe = rcar_canfd_probe,
 	.remove = rcar_canfd_remove,
-- 
2.43.0


