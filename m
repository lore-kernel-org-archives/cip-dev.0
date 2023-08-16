Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D6C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:25:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.162196.1692195911021926766
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:25:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100423"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:25:19 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1D5994210E4B;
	Wed, 16 Aug 2023 23:25:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/13] rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
Date: Wed, 16 Aug 2023 15:24:53 +0100
Message-Id: <20230816142458.147476-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:25:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12724

commit 5923fc75d0dfcebce53894ddada7e2440d756f8b upstream.

Drop enum isl1208_id and split the array isl1208_configs[] as individual
variables, and make lines shorter by referring to e.g. &config_isl1219
instead of &isl1208_configs[TYPE_ISL1219].

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230623140948.384762-9-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 56 +++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 67487a784e58..80ecb724ae6b 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -68,41 +68,51 @@
 
 static struct i2c_driver isl1208_driver;
 
-/* ISL1208 various variants */
-enum isl1208_id {
-	TYPE_ISL1208 = 0,
-	TYPE_ISL1209,
-	TYPE_ISL1218,
-	TYPE_ISL1219,
-	ISL_LAST_ID
-};
-
 /* Chip capabilities table */
-static const struct isl1208_config {
+struct isl1208_config {
 	unsigned int	nvmem_length;
 	unsigned	has_tamper:1;
 	unsigned	has_timestamp:1;
-} isl1208_configs[] = {
-	[TYPE_ISL1208] = { 2, false, false },
-	[TYPE_ISL1209] = { 2, true,  false },
-	[TYPE_ISL1218] = { 8, false, false },
-	[TYPE_ISL1219] = { 2, true,  true },
+};
+
+static const struct isl1208_config config_isl1208 = {
+	.nvmem_length = 2,
+	.has_tamper = false,
+	.has_timestamp = false
+};
+
+static const struct isl1208_config config_isl1209 = {
+	.nvmem_length = 2,
+	.has_tamper = true,
+	.has_timestamp = false
+};
+
+static const struct isl1208_config config_isl1218 = {
+	.nvmem_length = 8,
+	.has_tamper = false,
+	.has_timestamp = false
+};
+
+static const struct isl1208_config config_isl1219 = {
+	.nvmem_length = 2,
+	.has_tamper = true,
+	.has_timestamp = true
 };
 
 static const struct i2c_device_id isl1208_id[] = {
-	{ "isl1208", .driver_data = (kernel_ulong_t)&isl1208_configs[TYPE_ISL1208] },
-	{ "isl1209", .driver_data = (kernel_ulong_t)&isl1208_configs[TYPE_ISL1209] },
-	{ "isl1218", .driver_data = (kernel_ulong_t)&isl1208_configs[TYPE_ISL1218] },
-	{ "isl1219", .driver_data = (kernel_ulong_t)&isl1208_configs[TYPE_ISL1219] },
+	{ "isl1208", .driver_data = (kernel_ulong_t)&config_isl1208 },
+	{ "isl1209", .driver_data = (kernel_ulong_t)&config_isl1209 },
+	{ "isl1218", .driver_data = (kernel_ulong_t)&config_isl1218 },
+	{ "isl1219", .driver_data = (kernel_ulong_t)&config_isl1219 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl1208_id);
 
 static const __maybe_unused struct of_device_id isl1208_of_match[] = {
-	{ .compatible = "isil,isl1208", .data = &isl1208_configs[TYPE_ISL1208] },
-	{ .compatible = "isil,isl1209", .data = &isl1208_configs[TYPE_ISL1209] },
-	{ .compatible = "isil,isl1218", .data = &isl1208_configs[TYPE_ISL1218] },
-	{ .compatible = "isil,isl1219", .data = &isl1208_configs[TYPE_ISL1219] },
+	{ .compatible = "isil,isl1208", .data = &config_isl1208 },
+	{ .compatible = "isil,isl1209", .data = &config_isl1209 },
+	{ .compatible = "isil,isl1218", .data = &config_isl1218 },
+	{ .compatible = "isil,isl1219", .data = &config_isl1219 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, isl1208_of_match);
-- 
2.25.1


