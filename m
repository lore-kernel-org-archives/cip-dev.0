From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Wed,  4 Oct 2017 16:41:03 +0200
Subject: [cip-dev] [PATCH 09/10] watchdog: core: Clear WDOG_HW_RUNNING
	before calling the stop function
In-Reply-To: <20171004144104.14403-1-mosipov@ilbers.de>
References: <20171004144104.14403-1-mosipov@ilbers.de>
Message-ID: <20171004144104.14403-10-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Guenter Roeck <linux@roeck-us.net>

Backport from kernel.org, upstream commit 3c10bbde10fe

WDOG_HW_RUNNING indicates that the hardware watchdog is running while the
watchdog device is closed. The flag may be set by the driver when it is
instantiated to indicate that the watchdog is running, and that the
watchdog core needs to send heartbeat requests to the driver until the
watchdog device is opened.

When the watchdog device is closed, the flag can be used by the driver's
stop function to indicate to the watchdog core that it was unable to stop
the watchdog, and that the watchdog core needs to send heartbeat requests.
This only works if the flag is actually cleared when the watchdog is
stopped. To avoid having to clear the flag in each driver's stop function,
clear it in the watchdog core before calling the stop function.

Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[mosipov at ilbers.de backported to 4.4.y]
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 drivers/watchdog/watchdog_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6cc5ad34c5bc..e65a14f213ff 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -241,10 +241,12 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		goto out_stop;
 	}
 
-	if (wdd->ops->stop)
+	if (wdd->ops->stop) {
+		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
-	else
+	} else {
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	}
 
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
-- 
2.11.0
