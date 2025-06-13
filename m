Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88745C71153
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.7121.1749809784781761014
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dOK/pv/+;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb2e9fd208so383591766b.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809783; x=1750414583; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlCm5DklaSluj4lri7tIw2KWKpco/NNBvccybeuDrkk=;
        b=dOK/pv/+KAaP7zqmVJd3rsZPZKhNX7xEDyXOvG4CQcpnwxlybk2GsOH4iU5pwO6rYs
         SpBfFEmkYrFqrKJfhUq1bHVxR0fKz/n0ZJA5IUVwFW6XVg3GOQUkGUhp6wpO0nM8+ZYM
         2W7LBlrbcHpcbtl26aA0OQRyTVuNCAdkASWe5ebNzNtYSgoRFTfUSx/F61LxITWt1jEk
         JnwOfOVDs2qy+N9v6+4RXBdGUEdwUoczAwb56hrRV9WgwH0UHibOXBiuMK8zg9i9S9D2
         moKN8SWXlLseINT+XGzhR30DWalk3NOoCfpqxzz3kXuPMmau0J4mMGAG/sW3MRu0pPlT
         uaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809783; x=1750414583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlCm5DklaSluj4lri7tIw2KWKpco/NNBvccybeuDrkk=;
        b=K5SqmCEifrc53uTxjMV4LLplMvStXqKbAVbh0WyZbOSrAADJq5FNONHrO7VUu7BFbB
         l+QXEI2zMl8fkafgZZiRXumFqHdsnloGtWy4IWFwSp7udWVNO7t52ihm7Qt0tx52Hsla
         xgjJJttrV3ESu+QS0UzqPz6ye8cGS33jvt1+i5+tmGrYzeCrfUxdZNS9bWLUELZudg2E
         rMxr9skn2BCRFZcEMBQgx9eoJWj7CiEKsjdh33YSgPQEpuO+QeApVVrXtnityLt6Qggb
         N/5jshf2W+k+l9qA6Y/LeNfiySOWXCh3X6WhACpjWqBN2wLz8okxrePWGTX68VxTlFxe
         1Xog==
X-Forwarded-Encrypted: i=1; AJvYcCX92rWVVyjsKZT2B4Kgr12Tut/sAPG/LCmfC6oQjqRWBnChC8gd3Mq5YQh81ZUzlu98mOaiAgcH@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz2EZgIPks0f9hv01BwfRYDdnmc6GxZU/w26U9UcnoQZfSNfDtv
	lsD5eJxZM5B0ea5K4wEPi8zOdHG2OxrCwNRTK2wmmheFz/8uZufGcm9sEZVc3MnybPjMjUade29
	DLebr
X-Gm-Gg: ASbGnctLFiZdkDYuyT31g+a52fiDb8LMh7K015AX9e86m+4K6CptXobQ8tlHHSNYrPn
	eeqaOHSXxc0drT/3rHeeYHG9yTtj9jLIvJKHm7Lht/WTsv29sFuXdP94FyY7jkGFMV5tnCtdN/e
	lxmz+6zuMZP0JxR5HhspLKmt0OycHR78JQF092damTR5B0ucCdheArwP6lEhnnw8AgqQtDwgci9
	k5HQwlj8aXCP5EFforxBKTtBsMoDUXXj1ZXr3WnS/snK74mgXRGFrQtXbyzfDHtbX+DaMGvxTb/
	R1Gwkriue2xM7uBsPFGkOgcQp3/Dw/pBnqMbmv6n21/FZSkIc/t5bEshZcHTfS2kkGNmnXDngXq
	fbEfRnZmmAGKw8P4c
X-Google-Smtp-Source: AGHT+IFZ6paPkTpnFX+vUmLS74/6KxP3l+Ro3+nIlguOMgPOZSPOq7bGByDaUaiYWVMttTfQqnSy4w==
X-Received: by 2002:a17:907:2ce6:b0:adb:413e:2a2f with SMTP id a640c23a62f3a-adec5606ab6mr189669866b.9.1749809783040;
        Fri, 13 Jun 2025 03:16:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 07/14] iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
Date: Fri, 13 Jun 2025 13:16:06 +0300
Message-ID: <20250613101613.296649-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19076

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit d7c3e3463492f50644168cbb4e443034052d1c22 upstream.

Enable runtime PM autosuspend support for the rzg2l_adc driver. With this
change, consecutive conversion requests will no longer cause the device to
be runtime-enabled/disabled after each request. Instead, the device will
transition based on the delay configured by the user.

This approach reduces the frequency of hardware register access during
runtime PM suspend/resume cycles, thereby saving CPU cycles.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index ef7b14747409..c63829027833 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -208,7 +208,8 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 	rzg2l_adc_start_stop(adc, false);
 
 rpm_put:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -373,7 +374,8 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -438,6 +440,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register presetn assert devm action\n");
 
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
-- 
2.43.0


