Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379EFF45A01
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 17:03:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.161292.1775840586520620468
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 10:03:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: CLK4ZkK4TMiPUFBAP4FDRA==
X-CSE-MsgGUID: 0B5tl9PfSqqmpgXiWzgpDA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2026 02:03:09 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3F8D7402F558;
	Sat, 11 Apr 2026 02:03:07 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 04/11] thermal: renesas: rzg3e: make calibration value retrieval per-chip
Date: Fri, 10 Apr 2026 20:02:08 +0300
Message-ID: <20260410170215.393698-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 17:03:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22667

commit c33edd8f936ccf2e47eb1883f6b6944643d325c7 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
temperature calibration data via SMC SIP calls.

To prepare for supporting these SoCs, do the following changes.

Rename rzg3e_thermal_parse_dt() to rzg3e_thermal_get_syscon_trim().

Move the syscon usage out of rzg3e_thermal_get_calibration() and into
rzg3e_thermal_get_syscon_trim() and remove single-use variables from the
private state.

Place a pointer to rzg3e_thermal_get_syscon_trim() into the
chip-specific struct, and use it in the probe function to retrieve the
calibration values.

Now that syscon usage has been moved out of
rzg3e_thermal_get_calibration(), remove it and inline the calibration
validation into the probe function.

Also, reuse the TSU_CODE_MAX macro to mask the calibration values, as
GEMASK(11, 0) and 0xFFF are equivalent, and replace the hardcoded 0xFFF
with TSU_CODE_MAX in the calibration validation.

Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260108195223.193531-4-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 79 +++++++++++--------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index 3c9ff5e43d7eb..97c4053303e03 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -70,7 +70,10 @@
 #define TSU_POLL_DELAY_US	10	/* Polling interval */
 #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
 
+struct rzg3e_thermal_priv;
+
 struct rzg3e_thermal_info {
+	int (*get_trim)(struct rzg3e_thermal_priv *priv);
 	int temp_d_mc;
 	int temp_e_mc;
 };
@@ -91,13 +94,11 @@ struct rzg3e_thermal_info {
 struct rzg3e_thermal_priv {
 	void __iomem *base;
 	struct device *dev;
-	struct regmap *syscon;
 	struct thermal_zone_device *zone;
 	struct reset_control *rstc;
 	const struct rzg3e_thermal_info *info;
 	u16 trmval0;
 	u16 trmval1;
-	u32 trim_offset;
 	struct mutex lock;
 };
 
@@ -334,48 +335,30 @@ static const struct thermal_zone_device_ops rzg3e_tz_ops = {
 	.set_trips = rzg3e_thermal_set_trips,
 };
 
-static int rzg3e_thermal_get_calibration(struct rzg3e_thermal_priv *priv)
-{
-	u32 val;
-	int ret;
-
-	/* Read calibration values from syscon */
-	ret = regmap_read(priv->syscon, priv->trim_offset, &val);
-	if (ret)
-		return ret;
-	priv->trmval0 = val & GENMASK(11, 0);
-
-	ret = regmap_read(priv->syscon, priv->trim_offset + 4, &val);
-	if (ret)
-		return ret;
-	priv->trmval1 = val & GENMASK(11, 0);
-
-	/* Validate calibration data */
-	if (!priv->trmval0 || !priv->trmval1 ||
-	    priv->trmval0 == priv->trmval1 ||
-	    priv->trmval0 == 0xFFF || priv->trmval1 == 0xFFF) {
-		dev_err(priv->dev, "Invalid calibration: b=0x%03x, c=0x%03x\n",
-			priv->trmval0, priv->trmval1);
-		return -EINVAL;
-	}
-
-	dev_dbg(priv->dev, "Calibration: b=0x%03x (%u), c=0x%03x (%u)\n",
-		priv->trmval0, priv->trmval0, priv->trmval1, priv->trmval1);
-
-	return 0;
-}
-
-static int rzg3e_thermal_parse_dt(struct rzg3e_thermal_priv *priv)
+static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
 {
 	struct device_node *np = priv->dev->of_node;
+	struct regmap *syscon;
 	u32 offset;
+	int ret;
+	u32 val;
 
-	priv->syscon = syscon_regmap_lookup_by_phandle_args(np, "renesas,tsu-trim", 1, &offset);
-	if (IS_ERR(priv->syscon))
-		return dev_err_probe(priv->dev, PTR_ERR(priv->syscon),
+	syscon = syscon_regmap_lookup_by_phandle_args(np, "renesas,tsu-trim", 1, &offset);
+	if (IS_ERR(syscon))
+		return dev_err_probe(priv->dev, PTR_ERR(syscon),
 				     "Failed to parse renesas,tsu-trim\n");
 
-	priv->trim_offset = offset;
+	/* Read calibration values from syscon */
+	ret = regmap_read(syscon, offset, &val);
+	if (ret)
+		return ret;
+	priv->trmval0 = val & TSU_CODE_MAX;
+
+	ret = regmap_read(syscon, offset + 4, &val);
+	if (ret)
+		return ret;
+	priv->trmval1 = val & TSU_CODE_MAX;
+
 	return 0;
 }
 
@@ -402,11 +385,20 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	/* Parse device tree for trim register info */
-	ret = rzg3e_thermal_parse_dt(priv);
+	ret = priv->info->get_trim(priv);
 	if (ret)
 		return ret;
 
+	if (!priv->trmval0 || !priv->trmval1 ||
+	    priv->trmval0 == priv->trmval1 ||
+	    priv->trmval0 == TSU_CODE_MAX || priv->trmval1 == TSU_CODE_MAX)
+		return dev_err_probe(priv->dev, -EINVAL,
+				     "Invalid calibration: b=0x%03x, c=0x%03x\n",
+				     priv->trmval0, priv->trmval1);
+
+	dev_dbg(priv->dev, "Calibration: b=0x%03x (%u), c=0x%03x (%u)\n",
+		priv->trmval0, priv->trmval0, priv->trmval1, priv->trmval1);
+
 	/* Get clock to verify frequency - clock is managed by power domain */
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
@@ -423,12 +415,6 @@ static int rzg3e_thermal_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "Failed to get/deassert reset control\n");
 
-	/* Get calibration data */
-	ret = rzg3e_thermal_get_calibration(priv);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to get valid calibration data\n");
-
 	/* Get comparison interrupt */
 	irq = platform_get_irq_byname(pdev, "adcmpi");
 	if (irq < 0)
@@ -533,6 +519,7 @@ static const struct dev_pm_ops rzg3e_thermal_pm_ops = {
 };
 
 static const struct rzg3e_thermal_info rzg3e_thermal_info = {
+	.get_trim = rzg3e_thermal_get_syscon_trim,
 	.temp_d_mc = -41000,
 	.temp_e_mc = 126000,
 };
-- 
2.53.0


