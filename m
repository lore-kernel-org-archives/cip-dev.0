From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:47 +0100
Subject: [cip-dev] [PATCH 58/62] thermal: rcar_thermal: don't open code
	of_device_get_match_data()
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-59-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This change will also make Coverity happy by avoiding a theoretical NULL
pointer dereference; yet another reason is to use the above helper function
to tighten the code and make it more readable.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit 67bc3f4226c1d29ee820eff98fcaf8a9283938fe)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 0e735ac..82daba0 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -430,8 +430,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct rcar_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct resource *res, *irq;
-	const struct of_device_id *of_id = of_match_device(rcar_thermal_dt_ids, dev);
-	unsigned long of_data = (unsigned long)of_id->data;
+	unsigned long of_data = (unsigned long)of_device_get_match_data(dev);
 	int mres = 0;
 	int i;
 	int ret = -ENODEV;
-- 
2.7.4
