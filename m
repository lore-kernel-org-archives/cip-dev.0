X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.25202.1658136274779570356
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jul 2022 02:24:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,280,1650898800"; 
   d="scan'208";a="128219423"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jul 2022 18:24:37 +0900
Received: from biju-VirtualBox.ree.adwin.renesas.com (unknown [10.226.36.116])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DA6244007548;
	Mon, 18 Jul 2022 18:24:35 +0900 (JST)
From: "Biju Das" <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH v2 5.10.y-cip 02/12] thermal/drivers: Add TSU driver for RZ/G2L
Date: Mon, 18 Jul 2022 10:24:20 +0100
Message-Id: <20220718092430.382889-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
References: <20220718092430.382889-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

commit 673c68bd48390dad01f7d17670de3e33b60860ac upstream.

The RZ/G2L SoC incorporates a thermal sensor unit (TSU) that measures the
temperature inside the LSI.

The thermal sensor in this unit measures temperatures in the range from
−40 degree Celsius to 125 degree Celsius with an accuracy of ±3°C. The
TSU repeats measurement at 20 microseconds intervals and automatically
updates the results of measurement.

The TSU has no interrupts as well as no external pins.

This patch adds Thermal Sensor Unit(TSU) driver for RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211130155757.17837-3-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[biju: Replaced math.h->kernel.h]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/Kconfig         |   9 ++
 drivers/thermal/Makefile        |   1 +
 drivers/thermal/rzg2l_thermal.c | 240 ++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 drivers/thermal/rzg2l_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 7edc8dc6bbab..e51c8cc989d8 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -354,6 +354,15 @@ config RCAR_GEN3_THERMAL
 	  Enable this to plug the R-Car Gen3 or RZ/G2 thermal sensor driver into
 	  the Linux thermal framework.
 
+config RZG2L_THERMAL
+	tristate "Renesas RZ/G2L thermal driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	depends on OF
+	help
+	  Enable this to plug the RZ/G2L thermal sensor driver into the Linux
+	  thermal framework.
+
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
 	depends on MACH_KIRKWOOD || COMPILE_TEST
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index b64dd50a6629..b71f9b88b567 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
 obj-$(CONFIG_RCAR_THERMAL)	+= rcar_thermal.o
 obj-$(CONFIG_RCAR_GEN3_THERMAL)	+= rcar_gen3_thermal.o
+obj-$(CONFIG_RZG2L_THERMAL)	+= rzg2l_thermal.o
 obj-$(CONFIG_KIRKWOOD_THERMAL)  += kirkwood_thermal.o
 obj-y				+= samsung/
 obj-$(CONFIG_DOVE_THERMAL)  	+= dove_thermal.o
diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
new file mode 100644
index 000000000000..19062739e213
--- /dev/null
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L TSU Thermal Sensor Driver
+ *
+ * Copyright (C) 2021 Renesas Electronics Corporation
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/thermal.h>
+#include <linux/units.h>
+
+#include "thermal_hwmon.h"
+
+#define CTEMP_MASK	0xFFF
+
+/* default calibration values, if FUSE values are missing */
+#define SW_CALIB0_VAL	3148
+#define SW_CALIB1_VAL	503
+
+/* Register offsets */
+#define TSU_SM		0x00
+#define TSU_ST		0x04
+#define TSU_SAD		0x0C
+#define TSU_SS		0x10
+
+#define OTPTSUTRIM_REG(n)	(0x18 + ((n) * 0x4))
+
+/* Sensor Mode Register(TSU_SM) */
+#define TSU_SM_EN_TS		BIT(0)
+#define TSU_SM_ADC_EN_TS	BIT(1)
+#define TSU_SM_NORMAL_MODE	(TSU_SM_EN_TS | TSU_SM_ADC_EN_TS)
+
+/* TSU_ST bits */
+#define TSU_ST_START		BIT(0)
+
+#define TSU_SS_CONV_RUNNING	BIT(0)
+
+#define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
+#define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
+#define TS_CODE_CAP_TIMES	8	/* Capture  times */
+
+#define RZG2L_THERMAL_GRAN	500	/* milli Celsius */
+#define RZG2L_TSU_SS_TIMEOUT_US	1000
+
+#define CURVATURE_CORRECTION_CONST	13
+
+struct rzg2l_thermal_priv {
+	struct device *dev;
+	void __iomem *base;
+	struct thermal_zone_device *zone;
+	struct reset_control *rstc;
+	u32 calib0, calib1;
+};
+
+static inline u32 rzg2l_thermal_read(struct rzg2l_thermal_priv *priv, u32 reg)
+{
+	return ioread32(priv->base + reg);
+}
+
+static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
+				       u32 data)
+{
+	iowrite32(data, priv->base + reg);
+}
+
+static int rzg2l_thermal_get_temp(void *devdata, int *temp)
+{
+	struct rzg2l_thermal_priv *priv = devdata;
+	u32 result = 0, dsensor, ts_code_ave;
+	int val, i;
+
+	for (i = 0; i < TS_CODE_CAP_TIMES ; i++) {
+		/* TSU repeats measurement at 20 microseconds intervals and
+		 * automatically updates the results of measurement. As per
+		 * the HW manual for measuring temperature we need to read 8
+		 * values consecutively and then take the average.
+		 * ts_code_ave = (ts_code[0] + ⋯ + ts_code[7]) / 8
+		 */
+		result += rzg2l_thermal_read(priv, TSU_SAD) & CTEMP_MASK;
+		usleep_range(20, 30);
+	}
+
+	ts_code_ave = result / TS_CODE_CAP_TIMES;
+
+	/* Calculate actual sensor value by applying curvature correction formula
+	 * dsensor = ts_code_ave / (1 + ts_code_ave * 0.000013). Here we are doing
+	 * integer calculation by scaling all the values by 1000000.
+	 */
+	dsensor = TS_CODE_AVE_SCALE(ts_code_ave) /
+		(TS_CODE_AVE_SCALE(1) + (ts_code_ave * CURVATURE_CORRECTION_CONST));
+
+	/* The temperature Tj is calculated by the formula
+	 * Tj = (dsensor − calib1) * 165/ (calib0 − calib1) − 40
+	 * where calib0 and calib1 are the caliberation values.
+	 */
+	val = ((dsensor - priv->calib1) * (MCELSIUS(165) /
+		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
+
+	*temp = roundup(val, RZG2L_THERMAL_GRAN);
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops = {
+	.get_temp = rzg2l_thermal_get_temp,
+};
+
+static int rzg2l_thermal_init(struct rzg2l_thermal_priv *priv)
+{
+	u32 reg_val;
+
+	rzg2l_thermal_write(priv, TSU_SM, TSU_SM_NORMAL_MODE);
+	rzg2l_thermal_write(priv, TSU_ST, 0);
+
+	/* Before setting the START bit, TSU should be in normal operating
+	 * mode. As per the HW manual, it will take 60 µs to place the TSU
+	 * into normal operating mode.
+	 */
+	usleep_range(60, 80);
+
+	reg_val = rzg2l_thermal_read(priv, TSU_ST);
+	reg_val |= TSU_ST_START;
+	rzg2l_thermal_write(priv, TSU_ST, reg_val);
+
+	return readl_poll_timeout(priv->base + TSU_SS, reg_val,
+				  reg_val == TSU_SS_CONV_RUNNING, 50,
+				  RZG2L_TSU_SS_TIMEOUT_US);
+}
+
+static void rzg2l_thermal_reset_assert_pm_disable_put(struct platform_device *pdev)
+{
+	struct rzg2l_thermal_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(priv->rstc);
+}
+
+static int rzg2l_thermal_remove(struct platform_device *pdev)
+{
+	struct rzg2l_thermal_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	thermal_remove_hwmon_sysfs(priv->zone);
+	rzg2l_thermal_reset_assert_pm_disable_put(pdev);
+
+	return 0;
+}
+
+static int rzg2l_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *zone;
+	struct rzg2l_thermal_priv *priv;
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
+	priv->dev = dev;
+	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(priv->rstc))
+		return dev_err_probe(dev, PTR_ERR(priv->rstc),
+				     "failed to get cpg reset");
+
+	reset_control_deassert(priv->rstc);
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	priv->calib0 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0));
+	if (!priv->calib0)
+		priv->calib0 = SW_CALIB0_VAL;
+
+	priv->calib1 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(1));
+	if (!priv->calib1)
+		priv->calib1 = SW_CALIB1_VAL;
+
+	platform_set_drvdata(pdev, priv);
+	ret = rzg2l_thermal_init(priv);
+	if (ret) {
+		dev_err(dev, "Failed to start TSU");
+		goto err;
+	}
+
+	zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
+						    &rzg2l_tz_of_ops);
+	if (IS_ERR(zone)) {
+		dev_err(dev, "Can't register thermal zone");
+		ret = PTR_ERR(zone);
+		goto err;
+	}
+
+	priv->zone = zone;
+	priv->zone->tzp->no_hwmon = false;
+	ret = thermal_add_hwmon_sysfs(priv->zone);
+	if (ret)
+		goto err;
+
+	dev_dbg(dev, "TSU probed with %s caliberation values",
+		rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");
+
+	return 0;
+
+err:
+	rzg2l_thermal_reset_assert_pm_disable_put(pdev);
+	return ret;
+}
+
+static const struct of_device_id rzg2l_thermal_dt_ids[] = {
+	{ .compatible = "renesas,rzg2l-tsu", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_thermal_dt_ids);
+
+static struct platform_driver rzg2l_thermal_driver = {
+	.driver = {
+		.name = "rzg2l_thermal",
+		.of_match_table = rzg2l_thermal_dt_ids,
+	},
+	.probe = rzg2l_thermal_probe,
+	.remove = rzg2l_thermal_remove,
+};
+module_platform_driver(rzg2l_thermal_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/G2L TSU Thermal Sensor Driver");
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1


