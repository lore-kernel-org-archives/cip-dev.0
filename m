From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Wed,  4 Oct 2017 16:40:57 +0200
Subject: [cip-dev] [PATCH 03/10] watchdog: Make stop function optional
In-Reply-To: <20171004144104.14403-1-mosipov@ilbers.de>
References: <20171004144104.14403-1-mosipov@ilbers.de>
Message-ID: <20171004144104.14403-4-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Guenter Roeck <linux@roeck-us.net>

Backport from kernel.org, upstream commit d0684c8a9354

Not all hardware watchdogs can be stopped. The driver for
such watchdogs would typically only set the WATCHDOG_HW_RUNNING
flag in its stop function. Make the stop function optional and set
WATCHDOG_HW_RUNNING in the watchdog core if it is not provided.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[mosipov at ilbers.de backported to 4.4.y]
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 Documentation/watchdog/watchdog-kernel-api.txt | 20 ++++++++++++--------
 drivers/watchdog/watchdog_core.c               |  2 +-
 drivers/watchdog/watchdog_dev.c                |  6 +++++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index b12789745f86..a376f281f5a7 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -85,7 +85,8 @@ It contains following fields:
   If set, the infrastructure will send heartbeats to the watchdog driver
   if 'timeout' is larger than max_hw_heartbeat_ms, unless WDOG_ACTIVE
   is set and userspace failed to send a heartbeat for at least 'timeout'
-  seconds.
+  seconds. max_hw_heartbeat_ms must be set if a driver does not implement
+  the stop function.
 * bootstatus: status of the device after booting (reported with watchdog
   WDIOF_* status bits).
 * driver_data: a pointer to the drivers private data of a watchdog device.
@@ -141,17 +142,20 @@ are:
   device.
   The routine needs a pointer to the watchdog timer device structure as a
   parameter. It returns zero on success or a negative errno code for failure.
-* stop: with this routine the watchdog timer device is being stopped.
-  The routine needs a pointer to the watchdog timer device structure as a
-  parameter. It returns zero on success or a negative errno code for failure.
-  Some watchdog timer hardware can only be started and not be stopped.
-  If a watchdog can not be stopped, the watchdog driver must set the
-  WDOG_HW_RUNNING flag in its stop function to inform the watchdog core that
-  the watchdog is still running.
 
 Not all watchdog timer hardware supports the same functionality. That's why
 all other routines/operations are optional. They only need to be provided if
 they are supported. These optional routines/operations are:
+* stop: with this routine the watchdog timer device is being stopped.
+  The routine needs a pointer to the watchdog timer device structure as a
+  parameter. It returns zero on success or a negative errno code for failure.
+  Some watchdog timer hardware can only be started and not be stopped. A
+  driver supporting such hardware does not have to implement the stop routine.
+  If a driver has no stop function, the watchdog core will set WDOG_HW_RUNNING
+  and start calling the driver's keepalive pings function after the watchdog
+  device is closed.
+  If a watchdog driver does not implement the stop function, it must set
+  max_hw_heartbeat_ms.
 * ping: this is the routine that sends a keepalive ping to the watchdog timer
   hardware.
   The routine needs a pointer to the watchdog timer device structure as a
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 873f13972cf4..41f1854d026b 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -145,7 +145,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		return -EINVAL;
 
 	/* Mandatory operations need to be supported */
-	if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
+	if (!wdd->ops->start || (!wdd->ops->stop && !wdd->max_hw_heartbeat_ms))
 		return -EINVAL;
 
 	watchdog_check_min_max_timeout(wdd);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 55dc73f9b837..ca64724bf59a 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -237,7 +237,11 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		goto out_stop;
 	}
 
-	err = wdd->ops->stop(wdd);
+	if (wdd->ops->stop)
+		err = wdd->ops->stop(wdd);
+	else
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
 		watchdog_update_worker(wdd);
-- 
2.11.0
