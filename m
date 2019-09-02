From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:50 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 16/22] thermal: rcar_gen3_thermal:
	Update calculation formula of IRQTEMP
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

commit bdc4480a669d476814061b4da6bb006f7048c8e5 upstream.

Update the formula to calculate CTEMP:
Currently, the CTEMP is average of val1 (is calculated by
formula 1) and val2 (is calculated by formula 2). But,
as description in HWM (chapter 10A.3.1.1 Setting of Normal Mode)

If (STEMP < Tj_T) CTEMP value should be val1.
If (STEMP > Tj_T) CTEMP value should be val2.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 0830b9e..ad3908a 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -76,6 +76,7 @@ struct rcar_gen3_thermal_tsc {
 	struct equation_coefs coef;
 	int low;
 	int high;
+	int tj_t;
 };
 
 struct rcar_gen3_thermal_priv {
@@ -124,28 +125,26 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 /* no idea where these constants come from */
 #define TJ_3 -41
 
-static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
+static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
 					 int *ptat, int *thcode,
 					 int ths_tj_1)
 {
-	int tj_2;
-
 	/* TODO: Find documentation and document constant calculation formula */
 
 	/*
 	 * Division is not scaled in BSP and if scaled it might overflow
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
-	tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
-		/ (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
+	tsc->tj_t = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
+		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
 
-	coef->a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
-			     tj_2 - FIXPT_INT(TJ_3));
-	coef->b1 = FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
+	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
+				 tsc->tj_t - FIXPT_INT(TJ_3));
+	tsc->coef.b1 = FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
 
-	coef->a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
-			     tj_2 - FIXPT_INT(ths_tj_1));
-	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
+	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
+				 tsc->tj_t - FIXPT_INT(ths_tj_1));
+	tsc->coef.b2 = FIXPT_INT(thcode[0]) - tsc->coef.a2 * ths_tj_1;
 }
 
 static int rcar_gen3_thermal_round(int temp)
@@ -184,13 +183,15 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 					      int mcelsius)
 {
-	int celsius, val1, val2;
+	int celsius, val;
 
 	celsius = DIV_ROUND_CLOSEST(mcelsius, 1000);
-	val1 = celsius * tsc->coef.a1 + tsc->coef.b1;
-	val2 = celsius * tsc->coef.a2 + tsc->coef.b2;
+	if (celsius <= INT_FIXPT(tsc->tj_t))
+		val = celsius * tsc->coef.a1 + tsc->coef.b1;
+	else
+		val = celsius * tsc->coef.a2 + tsc->coef.b2;
 
-	return INT_FIXPT((val1 + val2) / 2);
+	return INT_FIXPT(val);
 }
 
 static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
@@ -413,7 +414,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcode[i],
 					     *rcar_gen3_ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
-- 
2.7.4
