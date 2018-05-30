From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:35:58 +0100
Subject: [cip-dev] [PATCH v2 02/11] thermal: convert rcar_thermal to use
	devm_thermal_zone_of_sensor_register
In-Reply-To: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527701767-41785-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Eduardo Valentin <edubezval@gmail.com>

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit 5e325868aa59d3c743aa1c9526f386f30c234cd7)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 82daba0..71a3392 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -492,7 +492,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 
 		if (of_data == USE_OF_THERMAL)
-			priv->zone = thermal_zone_of_sensor_register(
+			priv->zone = devm_thermal_zone_of_sensor_register(
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		else
-- 
2.7.4
