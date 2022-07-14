Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FB4CCA481
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 14:04:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.7947.1657807485091615821
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 07:04:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,271,1650898800";
   d="scan'208";a="127854066"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2022 23:04:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.147])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2ACFC441C336;
	Thu, 14 Jul 2022 23:04:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH [5.10.y-cip] 05/13] thermal/drivers/rz2gl: Fix OTP Calibration
 Register values
Date: Thu, 14 Jul 2022 15:04:24 +0100
Message-Id: <20220714140432.2210982-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714140432.2210982-1-biju.das.jz@bp.renesas.com>
References: <20220714140432.2210982-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 14:04:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8775

commit 2d37f5c90bdc659b329dac7cf6d165a4bbf34cb6 upstream.

As per the latest RZ/G2L Hardware User's Manual (Rev.1.10 Apr, 2022),
the bit 31 of TSU OTP Calibration Register(OTPTSUTRIM) indicates
whether bit [11:0] of OTPTSUTRIM is valid or invalid.

This patch updates the code to reflect this change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220428093346.7552-1-biju.das.jz@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/rzg2l_thermal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 7a9cdc1f37ca..be07e04c6926 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -32,6 +32,8 @@
 #define TSU_SS		0x10
 
 #define OTPTSUTRIM_REG(n)	(0x18 + ((n) * 0x4))
+#define OTPTSUTRIM_EN_MASK	BIT(31)
+#define OTPTSUTRIM_MASK		GENMASK(11, 0)
 
 /* Sensor Mode Register(TSU_SM) */
 #define TSU_SM_EN_TS		BIT(0)
@@ -183,11 +185,15 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	priv->calib0 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(0));
-	if (!priv->calib0)
+	if (priv->calib0 & OTPTSUTRIM_EN_MASK)
+		priv->calib0 &= OTPTSUTRIM_MASK;
+	else
 		priv->calib0 = SW_CALIB0_VAL;
 
 	priv->calib1 = rzg2l_thermal_read(priv, OTPTSUTRIM_REG(1));
-	if (!priv->calib1)
+	if (priv->calib1 & OTPTSUTRIM_EN_MASK)
+		priv->calib1 &= OTPTSUTRIM_MASK;
+	else
 		priv->calib1 = SW_CALIB1_VAL;
 
 	platform_set_drvdata(pdev, priv);
-- 
2.25.1


