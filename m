From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:43 +0100
Subject: [cip-dev] [PATCH 25/42] watchdog: renesas-wdt: Add support for
	WDIOF_CARDRESET
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-26-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>

This patch adds the WDIOF_CARDRESET support for the Renesas platform
watchdog, to know if the board reboot is due to a watchdog reset.

This is done via the WOVF bit (bit 4) of the RWTCSRA register, which
indicates if RWTCNT overflowed, triggering the reset in last boot.

Signed-off-by: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
[takeshi.kihara.df: changed to read the RWTCSRA register while clock is
 enabled]
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

(cherry picked from commit fdac6a90d2d151abdbb7e5ec14bb9ab64e2931ec)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 88b9c7d..e334a83 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -130,7 +130,8 @@ static int rwdt_restart(struct notifier_block *this, unsigned long mode,
 }
 
 static const struct watchdog_info rwdt_ident = {
-	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
+		WDIOF_CARDRESET,
 	.identity = "Renesas WDT Watchdog",
 };
 
@@ -165,9 +166,10 @@ static int rwdt_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	pm_runtime_enable(&pdev->dev);
-
 	pm_runtime_get_sync(&pdev->dev);
 	priv->clk_rate = clk_get_rate(clk);
+	priv->wdev.bootstatus = (readb_relaxed(priv->base + RWTCSRA) &
+				RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
 	pm_runtime_put(&pdev->dev);
 
 	if (!priv->clk_rate) {
-- 
2.7.4
