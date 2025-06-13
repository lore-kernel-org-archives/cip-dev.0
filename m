Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0730C71159
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.7099.1749809781464559209
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=I9afnt/w;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad1b94382b8so354401766b.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809780; x=1750414580; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVubKgJXCl4no5n+fg2x35DhZsZhgV6WJbuKdq6L5u4=;
        b=I9afnt/wW+OoDHFxoHMTyI9NZcJGJsV/zeVih8OlOQDtdhGw3/5emBS2CUD3MGC/UH
         fomqV2RCJpblptp8Y7ufGo9/sYJnFa9JM++dI3g9KVgNup8g9TPciQ/mZPe9gqmEw0Nn
         14zQtXygGKBZ3z/HfF6bBjw7s8zMsOXpmLQCqQHWKW+FBuhPsEKhIUuBqh3gpgmW3bmN
         xDC+y1on7zf0hpM8PdfdIb+IQil3AZBX+0LAuyirenBeHdsqjJlcgT3sO8QvwDZ0zImh
         s9zCxUHebVO0X3Iu8BtUFMbhUUA24sxVtVcGd0PMsidEeGBLL/yu8s06GvhJaEDVxfnR
         2rMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809780; x=1750414580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVubKgJXCl4no5n+fg2x35DhZsZhgV6WJbuKdq6L5u4=;
        b=fw5fATe9Vzuin39EV9+SGggeZ0htgcI1UMAlb27dyeSLlKX//8rO4ewNt+C/i15nkc
         3x6nrTFKODG5SDkLC3FJCMRRYi00XSF0TJQgCyiX8auyZJPklIFACOCEdzZnUXfO3i1/
         qG4ZFwOQx03HjmyOn/rShwviWcLIXeRa2rZGnY1qxA0rBGL2pZGXxj4ifzFLR51GnU0n
         2VP2iRY7xTqZxEpIRBHAMEfv61UQhQiHDFOGWojWnHhslc6cFL5X4JTscG1nQyZc3Z05
         Eo7zq2wrdvLIB2UYXvL8449Fk+AKK7a/u/sQoixPzlpQtjcxMp+wkJ+nyttHGO1KOzir
         l+rw==
X-Forwarded-Encrypted: i=1; AJvYcCVYluGAuuPmTYwoSRZjbPnlW/lPioxdOKdn1c8Jm/dPwghHf5bRoGarVqbagOUDbt3j52VcGJ03@lists.cip-project.org
X-Gm-Message-State: AOJu0YyKqrnvf4WTLrHvpNY82k21UgRBLX3LOm2+qtPgNZISrJWf5n6z
	0bPG9I4RPFgBIo9lvHBs6TZsu8BlNvF+qstnHs0oVtbibg39MjFGrokaa6kdUXMwN4dWhdA4zd+
	pz5ij
X-Gm-Gg: ASbGncvTMqj/ilODepgbTFrg/5bkk3iQoH3FiJCFazNru/ewgBJAIe2LZYxrZOfH3zY
	QE4bWSqv4y+sCczuLcbU5WdrrUft/fyDsc8SD79JsMdJhqWRiH0OyVhk32FcbTho4ZrufV0Y+j7
	HpWe9dJDJZ09PjRCukGo0oPs5ivHSmQKHJewcxly7d0wLLGCPa4ssBoSRIaBBg11DZzdYtD2QDg
	f3XrMIWA1GqHfGLTTF7g8RQbnf6EGVMrcH/FWjp0CP/CvZvov0OeGl2lwRLCICmTooSrXrT/Jsi
	KE8gy6HnjaFdXn6Gwiplt/jLiKaE9n0EvZ30AbODXAwJP76hIU90yyJaBQ3Yki8debOhQjeFwCZ
	vjoP15K5IApgLWHrc
X-Google-Smtp-Source: AGHT+IH3CUmRNU5Jz5GG0MtZPOPZvnRJVu5+OLwKJwh51Y4b/vUU/SP67t6pF8KmO8BMRqEOI6FfnQ==
X-Received: by 2002:a17:907:9716:b0:ad8:9909:20ac with SMTP id a640c23a62f3a-adec5bde506mr253213466b.50.1749809779682;
        Fri, 13 Jun 2025 03:16:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 04/14] iio: adc: rzg2l_adc: Switch to RUNTIME_PM_OPS() and pm_ptr()
Date: Fri, 13 Jun 2025 13:16:03 +0300
Message-ID: <20250613101613.296649-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19073

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
index bfa70a3c6541..46493fadab48 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -483,7 +483,7 @@ static const struct of_device_id rzg2l_adc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
 
-static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
+static int rzg2l_adc_pm_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -493,7 +493,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
+static int rzg2l_adc_pm_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
@@ -504,9 +504,7 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
-	SET_RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend,
-			   rzg2l_adc_pm_runtime_resume,
-			   NULL)
+	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime_resume, NULL)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
@@ -514,7 +512,7 @@ static struct platform_driver rzg2l_adc_driver = {
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.of_match_table = rzg2l_adc_match,
-		.pm		= &rzg2l_adc_pm_ops,
+		.pm		= pm_ptr(&rzg2l_adc_pm_ops),
 	},
 };
 
-- 
2.43.0


