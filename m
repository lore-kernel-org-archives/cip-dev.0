From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:39 +0100
Subject: [cip-dev] [PATCH 21/42] watchdog: renesas_wdt: make 'clk' a
	variable local to probe()
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-22-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

It is not needed outside probe() anymore.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit 9c22b6d33605d4b24e2491fdb743a285e8588738)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 834cff0..0e4a82e 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -48,7 +48,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
-	struct clk *clk;
 	unsigned long clk_rate;
 	u8 cks;
 };
@@ -132,6 +131,7 @@ static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
 	struct resource *res;
+	struct clk *clk;
 	unsigned long clks_per_sec;
 	int ret, i;
 
@@ -144,14 +144,14 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	pm_runtime_enable(&pdev->dev);
 
 	pm_runtime_get_sync(&pdev->dev);
-	priv->clk_rate = clk_get_rate(priv->clk);
+	priv->clk_rate = clk_get_rate(clk);
 	pm_runtime_put(&pdev->dev);
 
 	if (!priv->clk_rate) {
-- 
2.7.4
