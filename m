Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CE9C71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:00 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.7080.1749809752180258150
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JZx3Fxkk;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so3405776a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809750; x=1750414550; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJJ+pYGhYEF1J0IRKPhGD9rKucNjt2Z0qEIxgOny92A=;
        b=JZx3FxkkvU9evNiI9xbAMSnw8v7TzHrhn9XI9Oh4sWbadkMSca2Nkp3WDrIRZiqkr5
         eowkNoBJDlC1OUbPz3er23h/Gj/Doc7CvjTRhowHzVIVeFaRyWAhJJzo+Ms45Qdg0kx2
         8lSvLGxdwck20E62Sznb93ojPyf7W9fc8k563vB/0yrF0YrrJB1cnCIJ3dIp+FcvYbkC
         95Yf6Ba6g1xZGKPUCgJfSRPqmrcAApTMhi/lOy2/8d6pHUjgQvb2Oyx1pGRoCDE1+cU5
         g7POJkinoWpRkrkWJvj9tkoZLG+aEm+JWhR7Py8c4ZyoSy8l8W/SdPPC9xR3IY5Qz2K4
         rJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809750; x=1750414550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJJ+pYGhYEF1J0IRKPhGD9rKucNjt2Z0qEIxgOny92A=;
        b=WLFJfBF9jp2ei42VDIY0ScGIXS2rScMohcp5fc56af8XgaI9T4d+DbBFzMwKPw3dHX
         pJIvFWi/3JEdJttBOV1mKmW3IYoxF0wJwSP58YRRKz2rQJIAr/H9SYTmhYMeMbQgnXAx
         eVZekzNCpbv0aHLxybHoHgJhLi1PWv3oMvQCNnhzdMvqWhdUCgwE6R+S3RD99Mwo4QTH
         esbIBmDI9yPS88Z7O9MLtMNjUjm5G5Pt/e6eakTNHi19+RA9NEOh44qjmpQmp0TGcyTF
         MRkb8CmX3pnMOmJ+OerrkfaLdlrs3BJ+3GlV0B/D+/snJw/mHhSD/Iubeaz5uZJyzn/r
         +vJg==
X-Forwarded-Encrypted: i=1; AJvYcCV+G5e1GXY4RYv1OamZpE1TvKqJ3QQKd2YLPk6NxuuJSZ440vT7N2UK7zwMLU5/3zGu7U5v4Vpu@lists.cip-project.org
X-Gm-Message-State: AOJu0YzF/32OfuOyCzfAQ5U5isDLXb/wngQ/x66UjzcQdp7/MWh9rcHu
	s149JvlBzFcLX6sUWnEtSlEjMmxXgrNKvQDBDF033Vt0Q97hVPiA+6v5qzwLi3OmLzs=
X-Gm-Gg: ASbGnctgSx7UBEMq9H2x5zmQJPxvHxs+I1GS1M0sIZOe+1OlkyPXOkSlmJLXr21UlqT
	GKbVjILkFGkA+s6b2s5Aey4QVDJzawb2/QHiqTz6Qr49wU1HgslBU4+tzYkGnxK1egeeBtmvRXe
	m0Y0ilN/z025VkU+aEtGSViEmSg2aT6sxWeOjchK0FbJ7ZimzKNCNiKXk3jMitA+AC6vRXvWghm
	YlGJvkxRbNDhln+RG02khF7siMdwrVI87a4mCmptYisRnHRlw2lH8Qz+6e0omTIltKDaWICbnFi
	n8OIscR8FD664SWr0/HKv78wREypDp6xgoh+1gTdio+yzRHzwKco4mD4boaZOyTxIuDFv2E7hzQ
	uBFii06TTJ65KkVrE
X-Google-Smtp-Source: AGHT+IHQmvCT+eVU5OSenl3FNEBJJuSh9hrqk34ewe7OJDBRJFkzh8pJhLygyphBYC6HNWKgs1HX5g==
X-Received: by 2002:a05:6402:5c8:b0:607:6b8d:1a7c with SMTP id 4fb4d7f45d1cf-608b492603bmr1947180a12.12.1749809750565;
        Fri, 13 Jun 2025 03:15:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 10/14] iio: adc: rzg2l_adc: Add suspend/resume support
Date: Fri, 13 Jun 2025 13:15:32 +0300
Message-ID: <20250613101537.279131-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19064

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 563cf94f932946521ce885a089399a2c813c71ab upstream.

The Renesas RZ/G3S SoC features a power-saving mode where power to most of
the SoC components is turned off, including the ADC IP.

Suspend/resume support has been added to the rzg2l_adc driver to restore
functionality after resuming from this power-saving mode. During suspend,
the ADC resets are asserted, and the ADC is powered down. On resume, the
ADC resets are de-asserted, the hardware is re-initialized, and the ADC
power is restored using the runtime PM APIs.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-12-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 2364405c6b83..a28aa00680d1 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -88,6 +88,7 @@ struct rzg2l_adc {
 	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
+	bool was_rpm_active;
 };
 
 /**
@@ -561,8 +562,77 @@ static int rzg2l_adc_pm_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int rzg2l_adc_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = adc->presetn },
+		{ .rstc = adc->adrstn },
+	};
+	int ret;
+
+	if (pm_runtime_suspended(dev)) {
+		adc->was_rpm_active = false;
+	} else {
+		ret = pm_runtime_force_suspend(dev);
+		if (ret)
+			return ret;
+		adc->was_rpm_active = true;
+	}
+
+	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+	if (ret)
+		goto rpm_restore;
+
+	return 0;
+
+rpm_restore:
+	if (adc->was_rpm_active)
+		pm_runtime_force_resume(dev);
+
+	return ret;
+}
+
+static int rzg2l_adc_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct rzg2l_adc *adc = iio_priv(indio_dev);
+	struct reset_control_bulk_data resets[] = {
+		{ .rstc = adc->adrstn },
+		{ .rstc = adc->presetn },
+	};
+	int ret;
+
+	ret = reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
+	if (ret)
+		return ret;
+
+	if (adc->was_rpm_active) {
+		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			goto resets_restore;
+	}
+
+	ret = rzg2l_adc_hw_init(dev, adc);
+	if (ret)
+		goto rpm_restore;
+
+	return 0;
+
+rpm_restore:
+	if (adc->was_rpm_active) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+resets_restore:
+	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+	return ret;
+}
+
 static const struct dev_pm_ops rzg2l_adc_pm_ops = {
 	RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(rzg2l_adc_suspend, rzg2l_adc_resume)
 };
 
 static struct platform_driver rzg2l_adc_driver = {
-- 
2.43.0


