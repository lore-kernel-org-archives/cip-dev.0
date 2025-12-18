Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EB9D6E2BF
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1419.1766076973459729069
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=feEjfZTn;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso8201725e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076972; x=1766681772; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQGWL8B3tvtprbGyciufnia59rNSnkpSxkmw0uSoG+8=;
        b=feEjfZTnD4NK9F7RIUWsp2cIoBSlfq2n4QK04Zx8WxurA4B6CJj36TOyJ9p7ZROWmx
         BOQJDplpGT/RHxNwEJN6uqUusA+fEyErgB6s0iCFgkHMRKQlYrLySfRAZpMicXQlIelQ
         Ukeeif5g0xcfMGz5Rn8LEUqHGvZjxrkV8bQPt53pvTQMG4djDmjLM34uLiW2KfdAHhUj
         LeAKKc5M6bMeVzAVvktqKLe1sS8iKs8v0sxP2KK/TemGNro2zaD3m/putgSmV/FNe4pb
         yZuoq+IrJ8SijGbT0I6mMWqb262l/Dne9EhAUByBS4MOHBA1XakIppoJIOij1bmcVE0K
         FPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076972; x=1766681772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQGWL8B3tvtprbGyciufnia59rNSnkpSxkmw0uSoG+8=;
        b=Ocfe/Y3Rym+w5dSGJVwXEjnXu/vxxByL2V2u426JfzkRD4qds4E89ywZxWblfCMo8V
         VmameSW+pbjkrgwovrvPNrr+WtNpNqszsn7gar165vVpSQ7+ue7jWU3vMyasDVdQPXfM
         hgPev9BgJiMHFrMMsfWfp1e7ZWkg6O6lAU+wGxOWbhaKnI8IvXLOZMyIgK61BFCD8NUA
         F7OVFuj59kmHNvScflZyYx2GwXnzJlgc8apUm73HX+lPVJlxbjtyHnrkbjU4RKJ0abBF
         Ae0luaIthoUZRE0BGMPp6HoXXNG/2QY05pUHEi8GgbvYvHU5duYBPtsp+12jD2zjN8k9
         lAlQ==
X-Gm-Message-State: AOJu0Yx6vbAmXfBStYtWHwQMqcf5W90tVIxh19pp4ntINWt/3og5+8Ta
	XGe0+HfReCo5q4zTe/gEY/GIyK40h2BooOfKYgUfQmNkFf/075IaKF4Y71dIiw==
X-Gm-Gg: AY/fxX6SUclx9KDaGuY451oFvxNTgfW/TvnyX37PgXD0wvcqIH9V5zaAah2msbjEpn4
	nlzwvU9FM1WNgaAmdwLfXm/KzwmdTWNQnTSTYTwPACZ8XJszsdqbijd2DDpmkruWTlL2hL/4gNw
	weW7I6x5h7Z+wPp6mQzAHTPev3NMNzpBERFWoKpJ8pCYso9VZEdheWs3Qo491N6PfcMabHrA8az
	ryc/6DgYsvMUSOI6kJSSkbXp8ZaactlwIM8dFy+cwYBnhF5y3o6OJOc9ace3Epy3TgibjgryZTk
	sA2L2ogdlvX7FGeZQpmqZwE3EHDU22ZS0bHY/eDaTwAXwDldUjS3BvVYbf/dZfRyN7d6Np0GztT
	Tgc7HFot+V2P70wu3QFIFXz37doVBzIovjFX1Bk6rc0zHC3atrCMxLFWn0TcFoGK652r7em2Kw+
	vS4n9u0pkJxEZWtr8Cag==
X-Google-Smtp-Source: AGHT+IETE8VmXh1hX2TO0D1Lp0TjiPVwcL2dTfWhtFJM1V7JWw18iZe7EpZTM33ubIx153nlp73UqQ==
X-Received: by 2002:a05:6000:144c:b0:431:84:33e with SMTP id ffacd0b85a97d-4324e50ae1dmr158331f8f.50.1766076971549;
        Thu, 18 Dec 2025 08:56:11 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:11 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 22/24] can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 18 Dec 2025 16:55:21 +0000
Message-ID: <20251218165600.258194-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21160

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
index 9f47367c155b..bb17e96d7cb7 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2259,18 +2259,18 @@ static int rcar_canfd_remove(struct platform_device *pdev)
 	return 0;
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
@@ -2287,7 +2287,7 @@ static struct platform_driver rcar_canfd_driver = {
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


