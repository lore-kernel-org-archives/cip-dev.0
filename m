Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D4CC61DB2
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 10:16:00 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.7103.1749809750020823631
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Jun 2025 03:15:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=LuHX/gse;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607873cc6c4so3951932a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 03:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749809748; x=1750414548; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feNTm7Raw1ktYAs6/6pFHShfJO6V03WDLUYgMkq9jOo=;
        b=LuHX/gse9uk84Q8lmPMPn7uQ/sOjCr24dulQtZ4mjfbti8I0LWjovxIwCmdb6yBqDK
         JsafqWkZFlklcC3ZtbxF+x8MiZkzOsV63JHW4T/bGmXqHM+DmsTWiP7esdb8exHUcCWT
         2oDKu1ElW4SZSQTCBJQNt2BbDu36NDp1LiXRa5gaZkPx0AAXKy19ZjMavdsNQwOi+BkQ
         6Kx3hPh8eBlf3pj3sqiop4d59Hl+Y6N6zj8IdpoRO9s1AIzwvj5jqQHdFyTX9eABJelF
         Jn5LGr6qdTG/rXJf0Aqb2xsrmqV7R0vYh6LotXwYUoYcBL8HIQ4XqA9X1sLcQWcuXss6
         9aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749809748; x=1750414548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=feNTm7Raw1ktYAs6/6pFHShfJO6V03WDLUYgMkq9jOo=;
        b=s+/b5O+bM3xKtnXZfpD3d8kq3OnjGCKVGcJpZieD5zNC6gqKH5S5r3s0PR5UYY2GgM
         57qesgQl7EEI8KxnGpdhynQicO2RmEvlQgHgSWxK4+xI/5cIP/EWjH7uoVFhhdNP2NRD
         qlrIQjmk5HYkPcWmn4yBIBFz2HH5oof6DUzQz8gX6BH2L+la0zzxNmvxPQSjLq8njvfo
         X3RcIDjIeaQSDL78+KMlrueYvfT6K567imIzJTrQP6zuOr1nCQMNgxKEQeCCI2N9ekLh
         89Qv9y259jNKV19WYSJ10Tk+Qz+p/W3+XJFRlUoFEbZcNEokHDh1km/V/Gz4SqFVPMlN
         cVEA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Hxw6VO5WyapmRZ7k/sjJ8fCYooXdvpFJG4YQzcWMxjzTXQ5ikIQraSuDdcvrCdwz4IMcyy2k@lists.cip-project.org
X-Gm-Message-State: AOJu0YyiMMq4b7MQZ/uVHJ5Odq/y27VOuLrO+c1YKM1hD1Uf/qfmDFp8
	21jl0IR1dxbT7LI5Lifva+6lKGLVRaTJIrxfXSkfLD1NFnSp0NuULIzbQzSaWZssB0fkfJRn1lZ
	Dppv3
X-Gm-Gg: ASbGncvlum9snmjmDjpOcO18ZinGYtT8Z1OHMwbDYhynOgRXMXcW4KqUv3YQwgN8N3/
	RpgTOE7LOMXgQM2fmue//RrQaCO76724lb6gIfsyCQbL9EC7C9BSYhw4GOKiqMFMowrejUgFHZZ
	ZOWcLW38krsqTEcXTTyR8TVulrOgZCrj5+grCNRdcRqvwuOxK/DQX5LT9Sm55gvz7I7kNxnGO7n
	gWqlVmQQ2G8Zktct0PuxoF7Yq+17q99ghBApaUCrpImw6ibBzofPY5jYrRAlPnGZGeprRaqbsES
	BeiaDhnIHHx1ukvn+5egLc25UYfxSHGSXAv3mHwqJYDVTLKQQ7Z4CP8bVah+nqdAdNH8EAVXu/E
	QO11pEWP45xAE7xRA
X-Google-Smtp-Source: AGHT+IGUaXyee8+LBPLkl9PNgZN+ybjEDZs94E8EO/xoy+UAGnoMfEYGX97gbAuLFwB3rHil65UhGQ==
X-Received: by 2002:a17:907:3da8:b0:ad5:9ff3:c6ce with SMTP id a640c23a62f3a-adf4c6f7ec1mr13319066b.4.1749809748225;
        Fri, 13 Jun 2025 03:15:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b48d77a8sm1015320a12.20.2025.06.13.03.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:15:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 08/14] iio: adc: rzg2l_adc: Prepare for the addition of RZ/G3S support
Date: Fri, 13 Jun 2025 13:15:30 +0300
Message-ID: <20250613101537.279131-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Jun 2025 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19062

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a259a8465d3e9c744f990bda3582b5217562827f upstream.

The ADC IP available on the RZ/G3S differs slightly from the one found on
the RZ/G2L. The identified differences are as follows:
- different number of channels (one being used for temperature conversion);
  consequently, various registers differ
- different default sampling periods
- the RZ/G3S variant lacks the ADVIC register.

To accommodate these differences, the rzg2l_adc driver has been updated by
introducing the struct rzg2l_adc_hw_params, which encapsulates the
hardware-specific differences between the IP variants. A pointer to an
object of type struct rzg2l_adc_hw_params is embedded in
struct rzg2l_adc_data.

Additionally, the completion member of struct rzg2l_adc_data was relocated
to avoid potential padding, if any.

The code has been adjusted to utilize hardware-specific parameters stored
in the new structure instead of relying on plain macros.

The check of chan->channel in rzg2l_adc_read_raw() function, against the
driver specific mask was removed as the subsystem should have already
been done this before reaching the rzg2l_adc_read_raw() function. Along
with it the local variable ch was dropped as chan->channel could be used
instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20241206111337.726244-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[claudiu.beznea: fixed conflict in rzg2l_adc_parse_properties() by
 keeping also the call to fwnode_handle_put()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 87 +++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 47e50cb3f270..d723e957244f 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -33,20 +33,15 @@
 #define RZG2L_ADM1_MS			BIT(2)
 #define RZG2L_ADM1_BS			BIT(4)
 #define RZG2L_ADM1_EGA_MASK		GENMASK(13, 12)
-#define RZG2L_ADM2_CHSEL_MASK		GENMASK(7, 0)
 #define RZG2L_ADM3_ADIL_MASK		GENMASK(31, 24)
 #define RZG2L_ADM3_ADCMP_MASK		GENMASK(23, 16)
-#define RZG2L_ADM3_ADCMP_E		FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, 0xe)
-#define RZG2L_ADM3_ADSMP_MASK		GENMASK(15, 0)
 
 #define RZG2L_ADINT			0x20
-#define RZG2L_ADINT_INTEN_MASK		GENMASK(7, 0)
 #define RZG2L_ADINT_CSEEN		BIT(16)
 #define RZG2L_ADINT_INTS		BIT(31)
 
 #define RZG2L_ADSTS			0x24
 #define RZG2L_ADSTS_CSEST		BIT(16)
-#define RZG2L_ADSTS_INTST_MASK		GENMASK(7, 0)
 
 #define RZG2L_ADIVC			0x28
 #define RZG2L_ADIVC_DIVADC_MASK		GENMASK(8, 0)
@@ -57,12 +52,27 @@
 #define RZG2L_ADCR(n)			(0x30 + ((n) * 0x4))
 #define RZG2L_ADCR_AD_MASK		GENMASK(11, 0)
 
-#define RZG2L_ADSMP_DEFAULT_SAMPLING	0x578
-
 #define RZG2L_ADC_MAX_CHANNELS		8
-#define RZG2L_ADC_CHN_MASK		0x7
 #define RZG2L_ADC_TIMEOUT		usecs_to_jiffies(1 * 4)
 
+/**
+ * struct rzg2l_adc_hw_params - ADC hardware specific parameters
+ * @default_adsmp: default ADC sampling period (see ADM3 register)
+ * @adsmp_mask: ADC sampling period mask (see ADM3 register)
+ * @adint_inten_mask: conversion end interrupt mask (see ADINT register)
+ * @default_adcmp: default ADC cmp (see ADM3 register)
+ * @num_channels: number of supported channels
+ * @adivc: specifies if ADVIC register is available
+ */
+struct rzg2l_adc_hw_params {
+	u16 default_adsmp;
+	u16 adsmp_mask;
+	u16 adint_inten_mask;
+	u8 default_adcmp;
+	u8 num_channels;
+	bool adivc;
+};
+
 struct rzg2l_adc_data {
 	const struct iio_chan_spec *channels;
 	u8 num_channels;
@@ -72,8 +82,9 @@ struct rzg2l_adc {
 	void __iomem *base;
 	struct reset_control *presetn;
 	struct reset_control *adrstn;
-	struct completion completion;
 	const struct rzg2l_adc_data *data;
+	const struct rzg2l_adc_hw_params *hw_params;
+	struct completion completion;
 	struct mutex lock;
 	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
 };
@@ -154,6 +165,7 @@ static void rzg2l_set_trigger(struct rzg2l_adc *adc)
 
 static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 {
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	u32 reg;
 
 	if (rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_ADBSY)
@@ -163,7 +175,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 
 	/* Select analog input channel subjected to conversion. */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(2));
-	reg &= ~RZG2L_ADM2_CHSEL_MASK;
+	reg &= ~GENMASK(hw_params->num_channels - 1, 0);
 	reg |= BIT(ch);
 	rzg2l_adc_writel(adc, RZG2L_ADM(2), reg);
 
@@ -175,7 +187,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 	 */
 	reg = rzg2l_adc_readl(adc, RZG2L_ADINT);
 	reg &= ~RZG2L_ADINT_INTS;
-	reg &= ~RZG2L_ADINT_INTEN_MASK;
+	reg &= ~hw_params->adint_inten_mask;
 	reg |= (RZG2L_ADINT_CSEEN | BIT(ch));
 	rzg2l_adc_writel(adc, RZG2L_ADINT, reg);
 
@@ -184,6 +196,7 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_adc *adc, u8 ch)
 
 static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc, u8 ch)
 {
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	struct device *dev = indio_dev->dev.parent;
 	int ret;
 
@@ -201,7 +214,7 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
 
 	if (!wait_for_completion_timeout(&adc->completion, RZG2L_ADC_TIMEOUT)) {
 		rzg2l_adc_writel(adc, RZG2L_ADINT,
-				 rzg2l_adc_readl(adc, RZG2L_ADINT) & ~RZG2L_ADINT_INTEN_MASK);
+				 rzg2l_adc_readl(adc, RZG2L_ADINT) & ~hw_params->adint_inten_mask);
 		ret = -ETIMEDOUT;
 	}
 
@@ -219,7 +232,6 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 {
 	struct rzg2l_adc *adc = iio_priv(indio_dev);
 	int ret;
-	u8 ch;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW: {
@@ -228,12 +240,11 @@ static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
 
 		guard(mutex)(&adc->lock);
 
-		ch = chan->channel & RZG2L_ADC_CHN_MASK;
-		ret = rzg2l_adc_conversion(indio_dev, adc, ch);
+		ret = rzg2l_adc_conversion(indio_dev, adc, chan->channel);
 		if (ret)
 			return ret;
 
-		*val = adc->last_val[ch];
+		*val = adc->last_val[chan->channel];
 
 		return IIO_VAL_INT;
 	}
@@ -258,6 +269,7 @@ static const struct iio_info rzg2l_adc_iio_info = {
 static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 {
 	struct rzg2l_adc *adc = dev_id;
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	unsigned long intst;
 	u32 reg;
 	int ch;
@@ -270,11 +282,11 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	intst = reg & RZG2L_ADSTS_INTST_MASK;
+	intst = reg & GENMASK(hw_params->num_channels - 1, 0);
 	if (!intst)
 		return IRQ_NONE;
 
-	for_each_set_bit(ch, &intst, RZG2L_ADC_MAX_CHANNELS)
+	for_each_set_bit(ch, &intst, hw_params->num_channels)
 		adc->last_val[ch] = rzg2l_adc_readl(adc, RZG2L_ADCR(ch)) & RZG2L_ADCR_AD_MASK;
 
 	/* clear the channel interrupt */
@@ -287,6 +299,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 
 static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc *adc)
 {
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	struct iio_chan_spec *chan_array;
 	struct fwnode_handle *fwnode;
 	struct rzg2l_adc_data *data;
@@ -303,7 +316,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 	if (!num_channels)
 		return dev_err_probe(&pdev->dev, -ENODEV, "no channel children\n");
 
-	if (num_channels > RZG2L_ADC_MAX_CHANNELS)
+	if (num_channels > hw_params->num_channels)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "num of channel children out of range\n");
 
@@ -320,7 +333,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 			return ret;
 		}
 
-		if (channel >= RZG2L_ADC_MAX_CHANNELS) {
+		if (channel >= hw_params->num_channels) {
 			fwnode_handle_put(fwnode);
 			return -EINVAL;
 		}
@@ -342,6 +355,7 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 
 static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 {
+	const struct rzg2l_adc_hw_params *hw_params = adc->hw_params;
 	u32 reg;
 	int ret;
 
@@ -359,11 +373,13 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	if (ret)
 		goto exit_hw_init;
 
-	/* Only division by 4 can be set */
-	reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
-	reg &= ~RZG2L_ADIVC_DIVADC_MASK;
-	reg |= RZG2L_ADIVC_DIVADC_4;
-	rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
+	if (hw_params->adivc) {
+		/* Only division by 4 can be set */
+		reg = rzg2l_adc_readl(adc, RZG2L_ADIVC);
+		reg &= ~RZG2L_ADIVC_DIVADC_MASK;
+		reg |= RZG2L_ADIVC_DIVADC_4;
+		rzg2l_adc_writel(adc, RZG2L_ADIVC, reg);
+	}
 
 	/*
 	 * Setup AMD3
@@ -374,8 +390,10 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
 	reg = rzg2l_adc_readl(adc, RZG2L_ADM(3));
 	reg &= ~RZG2L_ADM3_ADIL_MASK;
 	reg &= ~RZG2L_ADM3_ADCMP_MASK;
-	reg &= ~RZG2L_ADM3_ADSMP_MASK;
-	reg |= (RZG2L_ADM3_ADCMP_E | RZG2L_ADSMP_DEFAULT_SAMPLING);
+	reg &= ~hw_params->adsmp_mask;
+	reg |= FIELD_PREP(RZG2L_ADM3_ADCMP_MASK, hw_params->default_adcmp) |
+	       hw_params->default_adsmp;
+
 	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
 
 exit_hw_init:
@@ -403,6 +421,10 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 
 	adc = iio_priv(indio_dev);
 
+	adc->hw_params = device_get_match_data(dev);
+	if (!adc->hw_params || adc->hw_params->num_channels > RZG2L_ADC_MAX_CHANNELS)
+		return -EINVAL;
+
 	ret = rzg2l_adc_parse_properties(pdev, adc);
 	if (ret)
 		return ret;
@@ -478,8 +500,17 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(dev, indio_dev);
 }
 
+static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
+	.num_channels = 8,
+	.default_adcmp = 0xe,
+	.default_adsmp = 0x578,
+	.adsmp_mask = GENMASK(15, 0),
+	.adint_inten_mask = GENMASK(7, 0),
+	.adivc = true
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
-	{ .compatible = "renesas,rzg2l-adc",},
+	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_adc_match);
-- 
2.43.0


