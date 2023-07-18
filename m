Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E70EB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 15:26:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.10729.1689693987594879117
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 08:26:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173423020"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jul 2023 00:26:31 +0900
Received: from mulinux.home (unknown [10.226.93.62])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 15C9F4007143;
	Wed, 19 Jul 2023 00:26:28 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
Date: Tue, 18 Jul 2023 16:26:20 +0100
Message-Id: <20230718152622.327364-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718152622.327364-1-fabrizio.castro.jz@renesas.com>
References: <20230718152622.327364-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 15:26:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12400

Commit 0c56f949f626e59ef7c5b18e2706fed2a6afc4a2 upstream.

The Renesas RZ/V2M External Power Sequence Controller (PWC)
IP is capable of:
* external power supply on/off sequence generation
* on/off signal generation for the LPDDR4 core power supply (LPVDD)
* key input signals processing
* general-purpose output pins

Add the corresponding device driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230106125816.10600-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/soc/renesas/Kconfig     |   4 +
 drivers/soc/renesas/Makefile    |   1 +
 drivers/soc/renesas/pwc-rzv2m.c | 141 ++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 drivers/soc/renesas/pwc-rzv2m.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index f95a1337450d..07465f85a236 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -328,6 +328,7 @@ config ARCH_R9A09G011
 	bool "ARM64 Platform support for RZ/V2M"
 	select PM
 	select PM_GENERIC_DOMAINS
+	select PWC_RZV2M
 	help
 	  This enables support for the Renesas RZ/V2M SoC.
 
@@ -343,6 +344,9 @@ config ARCH_R9A07G043
 
 endif # RISCV
 
+config PWC_RZV2M
+	bool "Renesas RZ/V2M PWC support" if COMPILE_TEST
+
 config RST_RCAR
 	bool "Reset Controller support for R-Car" if COMPILE_TEST
 
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 535868c9c7e4..6e4e77b0afff 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
 
 # Family
+obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
 obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
 obj-$(CONFIG_SYSC_RCAR_GEN4)	+= rcar-gen4-sysc.o
diff --git a/drivers/soc/renesas/pwc-rzv2m.c b/drivers/soc/renesas/pwc-rzv2m.c
new file mode 100644
index 000000000000..c83bdbdabb64
--- /dev/null
+++ b/drivers/soc/renesas/pwc-rzv2m.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+
+#define PWC_PWCRST			0x00
+#define PWC_PWCCKEN			0x04
+#define PWC_PWCCTL			0x50
+#define PWC_GPIO			0x80
+
+#define PWC_PWCRST_RSTSOFTAX		0x1
+#define PWC_PWCCKEN_ENGCKMAIN		0x1
+#define PWC_PWCCTL_PWOFF		0x1
+
+struct rzv2m_pwc_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct gpio_chip gp;
+	DECLARE_BITMAP(ch_en_bits, 2);
+};
+
+static void rzv2m_pwc_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			       int value)
+{
+	struct rzv2m_pwc_priv *priv = gpiochip_get_data(chip);
+	u32 reg;
+
+	/* BIT 16 enables write to BIT 0, and BIT 17 enables write to BIT 1 */
+	reg = BIT(offset + 16);
+	if (value)
+		reg |= BIT(offset);
+
+	writel(reg, priv->base + PWC_GPIO);
+
+	assign_bit(offset, priv->ch_en_bits, value);
+}
+
+static int rzv2m_pwc_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct rzv2m_pwc_priv *priv = gpiochip_get_data(chip);
+
+	return test_bit(offset, priv->ch_en_bits);
+}
+
+static int rzv2m_pwc_gpio_direction_output(struct gpio_chip *gc,
+					   unsigned int nr, int value)
+{
+	if (nr > 1)
+		return -EINVAL;
+
+	rzv2m_pwc_gpio_set(gc, nr, value);
+
+	return 0;
+}
+
+static const struct gpio_chip rzv2m_pwc_gc = {
+	.label = "gpio_rzv2m_pwc",
+	.owner = THIS_MODULE,
+	.get = rzv2m_pwc_gpio_get,
+	.set = rzv2m_pwc_gpio_set,
+	.direction_output = rzv2m_pwc_gpio_direction_output,
+	.can_sleep = false,
+	.ngpio = 2,
+	.base = -1,
+};
+
+static int rzv2m_pwc_poweroff(struct sys_off_data *data)
+{
+	struct rzv2m_pwc_priv *priv = data->cb_data;
+
+	writel(PWC_PWCRST_RSTSOFTAX, priv->base + PWC_PWCRST);
+	writel(PWC_PWCCKEN_ENGCKMAIN, priv->base + PWC_PWCCKEN);
+	writel(PWC_PWCCTL_PWOFF, priv->base + PWC_PWCCTL);
+
+	mdelay(150);
+
+	dev_err(priv->dev, "Failed to power off the system");
+
+	return NOTIFY_DONE;
+}
+
+static int rzv2m_pwc_probe(struct platform_device *pdev)
+{
+	struct rzv2m_pwc_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	/*
+	 * The register used by this driver cannot be read, therefore set the
+	 * outputs to their default values and initialize priv->ch_en_bits
+	 * accordingly. BIT 16 enables write to BIT 0, BIT 17 enables write to
+	 * BIT 1, and the default value of both BIT 0 and BIT 1 is 0.
+	 */
+	writel(BIT(17) | BIT(16), priv->base + PWC_GPIO);
+	bitmap_zero(priv->ch_en_bits, 2);
+
+	priv->gp = rzv2m_pwc_gc;
+	priv->gp.parent = pdev->dev.parent;
+	priv->gp.fwnode = dev_fwnode(&pdev->dev);
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &priv->gp, priv);
+	if (ret)
+		return ret;
+
+	if (device_property_read_bool(&pdev->dev, "renesas,rzv2m-pwc-power"))
+		ret = devm_register_power_off_handler(&pdev->dev,
+						      rzv2m_pwc_poweroff, priv);
+
+	return ret;
+}
+
+static const struct of_device_id rzv2m_pwc_of_match[] = {
+	{ .compatible = "renesas,rzv2m-pwc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2m_pwc_of_match);
+
+static struct platform_driver rzv2m_pwc_driver = {
+	.probe = rzv2m_pwc_probe,
+	.driver = {
+		.name = "rzv2m_pwc",
+		.of_match_table = of_match_ptr(rzv2m_pwc_of_match),
+	},
+};
+module_platform_driver(rzv2m_pwc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M PWC driver");
-- 
2.34.1


