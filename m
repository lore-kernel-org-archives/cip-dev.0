From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:44 +0100
Subject: [cip-dev] [PATCH 55/62] thermal: rcar: check irq possibility in
	rcar_thermal_irq_xxx()
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-56-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current rcar thermal driver sometimes checks irq possibility when it
calls rcar_thermal_irq_enable/disable(), but sometimes not.
This patch checks it inside rcar_thermal_irq_enable/disable().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit ffbcdf8a759c6dde71c6c4f646a552f7637bcca7)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b012d90..fb81fd7 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -290,6 +290,9 @@ static void _rcar_thermal_irq_ctrl(struct rcar_thermal_priv *priv, int enable)
 	unsigned long flags;
 	u32 mask = 0x3 << rcar_id_to_shift(priv); /* enable Rising/Falling */
 
+	if (!rcar_has_irq_support(priv))
+		return;
+
 	spin_lock_irqsave(&common->lock, flags);
 
 	rcar_thermal_common_bset(common, INTMSK, mask, enable ? 0 : mask);
@@ -374,8 +377,7 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 	struct rcar_thermal_priv *priv;
 
 	rcar_thermal_for_each_priv(priv, common) {
-		if (rcar_has_irq_support(priv))
-			rcar_thermal_irq_disable(priv);
+		rcar_thermal_irq_disable(priv);
 		thermal_zone_device_unregister(priv->zone);
 	}
 
@@ -461,8 +463,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			goto error_unregister;
 		}
 
-		if (rcar_has_irq_support(priv))
-			rcar_thermal_irq_enable(priv);
+		rcar_thermal_irq_enable(priv);
 
 		list_move_tail(&priv->list, &common->head);
 
-- 
2.7.4
