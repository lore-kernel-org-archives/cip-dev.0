From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:37 +0100
Subject: [cip-dev] [PATCH 19/42] watchdog: renesas_wdt: add another divider
	option
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-20-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If we set RWTCSRB to 0, we can gain 4096 as another divider value. This
is supported by all R-Car Gen2 and Gen3 devices which we aim to support.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit 03a196f25f5652a3deffc1b8eade8a3c1c39282c)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 454a2fc..1891a0e 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -23,21 +23,22 @@
 #define RWTCSRA_WOVF	BIT(4)
 #define RWTCSRA_WRFLG	BIT(5)
 #define RWTCSRA_TME	BIT(7)
+#define RWTCSRB		8
 
 #define RWDT_DEFAULT_TIMEOUT 60U
 
 /*
  * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
- * divider (10 bits). d is only a factor to fully utilize the WDT counter and
+ * divider (12 bits). d is only a factor to fully utilize the WDT counter and
  * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
  */
 #define MUL_BY_CLKS_PER_SEC(p, d) \
 	DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
 
-/* d is 16 bit, clk_divs 10 bit -> no 32 bit overflow */
+/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
 #define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
 
-static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
+static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024, 4096 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -83,6 +84,7 @@ static int rwdt_start(struct watchdog_device *wdev)
 
 	clk_prepare_enable(priv->clk);
 
+	rwdt_write(priv, 0, RWTCSRB);
 	rwdt_write(priv, priv->cks, RWTCSRA);
 	rwdt_set_timeout(wdev, wdev->timeout);
 
-- 
2.7.4
