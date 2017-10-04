From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Wed,  4 Oct 2017 16:41:04 +0200
Subject: [cip-dev] [PATCH 10/10] watchdog: core: add option to avoid early
	handling of watchdog
In-Reply-To: <20171004144104.14403-1-mosipov@ilbers.de>
References: <20171004144104.14403-1-mosipov@ilbers.de>
Message-ID: <20171004144104.14403-11-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Backport from kernel.org, upstream commit 2501b015313f

On some systems its desirable to have watchdog reboot the system
when it does not come up fast enough. This adds a kernel parameter
to disable the auto-update of watchdog before userspace takes over
and a kernel option to set the default. The info messages were
added to shorten error searching on misconfigured systems.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[mosipov at ilbers.de backported to 4.4.y]
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 drivers/watchdog/Kconfig        | 11 +++++++++++
 drivers/watchdog/watchdog_dev.c | 21 +++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1c427beffadd..88743cd0a7e6 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -46,6 +46,17 @@ config WATCHDOG_NOWAYOUT
 	  get killed. If you say Y here, the watchdog cannot be stopped once
 	  it has been started.
 
+config WATCHDOG_HANDLE_BOOT_ENABLED
+	bool "Update boot-enabled watchdog until userspace takes over"
+	default y
+	help
+	  The default watchdog behaviour (which you get if you say Y here) is
+	  to ping watchdog devices that were enabled before the driver has
+	  been loaded until control is taken over from userspace using the
+	  /dev/watchdog file. If you say N here, the kernel will not update
+	  the watchdog on its own. Thus if your userspace does not start fast
+	  enough your device will reboot.
+
 #
 # General Watchdog drivers
 #
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e65a14f213ff..28eaed17c4fe 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -53,6 +53,9 @@ static struct watchdog_device *old_wdd;
 
 static struct workqueue_struct *watchdog_wq;
 
+static bool handle_boot_enabled =
+	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
+
 static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 {
 	/* All variables in milli-seconds */
@@ -685,10 +688,15 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 	 * and schedule an immediate ping.
 	 */
 	if (watchdog_hw_running(wdd)) {
-		__module_get(wdd->ops->owner);
-		if (wdd->ops->ref)
-			wdd->ops->ref(wdd);
-		queue_delayed_work(watchdog_wq, &wdd->work, 0);
+		if (handle_boot_enabled) {
+			__module_get(wdd->ops->owner);
+			if (wdd->ops->ref)
+				wdd->ops->ref(wdd);
+			queue_delayed_work(watchdog_wq, &wdd->work, 0);
+		} else {
+			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
+					wdd->id);
+		}
 	}
 
 	return 0;
@@ -758,3 +766,8 @@ void __exit watchdog_dev_exit(void)
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
 	destroy_workqueue(watchdog_wq);
 }
+
+module_param(handle_boot_enabled, bool, 0444);
+MODULE_PARM_DESC(handle_boot_enabled,
+	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
+	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
-- 
2.11.0
