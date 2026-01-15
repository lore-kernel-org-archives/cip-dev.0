Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5579CD33A14
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:51 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31258.1768466028833163566
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:33:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CLw9i1eW;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8768225837so98867566b.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466027; x=1769070827; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzy8qSRpppZ5ScYOpQfBFvfQItXvQ0FOh0WzQDVXmmE=;
        b=CLw9i1eWXW0AfsZ8jBKIEJPQ/4YD71ybPnKy/vxyvlE87L+L3hGeZn4Cfhx9mpCNx4
         Ab7UIVHyfYt/nNP+Aglnp8Vc1O5+L04fbD7gfV3D6O+uXSr9F1kUIIgx6nfpuisJDDOF
         P5asUpW7qCe+8+wdxuUAuQkPVZTVqdRYsb30B3boAr8LV/EII9VB9+pBlNfvwMGgLab7
         92CEYMsQ61VNXkl5IspNl8VO++mTSrDJxT45n9ukk/66NXHwlSTYzCqCjRqxd3cv29Li
         QW+h3mgicf/+FdIeY6uMi2ms+kAWTBgYsAqRR0SiSz9cm2IKes0GLuwqpYLeifh5JXiO
         EDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466027; x=1769070827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tzy8qSRpppZ5ScYOpQfBFvfQItXvQ0FOh0WzQDVXmmE=;
        b=CH6DlIP9PHnQ+qzzJIewdUiJ0EwVHDZl4OSDN47X88+lpI6ocz+3pwPx3kzdFQLxoo
         8uvpfhf0Ml667ihB38hzTGAsa7rWtxpQ4tS4Ash4IsBWEVV0/FxVDD/B+60NBvPehFS6
         8XQe+VgXrxKqM9GPy2wLiEfOfoQ86Us3H9saYM3mIRiQHdEq0DdVPBjAZx7r5C/2kIK3
         LxbmWcedeLNm95GiwrTQHD/hHBI3xFXAkW4FVRGAlAfU9MUc2ZqGJwPyMyKbsRJ6YfoZ
         vuvYc4S5BrnCMPBnLN1Ua9QJdUDlvPC3X5w+9Hl9PBjA0Nto6jMLMtTlOja7+2w+y/ZO
         BPwg==
X-Gm-Message-State: AOJu0YxFz5bt2WEj5maTVIFEQbvLoPD7fc87xlncQAzeks/+cDHSfxMU
	oUcnpUPWWXLf50aCwORNjS1+ILzkwC+DjzDEOEHnfXgZj3sDA9Z0qqTus7DGo671ityqF/rksFw
	Ypg4h
X-Gm-Gg: AY/fxX63bgi9akhYZSiuIJAJcE/keGY1K/XEMoL7zAjX5EFOVr6dv/iGKbq3JAaN/aq
	mF5vTja9QnM+myTqSjJmUtqgRiXxv7Tx/x1rwbcRGr08DUBIZj8Se6Chlefo2wY0vsZYdxkSOWH
	aGsJhBDDNmkkHqBVlgIUERTKgpYDYRlXpeYyf1OXJb2jQcTP4Lbt45BM8nX9+NptN+ge4wQ46nZ
	tdCfmui3jvFdsGP8YGXbOMBQhnvTLl6qmUoOWY70nU4pyztyUfi4M5z/z8kwz9lmdlHNsIaNQ3V
	LERqgiyMlFb1DNkiu+oGpIxxlH0Ws/yHnja//5XCfAwaXnW+AxaQ6R76LKLUbtlJHyIwkEKQIvU
	Wv9FZJ4wEuZ8duhFKxdi61xWo2p3EujG8iNfHp4eRadFK06kstxK+xMUrAXoW+7N/ZayWvy4xaf
	RFWR2rhED2ixASmSDDo+xKsb6OSo5R3yufJvfOrnBJfeuqTvtkRy1maUJu2kqWPkGXmsYbGur2+
	34I
X-Received: by 2002:a17:906:3191:b0:b87:751:6f21 with SMTP id a640c23a62f3a-b876787b749mr296158066b.36.1768466027164;
        Thu, 15 Jan 2026 00:33:47 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f0718asm833387066b.67.2026.01.15.00.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:33:46 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v3 07/18] spi: Drop dev_pm_domain_detach() call
Date: Thu, 15 Jan 2026 10:33:21 +0200
Message-ID: <20260115083332.1063820-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083332.1063820-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:33:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21568

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
index 6acdb27a2be1..08276ff2004a 100644
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


