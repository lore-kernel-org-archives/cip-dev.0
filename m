From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:34 +0100
Subject: [cip-dev] [PATCH 16/42] watchdog: renesas_wdt: check rate also for
	upper limit
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-17-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

When checking the clock rate, ensure also that counting all 16 bits
takes at least one second to match the granularity of the framework.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit b51247c8029660a9c49ad48bf38f364479c96215)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 27c090e..9d68eb0 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -141,14 +141,14 @@ static int rwdt_probe(struct platform_device *pdev)
 
 	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
 		clks_per_sec = DIV_ROUND_UP(rate, clk_divs[i]);
-		if (clks_per_sec) {
+		if (clks_per_sec && clks_per_sec < 65536) {
 			priv->clks_per_sec = clks_per_sec;
 			priv->cks = i;
 			break;
 		}
 	}
 
-	if (!clks_per_sec) {
+	if (i < 0) {
 		dev_err(&pdev->dev, "Can't find suitable clock divider\n");
 		return -ERANGE;
 	}
-- 
2.7.4
