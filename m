Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F4BC61DB2
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:20 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.7096.1749809778921491185
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LAvYGVw7;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad574992fcaso297956366b.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809777; x=1750414577; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R5I6jcRxCYkEYOcMzklpOEu5N23inIXfEmJhw2RV/A=;
        b=LAvYGVw7cmFmEl/c+EsdjWe+GXqDR479UKMijVhrOCrNb4FN8OY9CKGQ3q3urZrrBU
         dnDQ/azNjnaQw+8PCpXghGYu6lLYukOWuw1wpcZVVUxR34vD7BqtsF+eK6E2osQAOsyv
         6cpWl7zEqo9umWocSnQf1cyWCrTm3GloPUKe5tBYCxf2WeIND7xlPyrpOdkQ7gnWCXi+
         5fikPNgJ9tHZg9Ep3NkkT7MfukHFYNwrEqVqthi+0YlQXvZg6L013OQdaudhruFzSlkj
         mOvoaQ56N/hO2S8hccnTd2t8RWuKykUbyp0KhcKW6WykxKITvURV9tkqe/vuSvS7DyLI
         H+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809777; x=1750414577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1R5I6jcRxCYkEYOcMzklpOEu5N23inIXfEmJhw2RV/A=;
        b=Hl6JKznNgBIqt/LPnIE4AEAOT7ZO3YRgnEI3P9gd2Zbh9HN3KRvuKxfsEuMUR2GlEm
         NPAlGW22nAjtq/Ep5Z+FH4UF1sbkApURZOUm+qvemrLcXLGjBvzI1LgwZGu6I58XreP7
         J+8B9Qtw+2VNYtBg0zVsccQGtxwHgHb3HCL3xjr0l0Gxk6OSYQAO3eGWSAtd9knHBWyj
         nY9W5DHGXL1X83sGZ+M799qePMXlKJ+oYMPo+/0MUETkycfg02kpYCwmA+FDDNpcTnr/
         YM7d6583dGjVdHvQtcRbe837BJqnqK8M6arZzDQ62dPiv3NfOkVY6p6HcXjy9pK3aO/s
         dafQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZJddKqTrmRoO5LS1sClKp19J+9MYxzvoGpHr/mulU3KVx1qHBVoZlZnndhX1iAVpsQmFyiU/@lists.cip-project.org
X-Gm-Message-State: AOJu0YycZXxALr94QMNxtfRJGuKCNJn1s6vB4E+MzA/31m6JYmYgpiFB
	6MdFXrnWGrOo4QK7K61ep5kjG44whHy5UAEsSA3jS1D1EK4HolBRkinQ5LK14A6dh1Y=
X-Gm-Gg: ASbGncsrkJ/wca/la8cQsbH6rFwgAPBQfSNvQ5jfjTxlotkq4f0bWZ8GbJ1k6ns9XYp
	CNCS0BYaiHPemWukKER5Fg2J3O4ZZGcHZnegSX1xlrn0CVsw6JvKV41j7jgHrSlisQIKXLzNzta
	v48iottdIbgwWShEN6fFpgyeaTGxh9lFtr0yeIFAW+s1wx5CCPP7pskceVZx7VaDu3bgMVYy7tC
	PSwnb9+0GQo7/qeAZaA5dIA94kcZXcblNQspWNFgI5L+056l8RiN7U0xfEqm3pgVwYpzjGcSYWW
	5FgyW0quoDbb2OE+c9cl7QpploMkdP/apPFCQBcBKRIX9M6HmA4NuPu4YJa9IhBnOwLq8LRamZ6
	sDYsZ9Cyfn9lAPmj0
X-Google-Smtp-Source: AGHT+IGUOY/xTO1go8v+4Moxxp09hsbbZDU9QSHOXwQv+DFFto+oc770Ec6hjt0z+JlaEnIOTaauog==
X-Received: by 2002:a17:907:6e8d:b0:ade:3ce3:15d1 with SMTP id a640c23a62f3a-adec5565bc4mr244766666b.27.1749809777156;
        Fri, 13 Jun 2025 03:16:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 02/14] iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
Date: Fri, 13 Jun 2025 13:16:01 +0300
Message-ID: <20250613101613.296649-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19071

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
index cd3a7e46ea53..13b4c490678f 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -313,15 +313,12 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
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
@@ -445,62 +442,51 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
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


