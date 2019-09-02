From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:35 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 01/22] watchdog: renesas_wdt: stop when
	unregistering
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 14de99b44b34dbb9d0f64845b1cbb675e047767e upstream.

We want to go into a sane state when unregistering. Currently, it
happens that the watchdog stops when unbinding because of RuntimePM
stopping the core clock. When rebinding, the core clock gets reactivated
and the watchdog fires even though it hasn't been opened by userspace
yet. Strange scenario, yes, but sane state is much preferred anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index d01efd3..62d9d3e 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -239,6 +239,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&priv->wdev, priv);
 	watchdog_set_nowayout(&priv->wdev, nowayout);
 	watchdog_set_restart_priority(&priv->wdev, 0);
+	watchdog_stop_on_unregister(&priv->wdev);
 
 	/* This overrides the default timeout only if DT configuration was found */
 	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
-- 
2.7.4
