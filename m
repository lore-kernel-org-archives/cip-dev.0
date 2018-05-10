From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:48 +0100
Subject: [cip-dev] [PATCH 59/62] thermal: rcar_thermal: Fix priv->zone error
	handling
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-60-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Dirk Behme <dirk.behme@de.bosch.com>

In case thermal_zone_xxx_register() returns an error, priv->zone
isn't NULL any more, but contains the error code.

This is passed to thermal_zone_device_unregister(), then. This checks
for priv->zone being NULL, but the error code is != NULL. So it works
with the error code as a pointer. Crashing immediately.

To fix this, reset priv->zone to NULL before entering
rcar_gen3_thermal_remove().

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
(cherry picked from commit 87260d3f7aecba9a5fadc6886c338b2a8fccfca9)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 82daba0..f0f0743 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -504,6 +504,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->zone)) {
 			dev_err(dev, "can't register thermal zone\n");
 			ret = PTR_ERR(priv->zone);
+			priv->zone = NULL;
 			goto error_unregister;
 		}
 
-- 
2.7.4
