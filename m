From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Thu, 16 Jan 2020 15:11:13 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 03/12] thermal: rcar_thermal: update
	calculation formula for R-Car Gen3 SoCs
In-Reply-To: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579187482-4626-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

commit 20386f0d84a22214d1f037dedfffb6709dd0117a upstream.

Update calculation for the R-Car Gen3 and RZ/G2 SoCs which have a
thermal IP block controlled by this driver. That is the:

* R-Car D3 (r8a77995)
* R-Car E2 (r8a77990)
* R-Car V3M (r8a77970)
* RZ/G2E (r8a774c0)

The calculation update is as documented in the R-Car Gen3 User's Manual,
v1.50 Nov 2018:

- When CTEMP is less than 24
   T = CTEMP[5:0] * 5.5 - 72
- When CTEMP is equal to/greater than 24
   T = CTEMP[5:0] * 5 - 60

This was inspired by a patch in the BSP by Van Do <van.do.xw@renesas.com>

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/thermal/rcar_thermal.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 5735e36..84baeb2 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -52,6 +52,7 @@ struct rcar_thermal_chip {
 	unsigned int irq_per_ch : 1;
 	unsigned int needs_suspend_resume : 1;
 	unsigned int nirqs;
+	unsigned int ctemp_bands;
 };
 
 static const struct rcar_thermal_chip rcar_thermal = {
@@ -60,6 +61,7 @@ static const struct rcar_thermal_chip rcar_thermal = {
 	.irq_per_ch = 0,
 	.needs_suspend_resume = 0,
 	.nirqs = 1,
+	.ctemp_bands = 1,
 };
 
 static const struct rcar_thermal_chip rcar_gen2_thermal = {
@@ -68,6 +70,7 @@ static const struct rcar_thermal_chip rcar_gen2_thermal = {
 	.irq_per_ch = 0,
 	.needs_suspend_resume = 0,
 	.nirqs = 1,
+	.ctemp_bands = 1,
 };
 
 static const struct rcar_thermal_chip rcar_gen3_thermal = {
@@ -80,6 +83,7 @@ static const struct rcar_thermal_chip rcar_gen3_thermal = {
 	 * interrupts to detect a temperature change, rise or fall.
 	 */
 	.nirqs = 2,
+	.ctemp_bands = 2,
 };
 
 struct rcar_thermal_priv {
@@ -255,7 +259,12 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
 		return ret;
 
 	mutex_lock(&priv->lock);
-	tmp =  MCELSIUS((priv->ctemp * 5) - 65);
+	if (priv->chip->ctemp_bands == 1)
+		tmp = MCELSIUS((priv->ctemp * 5) - 65);
+	else if (priv->ctemp < 24)
+		tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
+	else
+		tmp = MCELSIUS((priv->ctemp * 5) - 60);
 	mutex_unlock(&priv->lock);
 
 	if ((tmp < MCELSIUS(-45)) || (tmp > MCELSIUS(125))) {
-- 
2.7.4
