From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:48 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 14/22] thermal: rcar_gen3_thermal: Fix
	to show correct trip points number
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jiada Wang <jiada_wang@mentor.com>

commit e380ea8117ce8c83c5da7063a3587a728132de0b upstream.

Currently after store trip points number in 'ret', it is overwritten
afterwards, this cause incorrect trip point number always be shown in
the debug information after register of each thermal zone.

This patch fix this issue by moving get of trip number to
end of thermal zone registration.

Fixes: 6269e9f790e8d ("thermal: rcar_gen3_thermal: Register hwmon sysfs interface")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 7969209..c9e899a 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -409,10 +409,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 		tsc->zone = zone;
 
-		ret = of_thermal_get_ntrips(tsc->zone);
-		if (ret < 0)
-			goto error_unregister;
-
 		tsc->zone->tzp->no_hwmon = false;
 		ret = thermal_add_hwmon_sysfs(tsc->zone);
 		if (ret)
@@ -424,6 +420,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
+		ret = of_thermal_get_ntrips(tsc->zone);
+		if (ret < 0)
+			goto error_unregister;
+
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
-- 
2.7.4
