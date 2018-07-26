From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:35 +0100
Subject: [cip-dev] [PATCH 17/42] watchdog: renesas_wdt: don't round closest
	with get_timeleft
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-18-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We should never return more time left than there actually is. So, switch
to a plain divider instead of DIV_ROUND_CLOSEST.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit 1c1b2434017206b612764fad1820b6dd48cb9e92)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 9d68eb0..64f68d1 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -98,7 +98,7 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 	u16 val = readw_relaxed(priv->base + RWTCNT);
 
-	return DIV_ROUND_CLOSEST(65536 - val, priv->clks_per_sec);
+	return (65536 - val) / priv->clks_per_sec;
 }
 
 static const struct watchdog_info rwdt_ident = {
-- 
2.7.4
