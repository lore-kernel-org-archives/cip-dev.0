Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD889D33A24
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:21 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31300.1768466111790382756
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=S1IQ7KDw;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b876f3f603eso117829866b.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466110; x=1769070910; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPPMWdngrmyHD4gQjTSMQGE5FpovXitWFOD5rLdt3Gg=;
        b=S1IQ7KDw/CnP91Sr7lhXhjwkIyS2UeOPPPZPiusqydak5uiqkRcKGCJv+Rnppg0ZWr
         7lj3VGxuBtuLMNqHNkIsajn03cZFY9D5iRH6PptL03i5WAeg6XJsSKAhsqVMTR6FlhyB
         dEuSona+3O7wkhd1o7e+YkGa3BX7T6xcWHKhsfMCrpOeOfpteu3up5M5vobnAQK3COK0
         ofG8Y1Z75xExiF3utC5mg7tmSHmztXmtjIEjewcYATxXRn4tzDe5FMz03+3HvlSbo4+q
         gcPKpG5+Nk/y6Z3tnLops4mUnuHxEf0mwx4ZAF7LdI8+k8GQxY4bm0pgIlVxA2BH34tz
         eRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466110; x=1769070910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPPMWdngrmyHD4gQjTSMQGE5FpovXitWFOD5rLdt3Gg=;
        b=Kq912sPeU/bmuDn5HBG10UeSTR/p9iAvlEv3kS8KjSLnYjxMPi4VbC35uyMa43NUpl
         2zE0KzVuq+5FO32KLRqLn052FssbSuu29Ltxb92x3Z8bQujbbV/72p/GdVlbK3fdOJeQ
         0xZXKM0p6o7JSy1mpeRFZklBi6/3NTfQjE5ELehtg+frm8L6SnUIiNo0k8RbNcL4AsbY
         n6/FhwRPlBjH5gsKOoizDXHHHYwP7S/KnZkHK0zQnG4CVJBDOPddtqTVDFYzeXVtmL8X
         Dn5vvJkbIOyLCRbZJiN+HXIYLQzyLTZRQKhPiU421cHbpEcPiGcHA8jqa/kyIs5ETNa8
         nzpQ==
X-Gm-Message-State: AOJu0Yz6fVGkMm59Ze7FXo61AZQ9GPY2POV6EIp5maQ5oCX7oMYsfjza
	0l497X8Tdt+DmLFEADERRSrC0rnpcv0Mrt5QOGmZAy3lAydSg4aaJTqhu/EuwhZxgK3lR9TH9NC
	v1pDW
X-Gm-Gg: AY/fxX48XYoreuznO2afxHGOCVD8VZgIOkzr/bSH/10umw0WVtNGOAX18C6gd7DNXwt
	4BWGXvC5wOuoiGnKVnvWyi3LMZ/m9EnOsIkjYBUZGO6j6z/aeQAza0bM1bjjVHQ6kRDp/2y9cvG
	yZ2mwb3oarFaiCcRqhGO4IOiuv27YuOgfJ+7igFUoWypSwZtItlL1F2tp3N87yMqwJLN36p3kQw
	MH3UVjXB2HDKXYwdzy0w3474HHmQ+PfwMSHIYH3PohG1S9V2+FgKDOdXUHJNI8WNulQ/EuxmABV
	l1oJLdwKxnThFEe3OP1UnmvR+4OubkeaKmnlJzO8LEUOcG8ysPD3LLcrDpVDxvE9VsUlk5xkplK
	9mJ92yKkkqHH9vdzGeAzFH6KdMRT3YhV10jLpkF/C7WN5ymEelRTqgNyRgCWTSs3+RpPD7hi2Qv
	KJInZUISeZNZ2IRf7k+wgIMGh/mfZWjEU0vvDYs378B6BBx61ype85Oo9Ud0tIm/9Vkg==
X-Received: by 2002:a17:907:9689:b0:b73:7fc8:a9c9 with SMTP id a640c23a62f3a-b876106f8e1mr453595166b.29.1768466110146;
        Thu, 15 Jan 2026 00:35:10 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:08 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 09/19] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:34:41 +0200
Message-ID: <20260115083451.1064048-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21589

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
index 723dfaa994a0..faed61ec848a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -569,7 +569,8 @@ static int i2c_device_probe(struct device *dev)
 		goto err_clear_wakeup_irq;
 
 	do_power_on = !i2c_acpi_waive_d0_probe(dev);
-	status = dev_pm_domain_attach(&client->dev, do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0);
+	status = dev_pm_domain_attach(&client->dev, PD_FLAG_DETACH_POWER_OFF |
+				      (do_power_on ? PD_FLAG_ATTACH_POWER_ON : 0));
 	if (status)
 		goto err_clear_wakeup_irq;
 
@@ -608,7 +609,8 @@ static int i2c_device_probe(struct device *dev)
 err_release_driver_resources:
 	devres_release_group(&client->dev, client->devres_group_id);
 err_detach_pm_domain:
-	dev_pm_domain_detach(&client->dev, do_power_on);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, do_power_on);
 err_clear_wakeup_irq:
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
@@ -633,7 +635,8 @@ static void i2c_device_remove(struct device *dev)
 
 	devres_release_group(&client->dev, client->devres_group_id);
 
-	dev_pm_domain_detach(&client->dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(&client->dev, true);
 
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
-- 
2.43.0


