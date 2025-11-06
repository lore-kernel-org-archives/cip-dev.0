Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A29CCFA1C
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:04 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10057.1762416658095338236
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:10:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NMkYJq7m;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47117f92e32so4781875e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416656; x=1763021456; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XQfUImmoDcKzmFn5jPmXsh4tD/k2Dmqe+1MBSg5Zeg=;
        b=NMkYJq7mPvUyOErXfAJfqk17Jvempur/zKijpJsot9Q2LywXyI/6WRk1h7e/1qrYlN
         Cev/QE0leSEwssq+onQu9SoHsHnPi1XmIRGLYivV/1LLcHCGyjfZIHIw7vWHodNHEFe6
         sDLmkKHfMxA0TvVRyBHucHx4XHuqaJ+ZfCpxVGh8rnUJzzSLlGcHQGKa4pqWZXqrY9ex
         CRKZQM1f8FoVnBlW76Zo7Rk5OlYaKaQ9nsp0gy0ui658jAAiM2Hfk5rj/dC7O5l1vhMq
         zWdgvNHDuPxrwxGvq8e19MneilwbjYyk5oFSFawnOQGy1msKpRBgwGVMl5yrzknGqAGN
         jVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416656; x=1763021456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XQfUImmoDcKzmFn5jPmXsh4tD/k2Dmqe+1MBSg5Zeg=;
        b=Jvv3+ZPpWv/R6wY+DeQ49a6n2ZbYatp6kU5EBxOrTitE98guf1+YrQK4AkFUIh23rp
         6i4PsLiJejU7gmizh3yX8CFY6kxupPgD03Z8JgfTA985wZeN3wJeImIMVYj/M2LJxvwN
         Zt9zyjOidMjKbwh3anY90HBVspKP6KqPID2QjClyRLOU9iVeCdJjFVLcQ7OUTg/4Wxu3
         nNzm7qFBlkdlpsonDYw/HMZeSN5nWOVRqOmS/xTMfcpcDIftMX97q7Cl4jyw9FQ+WUIV
         ydwGQ3j4U/9ZQnkOX52WNVlIti77HvdicKsGAusyExU423pyj1xTwDVZv6UHhiLnq6SZ
         spdw==
X-Forwarded-Encrypted: i=1; AJvYcCWs+zHLsJ2s6Oe8D0W3yqgDuHCwD8hzeP0rBeBC0FLosFZ+5wYzucAitIhuiAgT+x0HWMBU66kY@lists.cip-project.org
X-Gm-Message-State: AOJu0YxqbnTpgPjJH4ChdToEIi4Q2OE8LIOO93cOZ22UZ/0303o3QHRs
	bSwub0zTLKEe9VspJn7yKHkNt7FLwaGFktWIZItamMlBkbL7HpXkTNW/I5LhNk0Fj9o=
X-Gm-Gg: ASbGnct3I2SztSylrP3JhjBEJXX4LED9A5j32thHLTSikVdmufn2nVvbzVy4d36rVi9
	WfLMuVgSllKdg9WMwDx7lo8K9ELIHweTUlbXElNAxFDNSpTTXefBJ8Wlc8RnSxPq2xUxgZByMqd
	bpB6aAu6eLBuTl9+LVwCNma82ZJ7Xy7Rh6AksJZGCWFb3f9akBn/L+jFoEPoOWRJ5AmDmlYr7Co
	lBedLrX9uNWph4KUP3Lj2RlkxyqC1tBHGmG7xF9V0zCFnIcJEmrI5HhhOPdySePiZlloqjAFr6n
	tiDZ4fZ4vkIqE33Vdrx1/pjnumIlXuGNWrjpOtBsbdc4JBItYQTQp0v3iXPgPg4q7IvljoQsXNj
	akzIJrIa/NMaa4UIroUYSRyw18daSRYLKLec6pCD6Wvxf+pZqXIptV48Clsv3qVYKjKk/AWktGX
	wYJWVWWkzxD6Ux69zggPhjsLt+YimHHQ==
X-Google-Smtp-Source: AGHT+IGAbc+mur+Rr6PMJ31uUbSkKYGGvmiks39NTQicbtuouUyDBlrXo1MEAmTEB6H7eQIbeVgV0g==
X-Received: by 2002:a05:600c:1c08:b0:46e:4a60:ea2c with SMTP id 5b1f17b1804b1-4775ce23cd1mr57129445e9.37.1762416656447;
        Thu, 06 Nov 2025 00:10:56 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb47873dsm3486735f8f.31.2025.11.06.00.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:10:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 05/23] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:10:30 +0200
Message-ID: <20251106081048.2574345-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081048.2574345-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20374

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
index 656601754966..07704ad86131 100644
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


