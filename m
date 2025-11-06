Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F1CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:11:54 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10036.1762416705622927426
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:11:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=U9WADeH6;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47109187c32so2700075e9.2
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416704; x=1763021504; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw0gL4PDd1QR2Pf19PmOE0Td0QBDX+cFTEunQvaCchA=;
        b=U9WADeH6p0Pp/b/a/KLlDICRHa1RoWdyzweHwe0rDg5R/nyV0lofk42VW+72unaAz4
         ZTdJ2bVAsdAryLDG4NxCWILTfSJw+7LpikKs7flPuRhJseopaLQvHHXkkizlssQPT/iN
         HkcPEeVx1x0gmE0jCPH0cWcLpLQIh+SklmoKsWxxstcSCLmt+mNGV2C0YgTdxnsyQp0V
         UqZOy8o9ph2Wn7GDV2s7MDMKdFszQBKImtJhdCawQLpZJzSqVBZu5MEAfeJWbezJzhIT
         BrY4f22EdT8xYP2GYGY5Z2VV467a8tFpt83G3sEPPvk76OcRwtTjixbksln2CnjLMBnO
         g20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416704; x=1763021504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw0gL4PDd1QR2Pf19PmOE0Td0QBDX+cFTEunQvaCchA=;
        b=Cle5rcufYKIv5hG/PVZWBZrcQPJijxcA1648tPkGgNeiEVzQDrfLEFDRWNWZzSJGle
         +ugNA1K5sueqyCs9JjzPbw53LbXbgpbrhgaN43jAS2xIbQN5KzsWzdCXEAfHmAFdtIHU
         A5kbhENXP4PciGWawJ/8pC5zvZlWRmFFcSw0SuH/3J1RPhuGZn8ssTzpae8COnOgINrx
         WvFbau1yMwAhlPRB+gvfxcv8ogWHeusahJhAT9raahvKphzhOLV7Ebso6t7/h7xupSWz
         fr1ai4grJZGy75+0eH8AQsDIOA48RmkJdFzD9V3xA6r96h8fLL1GSzZgCEl+d/icvyS/
         eDdw==
X-Forwarded-Encrypted: i=1; AJvYcCV1UN7HzfhJZJrROI4uCbRzmOJQc0iN/kVwJemS4gA397+llvdR5s7Zi0pUngBe4g0WgdkxvEEB@lists.cip-project.org
X-Gm-Message-State: AOJu0YwhOah/2sgI2QO1COwGaqvWPIlhmgWl5oNmA3zkFHAENBz96Hm+
	zqAsB2MaRRbBHYk1UDPBDyLZ8UTj9XRTsq5bBQMAL0Ozn8AthMil0Kch/DcI2318w8o=
X-Gm-Gg: ASbGncsZaax38uq0Bb8uaB/MJDRLwPKu4XTFO0iay9tj9RV3zFNXMJjZiG+iPfh6AvJ
	j8PyR6Sy08MxAZxMMb1URzWDFGWuXho9K6h2xEMRCzEk7ipIPIh6rtEWAX9UrhR1dwuq8bKJ68t
	gQ3SFExXz+sVKqcWMtn/gOJx3YuqWaCzI0WAO/83uPkYFpyMl7m+/GvfkOXb7sXT5kmNbHw2Z2c
	orLIEn5d2zQ6ttEKQUM+hxQOf9prLdAzrNsm1TKxH2dlvry8mr1iiA80+ZP/pk/cCiEW/YZZ1bM
	Z0T0c60AFRQWwfGtcta1ZyOBLfYaROe3blRR1E0t30UkWNtmVyEuIhGaZu/SMs+EErAwxb5m2av
	yOdUfDEZjbhJ2lTfnrJgE/uBNiUIFccPD9RpYoHmKVB+W4EgQqiyILGXtK/qj+T6uAj47lmspEq
	dshrX1xpjv64/melZHKN2xj2QL5oKO+D/Y86YKFwi8
X-Google-Smtp-Source: AGHT+IFMwlKiecapRX9FOBJPJ1JYlkjE05PywATIKVHk+Z5h4jjzFJB9VrHCRlmZ62gaQfOtxmjq0g==
X-Received: by 2002:a05:600c:1c90:b0:477:1ae1:fa5d with SMTP id 5b1f17b1804b1-4775ce1eaf2mr61596815e9.20.1762416704059;
        Thu, 06 Nov 2025 00:11:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm32862295e9.6.2025.11.06.00.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:11:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 06/23] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:11:15 +0200
Message-ID: <20251106081132.2574638-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081132.2574638-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:11:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20399

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


