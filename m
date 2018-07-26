From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:36 +0100
Subject: [cip-dev] [PATCH 18/42] watchdog: renesas_wdt: apply better
	precision
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-19-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The error margin of the clks_per_second variable was too large and
caused offsets when used with clock frequencies which left a remainder
after applying the dividers. Now we always calculate directly using the
clock rate and the divider using some helper macros. That also means
that DIV_ROUND_UP moves from probe to the multiplication macro. In
probe, we don't need to ensure anymore that 'clks_per_sec' would go too
fast but rather ensure that the lower limit is really at least 1 to
certainly get a full cycle.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit 82f64cd20848511f516bd28147a6432497dfb080)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 64f68d1..454a2fc 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -26,6 +26,17 @@
 
 #define RWDT_DEFAULT_TIMEOUT 60U
 
+/*
+ * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
+ * divider (10 bits). d is only a factor to fully utilize the WDT counter and
+ * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
+ */
+#define MUL_BY_CLKS_PER_SEC(p, d) \
+	DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
+
+/* d is 16 bit, clk_divs 10 bit -> no 32 bit overflow */
+#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
+
 static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -37,7 +48,7 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	struct clk *clk;
-	unsigned long clks_per_sec;
+	unsigned long clk_rate;
 	u8 cks;
 };
 
@@ -56,7 +67,7 @@ static int rwdt_set_timeout(struct watchdog_device *wdev, unsigned int seconds)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	wdev->timeout = seconds;
-	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
+	rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, wdev->timeout), RWTCNT);
 
 	return 0;
 }
@@ -98,7 +109,7 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 	u16 val = readw_relaxed(priv->base + RWTCNT);
 
-	return (65536 - val) / priv->clks_per_sec;
+	return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
 }
 
 static const struct watchdog_info rwdt_ident = {
@@ -119,7 +130,7 @@ static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
 	struct resource *res;
-	unsigned long rate, clks_per_sec;
+	unsigned long clks_per_sec;
 	int ret, i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -135,14 +146,13 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	rate = clk_get_rate(priv->clk);
-	if (!rate)
+	priv->clk_rate = clk_get_rate(priv->clk);
+	if (!priv->clk_rate)
 		return -ENOENT;
 
 	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
-		clks_per_sec = DIV_ROUND_UP(rate, clk_divs[i]);
+		clks_per_sec = priv->clk_rate / clk_divs[i];
 		if (clks_per_sec && clks_per_sec < 65536) {
-			priv->clks_per_sec = clks_per_sec;
 			priv->cks = i;
 			break;
 		}
@@ -160,7 +170,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	priv->wdev.ops = &rwdt_ops,
 	priv->wdev.parent = &pdev->dev;
 	priv->wdev.min_timeout = 1;
-	priv->wdev.max_timeout = 65536 / clks_per_sec;
+	priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
 	priv->wdev.timeout = min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
 
 	platform_set_drvdata(pdev, priv);
-- 
2.7.4
