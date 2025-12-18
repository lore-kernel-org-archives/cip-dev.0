Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBF9D6E2DC
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:17 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1398.1766076971393264240
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=V9Q4lnnj;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso11078025e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076969; x=1766681769; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zk6ll8BefAKD9k2NaJ4gnwoUt5KBY12bfN9KOR6VSg=;
        b=V9Q4lnnj/7U2UHGvKcOkT6L+7wOuGSS6Iy2i9tmDNVNA53ZW8tMG0tspdJgdqzj25t
         /feRutfjrRkP630usBh+Jzk4wO9xFWX4pIIftLYm3YZXgP9jODPz4/5f1lRpZeYIW8Wv
         NbEHNukU0A43vqCvEcwFujTAKV+R6Bf0PyIESIvNIJL89CdnEW24FTb3Gy4CBm7Wj+4w
         ly4VNFuj3UjxKOpTs/g+hJxdJ8evvHgJADw4pr0FUdv351jCjkzvQwQvFAg8lJuRVDKh
         sKfivlZGLlBQoBLbE53EWzFYHYR/nmLWjcKYsS1IEM6Pz9yXsiGm6BYTwkgaWL6V3YUY
         Q2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076969; x=1766681769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Zk6ll8BefAKD9k2NaJ4gnwoUt5KBY12bfN9KOR6VSg=;
        b=DFWjVYRZfnBTxoQJ04FG2wpMUK98PR5eiqGhdBL/m03sKRL7KHJR5OB01I9m6ulYHh
         DOdK6DaeBVrmAO+Kq0qYT7A6Z9nb6VlGtEoym6xogyPsUmwhTXynX4LzTzsw4JB9cE+u
         bSX81mggLUdIMzlfNWnh9Ot+xu8n9F1bKTew46q6H1zYjRaWtrhnwk/NQECUZUXksZMj
         Pgw8YzuL0dX5MG9yGVTeL4CZp0Zlv3m5sxMh9c2HQ14so2pEUswnFuQuV42sqQ77DSfk
         iD0X5gtAr5uXFs4opzZj7mNZcsgrtw4RWvOI6cUWiMXDtsQdEwmSwwQxlpSRojvynrCL
         TzOw==
X-Gm-Message-State: AOJu0Yz6mLQVwhzQKGzFsUCLZznvNSexqqSqxuqVNq7aiVboPOxmWD8w
	X457WYPPE7QWK+X5inVq1vmOGKmvKdxeI2sxWSjXcghCwN57ztulZMoLmClvvA==
X-Gm-Gg: AY/fxX7iQyCDIBbFXyo+Uhmsp6habvnVeeU3O1AupzP5pnNr81jBOAWDoYsAM9C6FaD
	LYv2xPwM9qls6NH6T9v2k/ww87cQc3kpWYt9ydv20bUG9muPEWQAPvq33mwmuxQcbWvXVA/H9fi
	GEaaZ6YRVMxJlxOdzqibN3lPeza4CAbt0clQvMTljIhvnYixxz7ma7hlrME1qvHNCSexff6Xe+R
	UoTkoAUj8cvkRuTic+SC5J45UbxkiHk8E6VwFmQsmR+E0MgccsLJZ5M5MBXZTlW6TqWH0Z/wtQH
	SzhdVH2i3IGNvXZnq+q89NZee9OPfI2zYdndY9qu2VT/KNaIlDs7hThBEkmBKuhE5Q59aMrGpGR
	oYEYbaPPP9eMCwKC6QICOacuFdGipoh9Fxrj9KrL2FJXUtCA6kai1lUhWxstQDHX125Mc6vUQfE
	aPj1K62BXm5aORRu99VIFvXmdGf8Ol
X-Google-Smtp-Source: AGHT+IE6otKFlnWz9HsvR8EqaqRQqfaeBfS0S2hSuMStTBFbIoY4Sy2wSa2yAlmy1Zleqo9Dfw0ODQ==
X-Received: by 2002:a05:6000:420c:b0:431:8bf:f08c with SMTP id ffacd0b85a97d-4324e42e651mr287465f8f.21.1766076969480;
        Thu, 18 Dec 2025 08:56:09 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:09 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 18/24] can: rcar_canfd: Invert global vs. channel teardown
Date: Thu, 18 Dec 2025 16:55:17 +0000
Message-ID: <20251218165600.258194-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21155

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 790ec4c453890f1221ea595674a1206bbee41dc4 ]

Global state is initialized and torn down before per-channel state.
Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 9029275eba8b..e6a90fd94f4f 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2205,14 +2205,14 @@ static int rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	rcar_canfd_reset_controller(gpriv);
-	rcar_canfd_disable_global_interrupts(gpriv);
-
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
+	rcar_canfd_disable_global_interrupts(gpriv);
+	rcar_canfd_reset_controller(gpriv);
+
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-- 
2.43.0


