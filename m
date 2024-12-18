Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2DE7718D
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:22:55 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.104173.1734524573041231026
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:22:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=l40opJr4;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e06af753so3313321f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524571; x=1735129371; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXMNAESOXHqTAoAF8i42CNtySnBQQXTbd8Cyrt6OENY=;
        b=l40opJr4QmcXAkzOelPb8KHazYOFmkl5xWlHSVcG+aaM6+02yQflhFytfYHY02uOrg
         eXmSHUkgY2+pJqIOYCC9xXbqjrcAauyx/VBflve5qGU3rV24yz+qSTjndH1O5n4AeuMy
         5waFbcC4yIi8km8QvvXvh4S6slHx0yBzMIn4pJAfIk4Buc+wrfzsQxBQMH9x/ibowhz9
         k1T/m9z8ZVdJAzD2gi46fE1hKmFtcRGwaE7d0g2PgXza4hZ1K40nKBg3fHES4QYOzT10
         Ire3FmQ+GKYEOTVbt4xJCpcuh9zOZlojWtTNVf++a/ZVwWFIi/cBuVeroHrNic+EmnTr
         zyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524571; x=1735129371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXMNAESOXHqTAoAF8i42CNtySnBQQXTbd8Cyrt6OENY=;
        b=Umr8mTfnanNKaSvf/INO5Sm6o4+pXnNic2ybU1y5ORyBx5eAcoitLNNqcvYNOBvbn/
         jECtC9vO+2QL44yEcpzykyne2Tedr+94eS88IR5qYuPrz3RzU7DgjdiwVpRJ5pHsG4iz
         j0Tkok+cEK743wcrSAvqkDGXb2Bs94RgkvcLPNP+qpBd34iQdGeXGXhf+A5vlv9sqzkA
         3YVV7J3m/kmuJ/BJAMwxHwmKffG/7/Q08aY2wu68NQzc1j/qa4RgYBT2zk6o3mGIAZOF
         4PzXrI6Nh9HN9n29dV1S9XA7Fj20P56tnEi3nQxvfFA2vfivN48ypmJ47+mSSP4WKcnk
         b0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUgpw92GRdchvDSKsZuEVIGJ8hFhZ0XO8i3XVlYD16ZjM0G9+xAT7swDY6L8X514PCXt6gd/4KE@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw9Rn0I36ASzqH3xulGhxtJppdFseGbOPKM+Yf0NEdqAdz4hAi4
	BbdI/A5Es1XElfUeMAvHTfbGt4k6/q0Wi2b8LpElcEgPrYdZjbCREIbuBPTlZzU=
X-Gm-Gg: ASbGncv90sqmkSoDWh96e4XB+jEP803xcALwmX6YmBnMceet0j84Ca36cX/sSgJVOpf
	cUXgNzihA07x+h9LRWA68NTvO6kfjqU86G/63VzeYXNm+PMEaOgdIdml97xiSqjbhpVPBuCKana
	fOrVgQEyuV4cdoxk8dxFksz0rdOt3yKCg2AavZmbVUqvgnmZfWtUaIpXrHblvt5EsCWZBq7GIwT
	lqz2QtcQbv2KtdTMwvquH80js6JHlM/Spi9rBpIpXM8dC2QFLWfcJHqdy4ggYOhqCcSqgSho0oy
	xsun3CqBAws=
X-Google-Smtp-Source: AGHT+IF4NtSaE2Zj2VhDIMZB6OxC8qNJYaUHfPg5xPO3HF1hZL2H7huGdUMuQmQWAbupzAGxvS+HxQ==
X-Received: by 2002:a5d:5986:0:b0:382:30a5:c38e with SMTP id ffacd0b85a97d-388e4d8b38emr2482602f8f.31.1734524571459;
        Wed, 18 Dec 2024 04:22:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b2dsm18790365e9.12.2024.12.18.04.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:22:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 3/8] watchdog: rzg2l_wdt: Remove comparison with zero
Date: Wed, 18 Dec 2024 14:22:41 +0200
Message-ID: <20241218122246.2365189-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:22:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17447

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 900b938335f7fbd401dcba14c8069dbf38ed1f28 upstream.

devm_add_action_or_reset() could return -ENOMEM or zero. Thus, remove
comparison with zero of the returning value to make code simpler.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240531065723.1085423-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index a473de5ff886..2c50e4c76131 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -318,7 +318,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&priv->wdev, priv);
 	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	watchdog_set_nowayout(&priv->wdev, nowayout);
-- 
2.43.0


