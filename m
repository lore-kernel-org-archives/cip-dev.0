Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF94C61DB2
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.7101.1749809782479334896
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rd6rWZGl;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso355589066b.3
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809781; x=1750414581; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG6hpcFRIr7lj2jVLzCne2dabXND9WWIEyVYA6dz6BY=;
        b=rd6rWZGlRJTM+84PEaltd13RKwZL43aX+6ntRKMRbiat7zRXnmbrD/KCBPAUaNWePs
         NGXXB60FPUeZZu82YsSoKqXshjLAu8CU8Bgt+8ulbj1cS4s+aVLZrOjtPsvUw/k6/nOY
         Z+3c7GoOvhmYqfzipTqhiqAKTHrhGtSpwQx7o2XmemHrESdukp3Ot5Zi5vB6aiV9AyKJ
         7m0AlcHFfMLTexfEn9vQ+hy1NWHvjkh9YzHNa+nBqS2jJ5aPZEpyOsl4YJGCS8LnmZid
         fHG/X6KDD+S3iaSJPCczQUcxikQyQf4zPr23u2UJ6F4el1cx44rBlMDW44mW1svsnWrE
         AO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809781; x=1750414581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG6hpcFRIr7lj2jVLzCne2dabXND9WWIEyVYA6dz6BY=;
        b=uM5FuorxXiYcjUg+fuqGO1ou4rlYddIloWFUeEun7i9HFlNtWMKcff8nfQbmUk7Tyo
         VoXjfSYGX53riMKCuYlXUtKuqiq3kMMByR8guxCoK1Htf1qqvMPp/tX5hod1I8WrqmbK
         VvdF/GQWWbDU7tP6y9u+vQntMrsYz98/QhNjE1wOnwOeOZpa5/Toj3XJ+e6T5yYLbZ1R
         RW/gsECvBNN6zLmq8hU09aKUFec5PmefvgrOFAJCx+WpQ39KlYi15NDIV9HiQL4lXeve
         lrRi1YdjCrP0LiXCpgH3ihco9a/vujf/jo5AUdQtMh0wjHbMgbJfnUicEmBrVLEutTGk
         3ToQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMtX7d27iCeLfBDhV2LfPxmbjpG0YAEZWQkThc8RaHx7uoJTLthRG2yMfgsckcsx6D5w5b0oAY@lists.cip-project.org
X-Gm-Message-State: AOJu0YwYXwU/M0D/KACLMvgP9TtF/QB/NTpuJ1UbfMGqMpg4mysieGay
	L4YsHX+atwssfK4m7h9o3Haqrp0uYeQbrqWH0Za+NUByAEz3j1kwXOfHAEU32Xo3yTc=
X-Gm-Gg: ASbGncvJjIa2Ae9+CxhbYQ+fm551k4TFI7U5tPeveKvJCx9AR2xXJt3nn1MtjEp9XV9
	eJlpGFe9fEdUVpJ+HL/x+DYel4/vtR8ZO9p3ShcbVuJOzwDdA07SnZSrz2YoII2FIxb95dY1k0i
	ocQvBJ6FLkzs0jfikZTBaQjBQmy5Z7zxIiT/gfO2fFPIRkNfNE+2NMDZPS3qh11K917Lp7S0RT8
	+WI6kJtbgZMxBbg6T6kRM7nPZKWVJae5UFqENfRZIMo7QQbBsqmGH5FMAQHjAouwzx8/uG567o8
	i7VdLdZeClADqQqTa/0a2m2nDZ/xuJwf1XpuLkx/QGEYUbbbOvPNgoye2x3Wsr0q+wPUzNBfSSd
	eFi29PI/IM+oug/UW
X-Google-Smtp-Source: AGHT+IEgAhBEkynDbclXiq+QhI8TdTnaNteAXBUPtvzTkRyqNF5R514EnOjVXTWzt4a5rIvjXISDmw==
X-Received: by 2002:a17:906:9f92:b0:ade:316e:bfc with SMTP id a640c23a62f3a-adec553b700mr256729966b.21.1749809780790;
        Fri, 13 Jun 2025 03:16:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 05/14] iio: adc: rzg2l_adc: Use read_poll_timeout()
Date: Fri, 13 Jun 2025 13:16:04 +0300
Message-ID: <20250613101613.296649-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19074

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b7549624af04eb52cb28df57bee2bcc88be1adc0 upstream.

Replace the driver-specific implementation with the read_poll_timeout()
function. This change simplifies the code and improves maintainability by
leveraging the standardized helper.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 46493fadab48..ae8a7a02bffc 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -112,7 +113,7 @@ static void rzg2l_adc_pwr(struct rzg2l_adc *adc, bool on)
 
 static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
 {
-	int timeout = 5;
+	int ret;
 	u32 reg;
 
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
@@ -125,15 +126,10 @@ static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
 	if (start)
 		return;
 
-	do {
-		usleep_range(100, 200);
-		reg = rzg2l_adc_readl(adc, RZG2L_ADM(0));
-		timeout--;
-		if (!timeout) {
-			pr_err("%s stopping ADC timed out\n", __func__);
-			break;
-		}
-	} while (((reg & RZG2L_ADM0_ADBSY) || (reg & RZG2L_ADM0_ADCE)));
+	ret = read_poll_timeout(rzg2l_adc_readl, reg, !(reg & (RZG2L_ADM0_ADBSY | RZG2L_ADM0_ADCE)),
+				200, 1000, true, adc, RZG2L_ADM(0));
+	if (ret)
+		pr_err("%s stopping ADC timed out\n", __func__);
 }
 
 static void rzg2l_set_trigger(struct rzg2l_adc *adc)
@@ -339,7 +335,6 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 
 static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
-	int timeout = 5;
 	u32 reg;
 	int ret;
 
@@ -352,14 +347,10 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg |= RZG2L_ADM0_SRESB;
 	rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
 
-	while (!(rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_SRESB)) {
-		if (!timeout) {
-			ret = -EBUSY;
-			goto exit_hw_init;
-		}
-		timeout--;
-		usleep_range(100, 200);
-	}
+	ret = read_poll_timeout(rzg2l_adc_readl, reg, reg & RZG2L_ADM0_SRESB,
+				200, 1000, false, adc, RZG2L_ADM(0));
+	if (ret)
+		goto exit_hw_init;
 
 	/* Only division by 4 can be set */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
-- 
2.43.0


