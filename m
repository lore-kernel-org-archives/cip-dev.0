Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C3C3DA59
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:18 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5818.1721118180107077795
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="211467688"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8A7424005B53;
	Tue, 16 Jul 2024 17:23:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/31] mfd: da9062: Support SMBus and I2C mode
Date: Tue, 16 Jul 2024 09:22:16 +0100
Message-ID: <20240716082255.56551-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16531

From: Andrej Picej <andrej.picej@norik.com>

commit 5c6f0f456351f5ca7d3b1a82060821eac4a7dc5c upstream.

Enable the I2C bus mode if I2C_FUNC_I2C is set. Based on da6093 commit:
"586478bfc9f7 mfd: da9063: Support SMBus and I2C mode"

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20211124065119.2514872-1-andrej.picej@norik.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/da9062-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 01f8e10dfa55..2774b2cbaea6 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -556,6 +556,7 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
 	regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
+	regmap_reg_range(DA9062AA_CONFIG_J, DA9062AA_CONFIG_J),
 	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
@@ -674,6 +675,17 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* If SMBus is not available and only I2C is possible, enter I2C mode */
+	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
+		dev_info(chip->dev, "Entering I2C mode!\n");
+		ret = regmap_clear_bits(chip->regmap, DA9062AA_CONFIG_J,
+					DA9062AA_TWOWIRE_TO_MASK);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to set Two-Wire Bus Mode.\n");
+			return ret;
+		}
+	}
+
 	ret = da9062_clear_fault_log(chip);
 	if (ret < 0)
 		dev_warn(chip->dev, "Cannot clear fault log\n");
-- 
2.43.0


