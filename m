X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4469.1660581443659508777
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Aug 2022 09:37:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600"; 
   d="scan'208";a="129583874"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 01:37:26 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 62DEE40171F7;
	Tue, 16 Aug 2022 01:37:25 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/4] thermal/drivers/rzg2l: Fix comments
Date: Mon, 15 Aug 2022 17:37:17 +0100
Message-Id: <20220815163718.24056-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 8f5a9371e69664cf4ad22a84204340323d5165cc upstream.

This patch replaces 'Capture times'->'Total number of ADC data samples' as
the former does not really explain much.

It also fixes the typo
 * caliberation->calibration

Lastly, as per the coding style /* should be on a separate line.
This patch fixes this issue.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220718121440.556408-1-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/thermal/rzg2l_thermal.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 3e0e2e4fe27d..792aa6e385c7 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -47,7 +47,7 @@
 
 #define TS_CODE_AVE_SCALE(x)	((x) * 1000000)
 #define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
-#define TS_CODE_CAP_TIMES	8	/* Capture  times */
+#define TS_CODE_CAP_TIMES	8	/* Total number of ADC data samples */
 
 #define RZG2L_THERMAL_GRAN	500	/* milli Celsius */
 #define RZG2L_TSU_SS_TIMEOUT_US	1000
@@ -80,7 +80,8 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	int val, i;
 
 	for (i = 0; i < TS_CODE_CAP_TIMES ; i++) {
-		/* TSU repeats measurement at 20 microseconds intervals and
+		/*
+		 * TSU repeats measurement at 20 microseconds intervals and
 		 * automatically updates the results of measurement. As per
 		 * the HW manual for measuring temperature we need to read 8
 		 * values consecutively and then take the average.
@@ -92,16 +93,18 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 
 	ts_code_ave = result / TS_CODE_CAP_TIMES;
 
-	/* Calculate actual sensor value by applying curvature correction formula
+	/*
+	 * Calculate actual sensor value by applying curvature correction formula
 	 * dsensor = ts_code_ave / (1 + ts_code_ave * 0.000013). Here we are doing
 	 * integer calculation by scaling all the values by 1000000.
 	 */
 	dsensor = TS_CODE_AVE_SCALE(ts_code_ave) /
 		(TS_CODE_AVE_SCALE(1) + (ts_code_ave * CURVATURE_CORRECTION_CONST));
 
-	/* The temperature Tj is calculated by the formula
+	/*
+	 * The temperature Tj is calculated by the formula
 	 * Tj = (dsensor − calib1) * 165/ (calib0 − calib1) − 40
-	 * where calib0 and calib1 are the caliberation values.
+	 * where calib0 and calib1 are the calibration values.
 	 */
 	val = ((dsensor - priv->calib1) * (MCELSIUS(165) /
 		(priv->calib0 - priv->calib1))) - MCELSIUS(40);
@@ -122,7 +125,8 @@ static int rzg2l_thermal_init(struct rzg2l_thermal_priv *priv)
 	rzg2l_thermal_write(priv, TSU_SM, TSU_SM_NORMAL_MODE);
 	rzg2l_thermal_write(priv, TSU_ST, 0);
 
-	/* Before setting the START bit, TSU should be in normal operating
+	/*
+	 * Before setting the START bit, TSU should be in normal operating
 	 * mode. As per the HW manual, it will take 60 µs to place the TSU
 	 * into normal operating mode.
 	 */
@@ -217,7 +221,7 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	dev_dbg(dev, "TSU probed with %s caliberation values",
+	dev_dbg(dev, "TSU probed with %s calibration values",
 		rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0)) ?  "hw" : "sw");
 
 	return 0;
-- 
2.17.1


