Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A27ED29FA0
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:16:19 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50551.1764872171291339482
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:16:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=o2k+sbAm;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso10247765e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872170; x=1765476970; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVq91KWNFTNbXoD+ksXzxIHQB6mSL5DlFXOK3kG3OWE=;
        b=o2k+sbAmIlTmIuhEXtf60NieZg7TGGtOQ5cvWb6/umYuHE1/xsd9vklK8fdd79GpK8
         495+aY6hbVNwfhSucCQDpwGpyilY/uo7+GQ/JwZdDN2JAGFtilb0C8AQDdTl0mYyv5aT
         BFiKbfEPz/8O8/Y5ooI/ZQbw/Waw00Ki8ldXcXL+7DTTloACcsSs2jKf0RYlqRKCaz6Q
         tK4yGWqBtaNVOdVLB6JpfRuuQ2EHhfw406cXA8HgwKKdYsamACAU6owhpRIdcaDCmzEM
         F06iSxMH6UkRrby97iGvmeSKLEv2XK/WLIHdYJ0uvTOhfmQF83Lz4dhxKNRVMzaUTh1p
         +eJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872170; x=1765476970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVq91KWNFTNbXoD+ksXzxIHQB6mSL5DlFXOK3kG3OWE=;
        b=Gz5XpdLGUlUqmR+IOdP0g8r0hvxKiIqoZzXAchoBiCgYTnoK+28ZD/lz+x+ruv9Ncf
         9UYlAj3MwHNFGdl1GTiM9HeBBr1N3IwRNqEyYVMQm5/JpmHZgxOrwa/JALCdq86d5H1M
         vzK41OhYZFTjA5s9kAn44ATpzpLvMBSwMjzrNCAIzJstRR3GDfDBBM4R29TVemgHuKxF
         vArVwcp5YG1+DfAdJzLYdyWEGhAgripGpYXl83LYnV/PsNnypGFexPyT3fPAKmEJgrYg
         hoCRSWckF8ysfN1OMSheLEW58yrsDB9RK8ecwFKvQynIFQBt+uSwlKxFHpo8ZvYeAKMF
         /KQA==
X-Forwarded-Encrypted: i=1; AJvYcCXYJzotaeg1RMXBYYDvzGs02pMurUzD4IEDeVMSsOkhGJwojHtbPRvk04EIzf6FqIeHcuIO3+vx@lists.cip-project.org
X-Gm-Message-State: AOJu0YzmiMZvh79ETWSK+Qgeww3DL8buGnbdwWI1u4BXDOc782mPY+3V
	5qrzanDEWuIx1aZRMOcwyrz8jzOg3tpmtD6murVI01kFd+ShUTXu15ECyghiQAPne9Q=
X-Gm-Gg: ASbGncu/PmuU3x9j1qIsnQephuscShjrK3c+5bBccZKmEnD3ti/VQkwUUba6bk7tkPQ
	R6cUGvaHlJcmdXl5oQ8oO6IVoWkCMRt/XjM5qn1vVFvQJTrrx67iAghSiZwLtojnt2laGSqT+ZK
	ac5EldH978s/2dt34jWcYyXWlOUFDt4Ir9LU52ySwz5sK1CkzWP+QFiasffeHuQf5gNGlvE3+xE
	2XS3SOQAOvjGyfFMYToeXutMYD+n24fIklBkfXTg2IcArVBF8cKNrQt9ZvjQd/EUpAsK2M0nXQ3
	YyJW4HKRbk2ae0oR0bYOoUmDdGe6ptjYsPKBIYFipgUpqv2StGC6x9B+30h2sCAbhAeEg8SoiMv
	z+GN/ee9K0XPm9ERZYksmrexnsYILoCuEjm+wmn0igwuPM/2gml3RHkx9hHyyPeTu7G98dwsxCZ
	otTJ6IUA3EXjuBOE09sWcBAr5ClkZeYEf7glkALvYM
X-Google-Smtp-Source: AGHT+IHLDmRntFAdIzmX2zERG72whnKak5UsJkqF0rdguIDUuvqIDeG21GgYtU7KeinrllfkAzgFPg==
X-Received: by 2002:a05:600c:1ca0:b0:477:7925:f7f3 with SMTP id 5b1f17b1804b1-4792aef1a2bmr83497195e9.14.1764872169671;
        Thu, 04 Dec 2025 10:16:09 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d353f75sm4665971f8f.42.2025.12.04.10.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:16:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v2 06/19] spi: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:47 +0200
Message-ID: <20251204181600.689203-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181600.689203-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:16:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20892

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
index e5f3372d86be..2e931ccc4c97 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -434,13 +434,14 @@ static int spi_probe(struct device *dev)
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
 
@@ -454,7 +455,8 @@ static void spi_remove(struct device *dev)
 	if (sdrv->remove)
 		sdrv->remove(to_spi_device(dev));
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 }
 
 static void spi_shutdown(struct device *dev)
-- 
2.43.0


