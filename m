Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F43CCFA1E
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10058.1762416659158830844
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:10:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jBXmkPKn;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711810948aso4193405e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416657; x=1763021457; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLRE1jII1+q6BJfenK6o3c2T2ae2cX6QoBHsZ8qLAGU=;
        b=jBXmkPKnzBs/0moDdwgG6KFPRjbgMLfvcWS3DL9mZ22LXVSKG/OLd0FqQr25B8sxHA
         pXGjxYINJSntaakleZJYInV0HHfcCVW9eRZREXzP9riwy/pa8iBMp5MuPSTeRS5g1y/y
         5sYgWfddpn/tXiGVY0B5DxPJek6aQ0Rg4NZ87VsN6kN/istYsYc9XUEO+6SujMjnH8vg
         O9tt5/ykHFTGbMqW2ocrL7Ie2mqvupdFsZZcO59z66lOm9D9k3IkYEDAkeSbWRzlPzWs
         mp3uy3qIJ1I0qTNXSF3zQ8rG1pUvEQFyyPUgXJr2tSH/4oNZgZUmzc6N1G0tFsUMPzhi
         e1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416657; x=1763021457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLRE1jII1+q6BJfenK6o3c2T2ae2cX6QoBHsZ8qLAGU=;
        b=xT7lzeAnNOD6lLlz43TzvQ/VAhfnsimWoVKTURVhSLAxL8LdNQoPSommnfeU2jhyov
         RCTtu51vgOGCnKms5nWcrXOMbiRhEjtrfnDZwVkd0EulWwxWjK6Mvfd7aC7eHff6TZ77
         QkhbpPSNNBy+kMUtgHctXzbJTFVFj6o+3W8aj8Yff/06YotZo22H8mmTidBwp7efATXI
         PfiE+qzM13cBEDPalUMfpSuGwGbGX6295G1KHr3PB8jN14K+7hnxb2vlgc8tanH1inn6
         uKX/ktxNqYjrrnOtOsR3Fh6u2RdKev0HoIf7eEHvX68A73bluRRQQ4qLR5++0jzBofzn
         UATw==
X-Forwarded-Encrypted: i=1; AJvYcCUpmRRh+XieGG/xGu4nhe24WAQz9lQ2CVsGDw2aiMXqN/lFUnsFh2iOcqjjksbHIxLKK0R58s0m@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxmy5URUy7nWnuhUg2vs/wvxMvwsreBkKXx/eY8WUzr1b88XbsJ
	PWZJg8YgDE2a158N9dWn6wn92rxOdfmsUSLjlVkgf0LUcHkGPhmG0QQw18uVd7IcjGI=
X-Gm-Gg: ASbGncsauUoOgzfk8wiRMYRYp1jbc4jejsZ5UTxGEnz64uSiFz0nokQ3XPKmutrQUw7
	RJLC7684zfuQ7Dd9wmSMstlPIVDlv8ZTlkAN/xMTnpS5H0hdatfEt1ujeFQWpHSJHRxG89V1U30
	C9G7TIt3VhAUZVZpMmVc3YgNx0GisRxaF/kZwZ3XJSGbP39Zb55uOCyXbhjr8WgFeyYfXBQBJWS
	DCvowr7cVZEEwN48kd91PNTWyErVz36eXiM5o7x4jn3vmjME74ooNQnapG01pR1Td/Kg65xgdQq
	428EBt4fj1iX77Ukr19B57BuLKlw5iY90HiLiKNrt45qTzeDKjrotzMxPcAzXqLuf8LIDprdOmT
	dg+jzYbQbURJAknrCQRuQb2VoE4lUErVTY1/fa3d3186fPaTUxwXyfM82MLhcQK+STtXgrxkKGp
	Mrh+11lDwCN+Aun+CW0qiWl7kObL3x5Q==
X-Google-Smtp-Source: AGHT+IEdA8J1cyIHyn5OBGB6a8XZrzNCMkl24QziPez0+InDo0HbOjct3LkpNNdqyzR6H0aLdicMuA==
X-Received: by 2002:a05:600c:46ce:b0:471:d2d:ac42 with SMTP id 5b1f17b1804b1-4775cdc8e30mr42944455e9.14.1762416657574;
        Thu, 06 Nov 2025 00:10:57 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:57 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 06/23] spi: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:10:31 +0200
Message-ID: <20251106081048.2574345-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20375

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
index fbc3b87c535c..55e94b55e3d3 100644
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


