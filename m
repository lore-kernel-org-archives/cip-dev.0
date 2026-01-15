Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F98D33A3A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:36:21 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31327.1768466177964981017
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:36:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KVgIuLtL;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so932192a12.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466176; x=1769070976; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XQfUImmoDcKzmFn5jPmXsh4tD/k2Dmqe+1MBSg5Zeg=;
        b=KVgIuLtLvPYgNERSgC0EZdVJCuZfN2bL4Lt2HGmfE66YaN3wCoAWYNMkxOtl1oHpHC
         IyT6Kz8d7kJgyPFKQObdqJtw8cupauCIehoVy/Yen1TEf8RziIMV8YoyHTc3M0QmwRvw
         t2/W6CgL/XE/p0aebEE+aDMEGwi5fOMoM+oN9ePdzt5FEqNB4qBgtFN1WlIuw5Mg7SUy
         I+GhDwKst3QKLGFG7Y99KG5SRcBKElpywY4hy0LHkbbE3eH9sRgieZO/EZu7IVRRJtBD
         HWFrnjv2yGZOB44z8cutNDDf1vOBDyQe66w+tSnaJJMnWMc7BL8g7t91ZaIonI+9eGKP
         TdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466176; x=1769070976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/XQfUImmoDcKzmFn5jPmXsh4tD/k2Dmqe+1MBSg5Zeg=;
        b=HYK58XudnIqXXMZA6RVdIgr6E5DAyXAFDwarN7g7bzb6cUNQkE+C0HXy0imYjHFYGv
         tixDi5PzBZ5orkKkKzPU5zB+AdsyVhGAqS/EAEYpKk7STkUvIL4D5p3iM0HfNTMgjQRy
         Xuxi4N4/xaTBqhUkuBUftWGlXve+pc+hhfdqhA6JPLlCa8XKm4mQBn37zZopttrqK+5Y
         /JJo5hPf5mz5WRGn1S4S8uQcw3hwg4ABO9C1Aw9vdeelBJKGjQncz6nuWnNmpaoGWxTC
         qxk35bi5JF2iIIcoBwrcGJkREnOqb1PuHMY0KBQYCZXp3rcs8WDsegeaUqE0LN+axeLj
         hsXQ==
X-Gm-Message-State: AOJu0Yz5sf4Wy0fql2lDUGBBLZdYAAF9nKy9LmeSy5fVKJwu5CpD+rhI
	nLSAZ6t6haBgcxU9Z8j4ArY9wqfUFVm8YsMGfdu1/XpAbxODCI6actiw5aZDFOojSwq3nfkHQpQ
	HoDFD
X-Gm-Gg: AY/fxX5CavbZponTuefzMQ/Iv8J95EhN/2Lc/K9+WBIi3rZgLFzxWcBwy0uTVI3m55g
	Z6FH0I4yBI3SlBJXvz5Ly9PL32R3Y50IqJT6DDV+mt/UUN5OYIXuuj0LM/wHKguz/6yMHeD4DAa
	QNOsdnCaXGA7kIEus0nIP9NEkWCJEThLN9PPKHXR+0r4Jk/gYp8WqJe2OdGqiJibELoplejvhqm
	UUoLe1YmJaDnu5J/AymnJkN73mxvUPqBIXR8d5jmoPfcOaAMy/v+Ki3AcEnh2O7HCsIaHOLOQwg
	9ac708bAS3l3g5qJFXeBNj1R+gYMVK6qrEnpZvbnJ+OZ7LJ/K8FjaHAvf013G1wYvOzjl1VZcjn
	woeUVjWJwQd828Dojhh8yoEwBjYUNAoU0Juh71lAy6LP40I0njcS9wl7XIFXmQauZCAqwH8pzbs
	A8ypd6GJ/EpoSxi1gEdOdznoWHgRguhHQEpbVuhtX8JX9a4lrKy9A4Yr1suZ1UzZrYtA==
X-Received: by 2002:a05:6402:4412:b0:64f:cfa0:9024 with SMTP id 4fb4d7f45d1cf-653ec46fa74mr3977147a12.34.1768466176358;
        Thu, 15 Jan 2026 00:36:16 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411882303sm1993564a12.10.2026.01.15.00.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:36:15 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip v3 05/19] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:35:49 +0200
Message-ID: <20260115083604.1064260-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:36:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21605

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


