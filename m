From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:41 +0100
Subject: [cip-dev] [PATCH 23/42] watchdog: renesas_wdt: Add suspend/resume
	support
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-24-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On R-Car Gen2 and RZ/G1 the watchdog IP clock needs to be always ON,
on R-Car Gen3 we power the IP down during suspend.

This commit adds suspend/resume support, so that the watchdog counting
"pauses" during suspend on all of the SoCs compatible with this driver
and on those we are now adding support for (R-Car Gen2 and RZ/G1).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit 07278ca1ccc9a1241f14a8aaa4f2430b7b217c3f)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index be1e39b..87f3e57 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -49,6 +49,7 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	unsigned long clk_rate;
+	u16 time_left;
 	u8 cks;
 };
 
@@ -210,6 +211,30 @@ static int rwdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused rwdt_suspend(struct device *dev)
+{
+	struct rwdt_priv *priv = dev_get_drvdata(dev);
+
+	if (watchdog_active(&priv->wdev)) {
+		priv->time_left = readw(priv->base + RWTCNT);
+		rwdt_stop(&priv->wdev);
+	}
+	return 0;
+}
+
+static int __maybe_unused rwdt_resume(struct device *dev)
+{
+	struct rwdt_priv *priv = dev_get_drvdata(dev);
+
+	if (watchdog_active(&priv->wdev)) {
+		rwdt_start(&priv->wdev);
+		rwdt_write(priv, priv->time_left, RWTCNT);
+	}
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rwdt_pm_ops, rwdt_suspend, rwdt_resume);
+
 static const struct of_device_id rwdt_ids[] = {
 	{ .compatible = "renesas,rcar-gen2-wdt", },
 	{ /* sentinel */ }
@@ -220,6 +245,7 @@ static struct platform_driver rwdt_driver = {
 	.driver = {
 		.name = "renesas_wdt",
 		.of_match_table = rwdt_ids,
+		.pm = &rwdt_pm_ops,
 	},
 	.probe = rwdt_probe,
 	.remove = rwdt_remove,
-- 
2.7.4
