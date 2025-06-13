Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C2FC71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.7097.1749809780048246798
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BSRdElNU;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso3641037a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809778; x=1750414578; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6V5An/99k04ybw8xt1BCF6wZ5tNLnm1wzTucQwQCYA=;
        b=BSRdElNUJc5YcaQ8tEkZkQJuRohP0IMJz0D696dNTlFq0ERn3AM/cyU/vtYjcjUd4g
         V0zdQL42rNLxDt0aHt6qkQ2LQx9Wiypkd6iq2ikb3kw09lSmdFVRpLg20cZizDDA4r8n
         ho4ENfF87wg8AeHYZ77JeGGnDjxveqpc4kpGQWsctMvrwTMWL4r3OvCscD/tF1l4+NFH
         //F4rhgXaSQnu7KR4S9EJSvOZWRkFyCAOVZ9EQgb70aRkEmYnEvvioXMHzmv9q+9AhcI
         0BuQz/k675u/bG17ly3oHfoSmzhEMMpbsrPArXaeUTjzvPM//FJI6ibjKb1vAucOxRv2
         U1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809778; x=1750414578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6V5An/99k04ybw8xt1BCF6wZ5tNLnm1wzTucQwQCYA=;
        b=ir1akgQOpUlUxDrVnv4uIAsQP9gJBe24hT4eWfZVM7BW6FT4vvnF/XkYGC2iVh1OM5
         0S5C8Hgx+zJ0GqiRp+sn/GK0KUgGw+OlAZNwExRMaUuhik8l7totGJKYpCOuU/PTXArh
         0ateAHJLLmdaL+QeDU8LWpKCH3soHr5ToPoRt87zwx5yTk90a/Jqy1yd4ANTIPRAt26h
         IC8OmNyVgOs85O6qMCHmDK/qQ+GhnDn6JLPSBsyfSTGuhV25Umd5j2N3qQk55ByQC+mI
         gqgmZsAcbUVNlMffCBJ9K0EvQGx1GHzP2F6JiP+1jZXgnddWvHWHKGqlSSwiWZv51TuX
         12Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWjrsl7wnxHoRLvy6NUjxLb9zqrIj6B7AWCmiaQvv8bxj+Y3YCdh6ZfVxHqoJnwTnMpThLls8A1@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz5Lvm01Opp4ML/xRITHBuunyPgdvf8KhWPV09rBxfRZ0uJEQKa
	9fQ6K1TDEtBESdY9FeKyKpj9C40WVk1QGSDV6BRy7Jv7P+LOLTy/vchzhvkh7ciXxEM=
X-Gm-Gg: ASbGncssxV0Gv/LGw059HoHTBh1svshqRwvl5rgIS4coC5hl3CsoDOmy9SieWJVaDsi
	0+wWRyQTeuNmlHj4BRJjvaJDynVCgk5vYlR3UQpIzY+iIgheH6oxp2Vfe4z+z3FpKGPTdJqSAp4
	R5x4p2llnk75XDLnFQAKfMjP34fgMaS9Mi/9uLf601Ouo8QXNcy443gm0esgh1IWdUXc/skkg1x
	izGZO4jJy+V0wHvBlCf7XTfVqlQCRnrWD2oDJrMfD/P76Ejo1xCK5Zez7hZiHpRNLD3DUY60SgO
	vB+xCeoJtvIPfLy4Uvg/Cta4vsc6YpOSEOmKLr6hX9FV3NQMa50j0mRl/uCssluiP3XuPw0MFpm
	Olsgh6K8Keoyz6fAPc5WWloYFcWg=
X-Google-Smtp-Source: AGHT+IHUdJRCkCGaeRALs4O4GUpOU9F7gcJ8MBw81L8vcQkluQErA3FTwPdK+lHbgpwBV2na9Wk+Ww==
X-Received: by 2002:a17:907:97ce:b0:ad5:2d77:7ca7 with SMTP id a640c23a62f3a-adec569ebb3mr226384366b.43.1749809778283;
        Fri, 13 Jun 2025 03:16:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 03/14] iio: adc: rzg2l_adc: Simplify the runtime PM code
Date: Fri, 13 Jun 2025 13:16:02 +0300
Message-ID: <20250613101613.296649-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19072

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
index 13b4c490678f..bfa70a3c6541 100644
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
@@ -349,13 +337,13 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
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
 
@@ -393,25 +381,10 @@ static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
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
@@ -441,16 +414,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
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
@@ -483,7 +446,13 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
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
@@ -499,26 +468,12 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
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
 
@@ -534,8 +489,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
 
 	rzg2l_adc_pwr(adc, false);
-	clk_disable_unprepare(adc->adclk);
-	clk_disable_unprepare(adc->pclk);
 
 	return 0;
 }
@@ -544,17 +497,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
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


