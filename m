Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A7FC71157
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:50 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.7071.1749809742770613622
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=O+kzaO7g;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acae7e7587dso289341466b.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809741; x=1750414541; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQ3ecMgEVGnkqqYKDnMwHQpTkXBHPBf1sY20uBSdVvM=;
        b=O+kzaO7gAjnoJkSX8qvTsZhArxVC17PyDHPb8F0vSG6jpfLfmDMvog5kkg5A5740iK
         85BwKfbT9odf6wwdSeK5HTuSSExDMaLInQeZ5g91eY0DDENQen/oLPUNKPzGlCPURF4g
         B642ddLC1Fn2Nh8N3UbrTzZN7XND30JjwzA3n9P0kN4XLnL/Jb2BWoi51s48ZlkOQ0dI
         X1UXMZHfG71GN2KlIxk2M/9sq52P4sbv1EBUm57pZCeW8GwU4tYTLKLGBtV5u4G7uL9e
         pXO770ltcKqjL6H95GvqMABvEUUBZoh64T/lik6VXh0o61pHAGMxSI84AgdQG/Tp+ZxJ
         NoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809741; x=1750414541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ3ecMgEVGnkqqYKDnMwHQpTkXBHPBf1sY20uBSdVvM=;
        b=PBn2JklvGOdQ3RS+x9GjksOPKOlsQwMQvBhE2PLInold1Tj/+YigbHH7mgncOT1FvU
         xYIP4qMn/YC1KlRGkd+1E5BDwuAE7Or8ru1qVvfBLXp8gl8Wpwr95KVJ+RoaJgxLiIOD
         v//FivvoDFg2YP1iq0Tbn/bldKMVQxjX1ZmhJkbI3mAEyewiniHVJmbYotYJXLT0QSNv
         0ZelrMokRoCsBcRRZIevnvDD+gEp6QLwrrj4uLP2ojCy4dFx6WlXUg+zYtEEG8NVxcuU
         vKLMi5B2PooS/Ptlbmz8W524BJ0tYg5qneHagsNK5mRr5sKvBibn8PsrIA/7SyDb0I9O
         QqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4xHZI/3mUgikEyX+sysxTGKFDFZaiB82bt4hdW7k1REKePKtqssPLKXpBctTKJpywbrqAxpPe@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy09XlRjrnJzkhS3C+v4zdhYGEW0uaaeqEzNlDTupc+4husiYLR
	0iqdXKt1dEUAikJyeeNiFUgjofvG3yt5asdnfb5Dk7JiB4SDjvFHzDf/UuJfjIZ+LaQ=
X-Gm-Gg: ASbGnctSLImEmWyFtAmmYaYyAnvx2u3KJfHTqAgcjTgyM2dteMF4TFk1jUz0EAWz2bm
	SH3/ba8HLfoGiqW2hhMMZc+8PDQQPlwQbdpCfCyP6HKBhUJELU257DOrzr7dwwgSouhhL68i0Bz
	4aiJEe16hALS12tFuQpiZVB124tQ9buubuh+KRsGdjL0aZ2JSG1XEQAUlCZeAGVFituNTkQJ95O
	7BH2tY/4t12FsldOfN10svlwGDb/p170Zw+151w87S2EUXefv0zXQbt4iUSddpHcYiKjQH3rQ6j
	bfziNgius2bkAgEGix7G+cxfnwKCDQEHYz4mMB4ADkZBaf3D2F/oZoootT1y8695sCCB0LnN+7p
	+zSDbEqljeApirpeI
X-Google-Smtp-Source: AGHT+IGeIsvXW5Gqt67LNG9wb++WacAcdbPx0+21Glh4khUypOUcQ25LLDwbcN9FWa97Z1ho4AKCpw==
X-Received: by 2002:a17:906:9f8a:b0:ad8:8c91:f976 with SMTP id a640c23a62f3a-adec5c3e4f7mr238106766b.35.1749809741049;
        Fri, 13 Jun 2025 03:15:41 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:40 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 02/14] iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
Date: Fri, 13 Jun 2025 13:15:24 +0300
Message-ID: <20250613101537.279131-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19056

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
index 0921ff2d9b3a..1d847c878014 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -314,15 +314,12 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
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
@@ -450,62 +447,51 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
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


