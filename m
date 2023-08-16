Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0ABC04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.161772.1692195686088194603
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100257"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:27 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1993F4210C30;
	Wed, 16 Aug 2023 23:21:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 28/31] rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
Date: Wed, 16 Aug 2023 15:20:14 +0100
Message-Id: <20230816142017.147173-29-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12710

commit fdd63f65ac25d0851dade4c7ba94a7a882b8d9c2 upstream.

The built-in RTC found on PMIC RAA215300 is the same as ISL1208.
However, the external oscillator bit is inverted on PMIC version
0x11. The PMIC driver detects PMIC version and instantiates the
RTC device based on i2c_device_id.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230623140948.384762-11-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 915f23668228..b8cb99810ce4 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -74,6 +74,7 @@ struct isl1208_config {
 	unsigned int	nvmem_length;
 	unsigned	has_tamper:1;
 	unsigned	has_timestamp:1;
+	unsigned	has_inverted_osc_bit:1;
 };
 
 static const struct isl1208_config config_isl1208 = {
@@ -100,11 +101,19 @@ static const struct isl1208_config config_isl1219 = {
 	.has_timestamp = true
 };
 
+static const struct isl1208_config config_raa215300_a0 = {
+	.nvmem_length = 2,
+	.has_tamper = false,
+	.has_timestamp = false,
+	.has_inverted_osc_bit = true
+};
+
 static const struct i2c_device_id isl1208_id[] = {
 	{ "isl1208", .driver_data = (kernel_ulong_t)&config_isl1208 },
 	{ "isl1209", .driver_data = (kernel_ulong_t)&config_isl1209 },
 	{ "isl1218", .driver_data = (kernel_ulong_t)&config_isl1218 },
 	{ "isl1219", .driver_data = (kernel_ulong_t)&config_isl1219 },
+	{ "raa215300_a0", .driver_data = (kernel_ulong_t)&config_raa215300_a0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl1208_id);
@@ -893,6 +902,9 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return sr;
 	}
 
+	if (isl1208->config->has_inverted_osc_bit)
+		xtosb_val = !xtosb_val;
+
 	rc = isl1208_set_xtoscb(client, sr, xtosb_val);
 	if (rc)
 		return rc;
-- 
2.25.1


