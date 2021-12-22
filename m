Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD29C433EF
	for <webhook@archiver.kernel.org>; Wed, 22 Dec 2021 13:50:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.19262.1640181000080184146
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 05:50:00 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,226,1635174000";
   d="scan'208";a="104366607"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 22:49:59 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 19C4D430F43A;
	Wed, 22 Dec 2021 22:49:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/21] reset: renesas: Add RZ/G2L usbphy control
 driver
Date: Wed, 22 Dec 2021 13:49:34 +0000
Message-Id: <20211222134951.19432-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211222134951.19432-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Dec 2021 13:50:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7238

From: Biju Das <biju.das.jz@bp.renesas.com>

commit bee08559701fb98b43d7061717e7c3131230aa69 upstream.

Add support for RZ/G2L USBPHY Control driver. It mainly controls
reset and power down of the USB/PHY.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210719121938.6532-5-biju.das.jz@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/reset/Kconfig                   |   7 +
 drivers/reset/Makefile                  |   1 +
 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 175 ++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 drivers/reset/reset-rzg2l-usbphy-ctrl.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 147543ad303f..9a759b0e5a79 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -154,6 +154,13 @@ config RESET_RASPBERRYPI
 	  interfacing with RPi4's co-processor and model these firmware
 	  initialization routines as reset lines.
 
+config RESET_RZG2L_USBPHY_CTRL
+	tristate "Renesas RZ/G2L USBPHY control driver"
+	depends on ARCH_R9A07G044 || COMPILE_TEST
+	help
+	  Support for USBPHY Control found on RZ/G2L family. It mainly
+	  controls reset and power down of the USB/PHY.
+
 config RESET_SCMI
 	tristate "Reset driver controlled via ARM SCMI interface"
 	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 16947610cc3b..243f765cdfa2 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_QCOM_AOSS) += reset-qcom-aoss.o
 obj-$(CONFIG_RESET_QCOM_PDC) += reset-qcom-pdc.o
 obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
+obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
new file mode 100644
index 000000000000..e0704fd2b533
--- /dev/null
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L USBPHY control driver
+ *
+ * Copyright (C) 2021 Renesas Electronics Corporation
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
+
+#define RESET			0x000
+
+#define RESET_SEL_PLLRESET	BIT(12)
+#define RESET_PLLRESET		BIT(8)
+
+#define RESET_SEL_P2RESET	BIT(5)
+#define RESET_SEL_P1RESET	BIT(4)
+#define RESET_PHYRST_2		BIT(1)
+#define RESET_PHYRST_1		BIT(0)
+
+#define PHY_RESET_PORT2		(RESET_SEL_P2RESET | RESET_PHYRST_2)
+#define PHY_RESET_PORT1		(RESET_SEL_P1RESET | RESET_PHYRST_1)
+
+#define NUM_PORTS		2
+
+struct rzg2l_usbphy_ctrl_priv {
+	struct reset_controller_dev rcdev;
+	struct reset_control *rstc;
+	void __iomem *base;
+
+	spinlock_t lock;
+};
+
+#define rcdev_to_priv(x)	container_of(x, struct rzg2l_usbphy_ctrl_priv, rcdev)
+
+static int rzg2l_usbphy_ctrl_assert(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = rcdev_to_priv(rcdev);
+	u32 port_mask = PHY_RESET_PORT1 | PHY_RESET_PORT2;
+	void __iomem *base = priv->base;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	val = readl(base + RESET);
+	val |= id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;
+	if (port_mask == (val & port_mask))
+		val |= RESET_PLLRESET;
+	writel(val, base + RESET);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int rzg2l_usbphy_ctrl_deassert(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = rcdev_to_priv(rcdev);
+	void __iomem *base = priv->base;
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	val = readl(base + RESET);
+
+	val |= RESET_SEL_PLLRESET;
+	val &= ~(RESET_PLLRESET | (id ? PHY_RESET_PORT2 : PHY_RESET_PORT1));
+	writel(val, base + RESET);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = rcdev_to_priv(rcdev);
+	u32 port_mask;
+
+	port_mask = id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;
+
+	return !!(readl(priv->base + RESET) & port_mask);
+}
+
+static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] = {
+	{ .compatible = "renesas,rzg2l-usbphy-ctrl" },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_usbphy_ctrl_match_table);
+
+static const struct reset_control_ops rzg2l_usbphy_ctrl_reset_ops = {
+	.assert = rzg2l_usbphy_ctrl_assert,
+	.deassert = rzg2l_usbphy_ctrl_deassert,
+	.status = rzg2l_usbphy_ctrl_status,
+};
+
+static int rzg2l_usbphy_ctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rzg2l_usbphy_ctrl_priv *priv;
+	unsigned long flags;
+	int error;
+	u32 val;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(priv->rstc))
+		return dev_err_probe(dev, PTR_ERR(priv->rstc),
+				     "failed to get reset\n");
+
+	reset_control_deassert(priv->rstc);
+
+	priv->rcdev.ops = &rzg2l_usbphy_ctrl_reset_ops;
+	priv->rcdev.of_reset_n_cells = 1;
+	priv->rcdev.nr_resets = NUM_PORTS;
+	priv->rcdev.of_node = dev->of_node;
+	priv->rcdev.dev = dev;
+
+	error = devm_reset_controller_register(dev, &priv->rcdev);
+	if (error)
+		return error;
+
+	spin_lock_init(&priv->lock);
+	dev_set_drvdata(dev, priv);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_resume_and_get(&pdev->dev);
+
+	/* put pll and phy into reset state */
+	spin_lock_irqsave(&priv->lock, flags);
+	val = readl(priv->base + RESET);
+	val |= RESET_SEL_PLLRESET | RESET_PLLRESET | PHY_RESET_PORT2 | PHY_RESET_PORT1;
+	writel(val, priv->base + RESET);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int rzg2l_usbphy_ctrl_remove(struct platform_device *pdev)
+{
+	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(priv->rstc);
+
+	return 0;
+}
+
+static struct platform_driver rzg2l_usbphy_ctrl_driver = {
+	.driver = {
+		.name		= "rzg2l_usbphy_ctrl",
+		.of_match_table	= rzg2l_usbphy_ctrl_match_table,
+	},
+	.probe	= rzg2l_usbphy_ctrl_probe,
+	.remove	= rzg2l_usbphy_ctrl_remove,
+};
+module_platform_driver(rzg2l_usbphy_ctrl_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Renesas RZ/G2L USBPHY Control");
+MODULE_AUTHOR("biju.das.jz@bp.renesas.com>");
-- 
2.17.1


