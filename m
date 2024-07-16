Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB9C41513
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 07:56:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5540.1721116607082293588
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 00:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211463304"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 16:56:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4914741CF052;
	Tue, 16 Jul 2024 16:56:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 02/23] mfd: da9062: Remove IRQ requirement
Date: Tue, 16 Jul 2024 08:56:07 +0100
Message-ID: <20240716075641.32177-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
References: <20240716075641.32177-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 07:56:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16502

From: Christoph Niedermaier <cniedermaier@dh-electronics.com>

commit c923d5001ba054df10ed3441d24f8f2c01db7e00 upstream.

This patch removes the requirement for an IRQ, because for the core
functionality IRQ isn't needed. So this makes the DA9061/62 chip
usable for designs which haven't connected the IRQ pin.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230309092254.56279-2-cniedermaier@dh-electronics.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/da9062-core.c | 84 +++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index fd2769592a4f..07801696e879 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -181,7 +181,7 @@ static const struct resource da9061_onkey_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_ONKEY, "ONKEY"),
 };
 
-static const struct mfd_cell da9061_devs[] = {
+static const struct mfd_cell da9061_devs_irq[] = {
 	MFD_CELL_OF("da9061-core", da9061_core_resources, NULL, 0, 0,
 		    NULL),
 	MFD_CELL_OF("da9062-regulators", da9061_regulators_resources, NULL, 0, 0,
@@ -194,6 +194,14 @@ static const struct mfd_cell da9061_devs[] = {
 		    "dlg,da9061-onkey"),
 };
 
+static const struct mfd_cell da9061_devs_noirq[] = {
+	MFD_CELL_OF("da9061-core", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("da9062-regulators", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("da9061-watchdog", NULL, NULL, 0, 0, "dlg,da9061-watchdog"),
+	MFD_CELL_OF("da9061-thermal", NULL, NULL, 0, 0, "dlg,da9061-thermal"),
+	MFD_CELL_OF("da9061-onkey", NULL, NULL, 0, 0, "dlg,da9061-onkey"),
+};
+
 static const struct resource da9062_core_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
 };
@@ -227,7 +235,7 @@ static const struct resource da9062_gpio_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_GPI4, 1, "GPI4", IORESOURCE_IRQ),
 };
 
-static const struct mfd_cell da9062_devs[] = {
+static const struct mfd_cell da9062_devs_irq[] = {
 	MFD_CELL_OF("da9062-core", da9062_core_resources, NULL, 0, 0,
 		    NULL),
 	MFD_CELL_OF("da9062-regulators", da9062_regulators_resources, NULL, 0, 0,
@@ -244,6 +252,16 @@ static const struct mfd_cell da9062_devs[] = {
 		    "dlg,da9062-gpio"),
 };
 
+static const struct mfd_cell da9062_devs_noirq[] = {
+	MFD_CELL_OF("da9062-core", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("da9062-regulators", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("da9062-watchdog", NULL, NULL, 0, 0, "dlg,da9062-watchdog"),
+	MFD_CELL_OF("da9062-thermal", NULL, NULL, 0, 0, "dlg,da9062-thermal"),
+	MFD_CELL_OF("da9062-rtc", NULL, NULL, 0, 0, "dlg,da9062-rtc"),
+	MFD_CELL_OF("da9062-onkey", NULL, NULL, 0, 0, "dlg,da9062-onkey"),
+	MFD_CELL_OF("da9062-gpio", NULL, NULL, 0, 0, "dlg,da9062-gpio"),
+};
+
 static int da9062_clear_fault_log(struct da9062 *chip)
 {
 	int ret;
@@ -581,7 +599,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
 	struct da9062 *chip;
-	unsigned int irq_base;
+	unsigned int irq_base = 0;
 	const struct mfd_cell *cell;
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
@@ -601,22 +619,16 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, chip);
 	chip->dev = &i2c->dev;
 
-	if (!i2c->irq) {
-		dev_err(chip->dev, "No IRQ configured\n");
-		return -EINVAL;
-	}
-
+	/* Start with a base configuration without IRQ */
 	switch (chip->chip_type) {
 	case COMPAT_TYPE_DA9061:
-		cell = da9061_devs;
-		cell_num = ARRAY_SIZE(da9061_devs);
-		irq_chip = &da9061_irq_chip;
+		cell = da9061_devs_noirq;
+		cell_num = ARRAY_SIZE(da9061_devs_noirq);
 		config = &da9061_regmap_config;
 		break;
 	case COMPAT_TYPE_DA9062:
-		cell = da9062_devs;
-		cell_num = ARRAY_SIZE(da9062_devs);
-		irq_chip = &da9062_irq_chip;
+		cell = da9062_devs_noirq;
+		cell_num = ARRAY_SIZE(da9062_devs_noirq);
 		config = &da9062_regmap_config;
 		break;
 	default:
@@ -651,29 +663,43 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
-	ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to configure IRQ type\n");
-		return ret;
-	}
+	/* If IRQ is available, reconfigure it accordingly */
+	if (i2c->irq) {
+		if (chip->chip_type == COMPAT_TYPE_DA9061) {
+			cell = da9061_devs_irq;
+			cell_num = ARRAY_SIZE(da9061_devs_irq);
+			irq_chip = &da9061_irq_chip;
+		} else {
+			cell = da9062_devs_irq;
+			cell_num = ARRAY_SIZE(da9062_devs_irq);
+			irq_chip = &da9062_irq_chip;
+		}
 
-	ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
-			trigger_type | IRQF_SHARED | IRQF_ONESHOT,
-			-1, irq_chip, &chip->regmap_irq);
-	if (ret) {
-		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
-			i2c->irq, ret);
-		return ret;
-	}
+		ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to configure IRQ type\n");
+			return ret;
+		}
 
-	irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
+		ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
+					  trigger_type | IRQF_SHARED | IRQF_ONESHOT,
+					  -1, irq_chip, &chip->regmap_irq);
+		if (ret) {
+			dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
+				i2c->irq, ret);
+			return ret;
+		}
+
+		irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
+	}
 
 	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
 			      cell_num, NULL, irq_base,
 			      NULL);
 	if (ret) {
 		dev_err(chip->dev, "Cannot register child devices\n");
-		regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
+		if (i2c->irq)
+			regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
 		return ret;
 	}
 
-- 
2.43.0


