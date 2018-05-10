From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:45 +0100
Subject: [cip-dev] [PATCH 56/62] thermal: rcar: rcar_thermal_get_temp()
	return error if strange temp
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-57-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit 5440c40b900fa561add48a7e70e9c892f0551387)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index fb81fd7..44b9c48 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -203,6 +203,7 @@ err_out_unlock:
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 {
 	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
+	int tmp;
 	int ret;
 
 	ret = rcar_thermal_update_temp(priv);
@@ -210,9 +211,18 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 		return ret;
 
 	mutex_lock(&priv->lock);
-	*temp =  MCELSIUS((priv->ctemp * 5) - 65);
+	tmp =  MCELSIUS((priv->ctemp * 5) - 65);
 	mutex_unlock(&priv->lock);
 
+	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
+		struct device *dev = rcar_priv_to_dev(priv);
+
+		dev_err(dev, "it couldn't measure temperature correctly\n");
+		return -EIO;
+	}
+
+	*temp = tmp;
+
 	return 0;
 }
 
-- 
2.7.4
