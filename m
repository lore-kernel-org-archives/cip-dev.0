Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA8CDC174
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:19 +0000 (UTC)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88219.1767699909453266893
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=akmLh1QF;
 spf=pass (domain: gmail.com, ip: 209.85.128.67, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so9200225e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699908; x=1768304708; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22JA5o5N/8ZKNqjv4NCrZV78vCnWi98oUpUNtuefJj4=;
        b=akmLh1QF7YoHSwIIb3ctJT3wtkIH3rAI3oQHxIbNH5t6ffJT8+viAC8arQ/cqeyP5C
         UqJkYpiSWfHSiU4N1VSEwETAgpkWmWsJKJJ0UvN9bngKugpF5Qktw5sCUgiIYDFEeUyt
         LbYaflF0vvswVLSo9sANXCP4JpC7ZDHyy2sKG60tbZDoZn4t8SbPOSGyDJYsjIEjsMKj
         q0O3Dw5qxk2SjMojchxw2kTWGwd2N2fE5jNtdv0pAQeHm0miCJG4bU9+t09kk3PNLP8o
         XrNKrPBx+CLr/qN4LMcmK9xfagZ8cCgQ5xslZ4jfUwTBboSurqkh+DcAcSgV5mQcxIO/
         fmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699908; x=1768304708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22JA5o5N/8ZKNqjv4NCrZV78vCnWi98oUpUNtuefJj4=;
        b=Zypy5FXeuc4AEB2nICQyxWpQ9O1pBcdKc199cYTUZSmKxv1mdqMfAQmMvCzrrIs70b
         d6AJJYrChtBpV+ZVnp7xMa6r86uJq6XK27INISg7NV5+HsfJ2gJnyHV20CHIHKDZWvf7
         pfwDyT3QbrCGCfjLbT46ymWgfowJwdqCCFSwILWKUxqtFb//0Erey2HasMxdvP4i3/Hm
         R8CJ5xEmbbQlUtLaZHPb5mGSWktPDC5lIqykWNydB9kmx7GYj0lw/yUbrlAV9ybq1/OL
         U9Scb0pXq2tuPtCGLVDO+JtElj5uRPSG+WoZ92fm6hllAiAi2/dQa12rDtrvRssyhksU
         mmEA==
X-Gm-Message-State: AOJu0Yw2a7602AbB/QMiNfhm8uhN2BlJvtutZE+0F0aHVHHNrWlTUEwB
	cwgC+EeJKXN21k3CEydvMqgQ4GrTPUIqjNv1zrDp4uFMLTn24ZHV6rxrnwo/RpTH
X-Gm-Gg: AY/fxX6o84WqrXK9vhEhoVadPXw0v6UqPbTdXKa5xsfKlNhkkhKhalhAwbvWjjt6mdW
	w0xx7cxal5LgrRtLfSjpNvSBdGWDrceq8QQUGZIxKOs4R9D3TVQEAQ+5cO1dE3PESOMEzOI/tPA
	qa8vHQzi3SZSzL9ziJeXKhu9lK5AMe4eXd/dEb9VICtBefAzhOMJwoVQLajt3G+vySKOnfxBD8J
	Jhufp9T0yNjkH6JEeLQQGQRCn12gowZKvA22WBmY61JqM9QCn3dlDS2hTpePOHGjBWmi1zgVr8t
	SNCWX2xkkXPV6/6h9V/XMEj2A5bj1lrkXEO+LISzyHQi9fjvFKkTCK24wEJjVbrEkuUMk+GmI+g
	e0M98val24ZEY1TjrCA0nFoKbmCbEejjSlWm4Lc76Tdt/mnro+/7n3klFNHfimd6HHHuYkKHR5u
	8HHoT49SFx5unijm8O8g==
X-Google-Smtp-Source: AGHT+IGQyUdvgHWVRYV3HEOxqHx0kj8UgAw1775PPtwmLrl8cJWDze7Zdsp6GgdbSSQ6H3m5B29h9w==
X-Received: by 2002:a05:600c:4e16:b0:477:7991:5d1e with SMTP id 5b1f17b1804b1-47d7f09da93mr31114355e9.25.1767699907639;
        Tue, 06 Jan 2026 03:45:07 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:07 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 17/24] can: rcar_canfd: Invert reset assert order
Date: Tue,  6 Jan 2026 11:44:40 +0000
Message-ID: <20260106114458.122333-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21349

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 41c13eaf39932fc79aa1ac245a9b97090fe23d5e ]

The two resets are asserted during cleanup in the same order as they
were deasserted during probe.  Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-2-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index e781363bcc4e..cf1f478a87f3 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2201,8 +2201,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 fail_clk:
 	clk_disable_unprepare(gpriv->clkp);
 fail_reset:
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 fail_dev:
 	return err;
 }
@@ -2223,8 +2223,8 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-	reset_control_assert(gpriv->rstc1);
 	reset_control_assert(gpriv->rstc2);
+	reset_control_assert(gpriv->rstc1);
 }
 
 static int __maybe_unused rcar_canfd_suspend(struct device *dev)
-- 
2.43.0


