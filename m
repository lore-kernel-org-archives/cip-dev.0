Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B34C71156
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:15:20 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.7072.1749809712819314774
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=VOMCbNoz;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso3828864a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809711; x=1750414511; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7nPBS8fNNhb1PjrWF9QI4LyvesI8B39+brTEUMvOqo=;
        b=VOMCbNozI3TnylVbVYuSUqmZ0h2+/XuqUCUNLsUYgUyIr687Q+OnX3O83uZIWIBqLA
         AEU8xKQpvSpS6a0/S1tkD7QG1d/RmoYjgGpNfAOi88wKVKgG2QcK//jfOjcnEqsdD73I
         eFUZ0RzyvBotSo+dJ+fnLY5q3GZX8bkFyO3zoPPh15mrVIrlcrlpXOP2Wd8Ji5zfKE15
         ZVLP6ydUbisZ7wxKLrtrhTZyUiEQUl4H4vOFSTyPEEdjx2bX1e42wc0woxJPfDu72e+x
         lSrKhnNwgrF2le3lyfEITA1w2miuFHD+GO1Mdvj/B7zjIPchtFwLq/NUFBxY6aiH2l5h
         7Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809711; x=1750414511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7nPBS8fNNhb1PjrWF9QI4LyvesI8B39+brTEUMvOqo=;
        b=eafvn4X5JdDTJh6SbwUzG+T94oYgFZTIbkU0t2a8aKbSQ+T8tZn7c3wucnq7sHZCPU
         j0FjizuK91FYm//4FzvOr6hVqQVkGuygIPvKRWCIFNDoCS9QImVlNwW/r6e1KExUw2pb
         2+M2OikaXqJoZK90izkb16roiCiZs44iLKZkv8+Ra6LPWsKd6JyuggiyKAKV6EQEYeOQ
         otrbLVHl7QasEjI7O3hq8VazF0twBQZ5X4Wq0mIdPp2UGP3q0gF2CDVhvk8pQxX6tShX
         kzNe71QhhyrQkBU9qTCa5lb3Gdhoa4gcLANEJVy1R09oouCaPFgmEp05mF5rO1F/ncBZ
         Xg5A==
X-Forwarded-Encrypted: i=1; AJvYcCXF9+jFuBvUqHmTTAATqFvkK2b885drZLftnCU30ma0mXxim1u3Gtr0+silSbp4mDsh/IXS3WF6@lists.cip-project.org
X-Gm-Message-State: AOJu0YzRjrtvg45CfkUKJBv2PJtkE+8gdfA33ouNXosLWHnkirOHoeIV
	QnK+2BIQg6M8HE393Yb5vfzqjzDCpGvRh8VQsSPmWnAmnCzeDyfyFOa0kuBhavGY40U=
X-Gm-Gg: ASbGncu5YCggHsQSKpngKxv1DU25SDSAl5BHhPVFWr1t6jFQxhNh6gvALJdl9eyB3b1
	q5A+6g+k+Fyixu0OgPROBWKvqLwlaLZduz5FsTstPn8PziML8h9o2eJ8WgzXdT/jdEO7IvyJzRJ
	BFcLHoz/Q9UmuhxVUZmhgIYOxMOKeB67OZkzXdVq9yKCMMryAGhyzZTY70rOD0kHmvFu1hL2CtF
	Kc/EB0kHy0hSUtz8bpa6/0YetIM2F/PHvFV5rYXfDqrLauISCYYcLqDLBR04i5kG8Hza+f1UkkE
	LfhzWl/WdG9mHItHDITr6DbOtP1ff8qwqabxxFV0a4jGK8MJJ/SJZJppp+jEW8kyiLLsCQ8okmM
	OUsAcwN4JSON8sL8H
X-Google-Smtp-Source: AGHT+IEi0P15Uzeg5duD+RBCpi/V0Oo4KfTezbEqdb+mquxdH+hw4IvePfUAiV3EUcEYw5jtjIy7mg==
X-Received: by 2002:a17:907:7f29:b0:ad2:39f2:3aa8 with SMTP id a640c23a62f3a-adec5cb7110mr250594966b.38.1749809711123;
        Fri, 13 Jun 2025 03:15:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8159377sm105101466b.9.2025.06.13.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 07/12] iio: adc: rzg2l_adc: Add support for channel 8
Date: Fri, 13 Jun 2025 13:14:56 +0300
Message-ID: <20250613101501.262091-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101501.262091-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19048

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 6dd8a7712538a38ddc742adc0fc5c3361560235f upstream.

The ADC on the Renesas RZ/G3S SoC includes an additional channel (channel
8) dedicated to reading temperature values from the Thermal Sensor Unit
(TSU). There is a direct in-SoC connection between the ADC and TSU IPs.

To read the temperature reported by the TSU, a different sampling rate
(compared to channels 0-7) must be configured in the ADM3 register.

The rzg2l_adc driver has been updated to support reading the TSU
temperature.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-11-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[claudiu.beznea:
 - drop reference to rzg2l_adc_read_label() as it is not
   available in v5.10-cip
 - fixed conflict in rzg2l_adc_read_raw() by checking also IIO_TEMP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 60 ++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index a0417102f286..1af5f4c0a2d2 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -50,12 +50,13 @@
 #define RZG2L_ADCR(n)			(0x30 + ((n) * 0x4))
 #define RZG2L_ADCR_AD_MASK		GENMASK(11, 0)
 
-#define RZG2L_ADC_MAX_CHANNELS		8
+#define RZG2L_ADC_MAX_CHANNELS		9
 #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
 
 /**
  * struct rzg2l_adc_hw_params - ADC hardware specific parameters
- * @default_adsmp: default ADC sampling period (see ADM3 register)
+ * @default_adsmp: default ADC sampling period (see ADM3 register); index 0 is
+ * used for voltage channels, index 1 is used for temperature channel
  * @adsmp_mask: ADC sampling period mask (see ADM3 register)
  * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
  * @default_adcmp: default ADC cmp (see ADM3 register)
@@ -63,7 +64,7 @@
  * @adivc: specifies if ADVIC register is available
  */
 struct rzg2l_adc_hw_params {
-	u16 default_adsmp;
+	u16 default_adsmp[2];
 	u16 adsmp_mask;
 	u16 adint_inten_mask;
 	u8 default_adcmp;
@@ -87,15 +88,26 @@ struct rzg2l_adc {
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
 };
 
-static const char * const rzg2l_adc_channel_name[] = {
-	"adc0",
-	"adc1",
-	"adc2",
-	"adc3",
-	"adc4",
-	"adc5",
-	"adc6",
-	"adc7",
+/**
+ * struct rzg2l_adc_channel - ADC channel descriptor
+ * @name: ADC channel name
+ * @type: ADC channel type
+ */
+struct rzg2l_adc_channel {
+	const char * const name;
+	enum iio_chan_type type;
+};
+
+static const struct rzg2l_adc_channel rzg2l_adc_channels[] = {
+	{ "adc0", IIO_VOLTAGE },
+	{ "adc1", IIO_VOLTAGE },
+	{ "adc2", IIO_VOLTAGE },
+	{ "adc3", IIO_VOLTAGE },
+	{ "adc4", IIO_VOLTAGE },
+	{ "adc5", IIO_VOLTAGE },
+	{ "adc6", IIO_VOLTAGE },
+	{ "adc7", IIO_VOLTAGE },
+	{ "adc8", IIO_TEMP },
 };
 
 static unsigned int rzg2l_adc_readl(struct rzg2l_adc *adc, u32 reg)
@@ -161,9 +173,18 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
 	rzg2l_adc_writel(adc, RZG2L_ADM(1), reg);
 }
 
+static u8 rzg2l_adc_ch_to_adsmp_index(u8 ch)
+{
+	if (rzg2l_adc_channels[ch].type == IIO_VOLTAGE)
+		return 0;
+
+	return 1;
+}
+
 static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 {
 	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
+	u8 index = rzg2l_adc_ch_to_adsmp_index(ch);
 	u32 reg;
 
 	if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
@@ -177,6 +198,11 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 	reg |= BIT(ch);
 	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
 
+	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
+	reg &= ~hw_params->adsmp_mask;
+	reg |= hw_params->default_adsmp[index];
+	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
+
 	/*
 	 * Setup ADINT
 	 * INTS[31] - Select pulse signal
@@ -233,7 +259,7 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (chan->type != IIO_VOLTAGE)
+		if (chan->type != IIO_VOLTAGE && chan->type != IIO_TEMP)
 			return -EINVAL;
 
 		mutex_lock(&adc->lock);
@@ -328,11 +354,11 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 			return -EINVAL;
 		}
 
-		chan_array[i].type = IIO_VOLTAGE;
+		chan_array[i].type = rzg2l_adc_channels[channel].type;
 		chan_array[i].indexed = 1;
 		chan_array[i].channel = channel;
 		chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
-		chan_array[i].datasheet_name = rzg2l_adc_channel_name[channel];
+		chan_array[i].datasheet_name = rzg2l_adc_channels[channel].name;
 		i++;
 	}
 
@@ -382,7 +408,7 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg &= ~RZG2L_ADM3_ADCMP_MASK;
 	reg &= ~hw_params->adsmp_mask;
 	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
-	       hw_params->default_adsmp;
+	       hw_params->default_adsmp[0];
 
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
@@ -493,7 +519,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
 	.num_channels = 8,
 	.default_adcmp = 0xe,
-	.default_adsmp = 0x578,
+	.default_adsmp = { 0x578 },
 	.adsmp_mask = GENMASK(15, 0),
 	.adint_inten_mask = GENMASK(7, 0),
 	.adivc = true
-- 
2.43.0


