Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C75C41513
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5927.1721118184270232470
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215425972"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:03 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C74654005B53;
	Tue, 16 Jul 2024 17:23:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/31] mfd: da9xxx-core: Constify static struct resource
Date: Tue, 16 Jul 2024 09:22:13 +0100
Message-ID: <20240716082255.56551-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16528

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

commit a0fa0abeb508360bea82a84ce83aea49769641d3 upstream.

Constify a number of static struct resource. The only usage of the
structs are to assign their address to the resources field in the
mfd_cell struct. This allows the compiler to put them in read-only
memory. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/da9055-core.c |  8 ++++----
 drivers/mfd/da9062-core.c | 24 ++++++++++++------------
 drivers/mfd/da9063-core.c |  8 ++++----
 drivers/mfd/da9150-core.c |  6 +++---
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index 6d0af8486269..d074d213e661 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -254,14 +254,14 @@ const struct regmap_config da9055_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(da9055_regmap_config);
 
-static struct resource da9055_onkey_resource = {
+static const struct resource da9055_onkey_resource = {
 	.name = "ONKEY",
 	.start = DA9055_IRQ_NONKEY,
 	.end   = DA9055_IRQ_NONKEY,
 	.flags = IORESOURCE_IRQ,
 };
 
-static struct resource da9055_rtc_resource[] = {
+static const struct resource da9055_rtc_resource[] = {
 	{
 		.name = "ALM",
 		.start = DA9055_IRQ_ALARM,
@@ -276,14 +276,14 @@ static struct resource da9055_rtc_resource[] = {
 	},
 };
 
-static struct resource da9055_hwmon_resource = {
+static const struct resource da9055_hwmon_resource = {
 	.name = "HWMON",
 	.start = DA9055_IRQ_HWMON,
 	.end   = DA9055_IRQ_HWMON,
 	.flags = IORESOURCE_IRQ,
 };
 
-static struct resource da9055_ld05_6_resource = {
+static const struct resource da9055_ld05_6_resource = {
 	.name = "REGULATOR",
 	.start = DA9055_IRQ_REGULATOR,
 	.end   = DA9055_IRQ_REGULATOR,
diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index fc30726e2e27..9583a98d3aae 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -160,23 +160,23 @@ static struct regmap_irq_chip da9062_irq_chip = {
 	.ack_base = DA9062AA_EVENT_A,
 };
 
-static struct resource da9061_core_resources[] = {
+static const struct resource da9061_core_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_VDD_WARN, "VDD_WARN"),
 };
 
-static struct resource da9061_regulators_resources[] = {
+static const struct resource da9061_regulators_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_LDO_LIM, "LDO_LIM"),
 };
 
-static struct resource da9061_thermal_resources[] = {
+static const struct resource da9061_thermal_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_TEMP, "THERMAL"),
 };
 
-static struct resource da9061_wdt_resources[] = {
+static const struct resource da9061_wdt_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_WDG_WARN, "WD_WARN"),
 };
 
-static struct resource da9061_onkey_resources[] = {
+static const struct resource da9061_onkey_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_ONKEY, "ONKEY"),
 };
 
@@ -211,32 +211,32 @@ static const struct mfd_cell da9061_devs[] = {
 	},
 };
 
-static struct resource da9062_core_resources[] = {
+static const struct resource da9062_core_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_regulators_resources[] = {
+static const struct resource da9062_regulators_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_LDO_LIM, 1, "LDO_LIM", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_thermal_resources[] = {
+static const struct resource da9062_thermal_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_TEMP, 1, "THERMAL", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_wdt_resources[] = {
+static const struct resource da9062_wdt_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_rtc_resources[] = {
+static const struct resource da9062_rtc_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_ALARM, 1, "ALARM", IORESOURCE_IRQ),
 	DEFINE_RES_NAMED(DA9062_IRQ_TICK, 1, "TICK", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_onkey_resources[] = {
+static const struct resource da9062_onkey_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
 };
 
-static struct resource da9062_gpio_resources[] = {
+static const struct resource da9062_gpio_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_GPI0, 1, "GPI0", IORESOURCE_IRQ),
 	DEFINE_RES_NAMED(DA9062_IRQ_GPI1, 1, "GPI1", IORESOURCE_IRQ),
 	DEFINE_RES_NAMED(DA9062_IRQ_GPI2, 1, "GPI2", IORESOURCE_IRQ),
diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index a353d52210a9..df407c3afce3 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -29,7 +29,7 @@
 #include <linux/uaccess.h>
 
 
-static struct resource da9063_regulators_resources[] = {
+static const struct resource da9063_regulators_resources[] = {
 	{
 		.name	= "LDO_LIM",
 		.start	= DA9063_IRQ_LDO_LIM,
@@ -38,7 +38,7 @@ static struct resource da9063_regulators_resources[] = {
 	},
 };
 
-static struct resource da9063_rtc_resources[] = {
+static const struct resource da9063_rtc_resources[] = {
 	{
 		.name	= "ALARM",
 		.start	= DA9063_IRQ_ALARM,
@@ -53,7 +53,7 @@ static struct resource da9063_rtc_resources[] = {
 	}
 };
 
-static struct resource da9063_onkey_resources[] = {
+static const struct resource da9063_onkey_resources[] = {
 	{
 		.name	= "ONKEY",
 		.start	= DA9063_IRQ_ONKEY,
@@ -62,7 +62,7 @@ static struct resource da9063_onkey_resources[] = {
 	},
 };
 
-static struct resource da9063_hwmon_resources[] = {
+static const struct resource da9063_hwmon_resources[] = {
 	{
 		.start	= DA9063_IRQ_ADC_RDY,
 		.end	= DA9063_IRQ_ADC_RDY,
diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index 7f0aa1e8db96..d8b0cde48589 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -350,18 +350,18 @@ static const struct regmap_irq_chip da9150_regmap_irq_chip = {
 	.num_irqs = ARRAY_SIZE(da9150_irqs),
 };
 
-static struct resource da9150_gpadc_resources[] = {
+static const struct resource da9150_gpadc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_GPADC, "GPADC"),
 };
 
-static struct resource da9150_charger_resources[] = {
+static const struct resource da9150_charger_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_CHG, "CHG_STATUS"),
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_TJUNC, "CHG_TJUNC"),
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_VFAULT, "CHG_VFAULT"),
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_VBUS, "CHG_VBUS"),
 };
 
-static struct resource da9150_fg_resources[] = {
+static const struct resource da9150_fg_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9150_IRQ_FG, "FG"),
 };
 
-- 
2.43.0


