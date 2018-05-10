From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:42 +0100
Subject: [cip-dev] [PATCH 53/62] thermal: rcar: move rcar_thermal_dt_ids to
	upside
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-54-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch is prepare for of-thermal support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit ca1e4558fcca68a5ac2a4e0f7834f788f9f4ac8f)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 13d01ed..96707a6 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -81,6 +81,12 @@ struct rcar_thermal_priv {
 # define rcar_force_update_temp(priv)	0
 #endif
 
+static const struct of_device_id rcar_thermal_dt_ids[] = {
+	{ .compatible = "renesas,rcar-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rcar_thermal_dt_ids);
+
 /*
  *		basic functions
  */
@@ -484,12 +490,6 @@ error_unregister:
 	return ret;
 }
 
-static const struct of_device_id rcar_thermal_dt_ids[] = {
-	{ .compatible = "renesas,rcar-thermal", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, rcar_thermal_dt_ids);
-
 static struct platform_driver rcar_thermal_driver = {
 	.driver	= {
 		.name	= "rcar_thermal",
-- 
2.7.4
