Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC86C41513
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5927.1721118184270232470
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215425990"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1C9CB4016D5E;
	Tue, 16 Jul 2024 17:23:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/31] mfd: da9062: Use MFD_CELL_OF macro
Date: Tue, 16 Jul 2024 09:22:18 +0100
Message-ID: <20240716082255.56551-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16533

From: Christoph Niedermaier <cniedermaier@dh-electronics.com>

commit 7d61f6313e90cdbe592eba5e0ae6d1c367b03548 upstream.

Use MFD_CELL_OF macro helper instead of plain struct properties, which makes
the code a bit shorter and to have commonly defined MFD cell attributes.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230309092254.56279-1-cniedermaier@dh-electronics.com
[Biju: Replaced MFD_CELL_OF->OF_MFD_CELL]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/da9062-core.c | 92 ++++++++++-----------------------------
 1 file changed, 24 insertions(+), 68 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index c2acdbcd5d6b..ae5274315554 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -182,34 +182,16 @@ static const struct resource da9061_onkey_resources[] = {
 };
 
 static const struct mfd_cell da9061_devs[] = {
-	{
-		.name		= "da9061-core",
-		.num_resources	= ARRAY_SIZE(da9061_core_resources),
-		.resources	= da9061_core_resources,
-	},
-	{
-		.name		= "da9062-regulators",
-		.num_resources	= ARRAY_SIZE(da9061_regulators_resources),
-		.resources	= da9061_regulators_resources,
-	},
-	{
-		.name		= "da9061-watchdog",
-		.num_resources	= ARRAY_SIZE(da9061_wdt_resources),
-		.resources	= da9061_wdt_resources,
-		.of_compatible  = "dlg,da9061-watchdog",
-	},
-	{
-		.name		= "da9061-thermal",
-		.num_resources	= ARRAY_SIZE(da9061_thermal_resources),
-		.resources	= da9061_thermal_resources,
-		.of_compatible  = "dlg,da9061-thermal",
-	},
-	{
-		.name		= "da9061-onkey",
-		.num_resources	= ARRAY_SIZE(da9061_onkey_resources),
-		.resources	= da9061_onkey_resources,
-		.of_compatible = "dlg,da9061-onkey",
-	},
+	OF_MFD_CELL("da9061-core", da9061_core_resources, NULL, 0, 0,
+		    NULL),
+	OF_MFD_CELL("da9062-regulators", da9061_regulators_resources, NULL, 0, 0,
+		    NULL),
+	OF_MFD_CELL("da9061-watchdog", da9061_wdt_resources, NULL, 0, 0,
+		    "dlg,da9061-watchdog"),
+	OF_MFD_CELL("da9061-thermal", da9061_thermal_resources, NULL, 0, 0,
+		    "dlg,da9061-thermal"),
+	OF_MFD_CELL("da9061-onkey", da9061_onkey_resources, NULL, 0, 0,
+		    "dlg,da9061-onkey"),
 };
 
 static const struct resource da9062_core_resources[] = {
@@ -246,46 +228,20 @@ static const struct resource da9062_gpio_resources[] = {
 };
 
 static const struct mfd_cell da9062_devs[] = {
-	{
-		.name		= "da9062-core",
-		.num_resources	= ARRAY_SIZE(da9062_core_resources),
-		.resources	= da9062_core_resources,
-	},
-	{
-		.name		= "da9062-regulators",
-		.num_resources	= ARRAY_SIZE(da9062_regulators_resources),
-		.resources	= da9062_regulators_resources,
-	},
-	{
-		.name		= "da9062-watchdog",
-		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
-		.resources	= da9062_wdt_resources,
-		.of_compatible  = "dlg,da9062-watchdog",
-	},
-	{
-		.name		= "da9062-thermal",
-		.num_resources	= ARRAY_SIZE(da9062_thermal_resources),
-		.resources	= da9062_thermal_resources,
-		.of_compatible  = "dlg,da9062-thermal",
-	},
-	{
-		.name		= "da9062-rtc",
-		.num_resources	= ARRAY_SIZE(da9062_rtc_resources),
-		.resources	= da9062_rtc_resources,
-		.of_compatible  = "dlg,da9062-rtc",
-	},
-	{
-		.name		= "da9062-onkey",
-		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
-		.resources	= da9062_onkey_resources,
-		.of_compatible	= "dlg,da9062-onkey",
-	},
-	{
-		.name		= "da9062-gpio",
-		.num_resources	= ARRAY_SIZE(da9062_gpio_resources),
-		.resources	= da9062_gpio_resources,
-		.of_compatible	= "dlg,da9062-gpio",
-	},
+	OF_MFD_CELL("da9062-core", da9062_core_resources, NULL, 0, 0,
+		    NULL),
+	OF_MFD_CELL("da9062-regulators", da9062_regulators_resources, NULL, 0, 0,
+		    NULL),
+	OF_MFD_CELL("da9062-watchdog", da9062_wdt_resources, NULL, 0, 0,
+		    "dlg,da9062-watchdog"),
+	OF_MFD_CELL("da9062-thermal", da9062_thermal_resources, NULL, 0, 0,
+		    "dlg,da9062-thermal"),
+	OF_MFD_CELL("da9062-rtc", da9062_rtc_resources, NULL, 0, 0,
+		    "dlg,da9062-rtc"),
+	OF_MFD_CELL("da9062-onkey", da9062_onkey_resources, NULL, 0, 0,
+		    "dlg,da9062-onkey"),
+	OF_MFD_CELL("da9062-gpio", da9062_gpio_resources, NULL, 0, 0,
+		    "dlg,da9062-gpio"),
 };
 
 static int da9062_clear_fault_log(struct da9062 *chip)
-- 
2.43.0


