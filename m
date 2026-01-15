Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999F9D33A26
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:11 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31283.1768466107833586221
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:35:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=X6u6KWXt;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1080784a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466106; x=1769070906; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFdmiTu9kfym5+hjphT/HIIaoLw5H9M3qWSXXLozM9c=;
        b=X6u6KWXts675h1ttZ5jVySZwOh5kged6PYDShn9vXZ6w0zMBgcgvgE+ZIrAYMzcfrf
         M5HXDOMMRnHSnF8Bu6KTG/wh35ra5EmEXilxWNX4PGuVY/U9zzGia2cDHb07X+cp6/OU
         Zuzpr6ymldxJ5USLAeKohP/dkpzPCD4zfn/JPcFoV5imS6QlPkYMjf4jccQ15n5M8nXU
         vdbEuz/PCBwe+tBiEObXcqAaRUEjTZyevY4nwtLhG9sU1wPgB2YkbG4Y4O33bIXTSvVm
         emehCu8Ebm2BVnZ/UPXxNQBJFLpkwqgHWbqHTVaT/TfZJAVwMYHdbH9dOtV0QH0Fdm5S
         NaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466106; x=1769070906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HFdmiTu9kfym5+hjphT/HIIaoLw5H9M3qWSXXLozM9c=;
        b=P4BJAnmsvXCLNha8RmOfmxPXoeV8vuC/eIYKiryHpreky0vaewJTOg+8u1YdOCVhVq
         qZ21hBQX7+QFqviiLqHhFYs8YeO++LyV7SJkRchGIT/SPsXWyojF2jiDyREFEJypBNtV
         gAa096vNJG5W2Ye+C2fxP90FfIxAsyGHT85WC8cCOKObwQISVURpKK1hK5RzdEMYOTgr
         UElbf7AxibAavU7nzhbaCHdi2I/6PR8LgTZ7QURQR4Fr+CuXeJwPN4fPw/HCT14kOZ0w
         T/XR1vxB9hhBeYX3jV0KflyIZNKsw+yKjuPR3w8Dpefjh8L/E8j4dUvluK3gQ+4dI1Uu
         pdpQ==
X-Gm-Message-State: AOJu0YxG8qmlsjVKhVLm+4wNQQf+hFFbc3HN0L84J/iJvro9cukEF0+L
	eFcwTskL2ueJO12u69nM5kAW2S4XIITKN86J4mUKpkB/yFUxZ4PLZSXOMvxGf2e6dno=
X-Gm-Gg: AY/fxX4vWcBZ/aMdxbYcjkjneFUpdeBY7mD0sfWz5a/L0fFiZHBYxXZg+IsHgQb1TZ/
	UIf5o500xVq6lju+apfZqr9KyrSj+GKY0W16vkukizFEJWAA6FmWleb+TMqQDvzm2dSKmf4OGl0
	LqLKlpHpVQYqdJ8bw3/sFutoiaBFfDI6KmXs2Wg11RsGRwShhmXxhRWFSE/gtKO+p7aJRmCs+ok
	r2luSSKFwCFZarjPtvZ/Teb026vyRbMIPwptlb9ZxClU+jOOzzN82dEYigjb7lLoQY4Ep787qUz
	wqPGo/wjVLTTSQWku5nGsTePeMOWjS18THBgFBjHeY45/L6udGw45kyipJ2DXycrf9Kez4//QES
	ZU7M7/9dL5ucvlU5Gf1CVX1p2XKrXm8/4K3mzUHt2OohqsvezSXOOVcHYL8xnk8oQ2/8CPz5bze
	U5nTZaZ1BEjN2RpTUAntZDTaZOrY/ftiGGq5of+RQl+yonPFze1XyuPRQvLl2Gc9CSTOCwFuCaV
	5s/
X-Received: by 2002:a05:6402:440a:b0:645:d07:8924 with SMTP id 4fb4d7f45d1cf-654130635f7mr2106993a12.16.1768466106212;
        Thu, 15 Jan 2026 00:35:06 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:35:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 07/19] spi: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:34:39 +0200
Message-ID: <20260115083451.1064048-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21587

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c42e36a488c7e01f833fc9f4814f735b66b2d494 upstream.

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
Message-ID: <20250827101612.928008-1-claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/spi/spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 123f443a40a4..7ad2658233a5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -435,13 +435,14 @@ static int spi_probe(struct device *dev)
 			spi->irq = 0;
 	}
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret)
 		return ret;
 
 	if (sdrv->probe) {
 		ret = sdrv->probe(spi);
-		if (ret)
+		if (ret && !dev_pm_domain_allow_detach_on_unbind_cleanup())
 			dev_pm_domain_detach(dev, true);
 	}
 
@@ -455,7 +456,8 @@ static void spi_remove(struct device *dev)
 	if (sdrv->remove)
 		sdrv->remove(to_spi_device(dev));
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 }
 
 static void spi_shutdown(struct device *dev)
-- 
2.43.0


