From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Fri, 10 Nov 2017 13:09:58 +0100
Subject: [cip-dev] [PATCH 04/10] watchdog: imx2: Convert to use
	infrastructure triggered keepalives
In-Reply-To: <20171110121004.17775-1-mosipov@ilbers.de>
References: <20171110121004.17775-1-mosipov@ilbers.de>
Message-ID: <20171110121004.17775-5-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Guenter Roeck <linux@roeck-us.net>

commit 11d7aba9ceb726d86aaaca3eb5f7d79de38989c5 upstream.

The watchdog infrastructure now supports handling watchdog keepalive
if the watchdog is running while the watchdog device is closed.
Convert the driver to use this infrastructure.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[mosipov at ilbers.de backported to 4.4.y]
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 drivers/watchdog/imx2_wdt.c | 74 ++++++++-------------------------------------
 1 file changed, 13 insertions(+), 61 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 29ef719a6a3c..378e7c5dfc50 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -34,7 +33,6 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
-#include <linux/timer.h>
 #include <linux/watchdog.h>
 
 #define DRIVER_NAME "imx2-wdt"
@@ -62,7 +60,6 @@
 struct imx2_wdt_device {
 	struct clk *clk;
 	struct regmap *regmap;
-	struct timer_list timer;	/* Pings the watchdog when closed */
 	struct watchdog_device wdog;
 	struct notifier_block restart_handler;
 };
@@ -151,16 +148,6 @@ static int imx2_wdt_ping(struct watchdog_device *wdog)
 	return 0;
 }
 
-static void imx2_wdt_timer_ping(unsigned long arg)
-{
-	struct watchdog_device *wdog = (struct watchdog_device *)arg;
-	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
-
-	/* ping it every wdog->timeout / 2 seconds to prevent reboot */
-	imx2_wdt_ping(wdog);
-	mod_timer(&wdev->timer, jiffies + wdog->timeout * HZ / 2);
-}
-
 static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int new_timeout)
 {
@@ -177,40 +164,19 @@ static int imx2_wdt_start(struct watchdog_device *wdog)
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
-	if (imx2_wdt_is_running(wdev)) {
-		/* delete the timer that pings the watchdog after close */
-		del_timer_sync(&wdev->timer);
+	if (imx2_wdt_is_running(wdev))
 		imx2_wdt_set_timeout(wdog, wdog->timeout);
-	} else
+	else
 		imx2_wdt_setup(wdog);
 
-	return imx2_wdt_ping(wdog);
-}
-
-static int imx2_wdt_stop(struct watchdog_device *wdog)
-{
-	/*
-	 * We don't need a clk_disable, it cannot be disabled once started.
-	 * We use a timer to ping the watchdog while /dev/watchdog is closed
-	 */
-	imx2_wdt_timer_ping((unsigned long)wdog);
-	return 0;
-}
-
-static inline void imx2_wdt_ping_if_active(struct watchdog_device *wdog)
-{
-	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
+	set_bit(WDOG_HW_RUNNING, &wdog->status);
 
-	if (imx2_wdt_is_running(wdev)) {
-		imx2_wdt_set_timeout(wdog, wdog->timeout);
-		imx2_wdt_timer_ping((unsigned long)wdog);
-	}
+	return imx2_wdt_ping(wdog);
 }
 
 static const struct watchdog_ops imx2_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = imx2_wdt_start,
-	.stop = imx2_wdt_stop,
 	.ping = imx2_wdt_ping,
 	.set_timeout = imx2_wdt_set_timeout,
 };
@@ -257,7 +223,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	wdog->info		= &imx2_wdt_info;
 	wdog->ops		= &imx2_wdt_ops;
 	wdog->min_timeout	= 1;
-	wdog->max_timeout	= IMX2_WDT_MAX_TIME;
+	wdog->max_hw_heartbeat_ms = IMX2_WDT_MAX_TIME * 1000;
 	wdog->parent		= &pdev->dev;
 
 	ret = clk_prepare_enable(wdev->clk);
@@ -277,9 +243,10 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(wdog, nowayout);
 	watchdog_init_timeout(wdog, timeout, &pdev->dev);
 
-	setup_timer(&wdev->timer, imx2_wdt_timer_ping, (unsigned long)wdog);
-
-	imx2_wdt_ping_if_active(wdog);
+	if (imx2_wdt_is_running(wdev)) {
+		imx2_wdt_set_timeout(wdog, wdog->timeout);
+		set_bit(WDOG_HW_RUNNING, &wdog->status);
+	}
 
 	/*
 	 * Disable the watchdog power down counter at boot. Otherwise the power
@@ -320,7 +287,6 @@ static int __exit imx2_wdt_remove(struct platform_device *pdev)
 	watchdog_unregister_device(wdog);
 
 	if (imx2_wdt_is_running(wdev)) {
-		del_timer_sync(&wdev->timer);
 		imx2_wdt_ping(wdog);
 		dev_crit(&pdev->dev, "Device removed: Expect reboot!\n");
 	}
@@ -334,10 +300,9 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
 
 	if (imx2_wdt_is_running(wdev)) {
 		/*
-		 * We are running, we need to delete the timer but will
-		 * give max timeout before reboot will take place
+		 * We are running, configure max timeout before reboot
+		 * will take place.
 		 */
-		del_timer_sync(&wdev->timer);
 		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
 		imx2_wdt_ping(wdog);
 		dev_crit(&pdev->dev, "Device shutdown: Expect reboot!\n");
@@ -355,10 +320,6 @@ static int imx2_wdt_suspend(struct device *dev)
 	if (imx2_wdt_is_running(wdev)) {
 		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
 		imx2_wdt_ping(wdog);
-
-		/* The watchdog is not active */
-		if (!watchdog_active(wdog))
-			del_timer_sync(&wdev->timer);
 	}
 
 	clk_disable_unprepare(wdev->clk);
@@ -384,19 +345,10 @@ static int imx2_wdt_resume(struct device *dev)
 		 * watchdog again.
 		 */
 		imx2_wdt_setup(wdog);
+	}
+	if (imx2_wdt_is_running(wdev)) {
 		imx2_wdt_set_timeout(wdog, wdog->timeout);
 		imx2_wdt_ping(wdog);
-	} else if (imx2_wdt_is_running(wdev)) {
-		/* Resuming from non-deep sleep state. */
-		imx2_wdt_set_timeout(wdog, wdog->timeout);
-		imx2_wdt_ping(wdog);
-		/*
-		 * But the watchdog is not active, then start
-		 * the timer again.
-		 */
-		if (!watchdog_active(wdog))
-			mod_timer(&wdev->timer,
-				  jiffies + wdog->timeout * HZ / 2);
 	}
 
 	return 0;
-- 
2.11.0
