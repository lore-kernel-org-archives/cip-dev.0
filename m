Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A6CC71155
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:00 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.7078.1749809751193766047
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nwDfiUoF;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso3829825a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809749; x=1750414549; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82y2aHcyLfJjtSJf6tBJs447RKAZRVmA3O9P3SUDkEk=;
        b=nwDfiUoFJxhYAfdgrLb1Z77eKoeqNoMmtCjHrfUzuEMvgh+ZGZjXvjm3DuDmv4TEIA
         bPg67h0HoFbcd3ytaXXAnCye+pmS069ZSgw7mDP/jNTk9KatBL8w8aBjgbzR2DRAkJ59
         9JzR3oVx/108oNiFhCCCP1W4bMXZH3wM0aOyLhmDSK188tpIVmNqfLM2ehscL32juqnG
         7GiRag0VFwhbpTMSM1RdFN4rcTFONE85fPFLHiWTSDDAseEYUFZXtIzkvTB9FPd6aZyb
         WBIhYp9cCfDYKy/MIcnYdStnOAYK7vi7Iqp/9FdyBOp+9zmHnVeqtbC8SYoY8MbyzbIP
         qNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809749; x=1750414549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82y2aHcyLfJjtSJf6tBJs447RKAZRVmA3O9P3SUDkEk=;
        b=wPDMvpmcjR/PNcfxhijs5K9hlRlie3EIXhYDCYek+czTyg/f0nd/MXvwFouFWg/I0P
         EGryU/erlzCgUW5O4Tw9Ai+AFAUwOB5ZgvjQhNiWGStOaXWwBEdeiGY8qF1LOy+QyYeW
         LgcI2lBzW1yBpEZbOsBKhvVCIx6XIceOExco932qq/eNsug9RK6AOGJBv6Lsnjt+qcnc
         oGEoGZXxnnPjp/Z2ydZeZV4mFzwghQLeko+VWWWaa2W0/obXF342FL5NN/tunieziUKu
         5tPgrFF3qRI/EGdUYsBFN3WLgWurkNLYA1epgXwUzdKhUXU9LxUJYSEFJP0UMy0x1MUX
         MNAA==
X-Forwarded-Encrypted: i=1; AJvYcCV22bCDq3yFxlaJzzijPgehFA8u2JOV6bKKXcAUceypFKyOxzeTGZFHVkHNN7sQDF7HzFKzqvMF@lists.cip-project.org
X-Gm-Message-State: AOJu0YzrDYhiLJh65pZPOoWtL1Q0OIsNB9U2pg2GFDVMUGskZr6JXjLK
	xbIts7OpKkoonz/jDJrBRPKMYu1XxEffgZsHWPMtaqKg+qCPBklBYfzHURJ/AObNmRU=
X-Gm-Gg: ASbGncsx7zWHmxx07fuueKDQxEwkJM6AZTUmva+DXIWG0hH4sWexPtq1saKa0K3sEE3
	N+QpP2TF5zMyNOIEgiEWr5Nv9kSlY70VGudQ6dNKzuuCjes4tPnRXZIc05sHuRMp8PozZaINWI4
	nEDKNbNqkwut6RmV/f1cRZrGCKhYp0wbsD054qXVL2pY6h1IHCPCsjyDVL2tV0hRh6ROaGUH9La
	eXqpI5O6zDkaoSeZjG2sIHlVD44FTdh9yeZfw4b6s+ZDA5vAGKZfunbi9nUT7yoLKEAk6AdUdoY
	J84Pd4b0JIaM340qE9JJg8TVgEPJw2tzFZgsi8cAYcfbTwXdmuIocyQ4KLWGIKrF5/2svX2kT00
	uToVCEy3fYMkctXVb
X-Google-Smtp-Source: AGHT+IFjHqz65YnuS89yIJdbggA5dOraA1EqsmRjx6bzNCJ4uTUShELne0DaS17rFijQKnj3UYupJQ==
X-Received: by 2002:a05:6402:35d4:b0:608:64ef:3807 with SMTP id 4fb4d7f45d1cf-608b478a5fcmr1901375a12.0.1749809749559;
        Fri, 13 Jun 2025 03:15:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 09/14] iio: adc: rzg2l_adc: Add support for channel 8
Date: Fri, 13 Jun 2025 13:15:31 +0300
Message-ID: <20250613101537.279131-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19063

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
index d723e957244f..2364405c6b83 100644
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
@@ -338,11 +364,11 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
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
 
@@ -392,7 +418,7 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg &= ~RZG2L_ADM3_ADCMP_MASK;
 	reg &= ~hw_params->adsmp_mask;
 	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
-	       hw_params->default_adsmp;
+	       hw_params->default_adsmp[0];
 
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
@@ -503,7 +529,7 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
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


