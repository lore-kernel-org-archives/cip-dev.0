Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AEAEEB58C
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 16:28:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1244.1694449726915033024
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 09:28:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="179434721"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Sep 2023 01:28:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7415A401D167;
	Tue, 12 Sep 2023 01:28:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/14] regulator: raa215300: Fix resource leak in case of error
Date: Mon, 11 Sep 2023 17:28:30 +0100
Message-Id: <20230911162840.1115401-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
References: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 16:28:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13044

commit e21ac64e669e960688e79bf5babeed63132dac8a upstream.

The clk_register_clkdev() allocates memory by calling vclkdev_alloc() and
this memory is not freed in the error path. Similarly, resources allocated
by clk_register_fixed_rate() are not freed in the error path.

Fix these issues by using devm_clk_hw_register_fixed_rate() and
devm_clk_hw_register_clkdev().

After this, the static variable clk is not needed. Replace it with 
local variable hw in probe() and drop calling clk_unregister_fixed_rate()
from raa215300_rtc_unregister_device().

Fixes: 7bce16630837 ("regulator: Add Renesas PMIC RAA215300 driver")
Cc: stable@kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230816135550.146657-2-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/regulator/raa215300.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/raa215300.c b/drivers/regulator/raa215300.c
index 8e1a4c86b978..253645696d0b 100644
--- a/drivers/regulator/raa215300.c
+++ b/drivers/regulator/raa215300.c
@@ -38,8 +38,6 @@
 #define RAA215300_REG_BLOCK_EN_RTC_EN	BIT(6)
 #define RAA215300_RTC_DEFAULT_ADDR	0x6f
 
-static struct clk *clk;
-
 static const struct regmap_config raa215300_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -49,10 +47,6 @@ static const struct regmap_config raa215300_regmap_config = {
 static void raa215300_rtc_unregister_device(void *data)
 {
 	i2c_unregister_device(data);
-	if (!clk) {
-		clk_unregister_fixed_rate(clk);
-		clk = NULL;
-	}
 }
 
 static int raa215300_clk_present(struct i2c_client *client, const char *name)
@@ -130,10 +124,16 @@ static int raa215300_i2c_probe(struct i2c_client *client)
 		u32 addr = RAA215300_RTC_DEFAULT_ADDR;
 		struct i2c_board_info info = {};
 		struct i2c_client *rtc_client;
+		struct clk_hw *hw;
 		ssize_t size;
 
-		clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 32000);
-		clk_register_clkdev(clk, clk_name, NULL);
+		hw = devm_clk_hw_register_fixed_rate(dev, clk_name, NULL, 0, 32000);
+		if (IS_ERR(hw))
+			return PTR_ERR(hw);
+
+		ret = devm_clk_hw_register_clkdev(dev, hw, clk_name, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to initialize clkdev\n");
 
 		if (np) {
 			int i;
-- 
2.25.1


