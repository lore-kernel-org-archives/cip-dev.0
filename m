Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C5FD65535
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:05 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11304.1765967524650194895
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=FBWLVVdP;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so80868066b.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967523; x=1766572323; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeIUOHeDf1QmMZqxPFakISiz2ifHOeLdRpEtNxLyB1c=;
        b=FBWLVVdPbT9RYr/mUo4flTpMF3kAfm+aJSF4zaKntTyyGs84DDw0ap/hxJryVWfPtE
         88gSciFArUJ3NgASof1F9hjVQSJ8GZmxF5fse1vBEPCt5KTqKplDSl01X4rwCwY9kb+v
         sYTETMUuD4w/VC9Q10d8O/Kalr7iatA/3vmc8jx7ydf/sRQiAFT4p6avNNjAtH/Mcpz1
         PLbu0rbzYJWeCMEXHMHdfWR7QEVP4sYxaqH4FrA8Vr7P9hzb5eH6KTM6XHwcZcIKMEPS
         2lDcJPxA6pV9YqXhLKSwAn6UkKIBKD9HlFbJWDj3xRpFvt9kNOtqoColyv0gCPoBLdUj
         7wCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967523; x=1766572323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oeIUOHeDf1QmMZqxPFakISiz2ifHOeLdRpEtNxLyB1c=;
        b=OHX8ddfPh39nSQmI1S0gGjXm/EeyTmDea3OwLW0grQ3X0cWI9jXli9dqSxo6AHjxrQ
         pw+fsz3l0gFZI0ZPWgi5e+D+nzkVz6YD9ENUCNTuBWbQNk71/1ctRw20kuHgFKxplfKR
         FPX4LpIG5N35vNv0m4Fvghrb5q1Qvb5Lo1TtsUaGlDrg0MeS/CZJwxf89AdPscEeFhs1
         hmqdfN4Ry8nxBmrBrJGrLKjz3Xj+C3Mr21zrJNSyGTnWxCZMp7OCcWm++xgWi8VsI1ff
         QmN5JUffbNTKGEiNJOqSq5aXkTBAhWhcNwbB6S4unMXvvQOlRAzvp5GTxCRo9GxSlhU8
         JESQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNLwx2feYYlzCQb3yE12q1cKejOD1L/MAOoUW3dT9ZlYDTcfkp/7zMwohmd/zxLgaQnugQVlxI@lists.cip-project.org
X-Gm-Message-State: AOJu0Ywk1h0sFIYPk/3xXLSPkqbLmsIqcm4ZtvZAvJU3p6tcK3TjSeGw
	nNJiyO6AM8jR5g4KVXKUxkC4ofXuxcyXMYm8BaW38uF2HtpMvsrL1go/OVJpo5VSgphcwfueSJd
	lu6a9
X-Gm-Gg: AY/fxX7b0LCcp5usBw3dr+BuQHpfpG0LO6TlfPmX3JK3orzmdr6F7fp0uBQjD8VTYWQ
	vmmxGyD37ENRxkL64TiZc2x8YHYnaaG8Qa4rDiJJUfyz3ZuOn86tmZA5I0Cq5YtPyAMOxO5y66C
	po4kKAqn2FRIA9mXSnkgPjGxKyj7r9rpfJw/ltJkAHt4iprr7W2jvdSue2uUu94N0U5CWmU4gNC
	WzEE1drjsqwShlTmkOzWx8P3kEJ40f6Pq3OoTRwoExGaLANFnLpb0fmVJZOCwmS+FYWvxBYQNOL
	is29v1GZj8qESBzBVK85DcTWLq6LpafcoDafZ59aL8GEtENY86dXM+3Gu6rMjXg9OaVLR5f2IDQ
	JxNV3uLcu6a+4e/167qvBegM96tPZKt8v8CTvcCq+nwvtfIsrbXo6XPntjlIuijfxIlcQ8/w4Ey
	t2F/NhGhAbZahYUwRXMKbmLi7v14tcUfm9qo+L1JRG
X-Google-Smtp-Source: AGHT+IGqUEYRtEVy2pQzABgpW43BImH0K/noLIaZnPJpQa2+hsTN5IXAHF6LI7pRwLmi2Z1NFT00HQ==
X-Received: by 2002:a17:907:6eac:b0:b73:9792:918b with SMTP id a640c23a62f3a-b7d236b50bamr1941887566b.27.1765967522971;
        Wed, 17 Dec 2025 02:32:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584800sm2050292a12.30.2025.12.17.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:02 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 4/7] thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas RZ/G3S SoC
Date: Wed, 17 Dec 2025 12:31:45 +0200
Message-ID: <20251217103149.4182935-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21101

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
 - as a result of cherry-picking, the entries in MAINTAINERS file around
   the "RENESAS RZ/G3S THERMAL SENSOR UNIT DRIVER" were picked as well;
   dropped them and kept only the RZ/G3S TSU entry
 - deleted drivers/thermal/renesas/{Kconfig, Makefile} as the renesas
   directory is not available in v5.10 CIP and updated instead the
   drivers/thermal/{Kconfig, Makfile}
 - moved drivers/thermal/renesas/rzg3s_thermal.c to
   drivers/thermal/rzg3s_thermal.c as the renesas directory is not
   available in v5.10 CIP
 - included "thermal_hwmon.h" instead of "../thermal_hwmon.h"
 - replaced thermal_zone_device_priv(rz) with tz->devdata as
   thermal_zone_device_priv is not in v5.10 CIP
 - used devm_reset_control_get_exclusive() + reset_control_deassert() +
   devm_add_action_or_reset() instead of
   devm_reset_control_get_exclusive_deasserted() as the latter is not
   available in v5.10 CIP; added
   rzg3s_thermal_reset_deassert() action function for this
 - used thermal_add_hwmon_sysfs() + devm_add_action_or_reset() instead
   of devm_thermal_add_hwmon_sysfs() as the latter is not available in
   v5.10 CIP; added rzg3s_thermal_rem_hwmon_sysfs() for this
 - added pm_runtime_mark_last_busy() as it is not embedded into
   pm_runtime_put_autosuspend() in v5.10 CIP
 - in rzg3s_thermal_get_temp() declare for iterator outside of the for
   block to avoid compilation error
 - changed the type of rzg3s_tz_of_ops to struct
   thermal_zone_of_device_ops as struct thermal_zone_device_ops is not
   available v5.10; with it, populated rzg3s_thermal_change_mode in the
   struct thermal_zone_device::ops::change_mode after the
   devm_thermal_zone_of_sensor_register() returns; as there is no way to
   get the driver private data structure now from the struct
   thermal_zone_device used a static variable to store it;
   rzg3s_thermal_zone_reset() was added to restore the struct
   thermal_zone_device::ops::change_mode to avoid calling it again on
   the next binds; along with all these changes, as the change_mode is
   populated after the thermal_zone_device was created call
   thermal_zone_device_enable in the driver probe
 - use SET_SYSTEM_SLEEP_PM_OPS() along with __maybe_unused for the PM
   callbacks]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 MAINTAINERS                     |   7 +
 drivers/thermal/Kconfig         |   8 +
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/rzg3s_thermal.c | 318 ++++++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 drivers/thermal/rzg3s_thermal.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 09e368cd67f7..99cf07744e82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14962,6 +14962,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/rtc/renesas,rz-rtca3.yaml
 F:	drivers/rtc/rtc-renesas-rtca3.c
 
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
index e51c8cc989d8..569f8cdda7f0 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -363,6 +363,14 @@ config RZG2L_THERMAL
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
index b71f9b88b567..f8b1b2414a37 100644
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
index 000000000000..65f00bc2f3d1
--- /dev/null
+++ b/drivers/thermal/rzg3s_thermal.c
@@ -0,0 +1,318 @@
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
+static struct rzg3s_thermal_priv *rzg3s_thermal_priv_data;
+
+static int rzg3s_thermal_get_temp(void *devdata, int *temp)
+{
+	struct rzg3s_thermal_priv *priv = devdata;
+	int ts_code_ave = 0;
+	u8 i;
+
+	if (priv->mode != THERMAL_DEVICE_ENABLED)
+		return -EAGAIN;
+
+	for (i = 0; i < TSU_READ_STEPS; i++) {
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
+	struct rzg3s_thermal_priv *priv = rzg3s_thermal_priv_data;
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
+static const struct thermal_zone_of_device_ops rzg3s_tz_of_ops = {
+	.get_temp = rzg3s_thermal_get_temp,
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
+static void rzg3s_thermal_zone_reset(void *data)
+{
+	struct thermal_zone_device *tz = data;
+
+	tz->ops->change_mode = NULL;
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
+	priv->tz = devm_thermal_zone_of_sensor_register(dev, 0, priv, &rzg3s_tz_of_ops);
+	if (IS_ERR(priv->tz))
+		return dev_err_probe(dev, PTR_ERR(priv->tz), "Failed to register thermal zone!\n");
+
+	rzg3s_thermal_priv_data = priv;
+	priv->tz->mode = THERMAL_DEVICE_DISABLED;
+	priv->tz->ops->change_mode = rzg3s_thermal_change_mode;
+
+	ret = devm_add_action_or_reset(dev, rzg3s_thermal_zone_reset, priv->tz);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable the thermal zone after the change_mode was populated.
+	 * Disable is done on the cleanup path of
+	 * devm_thermal_zone_of_sensor_register().
+	 */
+	ret = thermal_zone_device_enable(priv->tz);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable thermal zone!\n");
+
+	ret = thermal_add_hwmon_sysfs(priv->tz);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add hwmon sysfs!\n");
+
+	return devm_add_action_or_reset(dev, rzg3s_thermal_rem_hwmon_sysfs, priv->tz);
+}
+
+static int __maybe_unused rzg3s_thermal_suspend(struct device *dev)
+{
+	struct rzg3s_thermal_priv *priv = dev_get_drvdata(dev);
+
+	rzg3s_thermal_set_mode(priv, THERMAL_DEVICE_DISABLED);
+
+	return reset_control_assert(priv->rstc);
+}
+
+static int __maybe_unused rzg3s_thermal_resume(struct device *dev)
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
+	SET_SYSTEM_SLEEP_PM_OPS(rzg3s_thermal_suspend, rzg3s_thermal_resume)
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


