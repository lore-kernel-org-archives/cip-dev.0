Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C96EEB580
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 16:28:55 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1251.1694449726325808064
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 09:28:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,244,1688396400"; 
   d="scan'208";a="175711378"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Sep 2023 01:28:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E8C39401D15B;
	Tue, 12 Sep 2023 01:28:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/14] regulator: raa215300: Change the scope of the variables {clkin_name, xin_name}
Date: Mon, 11 Sep 2023 17:28:29 +0100
Message-Id: <20230911162840.1115401-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
References: <20230911162840.1115401-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 16:28:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13043

commit 42a95739c5bc4d7a6e93a43117e9283598ba2287 upstream.

Change the scope of the variables {clkin_name, xin_name} from global->local
to fix the below warning.

drivers/regulator/raa215300.c:42:12: sparse: sparse: symbol 'xin_name' was
not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306250552.Fan9WTiN-lkp@intel.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230629104200.102663-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/regulator/raa215300.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/raa215300.c b/drivers/regulator/raa215300.c
index 24a1c89f5dbc..8e1a4c86b978 100644
--- a/drivers/regulator/raa215300.c
+++ b/drivers/regulator/raa215300.c
@@ -38,8 +38,6 @@
 #define RAA215300_REG_BLOCK_EN_RTC_EN	BIT(6)
 #define RAA215300_RTC_DEFAULT_ADDR	0x6f
 
-const char *clkin_name = "clkin";
-const char *xin_name = "xin";
 static struct clk *clk;
 
 static const struct regmap_config raa215300_regmap_config = {
@@ -71,8 +69,10 @@ static int raa215300_clk_present(struct i2c_client *client, const char *name)
 static int raa215300_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	const char *clk_name = xin_name;
+	const char *clkin_name = "clkin";
 	unsigned int pmic_version, val;
+	const char *xin_name = "xin";
+	const char *clk_name = NULL;
 	struct regmap *regmap;
 	int ret;
 
@@ -114,15 +114,17 @@ static int raa215300_i2c_probe(struct i2c_client *client)
 	ret = raa215300_clk_present(client, xin_name);
 	if (ret < 0) {
 		return ret;
-	} else if (!ret) {
+	} else if (ret) {
+		clk_name = xin_name;
+	} else {
 		ret = raa215300_clk_present(client, clkin_name);
 		if (ret < 0)
 			return ret;
-
-		clk_name = clkin_name;
+		if (ret)
+			clk_name = clkin_name;
 	}
 
-	if (ret) {
+	if (clk_name) {
 		char *name = pmic_version >= 0x12 ? "isl1208" : "raa215300_a0";
 		struct device_node *np = client->dev.of_node;
 		u32 addr = RAA215300_RTC_DEFAULT_ADDR;
-- 
2.25.1


