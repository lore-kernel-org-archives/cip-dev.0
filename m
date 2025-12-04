Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE015D29F90
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:15:48 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50858.1764872143559321885
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:15:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OCZR+OEg;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47774d3536dso12488125e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872142; x=1765476942; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4dSLvwo5PgzCDG9xnKtEpej6Tbvv9H8X+Ler8IGSd0=;
        b=OCZR+OEgnAOS8o84izx8MMTHnAuQqaqJGqQitcRqmjc8JAI2E/wMOwKLNjR785P5Dy
         519fojGK+BlutqQz5ryfdXZ5oTZDgBOksmJ1wqFrmzDp40ot4N/534SdRVNf8Q9YhZdW
         p1/H3XhLqwFhK9RNavQj2gnhsJIPkn3X1uhgxpc/93VfUjlEvz9ZIs7JAnMBARtv28rb
         A2FN2zmgLoUjCjCw7/oYJ6yVWlu/eMGdBEaYVEI1IOIQYJePnd8cPOa4YqEcjGp+qaEa
         9UncZV+b0auVbqvBZyntBVxIqASVnuohIs7cmWiv0Wa94BUONfbfjfBgt7tStACb1SiT
         q+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872142; x=1765476942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F4dSLvwo5PgzCDG9xnKtEpej6Tbvv9H8X+Ler8IGSd0=;
        b=SRbxasIGZcy9jL550IZ8VjoDms/EfXMX5J2GkpUS6x/AHz7SCkLwIMCBwI1CABF2Ln
         ARCDj6UA8pwZxupbxQ+nIJPt5EXGCcvtBZbKUuDdkzyQJSnxISTrEai0AQgQwJHlO3gf
         BjhWg34SD2aY3b4Y5oN/ff5Sh7qDQC84bYdruY4R3amftKUR6AIyz6JD+To+MlwKTVk+
         yddl1x+tM+2k/ieiPfGK7zBTQ6JPvKEzIFyd5NS1fWlOUeOYXxdDGaX8U0+4GW93oRCL
         F8OCr8+aoqZ1AwPJG+/OO3CZ+uVSba0asxdpYC0slDkhBrNDVlfA1c0EDOJFzubG7Sz0
         QX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6Jx/3BNu7M7+ItZl0rAObO4C3X0a5n5mAJQLy3W20voGIcRscxMHLueovJQamynUNj56Jbyy+@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz9Ml7bhb9yeMZtsZ+Y51q1RzvQO+2Ewp05fhXAQH6IR+nRZEoj
	1LvRkH20z/HL6vol7d/6kZ7puPyONgRwTYVzmtgSXFIf8Vub0qoKw/XeBBzZlPRjuJ9hfVA4Reo
	0QJx/
X-Gm-Gg: ASbGnct2JToMTdkvKIja1Djhg7WvvoLq7Go6tsTYjWCrNqWK+jFmeQmnm8ZuJdLO6+Z
	EVYQtNRjz1JCIGuZ0O+HLGwpyxHhWJxmTszNr2PQ80GOiHeE1b53xmbcRRX08JMRDd8BvE5VAvk
	1JnXjKcHHtB7naRzooxsbkasfLl38IRahyLbh0waw4Siozbne8COuIQneGK4TioWaG2YX6+Vo3j
	pBWm1x6QaGC8e7dYhlzma20ujlP+EZRnVZV0kkI4lxbGhcKn13cOWOXR5G9LYhpCFpMIY/EEMj4
	NylIi8yHBIsQ2w4W/eqIzhUMGsGtusWih4wwq66lvl8mDcxtiBzKNr5/yCv/ZsFkXLsr0VXCNJr
	8rqr+JIVmnANUSLQG3QLNOq48I7q779Dj6NVKQ8K0aBvy+fQ4hgKwT3u8Kg3RHXfvvGrUbAhyww
	GAcfVr9hZCTtQzFVGlaX/lcWXJ3u6t4akX7y6yZr5A
X-Google-Smtp-Source: AGHT+IFEeTMKjTkI77hUH3Rj4JH5mtUm6QB/xLpvbRdbCVKXkJNgrobLF/LGSo0dH28iMj490/kYRA==
X-Received: by 2002:a05:600c:4f0f:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4792eb345acmr53244395e9.10.1764872141968;
        Thu, 04 Dec 2025 10:15:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930f286f4sm42953625e9.0.2025.12.04.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:15:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v2 07/19] spi: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:15:18 +0200
Message-ID: <20251204181530.689132-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181530.689132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20873

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
index feadf94b8893..b8e9d04ff27d 100644
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


