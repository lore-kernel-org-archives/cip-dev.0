From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:32 +0100
Subject: [cip-dev] [PATCH 14/42] watchdog: renesas-wdt: add driver
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Add support for watchdogs (RWDT and SWDT) found on RCar Gen3 based SoCs
from Renesas.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit bd99b68ed7f96c9c845aad2a25f84145213058f2)
(reworked dt-bindings to refer to R-Car Gen2 and RZ/G1 only.
replaced ARCH_RENESAS with ARCH_SHMOBILE in Kconfig. changes to
the driver:
* replaced "renesas,rcar-gen3-wdt" with "renesas,rcar-gen2-wdt"
* added rwdt_set_timeout
* modified rwdt_ping and rwdt_start to leverage rwdt_set_timeout)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 .../devicetree/bindings/watchdog/renesas-wdt.txt   |  33 ++++
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/renesas_wdt.c                     | 215 +++++++++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
 create mode 100644 drivers/watchdog/renesas_wdt.c

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
new file mode 100644
index 0000000..25b108e
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -0,0 +1,33 @@
+Renesas Watchdog Timer (WDT) Controller
+
+Required properties:
+ - compatible : Must be "renesas,<soctype>-wdt", followed by a generic
+		fallback compatible string when compatible with the generic
+		version.
+	       Examples with soctypes are:
+		 - "renesas,r8a7743-wdt" (RZ/G1M)
+		 - "renesas,r8a7745-wdt" (RZ/G1E)
+		The generic compatible string must be:
+		 - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
+
+  When compatible with the generic version, nodes must list the SoC-specific
+  version corresponding to the platform first, followed by the generic
+  version.
+
+- reg : Should contain WDT registers location and length
+- clocks : the clock feeding the watchdog timer.
+
+Optional properties:
+- timeout-sec : Contains the watchdog timeout in seconds
+- power-domains : the power domain the WDT belongs to
+
+Examples:
+
+	rwdt: watchdog at e6020000 {
+		compatible = "renesas,r8a7743-wdt",
+			     "renesas,rcar-gen2-wdt";
+		reg = <0 0xe6020000 0 0x0c>;
+		clocks = <&mstp4_clks R8A7743_CLK_RWDT>;
+		power-domains = <&cpg_clocks>;
+		timeout-sec = <60>;
+	};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 88743cd..b449065 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -589,6 +589,14 @@ config LPC18XX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called lpc18xx_wdt.
 
+config RENESAS_WDT
+	tristate "Renesas WDT Watchdog"
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This driver adds watchdog support for the integrated watchdogs in the
+	  Renesas R-Car and other SH-Mobile SoCs (usually named RWDT or SWDT).
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 53d4827..e1c5d85 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
+obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
new file mode 100644
index 0000000..ab3e9b0
--- /dev/null
+++ b/drivers/watchdog/renesas_wdt.c
@@ -0,0 +1,215 @@
+/*
+ * Watchdog driver for Renesas WDT watchdog
+ *
+ * Copyright (C) 2015-16 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015-16 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/watchdog.h>
+
+#define RWTCNT		0
+#define RWTCSRA		4
+#define RWTCSRA_WOVF	BIT(4)
+#define RWTCSRA_WRFLG	BIT(5)
+#define RWTCSRA_TME	BIT(7)
+
+#define RWDT_DEFAULT_TIMEOUT 60U
+
+static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct rwdt_priv {
+	void __iomem *base;
+	struct watchdog_device wdev;
+	struct clk *clk;
+	unsigned int clks_per_sec;
+	u8 cks;
+};
+
+static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned int reg)
+{
+	if (reg == RWTCNT)
+		val |= 0x5a5a0000;
+	else
+		val |= 0xa5a5a500;
+
+	writel_relaxed(val, priv->base + reg);
+}
+
+static int rwdt_set_timeout(struct watchdog_device *wdev, unsigned int seconds)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	wdev->timeout = seconds;
+	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
+
+	return 0;
+}
+
+static int rwdt_ping(struct watchdog_device *wdev)
+{
+	return rwdt_set_timeout(wdev, wdev->timeout);
+}
+
+static int rwdt_start(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	clk_prepare_enable(priv->clk);
+
+	rwdt_write(priv, priv->cks, RWTCSRA);
+	rwdt_set_timeout(wdev, wdev->timeout);
+
+	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
+		cpu_relax();
+
+	rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
+
+	return 0;
+}
+
+static int rwdt_stop(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	rwdt_write(priv, priv->cks, RWTCSRA);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+	u16 val = readw_relaxed(priv->base + RWTCNT);
+
+	return DIV_ROUND_CLOSEST(65536 - val, priv->clks_per_sec);
+}
+
+static const struct watchdog_info rwdt_ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.identity = "Renesas WDT Watchdog",
+};
+
+static const struct watchdog_ops rwdt_ops = {
+	.owner = THIS_MODULE,
+	.start = rwdt_start,
+	.stop = rwdt_stop,
+	.ping = rwdt_ping,
+	.get_timeleft = rwdt_get_timeleft,
+	.set_timeout = rwdt_set_timeout,
+};
+
+static int rwdt_probe(struct platform_device *pdev)
+{
+	struct rwdt_priv *priv;
+	struct resource *res;
+	unsigned long rate;
+	unsigned int clks_per_sec;
+	int ret, i;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -ENOENT;
+
+	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
+		clks_per_sec = DIV_ROUND_UP(rate, clk_divs[i]);
+		if (clks_per_sec) {
+			priv->clks_per_sec = clks_per_sec;
+			priv->cks = i;
+			break;
+		}
+	}
+
+	if (!clks_per_sec) {
+		dev_err(&pdev->dev, "Can't find suitable clock divider\n");
+		return -ERANGE;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	priv->wdev.info = &rwdt_ident,
+	priv->wdev.ops = &rwdt_ops,
+	priv->wdev.parent = &pdev->dev;
+	priv->wdev.min_timeout = 1;
+	priv->wdev.max_timeout = 65536 / clks_per_sec;
+	priv->wdev.timeout = min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
+
+	platform_set_drvdata(pdev, priv);
+	watchdog_set_drvdata(&priv->wdev, priv);
+	watchdog_set_nowayout(&priv->wdev, nowayout);
+
+	/* This overrides the default timeout only if DT configuration was found */
+	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
+	if (ret)
+		dev_warn(&pdev->dev, "Specified timeout value invalid, using default\n");
+
+	ret = watchdog_register_device(&priv->wdev);
+	if (ret < 0) {
+		pm_runtime_put(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rwdt_remove(struct platform_device *pdev)
+{
+	struct rwdt_priv *priv = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&priv->wdev);
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id rwdt_ids[] = {
+	{ .compatible = "renesas,rcar-gen2-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rwdt_ids);
+
+static struct platform_driver rwdt_driver = {
+	.driver = {
+		.name = "renesas_wdt",
+		.of_match_table = rwdt_ids,
+	},
+	.probe = rwdt_probe,
+	.remove = rwdt_remove,
+};
+module_platform_driver(rwdt_driver);
+
+MODULE_DESCRIPTION("Renesas WDT Watchdog Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wolfram Sang <wsa@sang-engineering.com>");
-- 
2.7.4
