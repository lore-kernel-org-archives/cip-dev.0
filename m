From: biju.das@bp.renesas.com (Biju Das)
Date: Mon,  2 Sep 2019 16:57:51 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 17/22] thermal: rcar_gen3_thermal:
	Update temperature conversion method
In-Reply-To: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
References: <1567439876-1886-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1567439876-1886-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

commit 6a310f8f97bb8bc2e2bb9db6f49a1b8678c8d144 upstream.

Update the formula to calculate temperature:
Currently, current TEMP is calculated as
average of val1 (is calculated by formula 1)
and val2 (is calculated by formula 2). But,
as description in HWM (chapter 10A.3.1.2 Normal Mode.)

If (TEMP_CODE < THCODE2[11:0]) CTEMP value should be val1.
If (TEMP_CODE > THCODE2[11:0]) CTEMP value should be val2.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index ad3908a..c67147e 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -62,6 +62,13 @@
 
 #define TSC_MAX_NUM	3
 
+/* default THCODE values if FUSEs are missing */
+static const int thcode[TSC_MAX_NUM][3] = {
+	{ 3397, 2800, 2221 },
+	{ 3393, 2795, 2216 },
+	{ 3389, 2805, 2237 },
+};
+
 /* Structure for thermal temperature calculation */
 struct equation_coefs {
 	int a1;
@@ -77,6 +84,7 @@ struct rcar_gen3_thermal_tsc {
 	int low;
 	int high;
 	int tj_t;
+	int id; /* thermal channel id */
 };
 
 struct rcar_gen3_thermal_priv {
@@ -126,7 +134,7 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
 #define TJ_3 -41
 
 static void rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
-					 int *ptat, int *thcode,
+					 int *ptat, const int *thcode,
 					 int ths_tj_1)
 {
 	/* TODO: Find documentation and document constant calculation formula */
@@ -160,15 +168,19 @@ static int rcar_gen3_thermal_round(int temp)
 static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = devdata;
-	int mcelsius, val1, val2;
+	int mcelsius, val;
 	u32 reg;
 
 	/* Read register and convert to mili Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
 
-	val1 = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1, tsc->coef.a1);
-	val2 = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2, tsc->coef.a2);
-	mcelsius = FIXPT_TO_MCELSIUS((val1 + val2) / 2);
+	if (reg <= thcode[tsc->id][1])
+		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
+				tsc->coef.a1);
+	else
+		val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
+				tsc->coef.a2);
+	mcelsius = FIXPT_TO_MCELSIUS(val);
 
 	/* Make sure we are inside specifications */
 	if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
@@ -351,11 +363,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 	/* default values if FUSEs are missing */
 	/* TODO: Read values from hardware on supported platforms */
 	int ptat[3] = { 2631, 1509, 435 };
-	int thcode[TSC_MAX_NUM][3] = {
-		{ 3397, 2800, 2221 },
-		{ 3393, 2795, 2216 },
-		{ 3389, 2805, 2237 },
-	};
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -410,6 +417,7 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			ret = PTR_ERR(tsc->base);
 			goto error_unregister;
 		}
+		tsc->id = i;
 
 		priv->tscs[i] = tsc;
 
-- 
2.7.4
