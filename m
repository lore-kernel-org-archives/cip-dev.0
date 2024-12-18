Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2DCE7718F
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:35 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.104387.1734524608774382543
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=GGTuJm69;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361d5dcf5bso69054955e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524607; x=1735129407; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0frQq1EYuR3+GgckAfdBQxSbxXb+N22JueZK+VM+kNE=;
        b=GGTuJm69VYFpllhhghXyGrtXgEfa9/kMFI3pEg4rL/n9TU10GknnBbCd1GECWksfno
         29NyRCRXRQol7u4zc2n5u6F0M4ZmUhw1EpHifgmzQH1HLAQBjQ2FTdjrh3dfkB7Tw+FU
         bJPJk6t9xsrksVl20KFh0YxcgDk686STjRONM7e6Rnc2VexwjMVfZE9B3JPiGwXyGKC+
         nCHq83c3pS8Sp+646PYtOP2nY3k8u6i/2pcaewM11bL/bnFMNqgtieRpph/e6Ixb+7SN
         ODPk4gEmuZDsaPs3lC5pZQOhad9tKtfrS/uz86HR6vxB1QZiOPWl1aIC/tJ6JJxC1TgZ
         nttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524607; x=1735129407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0frQq1EYuR3+GgckAfdBQxSbxXb+N22JueZK+VM+kNE=;
        b=oLC85LRXfiVdJ9W3o6buIG+S41t0JE0Ww1F0oTWYwUOrN7Aps8omgPjL83D+VYNEnn
         il+jc9EdBqPYTjnj2dpKPuv5lakZOmou72QkDx7JLsS7drp5vPZBLfTB1zPCjcCDdO0G
         30WAqH1Y1P5JhPq7GRiuuoiJJYzSzCXI4RfRABx7Y+q9jmTXPi/zEndozl7Q1opJy0Tq
         P9FenEgCrYKX5dzIRSxNC1/4/e8UYGxZAjXyJvvABkj3Xlb73b1lGtJ+Hc7J5sO9bjjd
         +oRRFHJUyB927YJpJsFdGAygtxoU2DaypKCeOWseVLFXFvR6tlSeExWcHWF/oIL1SZjd
         8X1A==
X-Forwarded-Encrypted: i=1; AJvYcCX0FCHpPxejm4IiP02Fc8X7Jcr6lu1MUSv9KB+gO3zxMKXjrg0l9NABttniai/AEu8oU48wAnsI@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz4GLZtHiDm+Oq7eO06Tf2FQOlwhZNvMMV1qhz/UWm9d+M23qBS
	V3+MaLwYxQmw7YBVKLwwmoEwivRAwrTu9iDH99Yo8aryykF3F2KCyukJiaMdi2I=
X-Gm-Gg: ASbGnctOBsimNjUhX+/8DoX3xZM50TzkVpYKEHS7886M+JaD2b44ls+Bo1akF0RomxU
	wWSo8SBhTGuUX7tiMBvQybA24WZO/O8OGCjspy71EnFOgD70DNr5Pob1WuDQTMYeEZgmXNH4rvv
	99LKt5pGsa4sPRn5sSj0zSTLmfuS2qNA+hMarzsemNXo1wGeSiRf9HzN1czu0TLAiSRwP1plKlN
	SCZ4vhZHGLfe8bdpGky3SpAlmp8Gw4LcQQcYirzyWo0pUrefmdabzhzgJWyxSljPPOHTI4Sp+lA
	6il28vLUqEk=
X-Google-Smtp-Source: AGHT+IHDOYcQ9nOuLCW/8uDZ8mb7ZsB7HODlV9vvdoybBDcWrpRxqJmWRQiO9TROlgPiFEwgmamZkg==
X-Received: by 2002:a05:600c:1987:b0:436:1b81:b65c with SMTP id 5b1f17b1804b1-4365536813fmr28035385e9.15.1734524607196;
        Wed, 18 Dec 2024 04:23:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 07/10] watchdog: rzg2l_wdt: Add suspend/resume support
Date: Wed, 18 Dec 2024 14:23:14 +0200
Message-ID: <20241218122317.2365272-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17460

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
[claudiu.beznea: replaced LATE_SYSTEM_SLEEP_PM_OPS() with
 SET_LATE_SYSTEM_SLEEP_PM_OPS()
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index ea535739f8b6..afc1e9f1bf04 100644
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
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
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


