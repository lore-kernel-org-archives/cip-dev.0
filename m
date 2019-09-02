From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:40 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 06/22] watchdog: renesas_wdt: Add a few
	cycles delay
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit b836005b4f95cccdc1f53849a31cac2dc375f4b7 upstream.

According to the hardware manual of R-Car Gen2 and Gen3,
software should wait a few RLCK cycles as following:
 - Delay 2 cycles before setting watchdog counter.
 - Delay 3 cycles before disabling module clock.

So, this patch adds such delays.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 450e517..2496397 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -10,6 +10,7 @@
  */
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -73,6 +74,15 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
 	return 0;
 }
 
+static void rwdt_wait_cycles(struct rwdt_priv *priv, unsigned int cycles)
+{
+	unsigned int delay;
+
+	delay = DIV_ROUND_UP(cycles * 1000000, priv->clk_rate);
+
+	usleep_range(delay, 2 * delay);
+}
+
 static int rwdt_start(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
@@ -83,6 +93,8 @@ static int rwdt_start(struct watchdog_device *wdev)
 	/* Stop the timer before we modify any register */
 	val = readb_relaxed(priv->base + RWTCSRA) & ~RWTCSRA_TME;
 	rwdt_write(priv, val, RWTCSRA);
+	/* Delay 2 cycles before setting watchdog counter */
+	rwdt_wait_cycles(priv, 2);
 
 	rwdt_init_timeout(wdev);
 	rwdt_write(priv, priv->cks, RWTCSRA);
@@ -101,6 +113,8 @@ static int rwdt_stop(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	rwdt_write(priv, priv->cks, RWTCSRA);
+	/* Delay 3 cycles before disabling module clock */
+	rwdt_wait_cycles(priv, 3);
 	pm_runtime_put(wdev->parent);
 
 	return 0;
-- 
2.7.4
