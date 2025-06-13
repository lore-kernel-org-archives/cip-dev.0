Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A70C71135
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:20 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web10.7055.1749809716211115757
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LRHTUksP;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-addcea380eeso337111066b.0
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809714; x=1750414514; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JK2xnysfLue2xlGNy5JbRqiz8u6pO47WN3KmTWlxUKY=;
        b=LRHTUksPOUmwc6X9ZRIVsbHG9MyDtVRXz7wYAdIx1nmDCtcEAf2+zv+CBYhCFco6xH
         GCKZ3bvgcbDsFJ2H6F42cTjmEcAHH3hr0iHVSHzTYBXVmxlR2FtyAruEbuYkTxBekUAa
         g9nq+ikyVKCrHS4+v1xjqfRChlNZZsXVup83YfPDt224zGEYQ+kn4pcIMtq+i9CMV953
         9lA0pg4jxR19xj4IQd5hQfkIrE8gdYq2t0vXhThlgw5GIhhU1btX9jae5XgIsOPk6O93
         7/BYHST0kWUyDb8VUBxOXlaarwmG0GPWLyR9e9jM9lNAYUT9hkYfEUIyxgJJBhd/ANDV
         +23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809714; x=1750414514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JK2xnysfLue2xlGNy5JbRqiz8u6pO47WN3KmTWlxUKY=;
        b=FZWnqRgKDrSw5EY9PhY4ZeQr/GZHtp+zrsNo/NHiT05w8EUQkI8GsQR0Ho1tOzXWIf
         wqL/IFQvTPd5r6rbTKwtzSKPL78tKYm12wWpq3+tKOw4sEDNdi46cdHVbnkXVuURpxgT
         yTb7CaNkeE/TSOhmVfU6TGkLWWiC9QJjIyVsaXAYmve8aeDuV6sDaxJDZYMYRnD3aNsw
         yc136mct+YSoOhRLMJV2VfGXFbq71iQrPUSJTMqkIrUTaF0bBqbtrNFdOzP1t3ElrhbV
         kVS4Lpl7cj8o+GkoaNmkfMLgc7K2g5rRAmH+lQN0X59DK8P220nYMLkNYb4pW9mxQG1T
         32hA==
X-Forwarded-Encrypted: i=1; AJvYcCW8nc4FGZJY4veZLtOuoMtLJD/S22fSA4HyiAAmAi75n2YmltIjrYGud8Btvh7M5XyM+pA8CNPN@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx9sMrbu+tvEdAmr5Yk1Za3+YolJAST7RrOXzMeW3dDHVQwfQ5G
	tv+oiV8ROYisssufjb3rNQ4z6nhrv3i90zEahieIfkkZ985c0GDvJQHaPFWWTBqMphVaDkwpkG0
	bkP7w
X-Gm-Gg: ASbGncs40pEnLad6BlWFgLxlfh/2Bvd7PV27neh8KXr84Sw6tcwEVqVg2ITeFy4JyRJ
	jtazQuZvG0Q//s4BooZSnZiH54uQDuWDd+fab10bnvtvnH+IDhcBu2cgGre7NVI+pHd/bHyJXMM
	GBbcXn0XuO5WPAMubUfA9mNTRHqVojt2ICq8DXxkrVtKOcqJIdSmni3zPhGYnSUmm2xViQpy+2A
	BTro6i4ZIEmfp2XBPNN+zQkDlMFH2f9g5LEF7U3J0akW1x8+86k8vEyjf1Mp7RNrI+r2Yi3xVlr
	wJK00z23vSGdO4SfZMo3T52HDBrYC5sRJ5VFXDQdA+KqGm1Cqk1Z7yHbqDXOd59He4XEI/EJSug
	FV15WYioS9R/APb7D
X-Google-Smtp-Source: AGHT+IG4dobnS1G2CF88SsiTZC5nX4YWHITOtNm5MbmifMpX4RKrccmTeMaLSYrf92Vf2dy4A+9FGg==
X-Received: by 2002:a17:907:d70d:b0:ad8:99cc:774c with SMTP id a640c23a62f3a-adf41dc74demr29827466b.58.1749809714543;
        Fri, 13 Jun 2025 03:15:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 10/12] iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
Date: Fri, 13 Jun 2025 13:14:59 +0300
Message-ID: <20250613101501.262091-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19051

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
index 2e94d163ddd4..d48aec92add9 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -526,7 +526,16 @@ static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
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


