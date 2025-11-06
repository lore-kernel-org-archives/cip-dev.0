Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6831DCCFA1A
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:45 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10106.1762416757690113547
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=e0fGlaSU;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso378976f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416756; x=1763021556; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nunGOImK67o8D6rM6pxdV0FERLb65jv34uADvJqd0OE=;
        b=e0fGlaSUBwtj8RDvLQJ7u1LOT4g4KXUWhycyKHzEVqVl/82V6CJHiXWhnLEErA4WBa
         0w+Tvxe20TXY4irdtRDmLJRtqCegH3SCWQerLC9420B0cBQuqITLsmSuygcFJ8ZFchkV
         rFeyPPv541BWmyh/68OMgxJu3sI78i4VgTU894Yn0Wm0Y47Zx0BDXD7t4XdIbqoIq5JM
         u/f9C0NP/crHN/kM6T9q0zmKW5ebZ1TC0+pNFRP2wgR5dmoCN9UdYkcnemjnAQxslh7l
         SjglsnBRi12rG+RJF7NluFbON5xckEeGpKveNpWUHSvXewj5KmpP/fMHaN7Ehgnwguq5
         Ay9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416756; x=1763021556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nunGOImK67o8D6rM6pxdV0FERLb65jv34uADvJqd0OE=;
        b=NdbAKRVDV42xuxcuHswnj4Z5nYQROxDsEHDdeJwRDhabqT16ESImOSB1px74kx+qe2
         kynjGNN3wmTVSmoT1SmTh3KqVWbMWKxghooRRCVfRYEywtxiMDT/jXMDiau3p3OvWH+J
         IoEm0iSt+M1zG2U9DWLd62bGl0PaIdW8M6Z+D0m7XAs8NwhuWOJk7j00HaP4/uo1Gm7j
         sIBbRJLCP+Df0DqOhL/+F5dURPJmWMAEstTiPRo1s/Fqbvry/EKXO6zj7dYe9BMt1WVp
         lrcG/Y90/bYA7rCVEg8/2sJWq9B+aDL5wIlD0c68tf7lppeIrY+iv6jd0AvnRYIy4NTe
         bCrg==
X-Forwarded-Encrypted: i=1; AJvYcCVYOz2RtHI9NLWzwvh6XjfuwUXSwQRyyi7Nij4uoMXVhpQo7CPQy1pFrBZajjYnnrQdXHryamWn@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxyr8QlAXhG8P9jSJYD4BRqBoABTxhU+3+NMbG7IkWXG1+4F65f
	cDeTKNGxkwKvyNGamhd0tRA9ru6tzNIrRRDMIKUHY312OYtupFzhQ8fbcxbFDZY1fr8InKRsYrE
	0SBpho94=
X-Gm-Gg: ASbGncvZnhkGDevuknTH8D7zTs42T/Q1qO3QDvf8gF6+1AEPuX7i/y+bFBybLLRSKGS
	P793WuylOFOkDErpaV+su0utW9OvnG/HBkGOPVZ7oSQ8FcBC5hZHoxilFgL9j+v9a6AxYOFQUTy
	Sq4MWEvRus40KfHlFo30k9tKowbw5Le5Ae2uSA1WoByANVNiPNrzcLzIZLKkqjfZepU9pFhTecJ
	lOUiozAQo5poyw6957MMIiEJ8oNY5ifBd52lDDPA0nUpNmr0lU/+pl2Zr0ExlPYzj1HNbLcGoy5
	VCewAlJEGDtYIz3b1RVzkdIebVqB1+W96RzF4N4k0YvzmSqgADwvHHscbLaQ9tMTJ+G+v2lGGTl
	7l7YN3W15sV2Y45iSnpnmzElArYxSK/ZK+C4Vt8uZfw9+7ZopzR7gd4Vq7/Yo9yPxNc3/uj8iNZ
	6NJ+QRCJVpnbbCVhUcOJF4RIgrJiKj42IfGgW5gzLR
X-Google-Smtp-Source: AGHT+IG6nsNZj+cWxOS5nxvCwKWn3/XgaMBnq4JVD7l/x2rQPJc2G5iqKm/b5lBlHxhz6SAJzos//A==
X-Received: by 2002:a05:6000:43c5:10b0:429:d4c2:cad9 with SMTP id ffacd0b85a97d-429e35d28bemr4552935f8f.5.1762416755994;
        Thu, 06 Nov 2025 00:12:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 11/22] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:12:07 +0200
Message-ID: <20251106081218.2574950-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20428

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


