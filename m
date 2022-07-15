Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F48BCCA480
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3871.1657869794050960984
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955894"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C659440083E1;
	Fri, 15 Jul 2022 16:23:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 22/24] i2c: riic: Simplify reset handling
Date: Fri, 15 Jul 2022 08:22:42 +0100
Message-Id: <20220715072244.2298757-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8808

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit da2e86c0bd7bc6fdb116dd03c041cf816205cbdc upstream.

Read reset phandle as optional instead of exclusive so that all the DT's
passing the reset phandle can be used to assert/deassert the reset line.
With this change we don't have to differentiate the RZ/G2L SoC.

With the above changes we no longer need the "renesas,riic-r9a07g044"
compatible string, so drop it from riic_i2c_dt_ids[]. No changes are
required to the r9a07g044.dtsi as we already have "renesas,riic-rz" as a
fallback compatible string.

While at it, check the return code of reset_control_deassert() as it might
fail and also add a devres action to assert the reset line.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 78b84445ee6a..3675ad12d45c 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -88,11 +88,6 @@
 
 #define RIIC_INIT_MSG	-1
 
-enum riic_type {
-	RIIC_RZ_A,
-	RIIC_RZ_G2L,
-};
-
 struct riic_dev {
 	void __iomem *base;
 	u8 *buf;
@@ -396,6 +391,11 @@ static struct riic_irq_desc riic_irqs[] = {
 	{ .res_num = 5, .isr = riic_tend_isr, .name = "riic-nack" },
 };
 
+static void riic_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int riic_i2c_probe(struct platform_device *pdev)
 {
 	struct riic_dev *riic;
@@ -404,7 +404,6 @@ static int riic_i2c_probe(struct platform_device *pdev)
 	struct i2c_timings i2c_t;
 	struct reset_control *rstc;
 	int i, ret;
-	enum riic_type type;
 
 	riic = devm_kzalloc(&pdev->dev, sizeof(*riic), GFP_KERNEL);
 	if (!riic)
@@ -421,16 +420,18 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(riic->clk);
 	}
 
-	type = (enum riic_type)of_device_get_match_data(&pdev->dev);
-	if (type == RIIC_RZ_G2L) {
-		rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-		if (IS_ERR(rstc)) {
-			dev_err(&pdev->dev, "Error: missing reset ctrl\n");
-			return PTR_ERR(rstc);
-		}
+	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
+				     "Error: missing reset ctrl\n");
 
-		reset_control_deassert(rstc);
-	}
+	ret = reset_control_deassert(rstc);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, riic_reset_control_assert, rstc);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(riic_irqs); i++) {
 		res = platform_get_resource(pdev, IORESOURCE_IRQ, riic_irqs[i].res_num);
@@ -492,8 +493,7 @@ static int riic_i2c_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id riic_i2c_dt_ids[] = {
-	{ .compatible = "renesas,riic-r9a07g044", .data = (void *)RIIC_RZ_G2L },
-	{ .compatible = "renesas,riic-rz", .data = (void *)RIIC_RZ_A },
+	{ .compatible = "renesas,riic-rz", },
 	{ /* Sentinel */ },
 };
 
-- 
2.25.1


