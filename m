From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 31 May 2018 13:56:06 +0100
Subject: [cip-dev] [PATCH 4.4-cip 1/2] watchdog: Fix potential kref
 imbalance when opening watchdog
In-Reply-To: <20180531125458.gohmb46oplx4iv4x@xylophone.i.decadent.org.uk>
References: <20180531125458.gohmb46oplx4iv4x@xylophone.i.decadent.org.uk>
Message-ID: <20180531125606.dhykhsfeluhuulp7@xylophone.i.decadent.org.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Guenter Roeck <linux@roeck-us.net>

commit 4bcd615fad6adddc68b058d498b30a9e0e0db77a upstream.

If a watchdog driver's open function sets WDOG_HW_RUNNING with the
expectation that the watchdog can not be stopped, but then stops the
watchdog anyway in its stop function, kref_get() wil not be called in
watchdog_open(). If the watchdog then stops on close, WDOG_HW_RUNNING
will be cleared and kref_put() will be called, causing a kref imbalance.
As result the character device data structure will be released, which in
turn will cause the system to crash on the next call to watchdog_open().

Fixes: ee142889e32f5 ("watchdog: Introduce WDOG_HW_RUNNING flag")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[bwh: Backported to 4.4:
 - We still use ref/unref callbacks instead of a kref
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/watchdog/watchdog_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 8ca87ae467f2..b9b34aa07d48 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -524,6 +524,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 {
 	int err = -EBUSY;
 	struct watchdog_device *wdd;
+	bool hw_running;
 
 	/* Get the corresponding watchdog device */
 	if (imajor(inode) == MISC_MAJOR)
@@ -539,7 +540,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!watchdog_hw_running(wdd) && !try_module_get(wdd->ops->owner))
+	hw_running = watchdog_hw_running(wdd);
+	if (!hw_running && !try_module_get(wdd->ops->owner))
 		goto out;
 
 	err = watchdog_start(wdd);
@@ -548,7 +550,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 
 	file->private_data = wdd;
 
-	if (!watchdog_hw_running(wdd) && wdd->ops->ref)
+	if (!hw_running && wdd->ops->ref)
 		wdd->ops->ref(wdd);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
