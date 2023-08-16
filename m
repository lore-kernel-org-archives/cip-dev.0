Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA4FC04E69
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:25:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161921.1692195918089632721
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:25:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787900"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:25:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8BC014210E4B;
	Wed, 16 Aug 2023 23:25:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/13] rtc: isl1208: Add isl1208_set_xtoscb()
Date: Wed, 16 Aug 2023 15:24:54 +0100
Message-Id: <20230816142458.147476-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:25:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12725

commit 262f72b4656e182eefaab91ab24a7575dda5524f upstream.

As per the HW manual, set the XTOSCB bit as follows:

If using an external clock signal, set the XTOSCB bit as 1 to
disable the crystal oscillator.

If using an external crystal, the XTOSCB bit needs to be set at 0
to enable the crystal oscillator.

Add isl1208_set_xtoscb() to set XTOSCB bit based on the clock-names
property. Fallback is enabling the internal crystal oscillator.

While at it, introduce a variable "sr" for reading the status register
in probe() as it is reused for writing and also remove the unnecessary
blank line.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230623140948.384762-10-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 57 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 80ecb724ae6b..915f23668228 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bcd.h>
+#include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -175,6 +176,20 @@ isl1208_i2c_validate_client(struct i2c_client *client)
 	return 0;
 }
 
+static int isl1208_set_xtoscb(struct i2c_client *client, int sr, int xtosb_val)
+{
+	/* Do nothing if bit is already set to desired value */
+	if ((sr & ISL1208_REG_SR_XTOSCB) == xtosb_val)
+		return 0;
+
+	if (xtosb_val)
+		sr |= ISL1208_REG_SR_XTOSCB;
+	else
+		sr &= ~ISL1208_REG_SR_XTOSCB;
+
+	return i2c_smbus_write_byte_data(client, ISL1208_REG_SR, sr);
+}
+
 static int
 isl1208_i2c_get_sr(struct i2c_client *client)
 {
@@ -511,7 +526,6 @@ isl1208_i2c_set_time(struct i2c_client *client, struct rtc_time const *tm)
 	return 0;
 }
 
-
 static int
 isl1208_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
@@ -805,12 +819,26 @@ static int isl1208_setup_irq(struct i2c_client *client, int irq)
 	return rc;
 }
 
+static int
+isl1208_clk_present(struct i2c_client *client, const char *name)
+{
+	struct clk *clk;
+
+	clk = devm_clk_get_optional(&client->dev, name);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	return !!clk;
+}
+
 static int
 isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
-	int rc = 0;
 	struct isl1208_state *isl1208;
 	int evdet_irq = -1;
+	int xtosb_val = 0;
+	int rc = 0;
+	int sr;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
@@ -835,6 +863,19 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		isl1208->config = (struct isl1208_config *)id->driver_data;
 	}
 
+	rc = isl1208_clk_present(client, "xin");
+	if (rc < 0)
+		return rc;
+
+	if (!rc) {
+		rc = isl1208_clk_present(client, "clkin");
+		if (rc < 0)
+			return rc;
+
+		if (rc)
+			xtosb_val = 1;
+	}
+
 	isl1208->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl1208->rtc))
 		return PTR_ERR(isl1208->rtc);
@@ -846,13 +887,17 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	isl1208->nvmem_config.size = isl1208->config->nvmem_length;
 	isl1208->nvmem_config.priv = isl1208;
 
-	rc = isl1208_i2c_get_sr(client);
-	if (rc < 0) {
+	sr = isl1208_i2c_get_sr(client);
+	if (sr < 0) {
 		dev_err(&client->dev, "reading status failed\n");
-		return rc;
+		return sr;
 	}
 
-	if (rc & ISL1208_REG_SR_RTCF)
+	rc = isl1208_set_xtoscb(client, sr, xtosb_val);
+	if (rc)
+		return rc;
+
+	if (sr & ISL1208_REG_SR_RTCF)
 		dev_warn(&client->dev, "rtc power failure detected, "
 			 "please set clock.\n");
 
-- 
2.25.1


