From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:49 +0100
Subject: [cip-dev] [PATCH 60/62] thermal: rcar-thermal: enable hwmon when
	thermal_zone_of_sensor_register is used
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-61-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rcar-thermal is supporting both thermal_zone_of_sensor_register() and
thermal_zone_device_register(). But thermal_zone_of_sensor_register()
doesn't enable hwmon as default.
This patch enables it to keep compatibility

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
(cherry picked from commit 64a411e8042ed00057658000126fd9f2b4105bdd)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index f0f0743..187b3f4 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -31,6 +31,8 @@
 #include <linux/spinlock.h>
 #include <linux/thermal.h>
 
+#include "thermal_hwmon.h"
+
 #define IDLE_INTERVAL	5000
 
 #define COMMON_STR	0x00
@@ -75,6 +77,8 @@ struct rcar_thermal_priv {
 #define rcar_priv_to_dev(priv)		((priv)->common->dev)
 #define rcar_has_irq_support(priv)	((priv)->common->base)
 #define rcar_id_to_shift(priv)		((priv)->id * 8)
+#define rcar_of_data(dev)		((unsigned long)of_device_get_match_data(dev))
+#define rcar_use_of_thermal(dev)	(rcar_of_data(dev) == USE_OF_THERMAL)
 
 #define USE_OF_THERMAL	1
 static const struct of_device_id rcar_thermal_dt_ids[] = {
@@ -416,6 +420,8 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 	rcar_thermal_for_each_priv(priv, common) {
 		rcar_thermal_irq_disable(priv);
 		thermal_zone_device_unregister(priv->zone);
+		if (rcar_use_of_thermal(dev))
+			thermal_remove_hwmon_sysfs(priv->zone);
 	}
 
 	pm_runtime_put(dev);
@@ -430,7 +436,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct rcar_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct resource *res, *irq;
-	unsigned long of_data = (unsigned long)of_device_get_match_data(dev);
 	int mres = 0;
 	int i;
 	int ret = -ENODEV;
@@ -491,7 +496,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto error_unregister;
 
-		if (of_data == USE_OF_THERMAL)
+		if (rcar_use_of_thermal(dev))
 			priv->zone = thermal_zone_of_sensor_register(
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
@@ -508,6 +513,17 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
+		if (rcar_use_of_thermal(dev)) {
+			/*
+			 * thermal_zone doesn't enable hwmon as default,
+			 * but, enable it here to keep compatible
+			 */
+			priv->zone->tzp->no_hwmon = false;
+			ret = thermal_add_hwmon_sysfs(priv->zone);
+			if (ret)
+				goto error_unregister;
+		}
+
 		rcar_thermal_irq_enable(priv);
 
 		list_move_tail(&priv->list, &common->head);
-- 
2.7.4
