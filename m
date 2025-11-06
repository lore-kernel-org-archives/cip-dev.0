Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7424ECCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:14 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10010.1762416666258254874
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hRF+eyUV;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429b9b6ce96so470471f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416665; x=1763021465; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR4fLDKYJBnHkJ72md+G+zEENAkuDpPtXwhJJOjPgQ0=;
        b=hRF+eyUV8N/sCcatnIKtCgmqTN+2MEq7U2IqdjJXzQSsWyYPxeAjCU4js7f2BUAajw
         555ltIG7MbeZnu7s+HMBahRGt2BUbkkjqUWWfq9SnAc4Qnpt36A9jLZv8g8L8vy5mh8N
         cGyJYZnecM0NbYr3T1wZvE0S6P3PWPzejByW6/8KqIp80lMTaaMIyHnA5V9ZZEYrWn0/
         3CDlVl3Hk9RRzjsAiuEbiIzuEP+Wc7NF1zKm4t0kxgNAkrMiCdudALvSxz8zCuVZE0Et
         K/vWqJVD9Jf2aP61cQVezDDhcqAWUcqo+tNUEDRpbgeHdYPuhOJqGM4yq5r/MeeF7c7X
         AcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416665; x=1763021465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IR4fLDKYJBnHkJ72md+G+zEENAkuDpPtXwhJJOjPgQ0=;
        b=uZlIFmAHerbWNaqmKXK1MYOe3G/RoW0DGLIfMoGdFQ5n3OmMVG8p4mEBlc0FNZOPXa
         iJozK78sxYIVn2wvEWA1oHUrOF+yxYrmCeyypdJ+2EK9+TGGzuEv5aGmOCBudL4bTpmP
         6M0KBR3rkW2/RZQihoK8T1EsEo9v+NI3k3pswD5JNLEYSSZxkGoiyyUnaXBpi3fcUCY/
         icFwf0r5STpsMzZKyeEw83nE4nxs1tatsvTau3VjMx71mnrXkWZ6lcvgiuw5HW1xwoij
         8SwnoRHjdpfWUFGleRSyb7ezCGjF2dQCYZUuilEhzE7/A1Oz/bCetW10LtAu6dri75dv
         udfA==
X-Forwarded-Encrypted: i=1; AJvYcCW5EpOjIvcoZUsUdeQNBEKwgqvTaJDdwb6VKdnCHevIEWhmflNjXvWkSOtYMgGvcZHnGCfgS5eU@lists.cip-project.org
X-Gm-Message-State: AOJu0YwsDWUeh/odDLVVxokac41IG6ng627TeotzCZfj3DloJAo3XvLg
	U1XGB3Dsg3YXh54o0ucNWhercKVc8kOaIX8XO6xt+C8zvgUcxKHstgcr9jektDQVEMr44hk5qF8
	hgjfzees=
X-Gm-Gg: ASbGncsNA+s+ikk4rsmONM9CdDem3AfRGg4H6kTPfw8pZMojN5KzyWY9UhBWgzhcEXx
	vj1YdABRkfeEqeUTGCjkv6sFt5I/oy0levQyJXC5doAf1EUNCZZVmqzQadiS+j3lhUoU9Xe5WNa
	pXL+qvXkAxPpYWKyo+wgQN7fAZf8LYJFni/DW/qjNpND30BWIpkRgrO41xQGgR7DBVk4yPxgvUd
	gUUcU5RvESqrO7oSiZPebUJR+iU85RyxC9L3VCWp6HkLaKPpbETp+oJle/BPYlJBDQbmDwOu1ER
	KbEQoBDPI867gmSWWt5bDxBXvLydjbM5ms6Y7qR6DYlIGexG4kjerAaGAzNx/S+r6TesPsTyyG9
	1brh10oT/zxAf0hYUa0PZMRn4hDRloUiwsJTzn3Wo/L9/k5kebL9Hx3PmzHkA9qZtxUK5EMHlqd
	T0/8/FOg3oJlZxvVUdeyP5du+U6S2QzT5tnnDZcQ+u
X-Google-Smtp-Source: AGHT+IGvp82ivhepJTcyCJ5JT5F5SC6FbdXfbYDUOnfB/l7TH76AnJDtcx0j+m4rMM4zT4SThk0U+w==
X-Received: by 2002:a05:6000:23c2:b0:429:ce0c:e668 with SMTP id ffacd0b85a97d-429e33079edmr4119968f8f.38.1762416664586;
        Thu, 06 Nov 2025 00:11:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:03 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 11/23] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:10:36 +0200
Message-ID: <20251106081048.2574345-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20380

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit eddfe53b0d84b02802432bf783ccd53b095dd10a upstream.

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/i2c-core-base.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index d70364e6ea6f..4a4756cd09b0 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -572,7 +572,8 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	do_power_on = !i2c_acpi_waive_d0_probe(dev);
-	status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
+	status = dev_pm_domain_attach(&client->dev, PD_FLAG_DETACH_POWER_OFF |
+				      (do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0));
 	if (status)
 		goto err_clear_wakeup_irq;
 
@@ -604,7 +605,8 @@ static int i2c_device_probe(struct device *dev)
 err_release_driver_resources:
 	devres_release_group(&client->dev, client->devres_group_id);
 err_detach_pm_domain:
-	dev_pm_domain_detach(&client->dev, do_power_on);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, do_power_on);
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
@@ -629,7 +631,8 @@ static void i2c_device_remove(struct device *dev)
 
 	devres_release_group(&client->dev, client->devres_group_id);
 
-	dev_pm_domain_detach(&client->dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, true);
 
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
-- 
2.43.0


