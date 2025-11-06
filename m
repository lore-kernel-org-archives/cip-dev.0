Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19193CCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 08:12:35 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10102.1762416751651826331
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 00:12:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oSU0QYMP;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429cf861327so517177f8f.0
        for <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 00:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762416750; x=1763021550; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0kQRkGuyh5+jrSNOY06xsBAoBJ/F6kVJEmbK+FzkCQ=;
        b=oSU0QYMP38MWwINLQSBjuTVLEQYaMUPasdWgng59YkpqA5upfxaMctTVBc53CasdPK
         gTPtsvEpz72zuI8IBh6oRyCWoH6yeFXwkFTpxYFdTh/iAf5cA/nX4fYl2K9zboIZGNoq
         wy9KHqlkLZM92Q+4tYhk7zO1/m/Ea9MgCTAtSFqUjqyG4tsDKg8pb39xlQ9WMZ/f2+Tc
         958solPHsl/lSYNf350VEyt3JHHu31QE1fFP4yJkwQ3r2NimCeJfnxuye05mCgg0F/6Y
         NEr3BMv3hZO8qj3tL4Vi/Uqiq9OlE9EY/qoqpKcbrOh1Kyp5fciElQTp1pdi7QbpahPl
         XNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762416750; x=1763021550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0kQRkGuyh5+jrSNOY06xsBAoBJ/F6kVJEmbK+FzkCQ=;
        b=OhVdddjY7nhSg4defOm+Ls8DK0jzErRComN27mStCUOVyuOBQKirJMI0JClaMOiEtG
         BY6jzujXKQmd8K8VNUGtI7AHVu+/z5PQCEt72pdl+bL4gBPaXMhdy4wjZjAOArml69cr
         aqc7IygiZx1VG07uAdo00zvsDx8UzRHlF6JQdj5UZ1AJhN6KU4IvhwgekCVFxryRIdpZ
         5DipavenzMyg9RXMpmNp6g4vqH06PPinJBN5IuSnhxvIhNnqPZNK/qqUTcRIWLGUxvL6
         5x6tE5wKryljCq9MLdTe8/nM7UC2H1KD56KOEx3Fl4oPtglfoPaXu5aTOwMUEms+gE8u
         9VRw==
X-Forwarded-Encrypted: i=1; AJvYcCW3M63NEEx7rjC/7FbWUKYZbpSYnbSkGr67xrhXlF/px7ucwHEgpP7TVyY2+3Nj/ZmaldTswoq3@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywj5D2UJl0889QGmRN3Xd6CfksNeMzP26Qw3BpA684Y/Euqaydr
	uOOHx6GlrrmhZAirLVVLtFl8cB8Yzui0Quvyun0IgrxJ35wLZBRY2iAkEQhC/sJxAZCey+mK22h
	G/5ccn64=
X-Gm-Gg: ASbGnctgy+h6g7cfhSJOv1sibLJYZwI6U5odf65cxmUoB1Ad9pdHgY6Sn+oUhatzYxl
	Qemy61oqoHvIhU1lCy6npfSV+Q6PpaEDKLQPNq8MdbXDZH4ZDxVl411oXYOVwXzmMoYEn55Un6R
	4gPX4s/dl6KEg9HxOeC2J9Pem5VEx1adN2kFJaBoT5C/MrbF3xVqlQIakry0pIrvYyiH/lAV4aG
	xJaSSjlw0CBcK/Sc5fR+YHkuecWiLbgITrrwKc7WAR1z7V5Xr5SZNbX89QAdQmI7KsC3GNo2/tW
	IIGSSOUzVefgeVlrMBuqG6dZEW+J8wAM9hpJXWwwgTIMRKcprsjIx/GO45E2oXLVllO86KiIB/4
	ejq6VF0BNg2GaDEhJEphhL0qxVIzaVEoBkAaGg6vfoSCTQDMJjfcgRp7cFC3B04S9e9hlj3wUmD
	rWs2X3jO0vbzqZx3Gnmi5FNOHGMPHAx4wwDrg+zcYz
X-Google-Smtp-Source: AGHT+IEWxcFiYbozI7IvKlKGvhZQEHpMnBDtrqkUtB3SdH7s8RwUOVuYNMuYX1C7LaSxV4FL652HUg==
X-Received: by 2002:a05:6000:1845:b0:429:ba95:3a89 with SMTP id ffacd0b85a97d-429e33078c3mr5798509f8f.36.1762416750044;
        Thu, 06 Nov 2025 00:12:30 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eceaed27sm2486647f8f.27.2025.11.06.00.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:12:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 07/22] spi: Drop dev_pm_domain_detach() call
Date: Thu,  6 Nov 2025 10:12:03 +0200
Message-ID: <20251106081218.2574950-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251106081218.2574950-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 08:12:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20424

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
index 3b0513659331..f6041d8fe86c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -407,13 +407,14 @@ static int spi_drv_probe(struct device *dev)
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
 
@@ -427,7 +428,8 @@ static int spi_drv_remove(struct device *dev)
 
 	if (sdrv->remove)
 		ret = sdrv->remove(to_spi_device(dev));
-	dev_pm_domain_detach(dev, true);
+	if (!dev_pm_domain_allow_detach_on_unbind_cleanup())
+		dev_pm_domain_detach(dev, true);
 
 	return ret;
 }
-- 
2.43.0


