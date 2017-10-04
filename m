From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Wed,  4 Oct 2017 16:41:02 +0200
Subject: [cip-dev] [PATCH 08/10] watchdog: core: Fix error handling of
	watchdog_dev_init()
In-Reply-To: <20171004144104.14403-1-mosipov@ilbers.de>
References: <20171004144104.14403-1-mosipov@ilbers.de>
Message-ID: <20171004144104.14403-9-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Backport from kernel.org, upstream commit 138913cb632b

Fix the error handling paths of watchdog_dev_init().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
[mosipov at ilbers.de backported to 4.4.y]
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
---
 drivers/watchdog/watchdog_dev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e3eacf27b1e7..6cc5ad34c5bc 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -733,8 +733,15 @@ int __init watchdog_dev_init(void)
 	}
 
 	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
-	if (err < 0)
+	if (err < 0) {
 		pr_err("watchdog: unable to allocate char dev region\n");
+		goto err_alloc;
+	}
+
+	return 0;
+
+err_alloc:
+	destroy_workqueue(watchdog_wq);
 	return err;
 }
 
-- 
2.11.0
