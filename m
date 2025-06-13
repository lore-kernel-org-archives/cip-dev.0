Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2236C71148
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:09 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.7049.1749809707784685264
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=PbOdYa7+;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so4126909a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809706; x=1750414506; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HvUWWbqyabSrkLKCnUqjCj+bIC1dwqQSOsiTOO4fSs=;
        b=PbOdYa7+6WkEGbhxiMIdRftGNgVB0oHlwquEnWP5Bx3nrMtaUr/sV5+qAwKqmjAJ3Y
         dYxYG1cBHKbw4dipAbCrVz9H6Q6WjfLfWdzsUnKNAxLqkU+AAi2aC5NiJMqVxHbQdoQF
         X09AwdkMdGwGMmAowGLEtGpUolQvaAkZjPkPthKvuwzdMaNi9o+2BKIEPIvx/iLbZ4D9
         1+DFvSIZfWDGUGm1SHd6NbkOLO9So9UoImTVOC+84ols22kr1W5DOgecDGJSfsDZhFGS
         HZ9v3GSrYSsmi/wF2yTpuFMZU+P/clVCQJecd/0taODguDQuvaIhnuU+MuQg5ihtxLD1
         1mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809706; x=1750414506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HvUWWbqyabSrkLKCnUqjCj+bIC1dwqQSOsiTOO4fSs=;
        b=FsKzg5rBZqyW4F7i/HLfat7BYwzGxQGrt4PzItvrubmwu8I08aOPPYutaJy2br2FLL
         e+AGegI6EqKPSbnXJAhSscAf7A1dyw9JPHpq01HqDJ7zjtL1Li22wEzQ7fMvk78NdpDb
         msNMS4lubOHV+Flbu3eMJBtSMEI04F2Lvka3T9yRk5NkfxbbBgI/banN5+fcfsCuK75n
         tz+RTZLbBUloeaiZTpyFCA0iqt20J3pAWkFL00TAbEk4gbzRWQreX0wf2uTEbeiFNAUo
         lxvTsMfgJI7+4MZu5wr8WFFZ4GW9t6vvb0qCAH81dFg44Mxwe6jnpSxKrNy9nLdT9NNn
         Tauw==
X-Forwarded-Encrypted: i=1; AJvYcCVSvTCyzcYbtNgW98Xrpq+5fbdJUNFOH2B3OSz1AnMoCjeuOQMDg2ORa9WupGWwKR36jOzqYgU+@lists.cip-project.org
X-Gm-Message-State: AOJu0YzQjJ7yIgqElFf9dSPP2bhCyirEhCGIKUn1IkB8yqT6YWzBtaJ5
	7zT8rbmGZTyEk9lnh0VrsykQQSE6osYC8W4neu40Z87Bh4/IEh5QUx71wKXwdxEzISQp7XqTHSR
	aYXyo
X-Gm-Gg: ASbGnctQCJc7m+jsRxBSQwTqj5FhEtQZGx1fJsecvEHXeRsHOyGjpaZIhsObNN3roh0
	6oQQ1BfhOn066j0XtYJkZGrhcApHAtU04j7c+QwLZ7Xft/HNHYn0XG3mfD+KgwRRA+A2DFhXaJt
	SzyhqD+INNjTtZz0Q1aSMk0h0uIvBNSDCyrt4IXpYdyuWssbUcZTWAMlj4Ej1bhTk0/whFuFa8P
	0B2rczYZcUX5J8xbREucepiDSqkmJ5I7GUxzQY4Vj66c/GvhJf4Ffwk6cUxujk5bLgH2h5Np5xs
	a1nuA7VMpOPybvqWJ6OnDy9EZRvgTvqtNFJYrJ2tiMTi4v6nlUfS+aVl91ye80gN64FhhdVpgVS
	RdoDJD5aHSA3MM5t/
X-Google-Smtp-Source: AGHT+IG/K3/vvhHOKlb3smidRlMe4Mc8CWF5Al9Id75O+XLBRdGJLTZbWpBGk1iO08iYwxHI0CERDw==
X-Received: by 2002:a17:907:934a:b0:ade:9b6d:779f with SMTP id a640c23a62f3a-adec5d1bbf0mr228431766b.32.1749809706110;
        Fri, 13 Jun 2025 03:15:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/12] iio: adc: rzg2l_adc: Simplify the runtime PM code
Date: Fri, 13 Jun 2025 13:14:52 +0300
Message-ID: <20250613101501.262091-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19044

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 89ee8174e8c8db0efc75b26f2307114b38d61354 upstream.

All Renesas SoCs using the rzg2l_adc driver manage ADC clocks through PM
domains. Calling pm_runtime_{resume_and_get, put_sync}() implicitly sets
the state of the clocks. As a result, the code in the rzg2l_adc driver that
explicitly manages ADC clocks can be removed, leading to simpler and
cleaner implementation.

Additionally, replace the use of rzg2l_adc_set_power() with direct PM
runtime API calls to further simplify and clean up the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[claudiu.beznea: kept rzg2l_adc_reset_assert() and all its references,
 kept devm_reset_control_get_exclusive() calls]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 98 ++++++++-----------------------------
 1 file changed, 20 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index cf95aeab7cf9..08b4d43aa3ea 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -68,8 +67,6 @@ struct rzg2l_adc_data {
 
 struct rzg2l_adc {
 	void __iomem *base;
-	struct clk *pclk;
-	struct clk *adclk;
 	struct reset_control *presetn;
 	struct reset_control *adrstn;
 	struct completion completion;
@@ -187,29 +184,18 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 	return 0;
 }
 
-static int rzg2l_adc_set_power(struct iio_dev *indio_dev, bool on)
-{
-	struct device *dev = indio_dev->dev.parent;
-
-	if (on)
-		return pm_runtime_resume_and_get(dev);
-
-	return pm_runtime_put_sync(dev);
-}
-
 static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc, u8 ch)
 {
+	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
-	ret = rzg2l_adc_set_power(indio_dev, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
 	ret = rzg2l_adc_conversion_setup(adc, ch);
-	if (ret) {
-		rzg2l_adc_set_power(indio_dev, false);
-		return ret;
-	}
+	if (ret)
+		goto rpm_put;
 
 	reinit_completion(&adc->completion);
 
@@ -218,12 +204,14 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 	if (!wait_for_completion_timeout(&adc->completion, RZG2L_ADC_TIMEOUT)) {
 		rzg2l_adc_writel(adc, RZG2L_ADINT,
 				 rzg2l_adc_readl(adc, RZG2L_ADINT) & ~RZG2L_ADINT_INTEN_MASK);
-		rzg2l_adc_start_stop(adc, false);
-		rzg2l_adc_set_power(indio_dev, false);
-		return -ETIMEDOUT;
+		ret = -ETIMEDOUT;
 	}
 
-	return rzg2l_adc_set_power(indio_dev, false);
+	rzg2l_adc_start_stop(adc, false);
+
+rpm_put:
+	pm_runtime_put_sync(dev);
+	return ret;
 }
 
 static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
@@ -345,13 +333,13 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 	return 0;
 }
 
-static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
+static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
 	int timeout = 5;
 	u32 reg;
 	int ret;
 
-	ret = clk_prepare_enable(adc->pclk);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
@@ -389,25 +377,10 @@ static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	clk_disable_unprepare(adc->pclk);
-
+	pm_runtime_put_sync(dev);
 	return ret;
 }
 
-static void rzg2l_adc_pm_runtime_disable(void *data)
-{
-	struct device *dev = data;
-
-	pm_runtime_disable(dev->parent);
-}
-
-static void rzg2l_adc_pm_runtime_set_suspended(void *data)
-{
-	struct device *dev = data;
-
-	pm_runtime_set_suspended(dev->parent);
-}
-
 static void rzg2l_adc_reset_assert(void *data)
 {
 	reset_control_assert(data);
@@ -437,16 +410,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(adc->base))
 		return PTR_ERR(adc->base);
 
-	adc->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(adc->pclk))
-		return dev_err_probe(dev, PTR_ERR(adc->pclk),
-				     "Failed to get pclk");
-
-	adc->adclk = devm_clk_get(dev, "adclk");
-	if (IS_ERR(adc->adclk))
-		return dev_err_probe(dev, PTR_ERR(adc->adclk),
-				     "Failed to get adclk");
-
 	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
 	if (IS_ERR(adc->adrstn))
 		return dev_err_probe(dev, PTR_ERR(adc->adrstn),
@@ -479,7 +442,13 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register presetn assert devm action\n");
 
-	ret = rzg2l_adc_hw_init(adc);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to initialize ADC HW\n");
@@ -495,26 +464,12 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
 	init_completion(&adc->completion);
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	indio_dev->name = DRIVER_NAME;
 	indio_dev->info = &rzg2l_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adc->data->channels;
 	indio_dev->num_channels = adc->data->num_channels;
 
-	pm_runtime_set_suspended(dev);
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_adc_pm_runtime_set_suspended, &indio_dev->dev);
-	if (ret)
-		return ret;
-
-	pm_runtime_enable(dev);
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_adc_pm_runtime_disable, &indio_dev->dev);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -530,8 +485,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
 
 	rzg2l_adc_pwr(adc, false);
-	clk_disable_unprepare(adc->adclk);
-	clk_disable_unprepare(adc->pclk);
 
 	return 0;
 }
@@ -540,17 +493,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
-	int ret;
-
-	ret = clk_prepare_enable(adc->pclk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(adc->adclk);
-	if (ret) {
-		clk_disable_unprepare(adc->pclk);
-		return ret;
-	}
 
 	rzg2l_adc_pwr(adc, true);
 
-- 
2.43.0


