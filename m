Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6ABC71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:50 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.7097.1749809743764161510
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XnnmVunh;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso3437269a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809742; x=1750414542; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvFEt7gPX0H8cy/ugFs5GNjqqfmDtz+DyE6gzgl4WAU=;
        b=XnnmVunhv9+PKDYJT2iN2xbxh6F4YPQ3n0WTa4FLVMnCW04uXUzRC4vvs+xkBHQjq2
         iL4SvT196ntfCeKcoWUoZmkooMDy+0aS9FbFTWWNiBE2Xj6sZTnJbaXRS81xOZQe6KG4
         K3mtpdKVAMzlLvZ8huKhfln48wDEaixg5QXOEOY7Bu9J6Ya2mBXG8wYRCR4TDFPPVmZF
         yycpOyyGe3kT/bk3ZOq7YsH5bm9njQbJHje7RGTmOXl61lEGNCn61dVBDvELX2Y/fqlR
         wGZ/WdrQ+7Fv0VYSonXf24HbzU1tXqNbBLGKpJSTNUI2eSzgKmA63K4aPiBA5W9ifkBi
         pQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809742; x=1750414542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvFEt7gPX0H8cy/ugFs5GNjqqfmDtz+DyE6gzgl4WAU=;
        b=qKG1gPo1kVtu1V+k6jzlM59k8gZOxwhotzxIYYOw7jeQq1FoRJgAk6q2Uz/CD0Lgw4
         YzSsQjI0bhy0UKf2THGRkvrfNSQGLRcK5eQfZ5dyRbjJZAy5cgUjUUrCp3Y7qkSSBVns
         c5CFfjRrn7oiGreGyezaqDzYul++ZOZ8iHxIPkgP3uqmQ9EGb1F1pY0ElZH9kh45tNyo
         /e8nEbA+ZzqeCKxUZTO6nUQ0Ptt3KlnICvExTBqtC46xIEWC+4Lab3uf2v6P7Y+8dmlw
         rX3V78ON262p/qb4rXJcPwhUdELT6yWiyWJdJcsyeZcg+Ku0DIYa6zGaHsDvA7BerNos
         px3A==
X-Forwarded-Encrypted: i=1; AJvYcCWardAO8BBsYXKu1XIe5ilt8iKYZ/JGfJghKxEIp+8etYcsT6+bgZye3ARThfIN9YzgIxUmsezx@lists.cip-project.org
X-Gm-Message-State: AOJu0YwVMjuC/cv9vufFTJfBtFq1ld6PhV3IpLuGwQbO1jh3Is87jaNy
	fhsk9994A+KUSZhunJVLPMiQ6ShGf/o633ULth899rOcIUWGh2QVYQW5S6aOxzjzpDE=
X-Gm-Gg: ASbGncuiB7MPZT6w+bXeFnUec659PHjKOULA7YLivhzfjhivQp5uy72vQpNSHRKlaiY
	oSgOFh/yr9lsEwgxwQmPZ1TafsIQlE8cZmMQrxLq4RwxXb6+KN0oxRUo3WZxY9fPeZ3lnGWxQRu
	rpFXxosUxMArLXgt46BmsrlEN1c3IIO13Smv4iIzvZQixTStc/eng/WjN5PwKN3FoXM0rYT755U
	OH6HHzqu4dsdc6dEj2KC0EfXI5tqEs86XUvLmmPiw+gVuwrUzMsAoFCcJgbVXIaBeJV68/oP2Gd
	fIBJfA+gIs8P+FG0lPREH6eJ5XfQ8Eblwcgs5UQdMtZ6BcUMjgodCC5695LXAJRmcVn13GWi75i
	o+0HeDJ6yu9ijM+ZJ15o9tcfI+wY=
X-Google-Smtp-Source: AGHT+IGYQ+4MTGJKfQMeW5iidKuVxA9kmtjpnAXMe1x7egmQq7KG9UlvdFuoPd19SWnKZ6PuGV6U7g==
X-Received: by 2002:a05:6402:268d:b0:607:16b1:7489 with SMTP id 4fb4d7f45d1cf-608b4986f2cmr2111000a12.20.1749809742146;
        Fri, 13 Jun 2025 03:15:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 03/14] iio: adc: rzg2l_adc: Simplify the runtime PM code
Date: Fri, 13 Jun 2025 13:15:25 +0300
Message-ID: <20250613101537.279131-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19057

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
index 1d847c878014..1de94bfd5c5f 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
@@ -69,8 +68,6 @@ struct rzg2l_adc_data {
 
 struct rzg2l_adc {
 	void __iomem *base;
-	struct clk *pclk;
-	struct clk *adclk;
 	struct reset_control *presetn;
 	struct reset_control *adrstn;
 	struct completion completion;
@@ -188,29 +185,18 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
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
 
@@ -219,12 +205,14 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
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
@@ -354,13 +342,13 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
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
 
@@ -398,25 +386,10 @@ static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
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
@@ -446,16 +419,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
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
@@ -488,7 +451,13 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
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
@@ -504,26 +473,12 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
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
 
@@ -539,8 +494,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
 
 	rzg2l_adc_pwr(adc, false);
-	clk_disable_unprepare(adc->adclk);
-	clk_disable_unprepare(adc->pclk);
 
 	return 0;
 }
@@ -549,17 +502,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
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


