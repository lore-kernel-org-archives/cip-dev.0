Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F179E7718B
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:25 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.104380.1734524603836910925
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Jx74xOHk;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43622354a3eso44573635e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524602; x=1735129402; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sZpTitVEMgqj8B0Z4Bpm8g9dx/7f7KAIN4AxwiOZPA=;
        b=Jx74xOHklu/0AtFumc6VynYpfHKJCtVrxnDj1KDbKwEYvgIeVn8rr9JzzXwTGtBPms
         wkEZ5PKiK/MKgpHaRoQJelaVRoy+NAQLauTZ4D07m+GZ5MO1hM9Zb3EZVhThRY2cRSEr
         MCNUl4cnbXKRPq/zJBeJ81jysa7zBu3sM6V/Y2dDv1CS99ePfRkLLHupH70/BTJVy8Kr
         2oEUyysBnt+bebZgtu1rVgZm/JHk7QMoZb3/jj/GpJflCTXiqSihlt3gwDNJOHtacA2g
         oL2jplDYiQCsmxdt/3z2zC83KR+3havH5p9iOF4hhOcB+emtzHPTy8dE+x1T8qfBazUp
         kYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524602; x=1735129402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sZpTitVEMgqj8B0Z4Bpm8g9dx/7f7KAIN4AxwiOZPA=;
        b=lETz6bTsuluVefjYeqK6crwqjeZ9GxtCV1BrrXlVpYY/S4D6K/RFOFdIhirmh60kXV
         ggF5QWyxKEUTqZsCNFRRBhdiUbEhoXZej79xUFf8AASyBWjq7i2Ttb9KRLUTRQGPDPiS
         a+Mweaw7Dz72nhpm2ZSFj7WZOoGDkeIeCxRjCetFgKPjOvGg8bDyrtn0UQxtUZWxkynT
         CdSkqpC+GSjLaRckvmjfeYOMLK2qaiSg8ubA9iDdmB3ljl0u1d5v4QDtLcvmlVKDdaJd
         gcxWt+jpmT2yx5SxnnpK2CQ0bzAccYDAZ2eF9s4LlXmJrm8CaY3v7FPUFmFrW035HhiJ
         3haQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxQFKnZfjJ46QxDtiqlCegAhXTKyNWIZzAOUyEsd94GcQr4IwQi1CMlnpAWxHBpYOApVOT27wH@lists.cip-project.org
X-Gm-Message-State: AOJu0YzKnIJhz833Muy/lG48tYbXZOSJOwQXU+TwKQjZqJwRl9P5d/aq
	2oZbyfkjlBCKebHPwXOnz8fQpMhqzbCrENPka+WAOplgGO/rJ7RGYJxkXqrv8YA=
X-Gm-Gg: ASbGncuRc3BuY0Z5T8G5X7Si+WJPBpcf9JHjghxRYxZ6WLKqiZFVfy+6gLNSRD4BceS
	nT9cQZJgd8yw5bRGhKlyPLjuH3P0vLDwyBjvBCGvNst+7p65erNrYMP3J3cdHR6lzR0NzzOV2RN
	pCiMqU6IZIuouUN2f3CfHIHj7ri1p3Sl+ZJnXKaoQqIvX8f1x3b3M6tpyZMhUGFlkOaqDiNeiPz
	dHB9fxl2aE+CP+ccNyXJYE4CurAM2sI2FT+5wAHOAMBh82ki27CWBY9Xtiunl48+9+0T61d7co5
	MTsObmFCB0w=
X-Google-Smtp-Source: AGHT+IHLkCqrCljt5RYNk7nv3ne3abXaQ8NizN8wcUMH40QSpvkrzYx+FL8EjLFZRHx0FDDHmw/pVw==
X-Received: by 2002:a05:600c:4ed3:b0:436:488f:4f3 with SMTP id 5b1f17b1804b1-4365536e7ccmr25009215e9.17.1734524602252;
        Wed, 18 Dec 2024 04:23:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 03/10] watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
Date: Wed, 18 Dec 2024 14:23:10 +0200
Message-ID: <20241218122317.2365272-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17456

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 471e45a33302852bf79bc140fe418782f50734f6 upstream.

pm_runtime_put() may return an error code. Check its return status.

Along with it the rzg2l_wdt_set_timeout() function was updated to
propagate the result of rzg2l_wdt_stop() to its caller.

Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240531065723.1085423-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 78d904df5f1e..9b2698a4fc1a 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
 static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int ret;
 
 	rzg2l_wdt_reset(priv);
-	pm_runtime_put(wdev->parent);
+
+	ret = pm_runtime_put(wdev->parent);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -163,7 +167,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int time
 	 * to reset the module) so that it is updated with new timeout values.
 	 */
 	if (watchdog_active(wdev)) {
-		rzg2l_wdt_stop(wdev);
+		ret = rzg2l_wdt_stop(wdev);
+		if (ret)
+			return ret;
+
 		ret = rzg2l_wdt_start(wdev);
 	}
 
-- 
2.43.0


