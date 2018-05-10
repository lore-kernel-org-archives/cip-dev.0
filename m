From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:43 +0100
Subject: [cip-dev] [PATCH 54/62] thermal: rcar: check every
	rcar_thermal_update_temp() return value
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-55-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Every rcar_thermal_update_temp() return value will be checked.

And also, rcar_thermal_get_temp() always call
rcar_thermal_update_temp() by this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit a1ade5653804b8eb9d14c5ba964da6d5c2f4cd30)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 96707a6..b012d90 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -75,12 +75,6 @@ struct rcar_thermal_priv {
 #define rcar_has_irq_support(priv)	((priv)->common->base)
 #define rcar_id_to_shift(priv)		((priv)->id * 8)
 
-#ifdef DEBUG
-# define rcar_force_update_temp(priv)	1
-#else
-# define rcar_force_update_temp(priv)	0
-#endif
-
 static const struct of_device_id rcar_thermal_dt_ids[] = {
 	{ .compatible = "renesas,rcar-thermal", },
 	{},
@@ -209,9 +203,11 @@ err_out_unlock:
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 {
 	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
+	int ret;
 
-	if (!rcar_has_irq_support(priv) || rcar_force_update_temp(priv))
-		rcar_thermal_update_temp(priv);
+	ret = rcar_thermal_update_temp(priv);
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&priv->lock);
 	*temp =  MCELSIUS((priv->ctemp * 5) - 65);
@@ -305,11 +301,15 @@ static void rcar_thermal_work(struct work_struct *work)
 {
 	struct rcar_thermal_priv *priv;
 	int cctemp, nctemp;
+	int ret;
 
 	priv = container_of(work, struct rcar_thermal_priv, work.work);
 
 	rcar_thermal_get_temp(priv->zone, &cctemp);
-	rcar_thermal_update_temp(priv);
+	ret = rcar_thermal_update_temp(priv);
+	if (ret < 0)
+		return;
+
 	rcar_thermal_irq_enable(priv);
 
 	rcar_thermal_get_temp(priv->zone, &nctemp);
@@ -447,7 +447,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		mutex_init(&priv->lock);
 		INIT_LIST_HEAD(&priv->list);
 		INIT_DELAYED_WORK(&priv->work, rcar_thermal_work);
-		rcar_thermal_update_temp(priv);
+		ret = rcar_thermal_update_temp(priv);
+		if (ret < 0)
+			goto error_unregister;
 
 		priv->zone = thermal_zone_device_register("rcar_thermal",
 						1, 0, priv,
-- 
2.7.4
