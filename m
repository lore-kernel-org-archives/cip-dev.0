Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC3FD2447C
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:28 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50478.1764872066417415274
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=enAIpuOf;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477b91680f8so12474605e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872065; x=1765476865; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvOHqtsQAPy0ELnmQoy6v/Q9dYoyX5N5EC9OnCC7LoI=;
        b=enAIpuOf+7goJW8ehEoM4hHatgQ7CpKGF+6iVh60IPQnYWbgWJD+UH6iTZydr/HtP5
         KhXsDRTRKtLb3ilfLNQPM3aWoh4fUXjOGHCMdFY9RRcszMSTPpZBGveMymXcM3qNeIED
         dc7eU1cyzu8iG6UwKqsm75qtvHJKq7SjmYgT+4O3z28nwgU/yXFND25v26UH3/vV9e9K
         oLs9YAjrqXyKNzk89zjyZfg/RsqJKFuyTkecD6cXK6ZzMtzVWllaWtm51Ajj7GfPGLcO
         4gU2TLqSSLogPqwHvbx7niVcL3fmlA7XIEa8JlMZ74YA/c4mcA/aebMtkGvFzJFJGrBA
         TSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872065; x=1765476865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvOHqtsQAPy0ELnmQoy6v/Q9dYoyX5N5EC9OnCC7LoI=;
        b=uu7gCfaVYKFLRcUSs1TNKFa17BBxEOxdoF/BWt/FrBmtSHAhzefRHxQ5fPEAuLcXHF
         r1Pb1G6OipeKiN9KuiUmRUHDU5TETz0gahzFk2iqIJAyCKNr0pPskZwb/DVQoFNKy1gH
         3dgJDiyIFmxKC+1L1IxSJN4bdgxx6WUVTjFfr4r6H+PLMt6D/x+T+zqo6s/e58md/Bs6
         lt1xp7j6IWRwpsR1GC0gVpYIVnnpaueCPSmsbf/ppQ/S5DGM+Ky/ta9o/pgXJUU2MQIB
         cAY7I0QrweOuwm3aM8gStHtLr/ufBZkhwBNQN6WxVRe4K/gq8QdEyikrpu8+mVstEzIy
         TKag==
X-Forwarded-Encrypted: i=1; AJvYcCU43LW7zOn1O/rWGFqWazPa2Kn+InoixgNgC01jW5M/2ZxBEcmCE8QC+JxD1hnXqPsvajxLfWcy@lists.cip-project.org
X-Gm-Message-State: AOJu0YxuhOSxbo8msyukynY9Q9xLu8Ax9A1cAWAaiC5KQBKI0Z61fRhe
	BLk2va12wpwhnanoIEWnQZMRzKGJvJDT/0+/wC0olLZZunQ3+/9fFhhJ/PzTtzOGi7o=
X-Gm-Gg: ASbGncuunyRi1QK8YMGOeHru8Ue/oDSvbFq85xr9VjK4wRDb4PNcVpHmtM3MoczKnC1
	Rn4KLq7D/9MRk1q8uKJbCcHYbhdZEj5Ng7bqfG66HcQNroEAr4vbaMNpIAEwMgTSvzoWS+3D4M7
	N62EbY4W+jxTs9USFQWcroCxoVDJElKP7rGgntq8M+FXhHute51QlJgdMefECdwEO3s1GxkJYEF
	Chx2/Yw1tv4d5uO/JviFi5UGNxLD//7WTgf6GneDwi2Oh6UuGege6P9lohDYfdaz8KGmtXJe9Bn
	vjcOoZ5QRq4UeQu72DYRb8YKj0x+Vj0t7lAsO6vlfQ7mtsVvogdZV1FSHocnrEBDE7oNMHUa7sb
	gDIxtkhEfhR9KIEAYC6v6TUwzIB3dnOtaRwDrXfhu23tBvYhd/goK8Sp3FYSa5lV45BYMgSeCch
	nVBd8Vkdrzbbc+Hz5fssd0C0x/BdMuEEAabZ5Xt227zc+hj/wJ7xw=
X-Google-Smtp-Source: AGHT+IGJ60Mh9sqcfhU1eDhhwZ2jhv9a5rcVuPXt/Dc1zaPYfTtJLWqVM62R4gyXCnaYfAN7xu3WKw==
X-Received: by 2002:a05:600c:1907:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4792aef70bbmr96121685e9.15.1764872064870;
        Thu, 04 Dec 2025 10:14:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 06/18] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu,  4 Dec 2025 20:14:03 +0200
Message-ID: <20251204181415.689009-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20853

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
index c90dabb5ab06..cfb1d2b5b21b 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -199,7 +199,8 @@ static int sdio_bus_probe(struct device *dev)
 	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 	return ret;
 }
 
@@ -231,7 +232,8 @@ static int sdio_bus_remove(struct device *dev)
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
 
-	dev_pm_domain_detach(dev, false);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, false);
 
 	return 0;
 }
-- 
2.43.0


