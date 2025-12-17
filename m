Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC27DD65544
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:25 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11314.1765967539035941829
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=pf3fqB8b;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735e278fa1so1020809166b.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967537; x=1766572337; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cnYXzKLLnu36yJxymxnm80OKtYfmEJsyyt61ROQ1V8=;
        b=pf3fqB8bMVSOvy3qrIW8fOaX/6m6HyRGIo9dmIizd3ewcaK3bDM6C2KDCRPXZvKBYh
         816hIRxfk7i+2u1n4pzItFEGIWRiCkSI2oJZGKPEiZ4iWyipq1fb5jFhoomQS5ml+Glb
         7K1liHPKNBIBlNnDYiWImEaXsBnTmpBpY8MprgWBVZNsQ3bqyRua6FzxzBH0RG4wXclg
         86aFc0+6cTZyst6o5dyYWpnJDK5bdBxWlUyCocYzPXQLBQa/4QL/SAg1zPqoNoGFu47b
         ZuzjCZv6ZoKDyJMkgByf8vuVVetPhl5k5ouzZtH68WgwRh3KaXeCFhaEOLMBskBzUQaX
         HENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967537; x=1766572337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3cnYXzKLLnu36yJxymxnm80OKtYfmEJsyyt61ROQ1V8=;
        b=qxyBbGmx6umB+hSGOfEn0IjfSFRbHyYMyeWLslHafiC4BkTx2WyddXdY1cq1iMPXna
         cwwU97s1RmFUYvAAxANxHYGCuGJmq7CXyTWg61vSWTEJX3QUxtciuu0SKrGdDBokUTjz
         T3H+2PqEJsjKhNEZ4Rxj2oXwmp13o206uF1dBKciQ1zjIevdxvZmXbm/zuxrPhnx2dQJ
         k17SZSAERxvnU2G2z5cx9CtOYbqvFjuUnQoN6e8+Cny8Ix/AOU/NjxgVgMQqkisX5Fpz
         t5J55RwhBFMigvv87LlaS2aMVbM6mvbtto5CTbLshB2f+4eP7Sxx5Lnc7uh3h44h82W0
         eGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZC2EUpy1J/+NP5wAeFvEY9UAE22HnN8GiqJz4mIVutfd11wpP9XRayXB06hzOv0CXZ5skKxJ+@lists.cip-project.org
X-Gm-Message-State: AOJu0YzqbbwSRvNKNz6Qf0s0hF5R2Rfjhyua4l5DuKWLLeNdZh6Z8J1y
	fn+/0VDD0zSrkP4eiPg813T4GWR6CemY9YPypLwnXwORXpWYozQrIdUyWI+WSV3ElaI=
X-Gm-Gg: AY/fxX77DycyGCE7P3qRpkOIqqVuivgg9EC1NnFae+HtFtIF1AKtJDZ5gxuCR5DGagp
	qTfM9LgcrJu6plfa3ZfwHvGQwHLh+zKtOUggJ1Cpto8w4HLBQlldhHh9kP1G4UHrjqfQixK0mOm
	KZ6kgg7f/JY0X84njktn15TIdl2qkk8wcBbOAJh2OkvPjojs/kiZo/N1DcWK1Efq4jjGrd1hIFR
	lMvAlWkee5z4Ly9WifJhtCxuO057Sq/HX42fP9U9RE5udVf2mpTcejKaS/Pp4n7hVacwWPr0ogA
	ff9QtdglaFvM6UAotSc0/fCZap2MIhJiyvE1iLhtn1DaV3SFBs7pc5IhtJ7ysrGisom4KuByrrB
	hmdj4j7XxoqPeVCOvfuZxEczbun+u5fjM3zRcTiiY3DT+s0YV0tlelw4JnN/ck6NkbpMNaAXpIi
	T+yZzZ/cHhdinq9tAIDpvQbv4RkS0G6Xx9OoXaSajx
X-Google-Smtp-Source: AGHT+IFoDOWUs50lXU09XAR8m3a5B+AdiUfoVEDUf2EFeLSHqlxK9M7pHPwTN3o65TN3HhEpVVI7Jw==
X-Received: by 2002:a17:906:c115:b0:b77:1166:7d63 with SMTP id a640c23a62f3a-b7d238c34f1mr1884385066b.40.1765967537290;
        Wed, 17 Dec 2025 02:32:17 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb76sm1930249166b.12.2025.12.17.02.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:16 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 4/7] thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas RZ/G3S SoC
Date: Wed, 17 Dec 2025 12:32:07 +0200
Message-ID: <20251217103210.4183025-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21109

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit dc095b37b09e1abbdb6daf5e69dbd0cd5265087e upstream.

The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
the junction temperature. The temperature is reported through a dedicated
ADC channel. Add a driver for the Renesas RZ/G3S TSU.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20250810122125.792966-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[claudiu.beznea:
 - fixed conflict in MAINTAINERS files as "RENESAS X9250 DIGITAL
   POTENTIOMETERS DRIVER" is not found in v6.1 CIP
 - deleted drivers/thermal/renesas/{Kconfig, Makefile} as the renesas
   directory is not available in v6.1 CIP and updated instead the
   drivers/thermal/{Kconfig, Makfile}
 - moved drivers/thermal/renesas/rzg3s_thermal.c to
   drivers/thermal/rzg3s_thermal.c as the renesas directory is not
   available in v6.1 CIP
 - included "thermal_hwmon.h" instead of "../thermal_hwmon.h"
 - replaced thermal_zone_device_priv(rz) with tz->devdata as
   thermal_zone_device_priv is not in v6.1 CIP
 - used devm_reset_control_get_exclusive() + reset_control_deassert() +
   devm_add_action_or_reset() instead of
   devm_reset_control_get_exclusive_deasserted() as the latter is not
   available in v6.1 CIP; added
   rzg3s_thermal_reset_deassert() action function for this
 - used thermal_add_hwmon_sysfs() + devm_add_action_or_reset() instead
   of devm_thermal_add_hwmon_sysfs() as the latter is not available in
   v6.1 CIP; added rzg3s_thermal_rem_hwmon_sysfs() for this
 - added pm_runtime_mark_last_busy() as it is not embedded in
   pm_runtime_put_autosuspend() on v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 MAINTAINERS                     |   7 +
 drivers/thermal/Kconfig         |   8 +
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/rzg3s_thermal.c | 292 ++++++++++++++++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 drivers/thermal/rzg3s_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f1c190f9468..f87e337db1e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17676,6 +17676,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/clock/renesas,versaclock7.yaml
 F:	drivers/clk/clk-versaclock7.c
 
+RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER
+M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
+F:	drivers/thermal/renesas/rzg3s_thermal.c
+
 RESET CONTROLLER FRAMEWORK
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 S:	Maintained
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..4bd995d9eb08 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -365,6 +365,14 @@ config RZG2L_THERMAL
 	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
 	  thermal framework.
 
+config RZG3S_THERMAL
+	tristate "Renesas RZ/G3S thermal driver"
+	depends on ARCH_R9A08G045 || COMPILE_TEST
+	depends on OF && IIO && RZG2L_ADC
+	help
+	  Enable this to plug the RZ/G3S thermal sensor driver into the Linux
+	  thermal framework.
+
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 2506c6c8ca83..a3498d4cb553 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
 obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
+obj-$(CONFIG_RZG3S_THERMAL)	+= rzg3s_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-y				+= samsung/
 obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
diff --git a/drivers/thermal/rzg3s_thermal.c b/drivers/thermal/rzg3s_thermal.c
new file mode 100644
index 000000000000..b2a98168e6b4
--- /dev/null
+++ b/drivers/thermal/rzg3s_thermal.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G3S TSU Thermal Sensor Driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/iio/consumer.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#include "thermal_hwmon.h"
+
+#define TSU_SM			0x0
+#define TSU_SM_EN		BIT(0)
+#define TSU_SM_OE		BIT(1)
+#define OTPTSUTRIM_REG(n)	(0x18 + (n) * 0x4)
+#define OTPTSUTRIM_EN_MASK	BIT(31)
+#define OTPTSUTRIM_MASK		GENMASK(11, 0)
+
+#define TSU_READ_STEPS		8
+
+/* Default calibration values, if FUSE values are missing. */
+#define SW_CALIB0_VAL		1297
+#define SW_CALIB1_VAL		751
+
+#define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
+
+/**
+ * struct rzg3s_thermal_priv - RZ/G3S thermal private data structure
+ * @base: TSU base address
+ * @dev: device pointer
+ * @tz: thermal zone pointer
+ * @rstc: reset control
+ * @channel: IIO channel to read the TSU
+ * @mode: current device mode
+ * @calib0: calibration value
+ * @calib1: calibration value
+ */
+struct rzg3s_thermal_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct thermal_zone_device *tz;
+	struct reset_control *rstc;
+	struct iio_channel *channel;
+	enum thermal_device_mode mode;
+	u16 calib0;
+	u16 calib1;
+};
+
+static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct rzg3s_thermal_priv *priv = tz->devdata;
+	int ts_code_ave = 0;
+
+	if (priv->mode != THERMAL_DEVICE_ENABLED)
+		return -EAGAIN;
+
+	for (u8 i = 0; i < TSU_READ_STEPS; i++) {
+		int ret, val;
+
+		ret = iio_read_channel_raw(priv->channel, &val);
+		if (ret < 0)
+			return ret;
+
+		ts_code_ave += val;
+		/*
+		 * According to the HW manual (Rev.1.10, section 40.4.4 Procedure for Measuring
+		 * the Temperature) we need to wait here at leat 3us.
+		 */
+		usleep_range(5, 10);
+	}
+
+	ts_code_ave = DIV_ROUND_CLOSEST(MCELSIUS(ts_code_ave), TSU_READ_STEPS);
+
+	/*
+	 * According to the HW manual (Rev.1.10, section 40.4.4 Procedure for Measuring the
+	 * Temperature) the computation formula is as follows:
+	 *
+	 * Tj = (ts_code_ave - priv->calib1) * 165 / (priv->calib0 - priv->calib1) - 40
+	 *
+	 * Convert everything to milli Celsius before applying the formula to avoid
+	 * losing precision.
+	 */
+
+	*temp = div_s64((s64)(ts_code_ave - MCELSIUS(priv->calib1)) * MCELSIUS(165),
+			MCELSIUS(priv->calib0 - priv->calib1)) - MCELSIUS(40);
+
+	/* Report it in milli degrees Celsius and round it up to 0.5 degrees Celsius. */
+	*temp = roundup(*temp, 500);
+
+	return 0;
+}
+
+static void rzg3s_thermal_set_mode(struct rzg3s_thermal_priv *priv,
+				   enum thermal_device_mode mode)
+{
+	struct device *dev = priv->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return;
+
+	if (mode == THERMAL_DEVICE_DISABLED) {
+		writel(0, priv->base + TSU_SM);
+	} else {
+		writel(TSU_SM_EN, priv->base + TSU_SM);
+		/*
+		 * According to the HW manual (Rev.1.10, section 40.4.1 Procedure for
+		 * Starting the TSU) we need to wait here 30us or more.
+		 */
+		usleep_range(30, 40);
+
+		writel(TSU_SM_OE | TSU_SM_EN, priv->base + TSU_SM);
+		/*
+		 * According to the HW manual (Rev.1.10, section 40.4.1 Procedure for
+		 * Starting the TSU) we need to wait here 50us or more.
+		 */
+		usleep_range(50, 60);
+	}
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+}
+
+static int rzg3s_thermal_change_mode(struct thermal_zone_device *tz,
+				     enum thermal_device_mode mode)
+{
+	struct rzg3s_thermal_priv *priv = tz->devdata;
+
+	if (priv->mode == mode)
+		return 0;
+
+	rzg3s_thermal_set_mode(priv, mode);
+	priv->mode = mode;
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops rzg3s_tz_of_ops = {
+	.get_temp = rzg3s_thermal_get_temp,
+	.change_mode = rzg3s_thermal_change_mode,
+};
+
+static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv)
+{
+	struct device *dev = priv->dev;
+	u32 val;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	val = readl(priv->base + OTPTSUTRIM_REG(0));
+	if (val & OTPTSUTRIM_EN_MASK)
+		priv->calib0 = FIELD_GET(OTPTSUTRIM_MASK, val);
+	else
+		priv->calib0 = SW_CALIB0_VAL;
+
+	val = readl(priv->base + OTPTSUTRIM_REG(1));
+	if (val & OTPTSUTRIM_EN_MASK)
+		priv->calib1 = FIELD_GET(OTPTSUTRIM_MASK, val);
+	else
+		priv->calib1 = SW_CALIB1_VAL;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static void rzg3s_thermal_reset_deassert(void *data)
+{
+	reset_control_deassert(data);
+}
+
+static void rzg3s_thermal_rem_hwmon_sysfs(void *data)
+{
+	thermal_remove_hwmon_sysfs(data);
+}
+
+static int rzg3s_thermal_probe(struct platform_device *pdev)
+{
+	struct rzg3s_thermal_priv *priv;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->channel = devm_iio_channel_get(dev, "tsu");
+	if (IS_ERR(priv->channel))
+		return dev_err_probe(dev, PTR_ERR(priv->channel), "Failed to get IIO channel!\n");
+
+	priv->rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(priv->rstc))
+		return dev_err_probe(dev, PTR_ERR(priv->rstc), "Failed to get reset!\n");
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, rzg3s_thermal_reset_deassert, priv->rstc);
+	if (ret)
+		return ret;
+
+	priv->dev = dev;
+	priv->mode = THERMAL_DEVICE_DISABLED;
+	platform_set_drvdata(pdev, priv);
+
+	pm_runtime_set_autosuspend_delay(dev, 300);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM!\n");
+
+	ret = rzg3s_thermal_read_calib(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read calibration data!\n");
+
+	priv->tz = devm_thermal_of_zone_register(dev, 0, priv, &rzg3s_tz_of_ops);
+	if (IS_ERR(priv->tz))
+		return dev_err_probe(dev, PTR_ERR(priv->tz), "Failed to register thermal zone!\n");
+
+	ret = thermal_add_hwmon_sysfs(priv->tz);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add hwmon sysfs!\n");
+
+	return devm_add_action_or_reset(dev, rzg3s_thermal_rem_hwmon_sysfs, priv->tz);
+}
+
+static int rzg3s_thermal_suspend(struct device *dev)
+{
+	struct rzg3s_thermal_priv *priv = dev_get_drvdata(dev);
+
+	rzg3s_thermal_set_mode(priv, THERMAL_DEVICE_DISABLED);
+
+	return reset_control_assert(priv->rstc);
+}
+
+static int rzg3s_thermal_resume(struct device *dev)
+{
+	struct rzg3s_thermal_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	if (priv->mode != THERMAL_DEVICE_DISABLED)
+		rzg3s_thermal_set_mode(priv, priv->mode);
+
+	return 0;
+}
+
+static const struct dev_pm_ops rzg3s_thermal_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(rzg3s_thermal_suspend, rzg3s_thermal_resume)
+};
+
+static const struct of_device_id rzg3s_thermal_dt_ids[] = {
+	{ .compatible = "renesas,r9a08g045-tsu" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);
+
+static struct platform_driver rzg3s_thermal_driver = {
+	.driver = {
+		.name = "rzg3s-thermal",
+		.of_match_table = rzg3s_thermal_dt_ids,
+		.pm = pm_ptr(&rzg3s_thermal_pm_ops),
+	},
+	.probe = rzg3s_thermal_probe,
+};
+module_platform_driver(rzg3s_thermal_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/G3S Thermal Sensor Unit Driver");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


