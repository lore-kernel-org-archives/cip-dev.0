From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:33 +0100
Subject: [cip-dev] [PATCH 15/42] watchdog: renesas_wdt: avoid (theoretical)
	type overflow
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Because the smallest clock divider we can select is 1, 'clks_per_sec'
must be the same type as 'rate'.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
(cherry picked from commit f6159dd4b085ad839ab02c1ba230535c53ef60d4)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/watchdog/renesas_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index ab3e9b0..27c090e 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -37,7 +37,7 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	struct clk *clk;
-	unsigned int clks_per_sec;
+	unsigned long clks_per_sec;
 	u8 cks;
 };
 
@@ -119,8 +119,7 @@ static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
 	struct resource *res;
-	unsigned long rate;
-	unsigned int clks_per_sec;
+	unsigned long rate, clks_per_sec;
 	int ret, i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-- 
2.7.4
