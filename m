Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5CCC04FDF
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:25:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.162189.1692195901931158900
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:25:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787875"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:25:08 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 88F584210E4B;
	Wed, 16 Aug 2023 23:25:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/13] regulator: raa215300: Add build dependency with COMMON_CLK
Date: Wed, 16 Aug 2023 15:24:48 +0100
Message-Id: <20230816142458.147476-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
References: <20230816142458.147476-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:25:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12719

commit e9bd04e52d649c3cfd713b594c5db35cab03c42b upstream.

The COMMON_CLK config is not enabled in some of the architectures.
This causes build issues. Fix these issues by adding build dependency.

ERROR: modpost: "clk_unregister_fixed_rate" [drivers/regulator/raa215300.ko] undefined!
ERROR: modpost: "clk_register_fixed_rate" [drivers/regulator/raa215300.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306282012.sPQAuAN7-lkp@intel.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230628174004.63984-1-biju.das.jz@bp.renesas.com
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 524abe99e406..905c43525ee6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1019,6 +1019,7 @@ config REGULATOR_QCOM_USB_VBUS
 config REGULATOR_RAA215300
 	tristate "Renesas RAA215300 driver"
 	select REGMAP_I2C
+	depends on COMMON_CLK
 	depends on I2C
 	help
 	  Support for the Renesas RAA215300 PMIC.
-- 
2.25.1


