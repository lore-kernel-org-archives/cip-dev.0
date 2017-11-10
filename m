From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Fri, 10 Nov 2017 13:09:56 +0100
Subject: [cip-dev] [PATCH 02/10] watchdog: Introduce WDOG_HW_RUNNING flag
In-Reply-To: <20171110121004.17775-1-mosipov@ilbers.de>
References: <20171110121004.17775-1-mosipov@ilbers.de>
Message-ID: <20171110121004.17775-3-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Guenter Roeck <linux@roeck-us.net>

commit ee142889e32f564f9b5e57b68b06693ec5473074 upstream.

The WDOG_HW_RUNNING flag is expected to be set by watchdog drivers if
the hardware watchdog is running. If the flag is set, the watchdog
subsystem will ping the watchdog even if the watchdog device is closed.

The watchdog driver stop function is now optional and may be omitted
if the watchdog can not be stopped. If stopping the watchdog is not
possible but the driver implements a stop function, it is responsible
to set the WDOG_HW_RUNNING flag in its stop function.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[mosipov at ilbers.de backported to 4.4.y]
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 22 ++++++++----
 drivers/watchdog/watchdog_dev.c                | 47 ++++++++++++++++++++------
 include/linux/watchdog.h                       | 10 ++++++
 3 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 9887fa6d8f68..b12789745f86 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -144,10 +144,10 @@ are:
 * stop: with this routine the watchdog timer device is being stopped.
   The routine needs a pointer to the watchdog timer device structure as a
   parameter. It returns zero on success or a negative errno code for failure.
-  Some watchdog timer hardware can only be started and not be stopped. The
-  driver supporting this hardware needs to make sure that a start and stop
-  routine is being provided. This can be done by using a timer in the driver
-  that regularly sends a keepalive ping to the watchdog timer hardware.
+  Some watchdog timer hardware can only be started and not be stopped.
+  If a watchdog can not be stopped, the watchdog driver must set the
+  WDOG_HW_RUNNING flag in its stop function to inform the watchdog core that
+  the watchdog is still running.
 
 Not all watchdog timer hardware supports the same functionality. That's why
 all other routines/operations are optional. They only need to be provided if
@@ -191,9 +191,8 @@ they are supported. These optional routines/operations are:
 The status bits should (preferably) be set with the set_bit and clear_bit alike
 bit-operations. The status bits that are defined are:
 * WDOG_ACTIVE: this status bit indicates whether or not a watchdog timer device
-  is active or not. When the watchdog is active after booting, then you should
-  set this status bit (Note: when you register the watchdog timer device with
-  this bit set, then opening /dev/watchdog will skip the start operation)
+  is active or not from user perspective. User space is expected to send
+  heartbeat requests to the driver while this flag is set.
 * WDOG_DEV_OPEN: this status bit shows whether or not the watchdog device
   was opened via /dev/watchdog.
   (This bit should only be used by the WatchDog Timer Driver Core).
@@ -202,6 +201,15 @@ bit-operations. The status bits that are defined are:
   (This bit should only be used by the WatchDog Timer Driver Core).
 * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the watchdog.
   If this bit is set then the watchdog timer will not be able to stop.
+* WDOG_HW_RUNNING: Set by the watchdog driver if the hardware watchdog is
+  running. The bit must be set if the watchdog timer hardware can not be
+  stopped. The bit may also be set if the watchdog timer is running after
+  booting, before the watchdog device is opened. If set, the watchdog
+  infrastructure will send keepalives to the watchdog hardware while
+  WDOG_ACTIVE is not set.
+  Note: when you register the watchdog timer device with this bit set,
+  then opening /dev/watchdog will skip the start operation but send a keepalive
+  request instead.
 * WDOG_UNREGISTERED: this bit gets set by the WatchDog Timer Driver Core
   after calling watchdog_unregister_device, and then checked before calling
   any watchdog_ops, so that you can be sure that no operations (other then
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index df43c586e53f..f38d4abf5ede 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -68,7 +68,8 @@ static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 	 *   requests.
 	 * - Userspace requests a longer timeout than the hardware can handle.
 	 */
-	return watchdog_active(wdd) && hm && t > hm;
+	return hm && ((watchdog_active(wdd) && t > hm) ||
+		      (t && !watchdog_active(wdd) && watchdog_hw_running(wdd)));
 }
 
 static long watchdog_next_keepalive(struct watchdog_device *wdd)
@@ -83,6 +84,9 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
 	hw_heartbeat_ms = min(timeout_ms, wdd->max_hw_heartbeat_ms);
 	keepalive_interval = msecs_to_jiffies(hw_heartbeat_ms / 2);
 
+	if (!watchdog_active(wdd))
+		return keepalive_interval;
+
 	/*
 	 * To ensure that the watchdog times out wdd->timeout seconds
 	 * after the most recent ping from userspace, the last
@@ -139,7 +143,7 @@ static int watchdog_ping(struct watchdog_device *wdd)
 		goto out_ping;
 	}
 
-	if (!watchdog_active(wdd))
+	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
 		goto out_ping;
 
 	wdd->last_keepalive = jiffies;
@@ -158,7 +162,7 @@ static void watchdog_ping_work(struct work_struct *work)
 			       work);
 
 	mutex_lock(&wdd->lock);
-	if (wdd && watchdog_active(wdd))
+	if (wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd)))
 		__watchdog_ping(wdd);
 	mutex_unlock(&wdd->lock);
 }
@@ -188,7 +192,10 @@ static int watchdog_start(struct watchdog_device *wdd)
 		goto out_start;
 
 	started_at = jiffies;
-	err = wdd->ops->start(wdd);
+	if (watchdog_hw_running(wdd) && wdd->ops->ping)
+		err = wdd->ops->ping(wdd);
+	else
+		err = wdd->ops->start(wdd);
 	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
 		wdd->last_keepalive = started_at;
@@ -233,7 +240,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 	err = wdd->ops->stop(wdd);
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
-		cancel_delayed_work(&wdd->work);
+		watchdog_update_worker(wdd);
 	}
 
 out_stop:
@@ -519,7 +526,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!try_module_get(wdd->ops->owner))
+	if (!watchdog_hw_running(wdd) && !try_module_get(wdd->ops->owner))
 		goto out;
 
 	err = watchdog_start(wdd);
@@ -528,7 +535,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 
 	file->private_data = wdd;
 
-	if (wdd->ops->ref)
+	if (!watchdog_hw_running(wdd) && wdd->ops->ref)
 		wdd->ops->ref(wdd);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
@@ -577,15 +584,22 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	}
 
 	/* Allow the owner module to be unloaded again */
-	module_put(wdd->ops->owner);
+	/*
+	 * Allow the owner module to be unloaded again unless the watchdog
+	 * is still running. If the watchdog is still running, it can not
+	 * be stopped, and its driver must not be unloaded.
+	 */
+	if (!watchdog_hw_running(wdd))
+		module_put(wdd->ops->owner);
 
 	cancel_delayed_work_sync(&wdd->work);
+	watchdog_update_worker(wdd);
 
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(WDOG_DEV_OPEN, &wdd->status);
 
 	/* Note wdd may be gone after this, do not use after this! */
-	if (wdd->ops->unref)
+	if (!watchdog_hw_running(wdd) && wdd->ops->unref)
 		wdd->ops->unref(wdd);
 
 	return 0;
@@ -652,8 +666,21 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 			misc_deregister(&watchdog_miscdev);
 			old_wdd = NULL;
 		}
+		return err;
 	}
-	return err;
+
+	/*
+	 * If the watchdog is running, prevent its driver from being unloaded,
+	 * and schedule an immediate ping.
+	 */
+	if (watchdog_hw_running(wdd)) {
+		__module_get(wdd->ops->owner);
+		if (wdd->ops->ref)
+			wdd->ops->ref(wdd);
+		queue_delayed_work(watchdog_wq, &wdd->work, 0);
+	}
+
+	return 0;
 }
 
 /*
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 26aba9b17ac3..cbe31d5b352c 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -106,6 +106,7 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+#define WDOG_HW_RUNNING		5	/* True if HW watchdog running */
 	struct list_head deferred;
 };
 
@@ -118,6 +119,15 @@ static inline bool watchdog_active(struct watchdog_device *wdd)
 	return test_bit(WDOG_ACTIVE, &wdd->status);
 }
 
+/*
+ * Use the following function to check whether or not the hardware watchdog
+ * is running
+ */
+static inline bool watchdog_hw_running(struct watchdog_device *wdd)
+{
+	return test_bit(WDOG_HW_RUNNING, &wdd->status);
+}
+
 /* Use the following function to set the nowayout feature */
 static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
 {
-- 
2.11.0
