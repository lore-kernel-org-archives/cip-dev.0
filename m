Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D344DCCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:54 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10041.1762416713811997980
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JvI3gXeo;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c8632fcbso461822f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416712; x=1763021512; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPPMWdngrmyHD4gQjTSMQGE5FpovXitWFOD5rLdt3Gg=;
        b=JvI3gXeoGk9qsDjkifOma0onCm7J9g6V/TzSm+j/UBbgPrbqliItsj3cAkixf9bFTS
         3IlALcISSXpu18ICAiGP7gatyhiLLkryURRGUfMBqykkA92+7ZScAMXqlj/ChNM1lGTa
         ZDLVVAiETAIJqd4U72KIKkYdZqrfTM8kLc4jeydLFnDh9I+LKjDxsrGY6uqwgJF4iSvZ
         t5OBTGNaFxCOhSu4ecXQbGVD5Z1ovvmh5qIS+rVEqQiV/yOP0jWJhSNXTuIArbOl5MDb
         MHz3yJL74Gbpc8G2TRarhHPEhxmWPy5YctyNUqScUKjgo9C1RGEv/WL48kpezrGugwsq
         sLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416712; x=1763021512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPPMWdngrmyHD4gQjTSMQGE5FpovXitWFOD5rLdt3Gg=;
        b=p0LsI8s9LeggCrzo01jO3KhNuxVmipP1ACufU/dzVsFbqDbdtZHMf/kkSpBQZThxuk
         l86XIfcOyOnRgHL1CJw7u1vw85vslIMdBkUjU555Ur/PtcVz1edkC4jJ5Qo/P0m/U6uw
         tIoMqFuAcPM0Lf38cR67s+7oCsaCkMIMjqQNeiz1CdjwsPYVsM0zrtmSussMXxF/1QdW
         h42E6tEOXTDB+1AG1uTC7Ip8hbTzxI41i6lB8mLBicZ+dmI070MVVWySs3vzC4DhJbZY
         5V4O/rPL+ogdCV/ehAo/YodNjc1EBOFCNkFuWrKW4NN7w1ccc+ffa0rwDJ5zaKu402jm
         7oPg==
X-Forwarded-Encrypted: i=1; AJvYcCVrnvHXn0SL9ws2U9XdT9k4Ir/btc/ZB6OgqQrSfZNBwN/EiXBjAiAUuLw3b4C2jn8fA0SmIU4S@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxuua3/CDvk7bY7+CXKijGQftb+V9on+WPtW1QoFuaq42+wCJAR
	Q0RG/skc7lRyQl0eul9HpI6gQy5Gt3Zk1CNkPYJbUNXd3sXiuA0Ji5Vcot24iTwY5vX4sRGrP79
	6jZeypvU=
X-Gm-Gg: ASbGnctQPiIS4IOzCAna9gZ0a9dcYU7m1OCnG/ba46IBxbCNiv7rxkyeqvpdpl1iWyN
	wCdKLJHXH+RveDgo1AE2KvPVDXtLyehDXSAnSTjqpcQGpb8nyBJss7Q3OZljdEmNkFgGreQxhDy
	M1ACNMAuN2x+p5HI+Ikvxw3Lgcm88sXK1ybi3Ow7IsbzrZon4iKfzJSKv/as43N4q6yo8b3JsKG
	a8cWyNS8ZwcRNZwzG79i3AJHLCVNw8Ej2XWG0cBP9TajbVT09MxwB7eI3Uka0mWG/jtTHbsL4J3
	BMgsI4URNPN/tHfW5tWpSIn3ZZQRs9StOyqaNL6J35bFz/Qk+KwwrwWNxRwEv4lJv0p5DE9fZix
	Vm6Pk+oLUNzxE/2Fz653zAP+k1mBWyoqqqyjJY4+2BejAkdGEMGjoZ1iFLk9yayet2kwn8czSNB
	rga82aLBJbj3VkszcryvG/nujBRAf8GbHK7Lwl6RJ3
X-Google-Smtp-Source: AGHT+IHbZzoN4KuUYsDDN67jKzxmr1ZA+wW4Y+GGH5sOhbw5iJnI+/zO5CXyqfjIEUCsP65dAFE2gQ==
X-Received: by 2002:a05:600c:620f:b0:471:9da:5252 with SMTP id 5b1f17b1804b1-4775cdf266fmr48522825e9.29.1762416712193;
        Thu, 06 Nov 2025 00:11:52 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 12/23] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:11:21 +0200
Message-ID: <20251106081132.2574638-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20405

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


