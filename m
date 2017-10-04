From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Wed,  4 Oct 2017 16:40:55 +0200
Subject: [cip-dev] [PATCH 01/10] watchdog: Introduce hardware maximum
	heartbeat in watchdog core
In-Reply-To: <20171004144104.14403-1-mosipov@ilbers.de>
References: <20171004144104.14403-1-mosipov@ilbers.de>
Message-ID: <20171004144104.14403-2-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Guenter Roeck <linux@roeck-us.net>

Backport from kernel.org, upstream commit 664a39236e71

Introduce an optional hardware maximum heartbeat in the watchdog core.
The hardware maximum heartbeat can be lower than the maximum timeout.

Drivers can set the maximum hardware heartbeat value in the watchdog data
structure. If the configured timeout exceeds the maximum hardware heartbeat,
the watchdog core enables a timer function to assist sending keepalive
requests to the watchdog driver.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[mosipov at ilbers.de backported to 4.4.y]
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  19 +++-
 drivers/watchdog/watchdog_dev.c                | 122 +++++++++++++++++++++++--
 include/linux/watchdog.h                       |  30 ++++--
 3 files changed, 154 insertions(+), 17 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index d8b0d3367706..9887fa6d8f68 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -53,6 +53,7 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int max_hw_heartbeat_ms;
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
@@ -73,8 +74,18 @@ It contains following fields:
   additional information about the watchdog timer itself. (Like it's unique name)
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
 * timeout: the watchdog timer's timeout value (in seconds).
+  This is the time after which the system will reboot if user space does
+  not send a heartbeat request if WDOG_ACTIVE is set.
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
-* max_timeout: the watchdog timer's maximum timeout value (in seconds).
+  If set, the minimum configurable value for 'timeout'.
+* max_timeout: the watchdog timer's maximum timeout value (in seconds),
+  as seen from userspace. If set, the maximum configurable value for
+  'timeout'. Not used if max_hw_heartbeat_ms is non-zero.
+* max_hw_heartbeat_ms: Maximum hardware heartbeat, in milli-seconds.
+  If set, the infrastructure will send heartbeats to the watchdog driver
+  if 'timeout' is larger than max_hw_heartbeat_ms, unless WDOG_ACTIVE
+  is set and userspace failed to send a heartbeat for at least 'timeout'
+  seconds.
 * bootstatus: status of the device after booting (reported with watchdog
   WDIOF_* status bits).
 * driver_data: a pointer to the drivers private data of a watchdog device.
@@ -160,7 +171,11 @@ they are supported. These optional routines/operations are:
   and -EIO for "could not write value to the watchdog". On success this
   routine should set the timeout value of the watchdog_device to the
   achieved timeout value (which may be different from the requested one
-  because the watchdog does not necessarily has a 1 second resolution).
+  because the watchdog does not necessarily have a 1 second resolution).
+  Drivers implementing max_hw_heartbeat_ms set the hardware watchdog heartbeat
+  to the minimum of timeout and max_hw_heartbeat_ms. Those drivers set the
+  timeout value of the watchdog_device either to the requested timeout value
+  (if it is larger than max_hw_heartbeat_ms), or to the achieved timeout value.
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
 * get_timeleft: this routines returns the time that's left before a reset.
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 56a649e66eb2..df43c586e53f 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -35,9 +35,11 @@
 #include <linux/module.h>	/* For module stuff/... */
 #include <linux/types.h>	/* For standard types (like size_t) */
 #include <linux/errno.h>	/* For the -ENODEV/... values */
+#include <linux/jiffies.h>	/* For timeout functions */
 #include <linux/kernel.h>	/* For printk/panic/... */
 #include <linux/fs.h>		/* For file operations */
 #include <linux/watchdog.h>	/* For watchdog specific items */
+#include <linux/workqueue.h>	/* For workqueue */
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
@@ -49,6 +51,73 @@ static dev_t watchdog_devt;
 /* the watchdog device behind /dev/watchdog */
 static struct watchdog_device *old_wdd;
 
+static struct workqueue_struct *watchdog_wq;
+
+static inline bool watchdog_need_worker(struct watchdog_device *wdd)
+{
+	/* All variables in milli-seconds */
+	unsigned int hm = wdd->max_hw_heartbeat_ms;
+	unsigned int t = wdd->timeout * 1000;
+
+	/*
+	 * A worker to generate heartbeat requests is needed if all of the
+	 * following conditions are true.
+	 * - Userspace activated the watchdog.
+	 * - The driver provided a value for the maximum hardware timeout, and
+	 *   thus is aware that the framework supports generating heartbeat
+	 *   requests.
+	 * - Userspace requests a longer timeout than the hardware can handle.
+	 */
+	return watchdog_active(wdd) && hm && t > hm;
+}
+
+static long watchdog_next_keepalive(struct watchdog_device *wdd)
+{
+	unsigned int timeout_ms = wdd->timeout * 1000;
+	unsigned long keepalive_interval;
+	unsigned long last_heartbeat;
+	unsigned long virt_timeout;
+	unsigned int hw_heartbeat_ms;
+
+	virt_timeout = wdd->last_keepalive + msecs_to_jiffies(timeout_ms);
+	hw_heartbeat_ms = min(timeout_ms, wdd->max_hw_heartbeat_ms);
+	keepalive_interval = msecs_to_jiffies(hw_heartbeat_ms / 2);
+
+	/*
+	 * To ensure that the watchdog times out wdd->timeout seconds
+	 * after the most recent ping from userspace, the last
+	 * worker ping has to come in hw_heartbeat_ms before this timeout.
+	 */
+	last_heartbeat = virt_timeout - msecs_to_jiffies(hw_heartbeat_ms);
+	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
+}
+
+static inline void watchdog_update_worker(struct watchdog_device *wdd)
+{
+	if (watchdog_need_worker(wdd)) {
+		long t = watchdog_next_keepalive(wdd);
+
+		if (t > 0)
+			mod_delayed_work(watchdog_wq, &wdd->work, t);
+	} else {
+		cancel_delayed_work(&wdd->work);
+	}
+}
+
+static int __watchdog_ping(struct watchdog_device *wdd)
+{
+	int err;
+
+	if (wdd->ops->ping)
+		err = wdd->ops->ping(wdd);  /* ping the watchdog */
+	else
+		err = wdd->ops->start(wdd); /* restart watchdog */
+
+	watchdog_update_worker(wdd);
+
+	return err;
+}
+
 /*
  *	watchdog_ping: ping the watchdog.
  *	@wdd: the watchdog device to ping
@@ -73,16 +142,27 @@ static int watchdog_ping(struct watchdog_device *wdd)
 	if (!watchdog_active(wdd))
 		goto out_ping;
 
-	if (wdd->ops->ping)
-		err = wdd->ops->ping(wdd);	/* ping the watchdog */
-	else
-		err = wdd->ops->start(wdd);	/* restart watchdog */
+	wdd->last_keepalive = jiffies;
+	err = __watchdog_ping(wdd);
 
 out_ping:
 	mutex_unlock(&wdd->lock);
 	return err;
 }
 
+static void watchdog_ping_work(struct work_struct *work)
+{
+	struct watchdog_device *wdd;
+
+	wdd = container_of(to_delayed_work(work), struct watchdog_device,
+			       work);
+
+	mutex_lock(&wdd->lock);
+	if (wdd && watchdog_active(wdd))
+		__watchdog_ping(wdd);
+	mutex_unlock(&wdd->lock);
+}
+
 /*
  *	watchdog_start: wrapper to start the watchdog.
  *	@wdd: the watchdog device to start
@@ -95,6 +175,7 @@ out_ping:
 static int watchdog_start(struct watchdog_device *wdd)
 {
 	int err = 0;
+	unsigned long started_at;
 
 	mutex_lock(&wdd->lock);
 
@@ -106,9 +187,13 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (watchdog_active(wdd))
 		goto out_start;
 
+	started_at = jiffies;
 	err = wdd->ops->start(wdd);
-	if (err == 0)
+	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
+		wdd->last_keepalive = started_at;
+		watchdog_update_worker(wdd);
+	}
 
 out_start:
 	mutex_unlock(&wdd->lock);
@@ -146,8 +231,10 @@ static int watchdog_stop(struct watchdog_device *wdd)
 	}
 
 	err = wdd->ops->stop(wdd);
-	if (err == 0)
+	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
+		cancel_delayed_work(&wdd->work);
+	}
 
 out_stop:
 	mutex_unlock(&wdd->lock);
@@ -211,6 +298,8 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 
 	err = wdd->ops->set_timeout(wdd, timeout);
 
+	watchdog_update_worker(wdd);
+
 out_timeout:
 	mutex_unlock(&wdd->lock);
 	return err;
@@ -490,6 +579,8 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	/* Allow the owner module to be unloaded again */
 	module_put(wdd->ops->owner);
 
+	cancel_delayed_work_sync(&wdd->work);
+
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(WDOG_DEV_OPEN, &wdd->status);
 
@@ -527,6 +618,11 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 {
 	int err, devno;
 
+	if (!watchdog_wq)
+		return -ENODEV;
+
+	INIT_DELAYED_WORK(&wdd->work, watchdog_ping_work);
+
 	if (wdd->id == 0) {
 		old_wdd = wdd;
 		watchdog_miscdev.parent = wdd->parent;
@@ -573,6 +669,8 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
 	set_bit(WDOG_UNREGISTERED, &wdd->status);
 	mutex_unlock(&wdd->lock);
 
+	cancel_delayed_work_sync(&wdd->work);
+
 	cdev_del(&wdd->cdev);
 	if (wdd->id == 0) {
 		misc_deregister(&watchdog_miscdev);
@@ -589,7 +687,16 @@ int watchdog_dev_unregister(struct watchdog_device *wdd)
 
 int __init watchdog_dev_init(void)
 {
-	int err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
+	int err;
+
+	watchdog_wq = alloc_workqueue("watchdogd",
+				      WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+	if (!watchdog_wq) {
+		pr_err("Failed to create watchdog workqueue\n");
+		return -ENOMEM;
+	}
+
+	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
 	if (err < 0)
 		pr_err("watchdog: unable to allocate char dev region\n");
 	return err;
@@ -604,4 +711,5 @@ int __init watchdog_dev_init(void)
 void __exit watchdog_dev_exit(void)
 {
 	unregister_chrdev_region(watchdog_devt, MAX_DOGS);
+	destroy_workqueue(watchdog_wq);
 }
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 027b1f43f12d..26aba9b17ac3 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -10,8 +10,9 @@
 
 
 #include <linux/bitops.h>
-#include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
 #include <uapi/linux/watchdog.h>
 
 struct watchdog_ops;
@@ -61,12 +62,17 @@ struct watchdog_ops {
  * @bootstatus:	Status of the watchdog device at boot.
  * @timeout:	The watchdog devices timeout value (in seconds).
  * @min_timeout:The watchdog devices minimum timeout value (in seconds).
- * @max_timeout:The watchdog devices maximum timeout value (in seconds).
+ * @max_timeout:The watchdog devices maximum timeout value (in seconds)
+ *		as configurable from user space. Only relevant if
+ *		max_hw_heartbeat_ms is not provided.
+ * @max_hw_heartbeat_ms:
+ *		Hardware limit for maximum timeout, in milli-seconds.
+ *		Replaces max_timeout if specified.
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
- * @deferred: entry in wtd_deferred_reg_list which is used to
- *			   register early initialized watchdogs.
+ * @deferred:	Entry in wtd_deferred_reg_list which is used to
+ *		register early initialized watchdogs.
  *
  * The watchdog_device structure contains all information about a
  * watchdog timer device.
@@ -88,8 +94,11 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int max_hw_heartbeat_ms;
 	void *driver_data;
 	struct mutex lock;
+	unsigned long last_keepalive;
+	struct delayed_work work;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog running/active */
@@ -121,13 +130,18 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 {
 	/*
 	 * The timeout is invalid if
+	 * - the requested value is larger than UINT_MAX / 1000
+	 *   (since internal calculations are done in milli-seconds),
+	 * or
 	 * - the requested value is smaller than the configured minimum timeout,
 	 * or
-	 * - a maximum timeout is configured, and the requested value is larger
-	 *   than the maximum timeout.
+	 * - a maximum hardware timeout is not configured, a maximum timeout
+	 *   is configured, and the requested value is larger than the
+	 *   configured maximum timeout.
 	 */
-	return t < wdd->min_timeout ||
-		(wdd->max_timeout && t > wdd->max_timeout);
+	return t > UINT_MAX / 1000 || t < wdd->min_timeout ||
+		(!wdd->max_hw_heartbeat_ms && wdd->max_timeout &&
+		 t > wdd->max_timeout);
 }
 
 /* Use the following functions to manipulate watchdog driver specific data */
-- 
2.11.0
