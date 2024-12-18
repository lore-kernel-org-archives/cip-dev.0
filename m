Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564CEE7718D
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:35 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.104386.1734524607637656079
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UdYJBqCZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43618283d48so46357255e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524606; x=1735129406; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkJG4Bqf1RF27OjiKI0iUzCClliQfuwI+suFdV7UrVo=;
        b=UdYJBqCZHMXTSR7mOx6ob9PJEztvngmoug7jUyGyQ9JwUYdkFkcK5T+zzuuZFdB4Uf
         z22vMare6ETFmnpMbrp/azCY2nqj/gZnMdTnIGFb5c5EvSVrVJt2Ba2tESCqRHRhfCS1
         4340flixt0DhrwK5b/krVpqbkdLe+iWECCBonm1ANb8ijtLs5QOv93OrHTlVd42mg5CT
         VCgDfYpMZMlfSayuP370DkmsXbdk8Y/w8jNMJsJV1QmO0sU26hLqxFTMZaeBtHttYiMt
         LnspN5YDgtuLNp1wxBIMLFUyfWJG7Xew3nlTH6xbXMjm7i8d5sxeX/rwTLKv+2nw7uS6
         Cl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524606; x=1735129406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkJG4Bqf1RF27OjiKI0iUzCClliQfuwI+suFdV7UrVo=;
        b=CML4WxDej5rO5SOiOGNc45Tx6DPiJDfv/9YML/ucYc/EpleTf+cowCNPKPymgldzvM
         7vk3jNulkZqOO/FeLjqjOKl5ljCanAKBRDiO1BKzcTIPKYkcfHJqWqjf8e4rs42v51H4
         fm4MsuESwSugJmMopjrYsRJ2Sr8pqim+TiFCjroFVAVwYqR2DmXX87rKwfEsHk5MFzwF
         ya6Dc7Bbd3BovEFLoBhfngqvhhEMxcYzdGAG0zbJjYz05q7PABttRu0bhBsIsuK+gqyx
         OihyO0no4+ElaV2TtwQzXmpDbniTIj0mHuxYp7rEcQLGjJ/dzuk7RkecTrZD+A2LXrQt
         4x8A==
X-Forwarded-Encrypted: i=1; AJvYcCXpZS83Mk3WPGz6q1/vHB/pgwd3UaZ+K8fxUd/eRR3SRdou3IwYpTbpr4mk0ttqWmhAOFcvVtT6@lists.cip-project.org
X-Gm-Message-State: AOJu0YwXaGFMjBqyguGyaT7eiSXFj2Cnyq9tiFxspqvjYKtHRzYKoM4s
	geevRz9SNKxzPWfqdTY7yCPWfvOb/E8VW66f7P1Y5+NgeqgpTYRwhbKqsMu0VhZZUJtuPG7fo7V
	Q
X-Gm-Gg: ASbGnctLTL1fXs2YK+sfeVF+8zuFx8PzQzdhE1H6XjPmGFKSJ5Pq5faZuNp275RU1nT
	ciah8JE77cr5ZpvKhUAUy363lyzM6zv43CVc5emCg/kP4oXUxBub2m7SLcGvD6ZycHQFTczbu0z
	Ns61/rIC6xSe4rEEosq2vphPO6uW5tQAYi5Fuz9Ct9FitzOzz5LIoetnTzIG6Epd8P+DkpPqIjg
	srsHaQSW5gBfE/z19spbz3VxwkHfiYKXbZwedo2R7VyqIzwwKWdL9wHn1Sgsn9vMWKEYWR+pNLn
	RMlFYGiz9A8=
X-Google-Smtp-Source: AGHT+IE9ULXt/GJZHAx5EMsDTkM8CKSWm2Te0HdcgLs4d0I5Er5kdvMtuKnjp24iY3Gzhe3KoUAKDw==
X-Received: by 2002:a05:600c:1d08:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-436553ec84cmr21394925e9.24.1734524606044;
        Wed, 18 Dec 2024 04:23:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:25 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 06/10] watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
Date: Wed, 18 Dec 2024 14:23:13 +0200
Message-ID: <20241218122317.2365272-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17459

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d8997ed79ed7c7c32b2ae571e0d99a58bbfd01fe upstream.

The reset driver has been adapted in commit da235d2fac21
("clk: renesas: rzg2l: Check reset monitor registers") to check the reset
monitor bits before declaring reset asserts/de-asserts as
successful/failure operations. With that, there is no need to keep the
reset workaround for RZ/V2M in place in the watchdog driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240531065723.1085423-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 39 ++++--------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 2c50e4c76131..ea535739f8b6 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -8,7 +8,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -54,35 +53,11 @@ struct rzg2l_wdt_priv {
 	struct reset_control *rstc;
 	unsigned long osc_clk_rate;
 	unsigned long delay;
-	unsigned long minimum_assertion_period;
 	struct clk *pclk;
 	struct clk *osc_clk;
 	enum rz_wdt_type devtype;
 };
 
-static int rzg2l_wdt_reset(struct rzg2l_wdt_priv *priv)
-{
-	int err, status;
-
-	if (priv->devtype == WDT_RZV2M) {
-		/* WDT needs TYPE-B reset control */
-		err = reset_control_assert(priv->rstc);
-		if (err)
-			return err;
-		ndelay(priv->minimum_assertion_period);
-		err = reset_control_deassert(priv->rstc);
-		if (err)
-			return err;
-		err = read_poll_timeout(reset_control_status, status,
-					status != 1, 0, 1000, false,
-					priv->rstc);
-	} else {
-		err = reset_control_reset(priv->rstc);
-	}
-
-	return err;
-}
-
 static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
 {
 	/* delay timer when change the setting register */
@@ -189,13 +164,12 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 			     unsigned long action, void *data)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int ret;
 
 	clk_prepare_enable(priv->pclk);
 	clk_prepare_enable(priv->osc_clk);
 
 	if (priv->devtype == WDT_RZG2L) {
-		int ret;
-
 		ret = reset_control_deassert(priv->rstc);
 		if (ret)
 			return ret;
@@ -207,7 +181,9 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 		rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
 	} else {
 		/* RZ/V2M doesn't have parity error registers */
-		rzg2l_wdt_reset(priv);
+		ret = reset_control_reset(priv->rstc);
+		if (ret)
+			return ret;
 
 		wdev->timeout = 0;
 
@@ -299,13 +275,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
 
-	if (priv->devtype == WDT_RZV2M) {
-		priv->minimum_assertion_period = RZV2M_A_NSEC +
-			3 * F2CYCLE_NSEC(pclk_rate) + 5 *
-			max(F2CYCLE_NSEC(priv->osc_clk_rate),
-			    F2CYCLE_NSEC(pclk_rate));
-	}
-
 	pm_runtime_enable(&pdev->dev);
 
 	priv->wdev.info = &rzg2l_wdt_ident;
-- 
2.43.0


