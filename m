From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:38 +0100
Subject: [cip-dev] [PATCH 20/42] watchdog: renesas_wdt: consistently use
	RuntimePM for clock management
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-21-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

On Renesas R-Car archs, RuntimePM does all the clock handling. So, use
it consistently to enable/disable the clocks. Also make sure that clocks
are really enabled around clk_get_rate(). clk_summary looks proper now:

		clock	enable_cnt	prepare_cnt	rate ...
Before this commit:

At boot:	rwdt	1		1		32768 0 0
WDT running:	rwdt	2		2		32768 0 0

After this commit:

At boot:	rwdt	0		1		32768 0 0
WDT running	rwdt	1		1		32768 0 0

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit 3be42941dd9df9b7c5062fc98c416a15bf4bbc0f)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 1891a0e..834cff0 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -82,7 +82,7 @@ static int rwdt_start(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	clk_prepare_enable(priv->clk);
+	pm_runtime_get_sync(wdev->parent);
 
 	rwdt_write(priv, 0, RWTCSRB);
 	rwdt_write(priv, priv->cks, RWTCSRA);
@@ -101,7 +101,7 @@ static int rwdt_stop(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	rwdt_write(priv, priv->cks, RWTCSRA);
-	clk_disable_unprepare(priv->clk);
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
@@ -148,9 +148,16 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	pm_runtime_enable(&pdev->dev);
+
+	pm_runtime_get_sync(&pdev->dev);
 	priv->clk_rate = clk_get_rate(priv->clk);
-	if (!priv->clk_rate)
-		return -ENOENT;
+	pm_runtime_put(&pdev->dev);
+
+	if (!priv->clk_rate) {
+		ret = -ENOENT;
+		goto out_pm_disable;
+	}
 
 	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
 		clks_per_sec = priv->clk_rate / clk_divs[i];
@@ -162,12 +169,10 @@ static int rwdt_probe(struct platform_device *pdev)
 
 	if (i < 0) {
 		dev_err(&pdev->dev, "Can't find suitable clock divider\n");
-		return -ERANGE;
+		ret = -ERANGE;
+		goto out_pm_disable;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-
 	priv->wdev.info = &rwdt_ident,
 	priv->wdev.ops = &rwdt_ops,
 	priv->wdev.parent = &pdev->dev;
@@ -185,13 +190,14 @@ static int rwdt_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Specified timeout value invalid, using default\n");
 
 	ret = watchdog_register_device(&priv->wdev);
-	if (ret < 0) {
-		pm_runtime_put(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_pm_disable;
 
 	return 0;
+
+ out_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int rwdt_remove(struct platform_device *pdev)
@@ -199,7 +205,6 @@ static int rwdt_remove(struct platform_device *pdev)
 	struct rwdt_priv *priv = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&priv->wdev);
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.7.4
