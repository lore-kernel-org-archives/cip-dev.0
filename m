From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:39 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 05/22] watchdog: renesas_wdt: Use 'dev'
	instead of dereferencing it repeatedly
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

commit b7fbd3e55c0f842551445d6dbe3dd92ab155b2e8 upstream.

Add helper variable dev = &pdev->dev

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
[fab: backported to 4.19.y-cip]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index c6ce244..450e517 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -178,16 +178,17 @@ static inline bool rwdt_blacklisted(struct device *dev) { return false; }
 
 static int rwdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct rwdt_priv *priv;
 	struct resource *res;
 	struct clk *clk;
 	unsigned long clks_per_sec;
 	int ret, i;
 
-	if (rwdt_blacklisted(&pdev->dev))
+	if (rwdt_blacklisted(dev))
 		return -ENODEV;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -196,16 +197,16 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 	priv->clk_rate = clk_get_rate(clk);
 	priv->wdev.bootstatus = (readb_relaxed(priv->base + RWTCSRA) &
 				RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 
 	if (!priv->clk_rate) {
 		ret = -ENOENT;
@@ -221,14 +222,14 @@ static int rwdt_probe(struct platform_device *pdev)
 	}
 
 	if (i < 0) {
-		dev_err(&pdev->dev, "Can't find suitable clock divider\n");
+		dev_err(dev, "Can't find suitable clock divider\n");
 		ret = -ERANGE;
 		goto out_pm_disable;
 	}
 
 	priv->wdev.info = &rwdt_ident;
 	priv->wdev.ops = &rwdt_ops;
-	priv->wdev.parent = &pdev->dev;
+	priv->wdev.parent = dev;
 	priv->wdev.min_timeout = 1;
 	priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
 	priv->wdev.timeout = min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
@@ -240,9 +241,9 @@ static int rwdt_probe(struct platform_device *pdev)
 	watchdog_stop_on_unregister(&priv->wdev);
 
 	/* This overrides the default timeout only if DT configuration was found */
-	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
+	ret = watchdog_init_timeout(&priv->wdev, 0, dev);
 	if (ret)
-		dev_warn(&pdev->dev, "Specified timeout value invalid, using default\n");
+		dev_warn(dev, "Specified timeout value invalid, using default\n");
 
 	ret = watchdog_register_device(&priv->wdev);
 	if (ret < 0)
@@ -251,7 +252,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	return 0;
 
  out_pm_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	return ret;
 }
 
-- 
2.7.4
