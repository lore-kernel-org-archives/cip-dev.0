Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6406FD33A18
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:51 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31259.1768466030657228847
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WIk2xkKA;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so965407a12.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466029; x=1769070829; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nunGOImK67o8D6rM6pxdV0FERLb65jv34uADvJqd0OE=;
        b=WIk2xkKAvkxh4PZPZyFqaWYk5kwn73RDCPfetgCTtRtJNXMsYVQlUlX0rFS0clDmoC
         b0PEg8yhqUuk9ZxUZNXNTi1oVIWT/2j3rBvooEnzQhkaiSO4TKIfdF6YkXX84AciENk2
         qqsT/LdIaqajRQssfDxg9ZzPDUkmhcaLdF1X0gURMXTlj74XYxBMBPp7NsXjwdFOpqYU
         qY5iv42v6ZarKuFxtz0vPDcd2jloWl5y+Jd0NRB8g6FrRMzdWDCEn6RlSA8Orf2FSilv
         gRGHUiIHsKWJBvgfF689PlHJ+HVLTZCOtmptt/wXDE/Ze3lupbBhc/ZFZkpPpMDYlT20
         WNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466029; x=1769070829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nunGOImK67o8D6rM6pxdV0FERLb65jv34uADvJqd0OE=;
        b=jQBeSAMNT4kCyeA5HIZnemO5heT3aXcHzqJ3+ETSKEq/zX6aymW5hdLgfvsi1utLpc
         EeVDVuEJl3cj7XuwtWvdgZx6q0xAt8pBxrCopDaaiDBMbdGKa+uSsWBFptD1q9Rnw7CN
         FK3qQboBF/0JPUDCAeId2rbo95Z+UC2VTvJYszF15NAX1639JR2p7TU6PiSmUK7m4mcE
         UA+5hVAJbIHMjG6u+yosW+dqO5JzNTEyj3AYU5QrfdH8z7P5mpCo/rxzJQbsfr9qvfSL
         us57wqhpkaNuDq6ZuzJ4JyTv5twil0NnRRtHaAnJ5k5j+S3R98EITujr97lnvo+1+XAF
         Q37Q==
X-Gm-Message-State: AOJu0YyUeVjErATSb/Y5F38uf1YrwxGFbNoMfaMs5gDJhpIkM2VPbrYS
	PfBmLvCb8SzB5aR9MwjAGx4GZpYJgePidHko0/JH8SfAgIxGezqFjC3zEr050SIcOYlu/cljvhM
	kAGcR
X-Gm-Gg: AY/fxX4VfU8W8HSXwih8QJ+MMQAn/Ee4YYmH+r6F+Lj1GeLS5jXsijJnMTs35f68YeW
	IGUNI+ApZDoE+mBKXuvMy1CrwY81pWtbkqQcF+dpon/TYgIus+UnY/qfVIeImURh442LWejXd5o
	VnhGboIkzTfWDHSGx5xP2OyanU8hXzh0R2jG7ryJJBhNncXI2WQytPY2lPH8fCVDYfu396HIZFO
	GCXAQ5vViqxlOXhbgfzqgoSWYWVSbAJOB2VVdcvR20V/LdXnJloiG7/hbjOenL3qSG5uYg2SCNM
	QvCEyPQ9dcbd8kA6DICWfAS+t7VgjR5xYUuzGI/iUzuPnKD9l32gqp+O0h8GvYV2zBWLECvmGzI
	RgM5CRgA1Tdu7589BldvEY+cqqxJMs4LqUVJgDafukLh0cKm6MHVNhWMy9CXUhn4TOhLMYynD1r
	FaPxVL6L01j7efwkqBfDHOIiJkOVJflV18CeSASwbXV7Wvq7U6EH04bVEwjbtrFt7vbQ==
X-Received: by 2002:a17:907:724b:b0:b87:15a7:85ee with SMTP id a640c23a62f3a-b876127693emr414665166b.47.1768466028988;
        Thu, 15 Jan 2026 00:33:48 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 08/18] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:33:22 +0200
Message-ID: <20260115083332.1063820-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21569

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


