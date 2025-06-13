Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E2AC61DB2
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:50 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.7100.1749809745083069910
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EXT052U8;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso3377296a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809743; x=1750414543; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh2HaOUjJPfLbK5Q1M7/b3APM88gd1nzU5XabJ8/OQA=;
        b=EXT052U8q/thj0ZxSG3jye9N8R32ezlygcPgpK8D5uYpDsou3gAO1+nm61vK0CjuDu
         +lxwC0uzdLKGYK1Kja87sg6iTuv0N9pcKvS26xFx6JwHnJ92hBtCok8Ihg20HhZ5Ee6d
         YnFAVWRzyx19QUu9BuVBtFcq9+1Nj/dLFky9Xhyv75uZ67dSPylDbmHj6Ym2cwq16M/M
         3bRVMYZrbqWIHfk1xWvj+Gwv0WoAM5wUsl1CxF0W3jCKWLd1IiGROhFhP0v3pUly2Cmv
         rU7jb1EIkvHm0Gw+r3Vw3wyRVsdevzGsXgYBYNOAfZnoX1ogK7/tH87woBb1ih3O+Q6e
         IilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809743; x=1750414543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sh2HaOUjJPfLbK5Q1M7/b3APM88gd1nzU5XabJ8/OQA=;
        b=GYZJ+rLdN64/JJvc3ER6GLwEUXHCgWUEH1EA5Img4YtYE+ybZD241uo3cJ9tw4ug1w
         53pK0DPAbUez5PVIUfCB7tsJTJ2dLH+flZImEMoXE32SEKi6w6O7pJdjl46yLjcjqt5I
         i5olttOA1SWayclnXcJ7qtEICBJHYS8zlMhtdsIJUwXbpOM68vQWjysGiOIFDQrM8fOV
         eBqhwjOrwVI8EBC9Sod5USdvY9WEZFz699Y5dnYGAwwGOdEGLO0hQrd6ieKSgP0VMJcR
         RPf9kS8BJBkI6JwD1jGvNoG9MBmWTmHUUCA/4wjtvKXJKC7cfHd2zKK83vuB6GnOjqM1
         jRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNsX+4tdUaionDKJfQ2PfJVMMNYUa8e426kpArqN2uxBj5T2Vt/g5FeHYOHJM4FrQb7gLl+yZ1@lists.cip-project.org
X-Gm-Message-State: AOJu0YyIVlmcj6AF8I0uQISXDEXJB31DeNmIJUcNWGKDybJKSKwJzO9G
	kGWAff6+p+ijNzoPND1qCH5UFxwzjlETJqwubw5adNShpNc2v460nRV37jf9LN5ghLo=
X-Gm-Gg: ASbGncuKalRqh3O36w5zs2aVTcc0WOsgCwoSdsrVfMDV53OJ2bNeEzw24OpWhSZ8JFu
	cAIvYUTcWUcBTaibSlqdW6pFBYdjdRuNUjslslvanGImivUkRuw11v9LsjVtsgK0nmKVlFOE1Bd
	ZtVtyW7JoP8l7b2mNLnj3kdQRxU0fDUZVTrS1AWc+55vbJXS0SlS6vGGLYzwK+R3Ho/VXNKaVDC
	uyiijViOJvsZmfrdZ7o6YudZbzKoHMhJxzvdfQxn0/3+E2Mu+p3gfC9Ko+7InxJMx22791YxRlG
	OjtHJT+d+3dCi41cn+67ouD0g1r6NLgIwgsgyT2r+sCYZEJJrXwTbIeMYK022zeQtV6OdFlVW5I
	j+CGPq0cD08Zoa/AXOBencJ5XyEc=
X-Google-Smtp-Source: AGHT+IF6nLgR3zgFOCAKdapid2MmBXUAMQmAGE2d60vANfzqb8fFoVV4lzRuKA7T2m7hDg4qLQkRJQ==
X-Received: by 2002:a05:6402:3587:b0:608:50ab:7e38 with SMTP id 4fb4d7f45d1cf-608b490f867mr1981893a12.14.1749809743471;
        Fri, 13 Jun 2025 03:15:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 04/14] iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
Date: Fri, 13 Jun 2025 13:15:26 +0300
Message-ID: <20250613101537.279131-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19058

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7842ef74c5fc807e1ebd221b6301cc144057280c upstream.

The use of SET_RUNTIME_PM_OPS() is now deprecated and requires
__maybe_unused annotations to avoid warnings about unused functions.
Switching to RUNTIME_PM_OPS() and pm_ptr() eliminates the need for such
annotations because the compiler can directly reference the runtime PM
functions, thereby suppressing the warnings. As a result, the
__maybe_unused markings can be removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 1de94bfd5c5f..e234d0e50ba3 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -488,7 +488,7 @@ static const struct of_device_id rzg2l_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
 
-static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
+static int rzg2l_adc_pm_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -498,7 +498,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
+static int rzg2l_adc_pm_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -509,9 +509,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
-	SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
-			   rzg2l_adc_pm_runtime_resume,
-			   NULL)
+	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime_resume, NULL)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
@@ -519,7 +517,7 @@ static struct platform_driver rzg2l_adc_driver = {
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = rzg2l_adc_match,
-		.pm		= &rzg2l_adc_pm_ops,
+		.pm		= pm_ptr(&rzg2l_adc_pm_ops),
 	},
 };
 
-- 
2.43.0


