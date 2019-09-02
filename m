From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:49 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 15/22] thermal: rcar_gen3_thermal:
	Update value of Tj_1
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-16-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

commit 4eb39f79ef443fa566d36bd43f1f578d5c140305 upstream.

As evaluation of hardware team, temperature calculation formula
of M3-W is difference from all other SoCs as below:
- M3-W: Tj_1: 116 (so Tj_1 - Tj_3 = 157)
- Others: Tj_1: 126 (so Tj_1 - Tj_3 = 167)

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
[fab: backported to 4.19.y-cip]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index c9e899a..0830b9e 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -122,11 +122,11 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
 
 /* no idea where these constants come from */
-#define TJ_1 116
 #define TJ_3 -41
 
 static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
-					 int *ptat, int *thcode)
+					 int *ptat, int *thcode,
+					 int ths_tj_1)
 {
 	int tj_2;
 
@@ -137,15 +137,15 @@ static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
 	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it unscaled
 	 */
 	tj_2 = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
-		/ (ptat[0] - ptat[2])) - FIXPT_INT(41);
+		/ (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
 
 	coef->a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
 			     tj_2 - FIXPT_INT(TJ_3));
 	coef->b1 = FIXPT_INT(thcode[2]) - coef->a1 * TJ_3;
 
 	coef->a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
-			     tj_2 - FIXPT_INT(TJ_1));
-	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * TJ_1;
+			     tj_2 - FIXPT_INT(ths_tj_1));
+	coef->b2 = FIXPT_INT(thcode[0]) - coef->a2 * ths_tj_1;
 }
 
 static int rcar_gen3_thermal_round(int temp)
@@ -294,11 +294,25 @@ static void rcar_gen3_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
 	usleep_range(1000, 2000);
 }
 
+static const int rcar_gen3_ths_tj_1 = 126;
+static const int rcar_gen3_ths_tj_1_m3_w = 116;
 static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
-	{ .compatible = "renesas,r8a774a1-thermal", },
-	{ .compatible = "renesas,r8a7795-thermal", },
-	{ .compatible = "renesas,r8a7796-thermal", },
-	{ .compatible = "renesas,r8a77965-thermal", },
+	{
+		.compatible = "renesas,r8a774a1-thermal",
+		.data = &rcar_gen3_ths_tj_1_m3_w,
+	},
+	{
+		.compatible = "renesas,r8a7795-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
+	{
+		.compatible = "renesas,r8a7796-thermal",
+		.data = &rcar_gen3_ths_tj_1_m3_w,
+	},
+	{
+		.compatible = "renesas,r8a77965-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
@@ -327,6 +341,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
+	const int *rcar_gen3_ths_tj_1 = of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	int ret, irq, i;
@@ -398,7 +413,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		priv->tscs[i] = tsc;
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
+		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i],
+					     *rcar_gen3_ths_tj_1);
 
 		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
-- 
2.7.4
