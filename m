Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F223CF9C53
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:37 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1331.1763657853816003082
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Nov 2025 08:57:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: udbV6txERr6szChtSmM1xA==
X-CSE-MsgGUID: 5du3L7d8TjCJTbKVqoyVzA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2025 01:57:34 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6AC64405DC26;
	Fri, 21 Nov 2025 01:57:33 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 3/9] reset: Add USB2PHY port reset driver for Renesas RZ/V2H(P)
Date: Thu, 20 Nov 2025 16:57:20 +0000
Message-ID: <20251120165726.18296-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
References: <20251120165726.18296-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 16:57:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20640

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit e3911d7f865bbc704205f45333e491e4034942c7 upstream.

Implement a USB2PHY port reset driver for the Renesas RZ/V2H(P) SoC.
Enable control of USB2.0 PHY reset and power-down operations, including
assert and deassert functionalities for the PHY.

Leverage device tree (OF) data to support future SoCs with similar USB2PHY
hardware but varying register configurations. Define initialization values
and control register settings to ensure flexibility for upcoming platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://lore.kernel.org/r/20250415195131.281060-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
[OP: - added linux/of_device.h include
     - replaced devm_reset_control_get_shared_deasserted() with
       devm_reset_control_get_shared() + reset_control_deassert()
     - added error handling in probe to assert the reset on errors
     - added remove callback]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/reset/Kconfig               |   7 +
 drivers/reset/Makefile              |   1 +
 drivers/reset/reset-rzv2h-usb2phy.c | 270 ++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 drivers/reset/reset-rzv2h-usb2phy.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index c561a93af655..e7ff064709cb 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -195,6 +195,13 @@ config RESET_RZG2L_USBPHY_CTRL
 	  Support for USBPHY Control found on RZ/G2L family. It mainly
 	  controls reset and power down of the USB/PHY.
 
+config RESET_RZV2H_USB2PHY
+	tristate "Renesas RZ/V2H(P) (and similar SoCs) USB2PHY Reset driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  Support for USB2PHY Port reset Control found on the RZ/V2H(P) SoC
+	  (and similar SoCs).
+
 config RESET_SCMI
 	tristate "Reset driver controlled via ARM SCMI interface"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 3e7e5fd633a8..970b085faca2 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
 obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
+obj-$(CONFIG_RESET_RZV2H_USB2PHY) += reset-rzv2h-usb2phy.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
diff --git a/drivers/reset/reset-rzv2h-usb2phy.c b/drivers/reset/reset-rzv2h-usb2phy.c
new file mode 100644
index 000000000000..a350afb5ae65
--- /dev/null
+++ b/drivers/reset/reset-rzv2h-usb2phy.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2H(P) USB2PHY Port reset control driver
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation
+ */
+
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
+
+struct rzv2h_usb2phy_regval {
+	u16 reg;
+	u16 val;
+};
+
+struct rzv2h_usb2phy_reset_of_data {
+	const struct rzv2h_usb2phy_regval *init_vals;
+	unsigned int init_val_count;
+
+	u16 reset_reg;
+	u16 reset_assert_val;
+	u16 reset_deassert_val;
+	u16 reset_status_bits;
+	u16 reset_release_val;
+
+	u16 reset2_reg;
+	u16 reset2_acquire_val;
+	u16 reset2_release_val;
+};
+
+struct rzv2h_usb2phy_reset_priv {
+	const struct rzv2h_usb2phy_reset_of_data *data;
+	void __iomem *base;
+	struct device *dev;
+	struct reset_control *rstc;
+	struct reset_controller_dev rcdev;
+	spinlock_t lock; /* protects register accesses */
+};
+
+static inline struct rzv2h_usb2phy_reset_priv
+*rzv2h_usbphy_rcdev_to_priv(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct rzv2h_usb2phy_reset_priv, rcdev);
+}
+
+/* This function must be called only after pm_runtime_resume_and_get() has been called */
+static void rzv2h_usbphy_assert_helper(struct rzv2h_usb2phy_reset_priv *priv)
+{
+	const struct rzv2h_usb2phy_reset_of_data *data = priv->data;
+
+	scoped_guard(spinlock, &priv->lock) {
+		writel(data->reset2_acquire_val, priv->base + data->reset2_reg);
+		writel(data->reset_assert_val, priv->base + data->reset_reg);
+	}
+
+	usleep_range(11, 20);
+}
+
+static int rzv2h_usbphy_reset_assert(struct reset_controller_dev *rcdev,
+				     unsigned long id)
+{
+	struct rzv2h_usb2phy_reset_priv *priv = rzv2h_usbphy_rcdev_to_priv(rcdev);
+	struct device *dev = priv->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(dev, "pm_runtime_resume_and_get failed\n");
+		return ret;
+	}
+
+	rzv2h_usbphy_assert_helper(priv);
+
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+static int rzv2h_usbphy_reset_deassert(struct reset_controller_dev *rcdev,
+				       unsigned long id)
+{
+	struct rzv2h_usb2phy_reset_priv *priv = rzv2h_usbphy_rcdev_to_priv(rcdev);
+	const struct rzv2h_usb2phy_reset_of_data *data = priv->data;
+	struct device *dev = priv->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(dev, "pm_runtime_resume_and_get failed\n");
+		return ret;
+	}
+
+	scoped_guard(spinlock, &priv->lock) {
+		writel(data->reset_deassert_val, priv->base + data->reset_reg);
+		writel(data->reset2_release_val, priv->base + data->reset2_reg);
+		writel(data->reset_release_val, priv->base + data->reset_reg);
+	}
+
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+static int rzv2h_usbphy_reset_status(struct reset_controller_dev *rcdev,
+				     unsigned long id)
+{
+	struct rzv2h_usb2phy_reset_priv *priv = rzv2h_usbphy_rcdev_to_priv(rcdev);
+	struct device *dev = priv->dev;
+	int ret;
+	u32 reg;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err(dev, "pm_runtime_resume_and_get failed\n");
+		return ret;
+	}
+
+	reg = readl(priv->base + priv->data->reset_reg);
+
+	pm_runtime_put(dev);
+
+	return (reg & priv->data->reset_status_bits) == priv->data->reset_status_bits;
+}
+
+static const struct reset_control_ops rzv2h_usbphy_reset_ops = {
+	.assert = rzv2h_usbphy_reset_assert,
+	.deassert = rzv2h_usbphy_reset_deassert,
+	.status = rzv2h_usbphy_reset_status,
+};
+
+static int rzv2h_usb2phy_reset_of_xlate(struct reset_controller_dev *rcdev,
+					const struct of_phandle_args *reset_spec)
+{
+	/* No special handling needed, we have only one reset line per device */
+	return 0;
+}
+
+static int rzv2h_usb2phy_reset_probe(struct platform_device *pdev)
+{
+	const struct rzv2h_usb2phy_reset_of_data *data;
+	struct rzv2h_usb2phy_reset_priv *priv;
+	struct device *dev = &pdev->dev;
+	int error;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	data = of_device_get_match_data(dev);
+	priv->data = data;
+	priv->dev = dev;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->rstc = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(priv->rstc))
+		return dev_err_probe(dev, PTR_ERR(priv->rstc),
+				     "failed to get reset\n");
+
+	error = reset_control_deassert(priv->rstc);
+	if (error)
+		return dev_err_probe(dev, error,
+				     "failed to deassert reset\n");
+
+	spin_lock_init(&priv->lock);
+
+	error = devm_pm_runtime_enable(dev);
+	if (error) {
+		dev_err_probe(dev, error, "Failed to enable pm_runtime\n");
+		goto out_assert_rst;
+	}
+
+	error = pm_runtime_resume_and_get(dev);
+	if (error) {
+		dev_err_probe(dev, error, "pm_runtime_resume_and_get failed\n");
+		goto out_assert_rst;
+	}
+
+	for (unsigned int i = 0; i < data->init_val_count; i++)
+		writel(data->init_vals[i].val, priv->base + data->init_vals[i].reg);
+
+	/* keep usb2phy in asserted state */
+	rzv2h_usbphy_assert_helper(priv);
+
+	pm_runtime_put(dev);
+
+	priv->rcdev.ops = &rzv2h_usbphy_reset_ops;
+	priv->rcdev.of_reset_n_cells = 0;
+	priv->rcdev.nr_resets = 1;
+	priv->rcdev.of_xlate = rzv2h_usb2phy_reset_of_xlate;
+	priv->rcdev.of_node = dev->of_node;
+	priv->rcdev.dev = dev;
+
+	platform_set_drvdata(pdev, priv);
+
+	error = devm_reset_controller_register(dev, &priv->rcdev);
+	if (error) {
+		dev_err_probe(dev, error,
+			      "devm_reset_controller_register() failed");
+		goto out_assert_rst;
+	}
+
+	return 0;
+
+out_assert_rst:
+	reset_control_assert(priv->rstc);
+
+	return error;
+}
+
+static int rzv2h_usb2phy_reset_remove(struct platform_device *pdev)
+{
+	struct rzv2h_usb2phy_reset_priv *priv = platform_get_drvdata(pdev);
+
+	reset_control_assert(priv->rstc);
+
+	return 0;
+}
+
+/*
+ * initialization values required to prepare the PHY to receive
+ * assert and deassert requests.
+ */
+static const struct rzv2h_usb2phy_regval rzv2h_init_vals[] = {
+	{ .reg = 0xc10, .val = 0x67c },
+	{ .reg = 0xc14, .val = 0x1f },
+	{ .reg = 0x600, .val = 0x909 },
+};
+
+static const struct rzv2h_usb2phy_reset_of_data rzv2h_reset_of_data = {
+	.init_vals = rzv2h_init_vals,
+	.init_val_count = ARRAY_SIZE(rzv2h_init_vals),
+	.reset_reg = 0,
+	.reset_assert_val = 0x206,
+	.reset_status_bits = BIT(2),
+	.reset_deassert_val = 0x200,
+	.reset_release_val = 0x0,
+	.reset2_reg = 0xb04,
+	.reset2_acquire_val = 0x303,
+	.reset2_release_val = 0x3,
+};
+
+static const struct of_device_id rzv2h_usb2phy_reset_of_match[] = {
+	{ .compatible = "renesas,r9a09g057-usb2phy-reset", .data = &rzv2h_reset_of_data },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2h_usb2phy_reset_of_match);
+
+static struct platform_driver rzv2h_usb2phy_reset_driver = {
+	.driver = {
+		.name		= "rzv2h_usb2phy_reset",
+		.of_match_table	= rzv2h_usb2phy_reset_of_match,
+	},
+	.probe = rzv2h_usb2phy_reset_probe,
+	.remove = rzv2h_usb2phy_reset_remove,
+};
+module_platform_driver(rzv2h_usb2phy_reset_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2H(P) USB2PHY Control");
-- 
2.51.0


