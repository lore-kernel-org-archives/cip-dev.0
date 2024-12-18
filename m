Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCE7E77187
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:05 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.104174.1734524575457942041
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=f7yxgLNR;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso42820405e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524574; x=1735129374; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44ctTBMoa2HzWiBsJcDtwFsNFV7tAjI6H7nyFcNUPP8=;
        b=f7yxgLNRuN+hMM5fQl+94gvL040uKa9ZzRckL4ci45QmyKigHG2+oWFFgf4rfdwGYa
         JZGipm5GIwRMxzjH5zwpFZtQ94+zxcXOgQtAd29ViEorN02fNMxX7oPiXVzdIG2FWr8z
         EOSJ4HVfVFapgarcHhxNvOctQIfoD8T9BX6WxcqCIFnQ5RkTTS6LKULPil371xsXE7dR
         hX8CoLm+91Qs9KPPDEpAmb/J2L3Vc/wKuSoKy6gB/bWGMuiWEvJHENHr3v0rSTY+ajuv
         FHykqj8dlMV+FSj3oYgThDSM9tXaIsdlB6A+7tSnXhhtQ4rIrVJo0+s8GFkKjo19B7jn
         W8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524574; x=1735129374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44ctTBMoa2HzWiBsJcDtwFsNFV7tAjI6H7nyFcNUPP8=;
        b=sir8Vs21MZOQMcIOb4SQIzeIjE9l26sogexoAJwzeES7zNqEiEwB2awm2Mg/2lIjf4
         mYKK/r08SLzo3vkNLrud0vcJmaggv4uv6K2Hw6+iR9REctoh3Ye1dsA1FoEWB56SQ6ph
         CBqcC4as7MfEW9/BnD7ugQKX8qY15XHbVdkhFShIYJ0dwtjLhEZK0SNiVf4t2OCGJF7O
         PjMOqEebkT1+D9KIcw0ryJgzy3hOF9KfMp49PQ5FyGO8SP0rj4YqtEr+6Q2sjd5RjsPf
         8nefoTVTrfPUIcA+7IPW+IuarNgIwAtCHbTD5hkNu/qIRzymuJSkCsje5ryF5rQZhyy3
         XN8g==
X-Forwarded-Encrypted: i=1; AJvYcCW9umlGv8alLs8pdyfjsX4f2cHdSeNBLeFU81lSTRYQYCvywajvyPeZ4XeFWG9MaFbC3flVlW0h@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxb6vSds21uuGDqFCKSv0tOPy4qZrgLqDngu2aiNH3Y6CRmveLI
	94t8EKr5ywK27GibvpKEKD3brFs3OS82Z7c7FyRfUC4S5CTC09Jw6Ss83wL6hvw=
X-Gm-Gg: ASbGncu4wvf/gz/oKjCZCnzz7mumtHDWbbtzQL7EMiiMVHOe6UXRjw/uaZtNCpIcCKf
	cM97EE0aGg1yc3NCFHXbuz5j1KkcyToS088SSfLwDJRoZeBgQcCW/U7WTTCRFvoxEHA459up4no
	JYZk2alTAq+prEif3HmJMb5v5C9o20Hf4hkcU8v7pirzivxY56y5tPszxfCg4MCCdG/vx5gmZfd
	4whKD+6ibNjKhEM2zkpDxYraLn+kYZRmvnyP76mQoR4YX503q4k90kE7T8uOpwaSm7cIYvtr3xN
	rr+b5l3ZVrU=
X-Google-Smtp-Source: AGHT+IGES/i+ohaDbL3B2o+9bxhE/OHcCkjlpRfSPcTBuVm0sp0ef7TEa3rBLVUdeC5ClxPVgsLg9Q==
X-Received: by 2002:a05:600c:4508:b0:434:f8a0:9dc5 with SMTP id 5b1f17b1804b1-436553602d9mr20534965e9.13.1734524573900;
        Wed, 18 Dec 2024 04:22:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 5/8] watchdog: rzg2l_wdt: Add suspend/resume support
Date: Wed, 18 Dec 2024 14:22:43 +0200
Message-ID: <20241218122246.2365189-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17449

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0aad7c4438b2e87359cd7b42c3e11b17f477ab8f upstream.

The RZ/G3S supports deep sleep states where power to most of the IP blocks
is cut off. To ensure proper working of the watchdog when resuming from
such states, the suspend function is stopping the watchdog and the resume
function is starting it. There is no need to configure the watchdog
in case the watchdog was stopped prior to starting suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240531065723.1085423-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index ea535739f8b6..1cf7360d7d48 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -286,6 +286,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
 
 	watchdog_set_drvdata(&priv->wdev, priv);
+	dev_set_drvdata(dev, priv);
 	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
 	if (ret)
 		return ret;
@@ -307,10 +308,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
 
+static int rzg2l_wdt_suspend_late(struct device *dev)
+{
+	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
+
+	if (!watchdog_active(&priv->wdev))
+		return 0;
+
+	return rzg2l_wdt_stop(&priv->wdev);
+}
+
+static int rzg2l_wdt_resume_early(struct device *dev)
+{
+	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
+
+	if (!watchdog_active(&priv->wdev))
+		return 0;
+
+	return rzg2l_wdt_start(&priv->wdev);
+}
+
+static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
+};
+
 static struct platform_driver rzg2l_wdt_driver = {
 	.driver = {
 		.name = "rzg2l_wdt",
 		.of_match_table = rzg2l_wdt_ids,
+		.pm = &rzg2l_wdt_pm_ops,
 	},
 	.probe = rzg2l_wdt_probe,
 };
-- 
2.43.0


