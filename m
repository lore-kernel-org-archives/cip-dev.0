From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Fri, 10 Nov 2017 13:10:00 +0100
Subject: [cip-dev] [PATCH 06/10] watchdog: skip min and max timeout validity
	check when max_hw_heartbeat_ms is defined
In-Reply-To: <20171110121004.17775-1-mosipov@ilbers.de>
References: <20171110121004.17775-1-mosipov@ilbers.de>
Message-ID: <20171110121004.17775-7-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Pratyush Anand <panand@redhat.com>

commit 1894cad9bf2c10359b2b7a0c00e564698f712751 upstream.

When max_hw_heartbeat_ms has a none zero value, max_timeout is not used.
So it's value can be 0. In such case if a driver uses min_timeout
functionality, then check will always fail.

This patch fixes above issue.

Signed-off-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[mosipov at ilbers.de backported to 4.4.y]
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 drivers/watchdog/watchdog_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 41f1854d026b..5de14c51bf95 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -88,7 +88,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 	 * Check that we have valid min and max timeout values, if
 	 * not reset them both to 0 (=not used or unknown)
 	 */
-	if (wdd->min_timeout > wdd->max_timeout) {
+	if (!wdd->max_hw_heartbeat_ms && wdd->min_timeout > wdd->max_timeout) {
 		pr_info("Invalid min and max timeout values, resetting to 0!\n");
 		wdd->min_timeout = 0;
 		wdd->max_timeout = 0;
-- 
2.11.0
