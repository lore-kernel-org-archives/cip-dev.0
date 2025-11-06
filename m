Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB13BCCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10080.1762416708689169627
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=prHasuVH;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477563bcaacso4789385e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416707; x=1763021507; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VVOq627M1vtVOUH9fwjzKM0u7XjJKsQGleoQx34xAU=;
        b=prHasuVHoXxAUzxnuXS+agZmqDpliOD4wLqtvDoYg0Cz/JzKa2FKR7YLoBBXFaGJqS
         yTTJFto4ecJart9uqxcQRJroVu3oiQzSM+mZCnqxGzBGMcJjgnsPiOK6tlOaygczVIUm
         1xNMM7y6TeJBTeggc6dWK87QUZ/cdf/z/Mfu8BH8kfjfagmtimtB5V+4C+APTjUaRGOS
         eNTbiz/3mF1iNHBNR7mVKYEuM4mJvOqxYCmVGAI2osM9QNCA10grVo+fo1374WqUpHSZ
         yQzUUySTt0sHhUDtUfX6qvdfQsqEh5p/XjPcIpVkqDrBGJDjIrEyeiRfLHGVS2IkLwTj
         qtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416707; x=1763021507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VVOq627M1vtVOUH9fwjzKM0u7XjJKsQGleoQx34xAU=;
        b=A2YDqcX1AgyT9Os3FrM3mOPhSnhlyjdeO0FKmRn8x/J8in9cxbuw1dNpGEbVEHBNeI
         +gEdqi8mZ8XTsGPtXdqpI2aN0FpSs+5N7xVPJx8ALTKZuWHnS7894EPTXimdUwXW6f/F
         CQev7rMApBSQ26owJr5fcHkdL1tlvK5aR5K94JseCkelHwTsQSSrdzspcJMY5u9bfiij
         HR2iTHQG/7WJIiZZ2+7nHW3mz6gSyoa+PJr0UydJJUN+TxM4qKn4+8pUQ/dZElWucq7m
         HHheh7RjQkd0iMVmMsbWLvQhRK2IsOs+JE9Rw8H6UowYOGqSKGKQrdfvkjcTOd7tccrc
         BKDg==
X-Forwarded-Encrypted: i=1; AJvYcCUUferYpRvSLiJz5hjN6U7jKppe2AkF2F7U+WcbEL0wMb7AL+6vcILqS3O41IVV8ysIqBvlSps/@lists.cip-project.org
X-Gm-Message-State: AOJu0YyjXMH3oMsjcMi3XcxQ2nxYgVoRrCyd30abARbpDAuvlxa8dkui
	gMT7DbdsJ1zdExJTREfvUMIZLYJBo1UjQ4j0m2rAywViBBaRQM88SVUa0P7O39IFBZKIV+qBeot
	P9swS5L0=
X-Gm-Gg: ASbGnctM6E1CVsuqBG1VRRKuGK9zsjlNg96lvEkIC/VavnmydKm7bWcSZ0CXM5YV9yK
	IsJ1Lo01JkMv7DfxUAPXp/a0X5ZkAT0UKzaVWk2QHlgpdrsragH9T7dFr9dLk6ljpeaIsBZyfyQ
	TJJwPFkzaoOrUE72ywx7U0g6yUWngE3tWp56/HJUrHkc+qOsGAihWHX4qbwl8wiDnHbyeFa9xbw
	dleL1JUcK4aD+9xI96RFojlwdexrsvVTcZdiXweIKSTSCZZGbKq9fqroekopm3gNWx6ocB9Ppom
	/iN5V1OIaiX+KHYJHJEbL1bB08X1Jq/gqQ87ExIRc7OflRgxDZDdsoUXIIf79jlAAPQtCOZywkq
	htYRRcFGZRVYrHI+A+739p4jQLn3+k4Q3/HyTrf8n4eD/3nOMvXw6OD4sXjhZwxHWrGIDuukLCD
	xEv5FejODb+VaORJAjOZOQWHnxHzkPVEys1S36qbUN
X-Google-Smtp-Source: AGHT+IH9XRFMslbvEmDE87StDGMcfqS3D1aaA57spUxMWxNAxcvup27OjaUTbS1irhBQ8d+kw62O/Q==
X-Received: by 2002:a05:600c:3f07:b0:477:5c45:8100 with SMTP id 5b1f17b1804b1-4775ce61f57mr41091785e9.24.1762416706918;
        Thu, 06 Nov 2025 00:11:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:46 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 08/23] rpmsg: core: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:11:17 +0200
Message-ID: <20251106081132.2574638-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20401

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 214ae22e6d4f774f053a8f7d32bd6a9874447b06 upstream.

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
Link: https://lore.kernel.org/r/20250827101352.927542-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
[claudiu.beznea: drop dev_pm_domain_detach() conditionally]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/rpmsg/rpmsg_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 65f723b8ac52..d51f881a6371 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -521,7 +521,8 @@ static int rpmsg_dev_probe(struct device *dev)
 	struct rpmsg_endpoint *ept = NULL;
 	int err;
 
-	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	err = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (err)
 		goto out;
 
@@ -578,7 +579,8 @@ static void rpmsg_dev_remove(struct device *dev)
 	if (rpdrv->remove)
 		rpdrv->remove(rpdev);
 
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 
 	if (rpdev->ept)
 		rpmsg_destroy_ept(rpdev->ept);
-- 
2.43.0


