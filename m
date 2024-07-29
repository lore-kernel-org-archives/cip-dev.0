Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D55DC52CDA
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.59142.1722267074879486248
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:31:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213908946"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:31:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D91534006C72;
	Tue, 30 Jul 2024 00:31:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/13] regulator: Add Renesas RZ/G2L USB VBUS regulator driver
Date: Mon, 29 Jul 2024 16:30:44 +0100
Message-ID: <20240729153109.510325-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
References: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16659

commit 84fbd6198766336f627ba08f073fd9970729074e upstream.

As per the RZ/G2L HW manual, VBUSEN can be controlled by the VBOUT
bit of the VBUS Control Register. This register is mapped in the reset
framework. The reset driver expose this register as regmap and instantiates
this driver. The consumer will use the regulator API to control the VBOUT
bit as the control need to be done in the atomic context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20240616105402.45211-5-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/regulator/Kconfig                     |  9 +++
 drivers/regulator/Makefile                    |  1 +
 .../regulator/renesas-usb-vbus-regulator.c    | 74 +++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 drivers/regulator/renesas-usb-vbus-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index cf539011ec0e..5e1303eaf68e 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1477,6 +1477,15 @@ config REGULATOR_UNIPHIER
 	help
 	  Support for regulators implemented on Socionext UniPhier SoCs.
 
+config REGULATOR_RZG2L_VBCTRL
+	tristate "Renesas RZ/G2L USB VBUS regulator driver"
+	depends on ARCH_RZG2L || COMPILE_TEST
+	depends on OF
+	select REGMAP_MMIO
+	default ARCH_RZG2L
+	help
+	  Support for VBUS regulators implemented on Renesas RZ/G2L SoCs.
+
 config REGULATOR_VCTRL
 	tristate "Voltage controlled regulators"
 	depends on OF
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 58ea83a3f800..3e5c5e22f23a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -174,6 +174,7 @@ obj-$(CONFIG_REGULATOR_TPS65132) += tps65132-regulator.o
 obj-$(CONFIG_REGULATOR_TPS68470) += tps68470-regulator.o
 obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
 obj-$(CONFIG_REGULATOR_UNIPHIER) += uniphier-regulator.o
+obj-$(CONFIG_REGULATOR_RZG2L_VBCTRL) += renesas-usb-vbus-regulator.o
 obj-$(CONFIG_REGULATOR_VCTRL) += vctrl-regulator.o
 obj-$(CONFIG_REGULATOR_VEXPRESS) += vexpress-regulator.o
 obj-$(CONFIG_REGULATOR_VQMMC_IPQ4019) += vqmmc-ipq4019-regulator.o
diff --git a/drivers/regulator/renesas-usb-vbus-regulator.c b/drivers/regulator/renesas-usb-vbus-regulator.c
new file mode 100644
index 000000000000..4eceb6b54497
--- /dev/null
+++ b/drivers/regulator/renesas-usb-vbus-regulator.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas USB VBUS output regulator driver
+//
+// Copyright (C) 2024 Renesas Electronics Corporation
+//
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+
+static const struct regulator_ops rzg2l_usb_vbus_reg_ops = {
+	.enable     = regulator_enable_regmap,
+	.disable    = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const struct regulator_desc rzg2l_usb_vbus_rdesc = {
+	.name = "vbus",
+	.of_match = of_match_ptr("regulator-vbus"),
+	.ops = &rzg2l_usb_vbus_reg_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.enable_reg  = 0,
+	.enable_mask = BIT(0),
+	.enable_is_inverted = true,
+	.fixed_uV	= 5000000,
+	.n_voltages	= 1,
+};
+
+static int rzg2l_usb_vbus_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = { };
+	struct device *dev = &pdev->dev;
+	struct regulator_dev *rdev;
+
+	config.regmap = dev_get_regmap(dev->parent, NULL);
+	if (!config.regmap)
+		return dev_err_probe(dev, -ENOENT, "Failed to get regmap\n");
+
+	config.dev = dev;
+	config.of_node = of_get_child_by_name(dev->parent->of_node, "regulator-vbus");
+	if (!config.of_node)
+		return dev_err_probe(dev, -ENODEV, "regulator node not found\n");
+
+	rdev = devm_regulator_register(dev, &rzg2l_usb_vbus_rdesc, &config);
+	if (IS_ERR(rdev)) {
+		of_node_put(config.of_node);
+		return dev_err_probe(dev, PTR_ERR(rdev),
+				     "not able to register vbus regulator\n");
+	}
+
+	of_node_put(config.of_node);
+
+	return 0;
+}
+
+static struct platform_driver rzg2l_usb_vbus_regulator_driver = {
+	.probe = rzg2l_usb_vbus_regulator_probe,
+	.driver	= {
+		.name = "rzg2l-usb-vbus-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_platform_driver(rzg2l_usb_vbus_regulator_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L USB Vbus Regulator Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


