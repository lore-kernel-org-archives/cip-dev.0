Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AE0D29F8C
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:48 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50856.1764872142550108180
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=hPreB4CT;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47778b23f64so8066415e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872141; x=1765476941; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw0gL4PDd1QR2Pf19PmOE0Td0QBDX+cFTEunQvaCchA=;
        b=hPreB4CTkzRj3gjij7Hlucn5HLGAUWIt1vp15DrDplWz9bYUo5rFlHhT4zNTyygBkt
         zITUjjL3Sq/lf5pbhXJ5gF8TM1cVQhIkP1nIHC7vDh+l0p09TUW0+9Y1lmbva8SkdmB+
         rWmSIW5tFllHnjxMco/b/Uub9QkB2O9K6edIotqjy+bPiQy/b+vt06JFGDEpe13xmQUg
         aH52sW42LUZ20ZwbxZbKkD05x0BMI+eEDzeAfl7+XL1BH6bPzEyqt904eRDiMKkdhaxD
         b5VNryQOGGbnM/1pBep655fZQJ54evMVFQGHbitnOkxFGHMQagen/y3GYVHVuvyDqrPC
         HN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872141; x=1765476941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xw0gL4PDd1QR2Pf19PmOE0Td0QBDX+cFTEunQvaCchA=;
        b=u8pRByRJ8cNexHcRA8XK09oqGOSKO9fhRHURIriXlMnYaY1CtgtLVQOgD0bZM1qFnl
         XpKjp7cbwH2OFw6YQNky0rsALd7M6WrRumnxlQEZHH9SHtvzbbYiRudKQySEVrMdptpM
         7+hcG9iLGilqr3LyqEInyXEzfUV83UYwk9XroqhIFJaxOLKE+9R6VYEmvTu0bR4KlCoW
         U5SqhHEf4JEWiHvmkh/Xm6bQTl5gGVx3OC3JIwFUEKhNz0ysnWubhVzSsxm0Fjkcj5uE
         jnwpWBGDRCWBfZx+XA75EKRnI/ltGhL33C2NUxdzjhiozF8izN4wBXcFGiN7+yFMH2DQ
         kRWA==
X-Forwarded-Encrypted: i=1; AJvYcCXRZ3JUCVwHadasytP2NhXG3Rkfq1s51TLzpw0atEeBko45xEeY8ST+XLf/cv2/pq8iv4H7Dtcu@lists.cip-project.org
X-Gm-Message-State: AOJu0YzhFSRMmXh39/KDPJ9Bq4Lg0k+bPK8F8/HwfiGawzx54Ol0kKyf
	yoIXC1TLpaLExTsnU7JPod47PBMRruRBGnx5Zd/EgQzvt/1tn0AvKib0nTi9P2pAt0c=
X-Gm-Gg: ASbGncv338J8AcHhKbh4ut+EXfxbAeWRh9k9uohb9zsSVLhcPFwM+vrGB3+8voRuBQ/
	TNoodeVaMO0wglh8mOMipCX9trsI8Plr/DHMV9uKOhuvXCGjpXJiGs779XVUpPH13B/CmgTy7I3
	9NB6hK+h/zYhL0+htIp1M2x86X/EsyCyTClXtG92AZyUw+7DxFcnYkq3X5u2RiNbs8f92N83TVg
	7/gNzY5oWjDzWctKt98QDLQRJBOTkcF2y1jRZJf+SmJmcgeDnYIqZlrAm5pb6ARAVlazdQJMj5z
	4xe87T63wi4CrF+gvr7sA+a1KPe9zHwOFHqZ4FTMcJ/1e+X86YVO6/Qa7X6xqAOywtHfGZhQ6/s
	j+3BeLTL5vXvBTt+1JK48RJwZpqUxbo+TVxiLrdUbNC3MpcoHhsZml2c/lBQzXYbz5YTkEdpdCa
	xbYoPVL9aXnia8FkA7bgKVj7Bf49QWT0pnX44ccelo
X-Google-Smtp-Source: AGHT+IEH4UlsVUpDB1/dRmQaMX63Hq5cVXEWHJnInV9IuMXklLiLoMNBN5+3t1RuC0SJxvtjhTUf1A==
X-Received: by 2002:a05:600c:4ece:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-4792af1b981mr69637035e9.22.1764872140861;
        Thu, 04 Dec 2025 10:15:40 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:39 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 06/19] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:17 +0200
Message-ID: <20251204181530.689132-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20872

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c2ef7a03f5c8f0a612a8beff666483b725adf8fc upstream.

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
Link: https://lore.kernel.org/r/20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/core/sdio_bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 8e7322fd62e0..0142db1bcd74 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -200,7 +200,8 @@ static int sdio_bus_probe(struct device *dev)
 	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 	return ret;
 }
 
@@ -232,7 +233,8 @@ static void sdio_bus_remove(struct device *dev)
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
 
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 }
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
-- 
2.43.0


