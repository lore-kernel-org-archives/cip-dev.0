Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD8EF45A05
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 17:03:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.161292.1775840586520620468
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 10:03:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: ZCMJ0K2iQhCGIWJ7XWlXnA==
X-CSE-MsgGUID: 0fMtE8kEReaCbs8OQwVo/g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2026 02:03:12 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9EA7A402F526;
	Sat, 11 Apr 2026 02:03:11 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 06/11] thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
Date: Fri, 10 Apr 2026 20:02:10 +0300
Message-ID: <20260410170215.393698-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 17:03:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22669

commit 0061030929e2d09398ade9fae320528bdcba2bed upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
temperature calibration via SMC SIP and do not have a reset for the
TSU peripheral, and use different minimum and maximum temperature values
compared to the already supported RZ/G3E.

Although the calibration data is stored in an OTP memory, the OTP itself
is not memory-mapped, access to it is done through an OTP controller.

The OTP controller is only accessible from the secure world,
but the temperature calibration data stored in the OTP is exposed via
SMC.

Add support for retrieving the calibration data using arm_smcc_smc().

Add a compatible for RZ/T2H, RZ/N2H can use it as a fallback.

Reviewed-by: John Madieu <john.madieu.xa@bp.renesas.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260108195223.193531-6-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index 97c4053303e03..dde021e283b7f 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2025 Renesas Electronics Corporation
  */
+#include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
@@ -70,6 +71,10 @@
 #define TSU_POLL_DELAY_US	10	/* Polling interval */
 #define TSU_MIN_CLOCK_RATE	24000000  /* TSU_PCLK minimum 24MHz */
 
+#define RZ_SIP_SVC_GET_SYSTSU	0x82000022
+#define OTP_TSU_REG_ADR_TEMPHI	0x01DC
+#define OTP_TSU_REG_ADR_TEMPLO	0x01DD
+
 struct rzg3e_thermal_priv;
 
 struct rzg3e_thermal_info {
@@ -362,6 +367,21 @@ static int rzg3e_thermal_get_syscon_trim(struct rzg3e_thermal_priv *priv)
 	return 0;
 }
 
+static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
+{
+	struct arm_smccc_res local_res;
+
+	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
+		      0, 0, 0, 0, 0, 0, &local_res);
+	priv->trmval0 = local_res.a0 & TSU_CODE_MAX;
+
+	arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
+		      0, 0, 0, 0, 0, 0, &local_res);
+	priv->trmval1 = local_res.a0 & TSU_CODE_MAX;
+
+	return 0;
+}
+
 static int rzg3e_thermal_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -524,8 +544,15 @@ static const struct rzg3e_thermal_info rzg3e_thermal_info = {
 	.temp_e_mc = 126000,
 };
 
+static const struct rzg3e_thermal_info rzt2h_thermal_info = {
+	.get_trim = rzg3e_thermal_get_smc_trim,
+	.temp_d_mc = -40000,
+	.temp_e_mc = 125000,
+};
+
 static const struct of_device_id rzg3e_thermal_dt_ids[] = {
 	{ .compatible = "renesas,r9a09g047-tsu", .data = &rzg3e_thermal_info },
+	{ .compatible = "renesas,r9a09g077-tsu", .data = &rzt2h_thermal_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3e_thermal_dt_ids);
-- 
2.53.0


