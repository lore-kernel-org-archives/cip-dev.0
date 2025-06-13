Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02296C71151
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:10 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.7067.1749809706935708264
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Qthc+hkg;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso4190323a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809705; x=1750414505; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH5wDizsWU5kOMHjwRpVGmiDa30POD+WZJPQmgh1jzE=;
        b=Qthc+hkgPRjaChreQ13tRs0bK8hkJUXCBWy8NGtDK5xGaVycxFYj2zGjQ+Wi8SP28f
         butIYPgJTHIIfGWFnbo+GfD1+/oAKBcW6Gw6MQBXoO4ALDkjcla6UmJzbg9V7wZTO4yP
         XcO73cAsFTKHiS8KkQk5S6mswwI/Vpy0uVdvzXoFZ1Q38lXVexx0l544m8NVUaT5KqOV
         pPpM/40aNM4JU8YkHcAyxp7u14mvr56CuUe0b3rauzerDmUhtJa7XgQtvAEVXW5kVKEz
         7VNsv0ez32QaG8soYk0uVwsDsrtTGJbOSNh6sYgNIcy+CQURRdbop0oVHsGjZXfJT74b
         GhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809705; x=1750414505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uH5wDizsWU5kOMHjwRpVGmiDa30POD+WZJPQmgh1jzE=;
        b=TX4G5JayHyKHQbelohciNk078hUV3AZNwmKTKEW3qQSLxpZNKLUC0bQ18SyvbOTeXS
         gWdIqaFSRg7M5SqxW3gV+sOZb1631yD+PKHv5vCXLJV9LYt4xa77We40XzfBgUBml+KD
         PmRRufv+ln/RPaMoOfeCr5vusJguxChJDWC8nRwmJzd/kVq6ZguJamiVlzjTk8TtwCRz
         QnyPyA5RsoQcl70idYxawdrEmdtFYpiunBLSOfePaBVbM6uTYlUuw2DaSvAp25lSGjuU
         D21krNQ8eHUBUp+eF+LcxIWLTXxyl0Zs92qxPBBBelDW8xJnNvJqd9UT6iCBiyZyKDQF
         okFA==
X-Forwarded-Encrypted: i=1; AJvYcCXaBz3IZwqYOsLERqvRC0enNysQZAzAdKQ36+83LMVguy4MWsGSf08uvgipPsYvA8G0nahWZwhz@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxu4ABd1sSOHEqIdnR0U+3zeUvoTagYkrGutY3V4129cgYcDuMs
	CsCWpFwB7+lQRIX/k6CR1nHLxQ1NxLqRWMck9ZCe2r6u6XEuC98Jt8MGfICeJS9H8BMNKZcS5jq
	sw60M
X-Gm-Gg: ASbGncs0n0wP0NmCzDCSVEP7Rl0MzFEfN7RzF0thKp9dTJQIS80kKZlAbAW9cx3XcNd
	mfiesgEBLdUFA+PiN54hV/FYF+Y7Vx2xn81LCRo5h/q74SBPqWIDxA/7OcdFimXTaKomiEPV4Ln
	mjddpHfwb2eE5vUSjWXumFW261JdJWBG9bHq++DK+i/h/wmJjazm8wCnWnzRQ2d5z7lod6vmqjs
	GBPZpXONGQCDHHH5tKctICY/1dulQSWnYtPm6f0K4tAh+izH5jCIJmoZBAaj20S1qhRxzrYLEkW
	Am/W5Hz1ufD6JiU5LeM0xzi90ywGDu83AReTy1a1mSPSqQutkGQsxnaCQDEu1uS4uMRqE2cXZtF
	LuHqef2Ohi4E8Qjx6
X-Google-Smtp-Source: AGHT+IExUdldqE4iCZwyViZafLPrw2EkB76e0oxnPkzLDkRJQaTF4BoMOYbNy/Ko+qi7m60ez/Tykg==
X-Received: by 2002:a17:907:6d1c:b0:ad1:e67e:483 with SMTP id a640c23a62f3a-adec5c2acd6mr237283866b.45.1749809705013;
        Fri, 13 Jun 2025 03:15:05 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:04 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 02/12] iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
Date: Fri, 13 Jun 2025 13:14:51 +0300
Message-ID: <20250613101501.262091-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19043

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a34dc289f89ecc4e967dfe6ec742aafdc5ae62f6 upstream.

Convert all occurrences of dev_err() in the probe path to dev_err_probe().
This improves readability and simplifies the code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 78 +++++++++++++++----------------------
 1 file changed, 32 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index b36048d7015d..cf95aeab7cf9 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -305,15 +305,12 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		return -ENOMEM;
 
 	num_channels = device_get_child_node_count(&pdev->dev);
-	if (!num_channels) {
-		dev_err(&pdev->dev, "no channel children\n");
-		return -ENODEV;
-	}
+	if (!num_channels)
+		return dev_err_probe(&pdev->dev, -ENODEV, "no channel children\n");
 
-	if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
-		dev_err(&pdev->dev, "num of channel children out of range\n");
-		return -EINVAL;
-	}
+	if (num_channels > RZG2L_ADC_MAX_CHANNELS)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "num of channel children out of range\n");
 
 	chan_array = devm_kcalloc(&pdev->dev, num_channels, sizeof(*chan_array),
 				  GFP_KERNEL);
@@ -441,62 +438,51 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(adc->base);
 
 	adc->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(adc->pclk)) {
-		dev_err(dev, "Failed to get pclk");
-		return PTR_ERR(adc->pclk);
-	}
+	if (IS_ERR(adc->pclk))
+		return dev_err_probe(dev, PTR_ERR(adc->pclk),
+				     "Failed to get pclk");
 
 	adc->adclk = devm_clk_get(dev, "adclk");
-	if (IS_ERR(adc->adclk)) {
-		dev_err(dev, "Failed to get adclk");
-		return PTR_ERR(adc->adclk);
-	}
+	if (IS_ERR(adc->adclk))
+		return dev_err_probe(dev, PTR_ERR(adc->adclk),
+				     "Failed to get adclk");
 
 	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
-	if (IS_ERR(adc->adrstn)) {
-		dev_err(dev, "failed to get adrstn\n");
-		return PTR_ERR(adc->adrstn);
-	}
+	if (IS_ERR(adc->adrstn))
+		return dev_err_probe(dev, PTR_ERR(adc->adrstn),
+				     "failed to get adrstn\n");
 
 	adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
-	if (IS_ERR(adc->presetn)) {
-		dev_err(dev, "failed to get presetn\n");
-		return PTR_ERR(adc->presetn);
-	}
+	if (IS_ERR(adc->presetn))
+		return dev_err_probe(dev, PTR_ERR(adc->presetn),
+				     "failed to get presetn\n");
 
 	ret = reset_control_deassert(adc->adrstn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to deassert adrstn pin\n");
 
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       rzg2l_adc_reset_assert, adc->adrstn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register adrstn assert devm action\n");
 
 	ret = reset_control_deassert(adc->presetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert presetn pin, %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to deassert presetn pin\n");
 
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       rzg2l_adc_reset_assert, adc->presetn);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register presetn assert devm action, %d\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register presetn assert devm action\n");
 
 	ret = rzg2l_adc_hw_init(adc);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize ADC HW, %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to initialize ADC HW\n");
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.43.0


