Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2F6C71151
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:00 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.7082.1749809754442534422
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=atfGvshK;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so3030924a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809753; x=1750414553; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=of0Xk09T1wfyass66Rofwr7/KU+bS83xKkmgiTiHWVY=;
        b=atfGvshKIyovXZxa21IrUmMgOY6FP28K2zl70EqjUj4uA5i79qXT3pUFDWgvjttTGn
         lnlTx6nFGNmOTfeqDXJtFUOigO9mIFhPESnOnY/oIbZes71lYZ2dCX4fqp43SAgGfMtV
         83+yhlE2sRqNjJBJWrURz+b6gw0U2jT50l1aM2zQbg+GPiRCzQpgI9kSrUkswhvyYffy
         sn/dap15FIUDUxBo+hRcaFiYSVjUknj4kQGfgddA05AmQ7Spw3Lz+9FTh75lFe++M64P
         Scx0JSo2BDBt+gb+3frO/eWJ5Mf8dDVm6Yw/t21NR94uwJRJd75udmATzhcveUU2xUFQ
         dM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809753; x=1750414553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=of0Xk09T1wfyass66Rofwr7/KU+bS83xKkmgiTiHWVY=;
        b=QYbNYy5gd7A8piLWvva4fu8scXUf3mbES4yJ8c2vYgDLXGQUFLProCrYjzOc1tDXz/
         9ng8tKm8XLqLjtdn69lnKdFoQveQ7qtPAW1XSqJnF7uxTkCTbTLIFy7t+LEakfJeq1ph
         kwQaxtdgKdOtCMTXxJVRyykFtY7TutktrKEK8Mz1Oder+mVABKJgS5zj2AMJgjnGl/KI
         etJJ3vI36+clXBoVgCe82JjSefEIWyFUiDYMxtViGDcqoMGG3QfAz31CUp9/tBUdaFe0
         8+72idXseykGXVyHavQL/qhTkii3v2SdqinRhGKkmm3PKMOwtJK0By2HsHFWLnckGZIn
         eDgA==
X-Forwarded-Encrypted: i=1; AJvYcCUYbKUp0hfPIOJAtMt2dautMR6N0nHANTAwLA16l+WBG2I8FU4tQudNH8hVWtAvAPshF04AOMen@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz4OCfn1uUlxDbi3Ij90SEWsG8hwDyKZb9zemmT3EH5lUO78Lv6
	GrzcwngCTOVCfpsJub+HBtEJzB70+7+JTXADMwN/HG1sfJiO/jszkJ3X627KzfPrckk=
X-Gm-Gg: ASbGncujnJ021oj652+BjUvvoQTUKgOpqfqU6lMq11HyQwcm5mXhG24unk0Y9iQVsMe
	Cza698I+jtuNUHNEfYf0+JFwEazSoE/MVhvmRlUm49hWNq+5CKCRs8u3uMLR8m6PoSnKc0XLsbv
	yFYyryNE1tV2N9RCOd9c01YPjRFhZLatQzB+BhN9gTyRUACaqR3LtHtIVG5qcBN5REWOBy4ogu3
	J9/4Mw+3njpPTE9iLv4Mc0boyC2wjaxGp+jv9fhLQCpkXwPT60KXQGAf/cwZjaT13uqEbgKePIC
	Ar8rQjtmFnLO5hU91ikA5qhN74h7JXVzyb/GI7bQ4AgLfO8W6olCiTnqH6rucZoNYH/nOoPnCac
	1i5PX4YQxRtN+VVE7
X-Google-Smtp-Source: AGHT+IHrm/KS79OXFQQyUdYgpv9ct8uKCH42YY9D1PMc3JQMWc8Qv+gtovIzWI7WyTBDRqslegCi9g==
X-Received: by 2002:a05:6402:3490:b0:602:4405:776f with SMTP id 4fb4d7f45d1cf-608b4a399ebmr1805081a12.31.1749809752781;
        Fri, 13 Jun 2025 03:15:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 12/14] iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
Date: Fri, 13 Jun 2025 13:15:34 +0300
Message-ID: <20250613101537.279131-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19066

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 645fb7c22fd8d27c223b0e4abff442632bd9a75a upstream.

Add ADC support for the Renesas RZ/G3S SoC. The key features of this IP
include:
- 9 channels, with one dedicated to reading the temperature reported by the
  Thermal Sensor Unit (TSU)
- A different default ADCMP value, which is written to the ADM3 register.
- Different default sampling rates
- ADM3.ADSMP field is 8 bits wide
- ADINT.INTEN field is 11 bits wide

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-14-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index a28aa00680d1..c19e3d29dbb8 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -536,7 +536,16 @@ static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
 	.adivc = true
 };
 
+static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
+	.num_channels = 9,
+	.default_adcmp = 0x1d,
+	.default_adsmp = { 0x7f, 0xff },
+	.adsmp_mask = GENMASK(7, 0),
+	.adint_inten_mask = GENMASK(11, 0),
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
+	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
 	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ /* sentinel */ }
 };
-- 
2.43.0


