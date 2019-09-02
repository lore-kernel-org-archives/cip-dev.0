From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:45 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 11/22] thermal: rcar_gen3_thermal:
	Register hwmon sysfs interface
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-12-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

commit 6269e9f790e8d442b3e1529bf3b3de452dd4ac92 upstream.

Register the hwmon sysfs interface on R-Car Gen3 thermal driver to
align it with Gen2 driver. Use devm_add_action() to unregister the
hwmon interface automatically.

Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
To: linux-pm at vger.kernel.org
From: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 393ed96..40a442e 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -19,6 +19,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 /* Register offsets */
 #define REG_GEN3_IRQSTR		0x04
@@ -339,6 +340,13 @@ static int rcar_gen3_thermal_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void rcar_gen3_hwmon_action(void *data)
+{
+	struct thermal_zone_device *zone = data;
+
+	thermal_remove_hwmon_sysfs(zone);
+}
+
 static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
@@ -431,6 +439,17 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto error_unregister;
 
+		tsc->zone->tzp->no_hwmon = false;
+		ret = thermal_add_hwmon_sysfs(tsc->zone);
+		if (ret)
+			goto error_unregister;
+
+		ret = devm_add_action(dev, rcar_gen3_hwmon_action, zone);
+		if (ret) {
+			rcar_gen3_hwmon_action(zone);
+			goto error_unregister;
+		}
+
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
-- 
2.7.4
