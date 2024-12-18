Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EB1E7718C
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:22:55 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.104172.1734524571815353170
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=AYSL8uwZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso69048495e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524570; x=1735129370; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRihk1XGgKv8NhSJW0zRtXEipnAVHt6UpK3/YhUvPxw=;
        b=AYSL8uwZVUPg/iJ00RuuRv004PXGDdpEob/Y58s1mRWUNzR74Aj597BaAx5XkGx+aS
         YoHXy+Y17gCauyYXnP9UrYkhUo5e9DIJMhzHrY6mQS6xXxoshVlD59ZxHJ2+d6xQGS/O
         VIAS/Qm9ui43ikm5GLbM/6nGDi2qohajZLPwyI4KOcja9niC7jgDBbzB47B+xE1/GLOr
         iN+90sAsColoSW+RHCbvCY79oBGC3/7WDMKL9r2/TfGlEfIY+h+AKYa4V67KuCLceMfl
         XFw1z9wVhTz/5meacW4mayNm1EScaB9JgUcQM7NhxDTJWj3ylu9XdC8ucjMUX+joXBgd
         Nz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524570; x=1735129370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRihk1XGgKv8NhSJW0zRtXEipnAVHt6UpK3/YhUvPxw=;
        b=A5qETGdjlPBiV7iDjI3PY+f6L9ohuqAvYMSUS9dj3rTU2qTMBW+sV9t0R8KEIltlJN
         mRKyZnAbMa9j2epvL+BAhYGlgApWk6TRasYzffgYC5Tw3U49VgV8s9uyTjB1YCMI4YKm
         B0QgTyPtfgrevnPD6NQjxcj9T2TzCaUddQBPyBxc2CxqwR3ad8RTfBRhr4O0pKcvxjZv
         ie8L1iUaHgjG1oj5ImAIt9nUFAsgbVDHGqA7UjQBFn2DNi+xRqxizQUNSbkm2MfVrPY2
         Q9QsNczEmDBfotP4cH65UkobQFn8SVKy84qbk15XhFeUQYVTwfA8ilpeGVPxwgik6xUq
         iS2w==
X-Forwarded-Encrypted: i=1; AJvYcCW9SyaCT29CVobPF3/R+zqC9YQZSzQhpc3Dh8qpG843Pfxw1ooiye4VRm0txQv6TqSIVzAMU/6J@lists.cip-project.org
X-Gm-Message-State: AOJu0YzcO9SPx7TDzhOP5C5aYAilN9NemZ+XwrD1Sknnb+Fqc+Li3Gj+
	JYHZQf/Ja0NCv8xp9vMme58gn1gxk1B1OMgid1jfp7MmBuEgrtwKmDeBjF/A008=
X-Gm-Gg: ASbGncuis0J5padNOsoErwn7gOd1f+lqPLlTtjYDzdApGr0cX6Ol7CMUTuVydBZW5Ls
	/LhfisJFKFbXybEMXUr98nIh15BNF0jam1fjnShWqLHZQAsgy8MAp1vi1BgNQSy+RgJZyF84N/y
	GQEBDxV71A4nd7JHw0bEG10Bd5ww/H9WKuOLsXlxuM/5E2CC6UpfhoyzLflAbkpf+p0V63xduzx
	idoIzMt9yu9RPOyIjv2Quee3n0wHT/yK8pOLGpaxwlJqehCtk1hUmsmYSqKduAt9QO50DcsAOd7
	ccUtYNYwj00=
X-Google-Smtp-Source: AGHT+IFVc7lVCH0oPRreWMAgaiyDBbRYkMeYBea4bV075/7g5qJ//Elg21pdKKLzKZla1dy1xP5QFw==
X-Received: by 2002:a05:600c:4586:b0:434:f586:753c with SMTP id 5b1f17b1804b1-43655341348mr20351715e9.7.1734524570248;
        Wed, 18 Dec 2024 04:22:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:49 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 2/8] watchdog: rzg2l_wdt: Remove reset de-assert from probe
Date: Wed, 18 Dec 2024 14:22:40 +0200
Message-ID: <20241218122246.2365189-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:22:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17446

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


