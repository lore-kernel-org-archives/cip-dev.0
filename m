Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F52E77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:22:55 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.104360.1734524574103414869
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TW2f+ld+;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-432d86a3085so42825785e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524572; x=1735129372; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkJG4Bqf1RF27OjiKI0iUzCClliQfuwI+suFdV7UrVo=;
        b=TW2f+ld+fXhhMXeUh4HXFo4wm1ADkWIitnvCjSqvDlqfc091uITNaOYzWfvNgN/S22
         +EWqOVKLBBmHWmsqqx609HbUp/Dou14znLyKbRu2p8SR61Hte/bFcnAoA5XPWp0PJiv5
         HsKQa/xP8CLE0++3wvNsaX04/mK3ZLxpZdvNHjUmJoTzojc/vR+6GBE0WWA/48EEV8pP
         sb9DZ9HTV+8gEu03yxbsosgOrWp78Nj4YEAANKr6GWRJf9CmhK6GxFKnhdkJgYXcUjN5
         Turo5XHAYM5IoymbuAEnht76hTcQNki1xM9VdfHZ7RSrSMevP69YMh+o49CGHFIK2vf5
         ziww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524572; x=1735129372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkJG4Bqf1RF27OjiKI0iUzCClliQfuwI+suFdV7UrVo=;
        b=efYY0XE3nBpj9vFFFUx1Jkm3oZflXf2CiFcLW+rDEYlGFXFmwVVCywDnfvUxaSRhIj
         zViD8iRbxtxtQtDxZ0uPCqENtO399RkPPf0u9woPlmAn/PRChOwXfKM15lyLGlvwW949
         EcrEVR1syRFWcEe8d3gvqQwhLVlDA5fKRD0iq7BOx7ARtU5yiievP4wBFH1yaTvhkPXC
         DBR5A0uzmQaeCilStuvTi98IpnZZ/QdPtdrHSGn5+/7Xp/0CS7etjqqpb5nh76W9DU+d
         6H0vWemfXOqZcVv9wVRK1RInIVNNM4YvqkAGwI3fYgRBn0TgVR1gn7mQwrmdBTOimM4L
         Kigg==
X-Forwarded-Encrypted: i=1; AJvYcCUyqC+RL4As3r7BrTJwT4HG6SCMBf/N+kVW+rEoK3UlEowC2Evzz9di8Z8WH9yogWjC1grEVWnQ@lists.cip-project.org
X-Gm-Message-State: AOJu0YzDRdOweCufAGkp9ruGTRgJKhM2ulw7mLEbq/SbKLJ0NTiL1dZM
	PayTU6bwOo8iSmrsBRaqeUcWUxWpi5qLrgp7YkkvlyMQs5Ksnd5SkKwu4Hw49Oo=
X-Gm-Gg: ASbGncuDlm6VOXGoUca8uvrnS8Yej6UoXygf/miLEBlLP9c2E8FA7q9FlN6AMlE8rtS
	3ewxdWbeRyO9Kn3sPixCjCeevBR+bsonDO7PNAv+IUZizbmtuYGv3MkFNFW9Svdq4G5bhFPOpIH
	z32DQ7kf0aCXVM/KpiyIZm5/OKfinkG8tlDbWFsC5lf+HTZk8XlDN84ECbSXmQRC2Gzl3p9/CzP
	rWxmnTi2Xa+pjKEDnWQui+XXlDL9ovK2/RCNGvFcaGX5OZUh45GqkmIvDqVOKzgeh1xhNCJHVmj
	LtDtRhZXZfQ=
X-Google-Smtp-Source: AGHT+IHYwmIqW+SVFwvVVrbCJZq33ezEV0R9MmgHTS0fYz4zYf3Ft2HAnLrNXUCsPXcmyI/e1IUCwA==
X-Received: by 2002:a05:6000:188d:b0:386:62f:cf18 with SMTP id ffacd0b85a97d-388e4db7e91mr2127734f8f.49.1734524572517;
        Wed, 18 Dec 2024 04:22:52 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:52 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 4/8] watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
Date: Wed, 18 Dec 2024 14:22:42 +0200
Message-ID: <20241218122246.2365189-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:22:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17448

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


