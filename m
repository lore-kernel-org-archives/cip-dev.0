Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EE7E7718A
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 12:23:35 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.104194.1734524606492258166
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Dec 2024 04:23:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PuotNHcT;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283dedso62035115e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 04:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734524605; x=1735129405; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXMNAESOXHqTAoAF8i42CNtySnBQQXTbd8Cyrt6OENY=;
        b=PuotNHcTZ9k3R0WbWXK7RpNKR+nZHmPDiQKAIB1EzycH7EkubR+CWaFmJK+R1zLQL6
         cp3MyggTaGgWsHuM1jrl11t8OcJtchz/XTX2WgpDT4m2u49OWUfcGM3BVxOXjytG//FX
         Unc7K8UhYqgYPhl9iwgVOi0GrULiRxOldHVtOu4YXHN0JjRoGwJs2YEbUNu1qeOg5tu0
         bWW2YaZtpSqLhMz4MQhUEIaqLhkLC4MW52Q3Bh+8IOeZlfhTQOj6t6TsXp38/TiFnwp+
         nLIEWgCXfrqu+DF3uQSqWD+BCB5jranZNe4aWYMrWtaZXz+pDyNkXSqxmIgM5Zd/c4ko
         jINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524605; x=1735129405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXMNAESOXHqTAoAF8i42CNtySnBQQXTbd8Cyrt6OENY=;
        b=sjCQOlF6ORe0clPsHDpSogSB7HLGcTp0WMJVscTW4XS3aa675BqMuPNUBimA9Neqx5
         9ZM5knwAO6j18Ew+LHxsozQ8SYHni9iPokfOd0P9QahvG4NxWkDBnYnNYYrDbE0Et6Y0
         Vjkv8vN3oD9TvBwBtbqwNTSooxdb/Y0G/Ai+spzQo32+2mEYhqDc37xgdCaAYFU7iWuL
         WgMvazqotfcvgltx3YpzPV/AgETZm8B5mW/NTZ9H/YZe77U1zA4C4GNzuXc1BQPOJk+B
         8KINR3JtVhSBJuZ9gawPREv3vHwyg02vRniQAQJNSzjBET+6pmzWX+RnK2cOvzdfOr/v
         7cCA==
X-Forwarded-Encrypted: i=1; AJvYcCX2PKEJyTr2QXW4DyyVKYrl/VsSLG0khBG6aUTCCe1jbDfj3qz3KDHn7F1wWp2qw+GW9pG9RuzC@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy6SRmxbgrB5iN41yB53rYcxpYpqkCHUXG13CBDTfg3snxiQQgu
	bgCNNysvbQWaH2/OClafVBcGdC4Owhott4Qh2LnVup0e7upuanhKZAcU5ZB0Mi4=
X-Gm-Gg: ASbGnctQ97Npaw2NEb1/owNxFgSeHIilK0N3rGd1io6rHVuzCUxQLwTQJIwC8n9SnQJ
	29csa55asHXgGdspM49nNR7aRgYMMpw9lWO51Uf0twhHRUFg2dBbQKg7xs7MCHmZC5PE7qnaYDB
	yn/rbQ7DnIc10jVG+6BeP0sEbvKz2WVl0wtqOftbQif70yRm2TDqR13zJZYNrk1XQgWuSbh0TFO
	17lW+sl9LtK2QuSFfmix8QcbV1R2YsqusTcD95gek+AgmyT+v91thML+557Xg3xc0sTTQy+XiGv
	rZiO98+BiU4=
X-Google-Smtp-Source: AGHT+IEHsUNBD4GSJuTGqz5DMvLoW8Q3c3iQ0vVcy9rBLt03oPXwSO/V7XBife35AXRr/zXwRsIb7Q==
X-Received: by 2002:a05:600c:1910:b0:435:1a2:2633 with SMTP id 5b1f17b1804b1-43655368155mr26855145e9.15.1734524604905;
        Wed, 18 Dec 2024 04:23:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b01b15sm18746445e9.11.2024.12.18.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:23:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 5.10.y-cip 05/10] watchdog: rzg2l_wdt: Remove comparison with zero
Date: Wed, 18 Dec 2024 14:23:12 +0200
Message-ID: <20241218122317.2365272-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241218122317.2365272-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 12:23:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17458

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


