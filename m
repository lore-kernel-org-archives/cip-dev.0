From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:36:01 +0100
Subject: [cip-dev] [PATCH v2 05/11] thermal: rcar_thermal: don't call
	thermal_zone_device_unregister when USE_OF_THERMAL
In-Reply-To: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527701767-41785-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Bui Duc Phuc <bd-phuc@jinso.co.jp>

devm_thermal_zone_of_sensor_register() case doesn't need to call
thermal_zone_device_unregister().
Otherwise, rcar-thermal can't register thermal zone again after rebind.
This patch fixes it.

Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
(cherry picked from commit d4b23c5c434a7af053782cc0f9eebee51ec71bb2)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 4048003..e895830 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -419,9 +419,10 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 
 	rcar_thermal_for_each_priv(priv, common) {
 		rcar_thermal_irq_disable(priv);
-		thermal_zone_device_unregister(priv->zone);
 		if (rcar_use_of_thermal(dev))
 			thermal_remove_hwmon_sysfs(priv->zone);
+		else
+			thermal_zone_device_unregister(priv->zone);
 	}
 
 	pm_runtime_put(dev);
-- 
2.7.4
