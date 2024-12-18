Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31994E77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:35 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.104381.1734524604985408478
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EtLnLJy9;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso44793235e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524603; x=1735129403; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRihk1XGgKv8NhSJW0zRtXEipnAVHt6UpK3/YhUvPxw=;
        b=EtLnLJy9O+W819cG3U0YlOcgzwcuv7vX7cloAILuop1YXv+wmXCjppE1Mi6rPXLebw
         5PJPgxTRGkkkSKB4qAOWz1ZYcOu9SFI+uT7K7qjSsGfVFFiRi/QElNtNMN2rOQUrpdUL
         SlTe0idVUDvrGO6wcow7ZkCg18eGU5/LqdAqT3VbZXjDPNWlJo3XPrb8Qoy0il5ezs8f
         EScFViyDD/144hZNTzwtIx+kE5rXMLy6N6CeIOu1rsRlQxJBpIS1QRvbhouNlZ7bTwWt
         a1LIwgQOXOVRIgrweNqfrK3X85eObV9HbZZdoTNV2fvnTVkJ/ulWB6V48QD//uRLtrel
         grKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524603; x=1735129403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRihk1XGgKv8NhSJW0zRtXEipnAVHt6UpK3/YhUvPxw=;
        b=Zp29NepjUUimrJhuN7E0T0la0jE+5nhzt+ytjGmo97zRpeyAwaipDhulR2qkXktAdV
         STFds6odZrSevvIXeQOReJbjFfDZ2TMsN6KJeOoaqj3BDzugGnbDatNe+bbmw3TsVKic
         UMmjNHDSX2gfPsEUi3a6tBuwjauH3R9A0ZK46JlJiu6XKbYsTaLAjt8bils6MBtwXQlH
         7voHaVko1eIWjZPjgVMtpLYKN3hrt4AP15/jsy7e6vgUI4mkvEBmmplOlNvrHdo2jfC/
         MUD6rMQmZF2C1n67i+TVUzIUFILG58AE+7YXPqswj7n2AXc+foxZz80RAtxQtOAyNF5N
         /xvA==
X-Forwarded-Encrypted: i=1; AJvYcCUb2xIkgxk8XbIgeOGlg3xnP21YrIGXDexkDDANSOm3emdC13LM9he4m9ye2Vryiz2gnhbuHyd7@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy+2GAwY8ZEdmEhUVu6wcDI6/SVu5XcXvKQUWpFuHwwPDM9Ep66
	jLK6VCbxnPYhsNqjeaT7O9kk7GZXuHCv0F7SYDWV3hcpQERS7g64uoFgw1Oo+wM=
X-Gm-Gg: ASbGncsuZ8Pn4jHrOA/mJbSV9Kp7zSNKpatDEc1trBcZREvKNcLPODH5qPEc2a4p4wE
	IIuHYoExQfNijdRpHNs5SMylEJWExZUzTy1DHsRPKUbjHj46YTKVs9FoEYiiBTxYpFJNX5+3PkQ
	DH0/Q6FpdedSCBemLnyFJK3CzI0nxywmGT7HLiRoL0pIw78m3JO3TSEJtYbZWZNJr5OUfW+7I3H
	rwE3JWyaXe3cE88VZ5t80pqPr7OKsjt8bKSrQ0cK4BCFHUR+LKKmAelJ/g/TvK0Fs8GLzb198DS
	vMbdlWdn9Qw=
X-Google-Smtp-Source: AGHT+IFPfd8C9myq5Pz8v+ZRPMrnCzwg5/wW/mEdu2o9agheYEcXsvh2pOk22LL4lcA36gIOjzReqg==
X-Received: by 2002:a05:600c:4508:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-4365535fe12mr20814245e9.11.1734524603431;
        Wed, 18 Dec 2024 04:23:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:22 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 04/10] watchdog: rzg2l_wdt: Remove reset de-assert from probe
Date: Wed, 18 Dec 2024 14:23:11 +0200
Message-ID: <20241218122317.2365272-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17457

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 064319c3fac88e04f53f3460cd24ae90de2d9fb6 upstream.

There is no need to de-assert the reset signal on probe as the watchdog
is not used prior executing start. Also, the clocks are not enabled in
probe (pm_runtime_enable() doesn't do that), thus this is another indicator
that the watchdog wasn't used previously like this. Instead, keep the
watchdog hardware in its previous state at probe (by default it is in
reset state), enable it when it is started and move it to reset state
when it is stopped. This saves some extra power when the watchdog is
unused.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240531065723.1085423-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 9b2698a4fc1a..a473de5ff886 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -129,6 +129,12 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(priv->rstc);
+	if (ret) {
+		pm_runtime_put(wdev->parent);
+		return ret;
+	}
+
 	/* Initialize time out */
 	rzg2l_wdt_init_timeout(wdev);
 
@@ -146,7 +152,9 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 	int ret;
 
-	rzg2l_wdt_reset(priv);
+	ret = reset_control_assert(priv->rstc);
+	if (ret)
+		return ret;
 
 	ret = pm_runtime_put(wdev->parent);
 	if (ret < 0)
@@ -186,6 +194,12 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 	clk_prepare_enable(priv->osc_clk);
 
 	if (priv->devtype == WDT_RZG2L) {
+		int ret;
+
+		ret = reset_control_deassert(priv->rstc);
+		if (ret)
+			return ret;
+
 		/* Generate Reset (WDTRSTB) Signal on parity error */
 		rzg2l_wdt_write(priv, 0, PECR);
 
@@ -236,13 +250,11 @@ static const struct watchdog_ops rzg2l_wdt_ops = {
 	.restart = rzg2l_wdt_restart,
 };
 
-static void rzg2l_wdt_reset_assert_pm_disable(void *data)
+static void rzg2l_wdt_pm_disable(void *data)
 {
 	struct watchdog_device *wdev = data;
-	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	pm_runtime_disable(wdev->parent);
-	reset_control_assert(priv->rstc);
 }
 
 static int rzg2l_wdt_probe(struct platform_device *pdev)
@@ -285,10 +297,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
 
-	ret = reset_control_deassert(priv->rstc);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to deassert");
-
 	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
 
 	if (priv->devtype == WDT_RZV2M) {
@@ -309,9 +317,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
 
 	watchdog_set_drvdata(&priv->wdev, priv);
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_wdt_reset_assert_pm_disable,
-				       &priv->wdev);
+	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


