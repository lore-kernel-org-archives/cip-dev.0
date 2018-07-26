From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:42 +0100
Subject: [cip-dev] [PATCH 24/42] watchdog: renesas_wdt: Add restart handler
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-25-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On iWave's boards iwg20d and iwg22d the only way to reboot the system is
by means of the watchdog.
This patch adds a restart handler to rwdt_ops, and also makes sure we
keep its priority to the lowest level, in order to not override other
more effective handlers.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit 089bcaa87e772beb005068a5ef28c71bb895d01d)
(changed restart handler implementation as .restart is not available
from struct watchdog_ops)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 87f3e57..88b9c7d 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -17,6 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/watchdog.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #define RWTCNT		0
 #define RWTCSRA		4
@@ -51,6 +53,7 @@ struct rwdt_priv {
 	unsigned long clk_rate;
 	u16 time_left;
 	u8 cks;
+	struct notifier_block restart_handler;
 };
 
 static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned int reg)
@@ -114,6 +117,18 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
 	return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
 }
 
+static int rwdt_restart(struct notifier_block *this, unsigned long mode,
+			void *cmd)
+{
+	struct rwdt_priv *priv = container_of(this, struct rwdt_priv,
+					      restart_handler);
+
+	rwdt_start(&priv->wdev);
+	rwdt_write(priv, 0xffff, RWTCNT);
+
+	return NOTIFY_DONE;
+}
+
 static const struct watchdog_info rwdt_ident = {
 	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
 	.identity = "Renesas WDT Watchdog",
@@ -194,6 +209,15 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_pm_disable;
 
+	priv->restart_handler.notifier_call = rwdt_restart;
+	priv->restart_handler.priority = 0;
+	ret = register_restart_handler(&priv->restart_handler);
+	if (ret) {
+		dev_err(&pdev->dev, "can't register restart handler (err=%d)\n",
+			ret);
+		priv->restart_handler.notifier_call = NULL;
+	}
+
 	return 0;
 
  out_pm_disable:
@@ -205,6 +229,8 @@ static int rwdt_remove(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv = platform_get_drvdata(pdev);
 
+	if (priv->restart_handler.notifier_call);
+		unregister_restart_handler(&priv->restart_handler);
 	watchdog_unregister_device(&priv->wdev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.7.4
