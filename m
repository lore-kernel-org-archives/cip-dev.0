From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Thu, 31 May 2018 13:56:15 +0100
Subject: [cip-dev] [PATCH 4.4-cip 2/2] watchdog: Fix kref imbalance seen if
 handle_boot_enabled=0
In-Reply-To: <20180531125458.gohmb46oplx4iv4x@xylophone.i.decadent.org.uk>
References: <20180531125458.gohmb46oplx4iv4x@xylophone.i.decadent.org.uk>
Message-ID: <20180531125615.efqb373lp2ov3zoy@xylophone.i.decadent.org.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Guenter Roeck <linux@roeck-us.net>

commit 914d65f3f013ba2556c7beec5d3baac7b3292504 upstream.

If handle_boot_enabled is set to 0, the watchdog driver module use
counter will not be increased and kref_get() will not be called when
registering the watchdog. Subsequently, on open, this does not happen
either because the code believes that it was already done because the
hardware watchdog is marked as running.

We could introduce a state variable to indicate this state, but let's
just increase the module use counter and call kref_get() unconditionally
if the hardware watchdog is running when a driver is registering itself
to keep the code simple.

Fixes: 2501b015313fe ("watchdog: core: add option to avoid early ...")
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[bwh: Backported to 4.4:
 - We still use ref/unref callbacks instead of a kref
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/watchdog/watchdog_dev.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index b9b34aa07d48..60a32917d3d5 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -688,15 +688,14 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 	 * and schedule an immediate ping.
 	 */
 	if (watchdog_hw_running(wdd)) {
-		if (handle_boot_enabled) {
-			__module_get(wdd->ops->owner);
-			if (wdd->ops->ref)
-				wdd->ops->ref(wdd);
+		__module_get(wdd->ops->owner);
+		if (wdd->ops->ref)
+			wdd->ops->ref(wdd);
+		if (handle_boot_enabled)
 			queue_delayed_work(watchdog_wq, &wdd->work, 0);
-		} else {
+		else
 			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
-					wdd->id);
-		}
+				wdd->id);
 	}
 
 	return 0;
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
