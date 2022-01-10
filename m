Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D615AC43217
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 11:53:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30621.1641815634139127276
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 03:53:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106552681"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 20:53:51 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 90E0B429BEB0;
	Mon, 10 Jan 2022 20:53:50 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 01/15] i2c: riic: Add RZ/G2L support
Date: Mon, 10 Jan 2022 11:53:34 +0000
Message-Id: <20220110115348.14297-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 11:53:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7351

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 010e765b406f8e08685ea5b687c63a5ea234719a upstream.

RZ/G2L i2c controller is compatible with RZ/A i2c controller.
By default IP is in reset state, so need to perform release
reset before accessing any register.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 4eccc0f69861..78b84445ee6a 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -42,8 +42,10 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 
 #define RIIC_ICCR1	0x00
 #define RIIC_ICCR2	0x04
@@ -86,6 +88,11 @@
 
 #define RIIC_INIT_MSG	-1
 
+enum riic_type {
+	RIIC_RZ_A,
+	RIIC_RZ_G2L,
+};
+
 struct riic_dev {
 	void __iomem *base;
 	u8 *buf;
@@ -395,7 +402,9 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct resource *res;
 	struct i2c_timings i2c_t;
+	struct reset_control *rstc;
 	int i, ret;
+	enum riic_type type;
 
 	riic = devm_kzalloc(&pdev->dev, sizeof(*riic), GFP_KERNEL);
 	if (!riic)
@@ -412,6 +421,17 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(riic->clk);
 	}
 
+	type = (enum riic_type)of_device_get_match_data(&pdev->dev);
+	if (type == RIIC_RZ_G2L) {
+		rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+		if (IS_ERR(rstc)) {
+			dev_err(&pdev->dev, "Error: missing reset ctrl\n");
+			return PTR_ERR(rstc);
+		}
+
+		reset_control_deassert(rstc);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(riic_irqs); i++) {
 		res = platform_get_resource(pdev, IORESOURCE_IRQ, riic_irqs[i].res_num);
 		if (!res)
@@ -472,7 +492,8 @@ static int riic_i2c_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id riic_i2c_dt_ids[] = {
-	{ .compatible = "renesas,riic-rz" },
+	{ .compatible = "renesas,riic-r9a07g044", .data = (void *)RIIC_RZ_G2L },
+	{ .compatible = "renesas,riic-rz", .data = (void *)RIIC_RZ_A },
 	{ /* Sentinel */ },
 };
 
-- 
2.17.1


