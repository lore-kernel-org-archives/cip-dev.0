Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE376C71157
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:30 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.7102.1749809787095471403
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:16:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=B21nK46Z;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade4679fba7so346776366b.2
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809785; x=1750414585; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9XDej/Cmd/0GBKIiElDu1GnkTFqD5i2+NWeRRibs1Q=;
        b=B21nK46ZJPQivoeSWz2B18gj8Fn/Pl/A7Xl54NJfYV2yqq14Ks9H3wrNDNo5HiEpkH
         RqOzn2GXeIqAzUg8Lsn3Q7sM9RCvpq0kcM8Zyi1sgvmyzDjmbhkoENl9SedCqwBSZSDd
         5WFGLn6f0XfI+rxcj5tsD3Bw4JEM8al+LxDCrfiWOjvsKoDQsTOGb4Lfd72/MEfpVHKQ
         RcLWMEYAcxNK8DMauL8YOl/IE8CR7td/V1a+h5Eg0/yDQkn1yc2PpgDaVfaJ9yMMUifI
         q5iXCf91/3xgchU5QBv3kf/AHpp+gkhlURzdGVIFpBNzrS0XTJiq2I01GGFbfcQjf6dL
         7RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809785; x=1750414585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9XDej/Cmd/0GBKIiElDu1GnkTFqD5i2+NWeRRibs1Q=;
        b=FNoF0YLWPoZLJz/Hv0hmiOa/EYerJwf1wu5kYALu2cXCdknuz9ofiG/bJijsiTUau5
         Nmgtw1qClsHWfOHn25RmZ+OINIxoB3HZ6bucWSZF2TwWL8I5vSjZGD9Z0WzdqDQDxM5c
         5x5pceHao7gf4u7bO3CAgYcbp/Rf/+gTRlbD/Nt1D0C+ffDBfNEgRXGSTbWN3+rkh74S
         ux8nWASgh5RcOlTl3n6fcfVsJ7Qva82feJGjgpXRNCpL+cCI4HEt4DmHZK69FV4AlZXi
         nIpUJdeWybXYx6d9FVUFp7BK0ljduXGZnAcQ21iKVnSvnJ6dlpYi78b/2VfT7Hgl+liK
         xJOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMSN6UHc4Z2zHIyhZYV5ZS8jL9rJ11C7Du8rxEuw83GDU5p7WrR00IbK7Auyj9icW8vwdu8KNp@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz+PK027soepKFmPNf86YcREEMFMIZfZv8sqjF9fdNFZgFOB0XK
	lB/NRXnFUYa5i3NBPbYUaWOM10+EZ5P5LjrOrGAgNKci12huM5Q1P+XkCo5UZRuAn/s=
X-Gm-Gg: ASbGnctm5RxiPsuft3wlxNc2k5aGlJYeLH9JYa97t46J+9OH7cZMGVQ71MRGU9831zT
	hb7S5Ad8wDUJb11AGoARlWxHCf8ZqD6GXDeEaAB+bkNvwJo/ycZp75p4exWvrN8rg3Eym21WRzG
	P2MFzAQ80VEbB6sV1aDXkS9RxPqRPozmIvp/kfTnQxpLNIPWpY2lsoThJSYKWKtaGZuN8Shw7gX
	FNxCIBOo0CCraMNPndXQUJ8+xPIxGF1Q99AC+AhFzi7bt7NlLvj7fc5ABnEW3Ga2YqitZMBjnLv
	TzEfHIO0oSfwlcvGoQbfadCRSCf4l/nDWa87l/rxJY4jReEJUgQbfv43VULh/tZ+yPhudvAahGL
	EYRELkbzwRTM5Fxbr
X-Google-Smtp-Source: AGHT+IGJjnUqSGkPSOZHLtkdc0nwXBVERdIUMZObKQxc/nklb93J6kcYoQJDz0G+tnIOJb5129p8Yw==
X-Received: by 2002:a17:907:74a:b0:ada:6adb:cca with SMTP id a640c23a62f3a-adec5604959mr245560566b.6.1749809785359;
        Fri, 13 Jun 2025 03:16:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88ff5efsm104506666b.104.2025.06.13.03.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:16:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 09/14] iio: adc: rzg2l_adc: Add support for channel 8
Date: Fri, 13 Jun 2025 13:16:08 +0300
Message-ID: <20250613101613.296649-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101613.296649-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19078

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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 62 ++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index fb2a1253150c..0199aa724b7f 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -52,12 +52,13 @@
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
@@ -65,7 +66,7 @@
  * @adivc: specifies if ADVIC register is available
  */
 struct rzg2l_adc_hw_params {
-	u16 default_adsmp;
+	u16 default_adsmp[2];
 	u16 adsmp_mask;
 	u16 adint_inten_mask;
 	u8 default_adcmp;
@@ -89,15 +90,26 @@ struct rzg2l_adc {
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
@@ -163,9 +175,18 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
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
@@ -179,6 +200,11 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
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
@@ -235,7 +261,7 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: {
-		if (chan->type != IIO_VOLTAGE)
+		if (chan->type != IIO_VOLTAGE && chan->type != IIO_TEMP)
 			return -EINVAL;
 
 		guard(mutex)(&adc->lock);
@@ -258,7 +284,7 @@ static int rzg2l_adc_read_label(struct iio_dev *iio_dev,
 				const struct iio_chan_spec *chan,
 				char *label)
 {
-	return sysfs_emit(label, "%s\n", rzg2l_adc_channel_name[chan->channel]);
+	return sysfs_emit(label, "%s\n", rzg2l_adc_channels[chan->channel].name);
 }
 
 static const struct iio_info rzg2l_adc_iio_info = {
@@ -333,11 +359,11 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		if (channel >= hw_params->num_channels)
 			return -EINVAL;
 
-		chan_array[i].type = IIO_VOLTAGE;
+		chan_array[i].type = rzg2l_adc_channels[channel].type;
 		chan_array[i].indexed = 1;
 		chan_array[i].channel = channel;
 		chan_array[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
-		chan_array[i].datasheet_name = rzg2l_adc_channel_name[channel];
+		chan_array[i].datasheet_name = rzg2l_adc_channels[channel].name;
 		i++;
 	}
 
@@ -387,7 +413,7 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg &= ~RZG2L_ADM3_ADCMP_MASK;
 	reg &= ~hw_params->adsmp_mask;
 	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
-	       hw_params->default_adsmp;
+	       hw_params->default_adsmp[0];
 
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
@@ -498,7 +524,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
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


