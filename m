Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B59C71159
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:50 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.7075.1749809748315995806
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=d6+DtTXL;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so3951877a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809747; x=1750414547; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QU0VxY9EWwOTYYD+RRez7aXb2FrVjwg5V3cOaf6CW9U=;
        b=d6+DtTXLsgouy91Z5Zf8WWsOgePJZ8ezlaBH6OvZGwDkwWtC+vcPtBNrC8BFxv+pDO
         1ouBOnR2JDsyHsehldrclGQskVk6mSykI7p/g+Y+HoTFDq07+ZbJFur3Q9rfGXNLWKow
         yN5NRgX6lyd37Povqt5oI1PXrAxoNskbmW4pH49+jOd7ejX5WG0q68KicBioz1UNzjIQ
         Xdxy3bfXZETmKHa9E2ZZ7GhYS8nuLIdVQHt4pmVnnop9xg3YmJWTi3EP9YngBEBwTgaS
         O8h/xAaSnhmuHVKTFy8WVQdAVu/r52j2qkkUZQUBj7PGEa8V0tB4/nwLW33whoZsK6lV
         FtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809747; x=1750414547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QU0VxY9EWwOTYYD+RRez7aXb2FrVjwg5V3cOaf6CW9U=;
        b=UJksL8R0krWj80NDLv2ClzFxRyuKHpBF9wxIKWS+2QVOn5k/hKeO52K+HNldt/jybn
         Wc0b/26icxEjxKgxKzayatKqk3+jt0bjLWKjS8nKy4IyB/sNYyeww57OheCkkw1hKuiY
         a6wn7uzUGjdIeZrvK8+xPAu2ohAYTcmNburEN63/GiBnF2US8rCn7c5a1ttIbWb4cTeB
         F9aMXv9CokvgYQGtdpQEhI466XrectqSiU0vb4t5iyE6iSCAjAhWRaJM1hSANrJ6CgJY
         sp0KU8FzjDSYz1+Bm5mxlf6O4fZ3iQGXH5v5SohbX1sBNM8ydvBH8qRAvVfyzWsEAlX4
         KGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0W3cA7ladMl52prwp9zi2h0LxhNe5zsO+zvytn18ng8cxDm1IpdP6Q6VBdp1E4utuBWHyTu7s@lists.cip-project.org
X-Gm-Message-State: AOJu0YyuWTQDMO7GKN/jsqJ966UhJNLdOkPQ3D3PK+FBFSJmsHB+PaLk
	xMxTS4dTL1KPIhPOlnSQ634j8qYcPCPbbAc2CNB6EkphN084ALgTBM2XJw8LonBjBME=
X-Gm-Gg: ASbGncu3MfMxtQpcle9jYdmWUZRBbl5SnRj6YFQKwn+eusnyMrfIRiqSC20Y2OMprv6
	NL8h5oAcvKcqYOTrLwlWJkYab14WuXriG9r6rN0IyumDoJ489jD1daORcL0IXPzI42ZkcagYmV1
	DAdNDj/unpjbjKQOsgtknhDQU4kyF4bClOiUOtszmUVv0KSLys8ICCy2OuEs43wpeWDwdgMPPuN
	Tk3ETB4O47jBz4ZjI1xVKH+M1xdDsYMLmqOgcYov1hErHY0k+CFqpgz0b8hKdiUvPB828JRsDQp
	cq/+sh9wd/uBOnXXSdlHgsFKhhXX/k81UN7oY61TFml3GD1P7dVAvSpfe2kSDY/v8opEWQH5/8F
	hIzS38cbeO9ykJ4mL
X-Google-Smtp-Source: AGHT+IEUCPyZcooM42Py3z6EClyccwwdlxzRKzIDaNXMgQfdeWdvEqr18Q2v4THo5d2VCeB1N2j6iw==
X-Received: by 2002:a05:6402:40d0:b0:600:a694:7a23 with SMTP id 4fb4d7f45d1cf-608c6c3830cmr182372a12.0.1749809746738;
        Fri, 13 Jun 2025 03:15:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 07/14] iio: adc: rzg2l_adc: Enable runtime PM autosuspend support
Date: Fri, 13 Jun 2025 13:15:29 +0300
Message-ID: <20250613101537.279131-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19061

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
index 93ee448bf575..47e50cb3f270 100644
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
 
@@ -378,7 +379,8 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
-	pm_runtime_put_sync(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
 
@@ -443,6 +445,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register presetn assert devm action\n");
 
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
-- 
2.43.0


