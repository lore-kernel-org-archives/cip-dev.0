Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C625DCDC16A
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:18 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88180.1767699911807512203
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UB2FbySI;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so5742625e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699910; x=1768304710; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4jeo/S1I6/Xp6fqA1F+uwEDyY/zr64pWVNvwVYnujs=;
        b=UB2FbySIVfHKxTDGl+3Qvpm4Qqs7Mt0ssMQIyH8AEO3QTb8a8IcURAQHXBYoqtwx1k
         FNA28ARnK2vwjsvVZEhvTbYf0qjN7fq9VCbfypRRSFQuhUvS2G36/UwSJD6QLgk/kuG5
         l29q168xBcEW7vBM3b6Ng6tHuQpJdPmDDAdvcIpX5sgZP6GjxB3qIgaV2MFLfp6ur6nP
         A6TV9ZzRdjZZ9+upGp8+rICzuCMJE1eS1QopRJMawHfgoxtq1qmFdguJ1SfKC+zPUmOQ
         iu0kVGXHUvYxTaebm7KmTTlq8WiaClXXVdq1e6bAQHSUpW4KHRX806DM/8IvH83ldPs8
         P/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699910; x=1768304710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u4jeo/S1I6/Xp6fqA1F+uwEDyY/zr64pWVNvwVYnujs=;
        b=Ce+MTCu3TMiy9qAe2iUAoVaVxX0vaqyJE9v8l6b3YKLrK5kUwx3uWMksfo24lK+Qvd
         c6Du70cVVsLARxPCRq2kH1TKtq6/5dFQ7bzEkhH7/pdO2rTEjOreLClkU+WsIKFP8ykM
         kZXoUUn0qm4vM0Xl6eIShfqF4t7iAYXEeZa0Cf8Mj58FYJU54PsgVbGOFBGP/KU9Hqph
         4I77z33t2piPzArtk6T7ujHKIFNKxmVzeR9UrH+Y0YueOPYfE06ysJWw93ZTbgBpllHc
         R/8RJoSf4W5F55YwU8JocglJj6IsTWjySZAjXrR0I+HptoSuF4PRG6KLujwLC2n2m8+L
         YZCw==
X-Gm-Message-State: AOJu0Ywo+UJD/IPp/gPy8Yp+8LD3HT3S2pVDc6u05DO+Qh34fNIefKW4
	N1GVl0oe7XyFGH5bB8NrDatPiUUj8i04xlAFDtgAVZVgTWaaesunF/ckemANow==
X-Gm-Gg: AY/fxX7vBKabvPZNQvbBS4EFqpEnJZtzF+/Xj/zfBrzyCAR3cPGOsM0v3EaGtE+w71D
	BgWjZT70AF1VCUcAYYBysWUlh/IKaSoraRNmi4URTiyyymPJqEzbh6L4FMwAkpij9yhpYygXn3y
	DPgScauZ9vp8u9QIG6qb6M0t/Cmd3AG8IJ/dYqmbbCLkPOWXtcWVf//liRjYPIP3eSzuez7QBE1
	o2oHCQDTSbiG4QnOfVhYfNNItJw6oXQZR7oLhxaMY7NJI+f3lypZqSy1rgJdIsfMb4Kbt5F6k6Z
	GpPLzE1+YXfXTLePxL9wkjHmObHdIqMvI10AsKs/mpAiluwXe+bsXJ/zt51ZJS5ONoR5HBPtpka
	YHSG9pYMQyQMwwHI89QAis+UHIa/4WD496AiOcHQNxu/0GphbvRf0UsQn9gvhl0wa2tvy1IqRpA
	dRev8U0SpqQW7SpiXriQ==
X-Google-Smtp-Source: AGHT+IHpKZc56kmLWtgT4nro5itqlM/Pa8A27r9Orkq4fI8gca1EdSZS9AXX4h2o4+ZM0Yy4njAnyQ==
X-Received: by 2002:a05:600c:350e:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-47d7f0676c4mr29146685e9.9.1767699909869;
        Tue, 06 Jan 2026 03:45:09 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 22/24] can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue,  6 Jan 2026 11:44:45 +0000
Message-ID: <20260106114458.122333-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21354

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
index 233ec0e4af78..f6bc3f1cbd63 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2264,18 +2264,18 @@ static void rcar_canfd_remove(struct platform_device *pdev)
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
@@ -2292,7 +2292,7 @@ static struct platform_driver rcar_canfd_driver = {
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


