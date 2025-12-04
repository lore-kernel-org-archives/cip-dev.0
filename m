Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E60D24476
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:38 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50481.1764872068640023640
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bolfR+LY;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779d47be12so11760735e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872067; x=1765476867; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nunGOImK67o8D6rM6pxdV0FERLb65jv34uADvJqd0OE=;
        b=bolfR+LYcUm+ZiEZvr7uljBThFFlTmna0yrLDnx/aCQvXF5kUjFCXHbvzt+NsL2I1z
         OeUgQbO2iT9MZhR94EqzSIpgzCOLpilz7xmqnGYxPPSFZGwP3GKhzKHJK/M442qcuRvB
         jpnNAGkM8l8SxZmR5DRpRMdBUY1uP7ZXUPmjTd+bFv2DTDM61vl8gAUIxChm+nzZjY1Q
         nDli5jUC2ds8AS3rSj0Trp6Kb3IyV75YH0HvxIVMyg3CZb/dDBQ30Nyk/YX5OB8t4fY4
         vA3/Ewuv6DDphksuvSHQ0MZkp4FZhZlz1ki9krjvwQEg4uuW7T34+kaIBdzJANc55KxG
         qAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872067; x=1765476867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nunGOImK67o8D6rM6pxdV0FERLb65jv34uADvJqd0OE=;
        b=JiibzC2rr62j3YKSGE2f/OqB842CFmHAmxCWnbQYZnG1po2nt1aLF57GzFp7fGxMZA
         d7EvklJlV6omUsY83whHLC+brhSD/HcealXkflWm6t01G29Ky3XVEvAyZm9I1rlgwHRf
         zFBbyG5qVQNHjW0yGb8T0Trcz38cvaFaNNLSU60B3kw7yw0EHJfUBEHDJi1YFE2JvcSW
         beUJ0OJCgCxTN+2yK9lXXM1vJjwHS6k8bEZwNhmMcsUDQ3LgiyCRpR/KUhMfYT4MoTMj
         M4fJKY0Xbbx0nZpcTydUnPYma9A9KY7g1VMVc+arVZl1zNgCvAcMm2ESJ+Pza3JpvWfe
         IWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPSUFmvygs7YCbEBr10leP8Mw5MLBiFPp5Z7r8SUpbBIbJ3tvhM+DOMI+m0clpfYtKrRjZVO5g@lists.cip-project.org
X-Gm-Message-State: AOJu0YxCGnIhD/EMj5bVRn6166jYJzE6r74fffDJPPUbSwIm660Ex22a
	g3QcSi+AoHlFdgt4ZakSLbRmssX74rSUKei8/4fO2fLOZAWxvlvSgC3FwHy5dOGgdVU=
X-Gm-Gg: ASbGncuE6J+l1OoBIPGztdinjm1PkU6z5dYsb8B7NnOFOqs2kJ3jD4tDXBIK6syFyKT
	GQzEI9WfbwzyHM72ec89LjUj6uNHWaAoZZjXLVDswpuutHyijvIcd4znTBawfNViKBx/E2vbzS2
	SqGW6hbrVKyIQ39abAPVW15/bOnHaMCO83iJWYemnpvnAO7qkqLYeJHrayfYpVCrdwlTZQRfDpy
	GrVYfwP+o7BwD4c2IPTtaBbNBIEy9mvlY7/uBU2L0qygtFI6Lw3QH9Tz5mhxoi05iknfUNFSOsg
	l8IoTYATM08vP/3+8pvzQC+/BxBogU/Hd/F8cFULJq6qvRz7jNZWO9p8VQZvo8dYcHCeimQRV32
	zkn/jmodGe0eC5NgWO802/mOVnH6Opwq39g0JWiX7QymmWJ7LhH+3pHlN2pt9gYgxfuYx2A4N/V
	bAFVsflB++WDFnyeqqs6YZhU28ZrR3TZ+RGBESVzAa
X-Google-Smtp-Source: AGHT+IFdUhoUGAj0wKW7wJP/R5cuUHaqWLEhvT7Z75M2YxpQruevbSGvIxE73o+amjtJmFT6ihQpfg==
X-Received: by 2002:a05:6000:26d0:b0:42b:a40d:713d with SMTP id ffacd0b85a97d-42f7317dc50mr7883937f8f.21.1764872067046;
        Thu, 04 Dec 2025 10:14:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 08/18] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:14:05 +0200
Message-ID: <20251204181415.689009-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20855

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
[claudiu.beznea:
 - fixed conflict by keeping v5.10 CIP code
 - manually added PD_FLAG_DETACH_POWER_OFF
 - drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/i2c-core-base.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index fea3ea0bc08a..ad223e3082e9 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -535,7 +535,8 @@ static int i2c_device_probe(struct device *dev)
 	if (status < 0)
 		goto err_clear_wakeup_irq;
 
-	status = dev_pm_domain_attach(&client->dev, PD_FLAG_ATTACH_POWER_ON);
+	status = dev_pm_domain_attach(&client->dev, PD_FLAG_ATTACH_POWER_ON |
+						    PD_FLAG_DETACH_POWER_OFF);
 	if (status)
 		goto err_clear_wakeup_irq;
 
@@ -557,7 +558,8 @@ static int i2c_device_probe(struct device *dev)
 	return 0;
 
 err_detach_pm_domain:
-	dev_pm_domain_detach(&client->dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, true);
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
@@ -583,7 +585,8 @@ static int i2c_device_remove(struct device *dev)
 		status = driver->remove(client);
 	}
 
-	dev_pm_domain_detach(&client->dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, true);
 
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
-- 
2.43.0


