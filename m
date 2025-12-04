Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B05D29FA3
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:19 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50892.1764872173706815894
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CRFXoUSy;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso12491205e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872172; x=1765476972; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR4fLDKYJBnHkJ72md+G+zEENAkuDpPtXwhJJOjPgQ0=;
        b=CRFXoUSyhuwUt8kZKvOI13BQ7hSNIVyu0mJbjTZtJ44rIX/KQd8Qu2vtX5/eROZAbA
         v5acxF5zChdg0pHJbc4xxLUS4E66cmXeE8MTJwnXV3SY/p3Oz/0j0sHogmRRxzHUo2I0
         tss9rQpheBK21m1S/nq4vpasrSju2IVHJGYjyUaFRwBTtYzmzGYgzFw0deR+cZwYcVlO
         xihC0DFoXta4MIuSsTFrMen6LgKuDWtZnjtqpcMBCyNeXIgny8nfl+9NDbM7Vqf89DEH
         zpM2jB7q9RCPB1giHp3Iz+NqCWh8pmOeFpXImPR6mbf2aFUXnsIWh3udbOQZ0OR5sYDN
         5ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872172; x=1765476972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IR4fLDKYJBnHkJ72md+G+zEENAkuDpPtXwhJJOjPgQ0=;
        b=j/bodQ74V62bQSOg63LHWCp9MVKjRbb/7juWn4ntaNqI63yKWJwfAWc/2B3sqTDZrJ
         87tqkh3/RL+ESD2Ki9EPhS7t92ViIw2VgCPxbw8OlR0lcbeLMh2BlNU0Yyq3l/f8QgbO
         nQZRUFGWXaAqF2+u8NqCxZl6VAbiuWkB1NRLYzLnDR+tKV0VG19PNwfTQijpxUXLoSQv
         j8+9KL9Lg/W420BVADD2KOpndXBn0218kurMZ6n7Y/OsFYNgAaUlAnE51O+fkmH215uT
         St7xonVXROLnH2BeaHSEg7/yWiTIoAKgMmEyAxC0g46HWTWFTaXtzQb2xGg8cg1tvON3
         RVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK8Z2IIBiQhW0WFPcX8SI87RS34h+d+F6M29C+ychnYz6XbERSlrkcFpEzOgpGiqMbhXzulNwC@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy6PoOLy7ukCFZTKKiQeZAdm42bVigw6QFihx3sL8/Ee5pI+YYT
	IaCP6DTqAd8E1pKH2tlBJHowtc9RMuvqnfNSPmUokfx6t0pKR68oYvRn1TVYaES27oYPZulfzuF
	AVsIv
X-Gm-Gg: ASbGnctUs3R9e8IcFzIeLb24GbXKZWPSDZbGZfo0sFOWil0SxwQMW13Ma/ggZJ50x02
	zJeEJ9rahxkYI01u3rCQa4VfCyfUMCGF4UcIIjD8eBxFJ52tFuYNxUR9H5TRBWtURIdtg3i5wI+
	pXcaPTXjActUy129BWl0cwxtHsGZ/SGjqxxNhalfibAU167uEdtDxdjAxAT6sxYkOC9dj3sm5s9
	AmauiwKeUTNiPJS91leURS9RZP/pmvZmMuMHt8xB4XJq9JtlZTT7p1gZ0SboxArG/lUw9wK4b4T
	V4TR1cSfx8a84It7xjEimYc7AI0zKDX3os+1ufmVW9dw1YF+cCME/9h6GrNQOMDIbztVjgaZLaS
	gdHKQlkiXkpvyXzEr7sQewEw8Sjj3+9mMQ4Sqy2St+sTVsqmjAMKYpkl1V9C6GmX4Sv4JH4sc+u
	HhvZakABtqPno7PDPdsCr/FMv9sSEFPiEj77NzRoOfpQm46TeSYGg=
X-Google-Smtp-Source: AGHT+IEzbJNDGpwdcIf0ckIJSNQYCU6/tdpvjlj3YBV4eTu60/Il1EOnU276i4Ec7Z84ZPSj0Ebv5Q==
X-Received: by 2002:a05:600c:6c49:b0:477:3fcf:368c with SMTP id 5b1f17b1804b1-4792eb5d733mr30281265e9.9.1764872172027;
        Thu, 04 Dec 2025 10:16:12 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 08/19] i2c: core: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:49 +0200
Message-ID: <20251204181600.689203-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20894

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


