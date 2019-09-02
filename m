From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:37 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 03/22] watchdog: renesas_wdt: don't
	keep timer value during suspend/resume
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 9077123c68074619177c9a8d3adce2527bd94179 upstream.

After discussing this mail thread [1] again, we concluded that giving
userspace enough time to prepare is our favourite option. So, do not
keep the time value when suspended but reset it when resuming.

[1] https://patchwork.kernel.org/patch/10252209/

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 777c5a1..a579a23 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -51,7 +51,6 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	unsigned long clk_rate;
-	u16 time_left;
 	u8 cks;
 };
 
@@ -271,10 +270,9 @@ static int __maybe_unused rwdt_suspend(struct device *dev)
 {
 	struct rwdt_priv *priv = dev_get_drvdata(dev);
 
-	if (watchdog_active(&priv->wdev)) {
-		priv->time_left = readw(priv->base + RWTCNT);
+	if (watchdog_active(&priv->wdev))
 		rwdt_stop(&priv->wdev);
-	}
+
 	return 0;
 }
 
@@ -282,10 +280,9 @@ static int __maybe_unused rwdt_resume(struct device *dev)
 {
 	struct rwdt_priv *priv = dev_get_drvdata(dev);
 
-	if (watchdog_active(&priv->wdev)) {
+	if (watchdog_active(&priv->wdev))
 		rwdt_start(&priv->wdev);
-		rwdt_write(priv, priv->time_left, RWTCNT);
-	}
+
 	return 0;
 }
 
-- 
2.7.4
