Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68107C63702
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:46 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34415.1649075760888079755
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="116695138"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Apr 2022 21:35:59 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D18144285534;
	Mon,  4 Apr 2022 21:35:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/29] spi: spi-rspi: Add support to
 deassert/assert reset line
Date: Mon,  4 Apr 2022 13:35:27 +0100
Message-Id: <20220404123553.25851-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7966

commit aadbff4af5c90919cbe67e2c4d77c68cdefa454e upstream.

On RZ/G2L SoC we need to explicitly deassert the reset line
for the device to work, use this opportunity to deassert/assert
reset line in spi-rspi driver.

This patch adds support to read the "resets" property (if available)
from DT and perform deassert/assert when required.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211118031041.2312-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rspi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index e39fd38f5180..fc491091b3d1 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/sh_dma.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/rspi.h>
@@ -1225,8 +1226,14 @@ static const struct of_device_id rspi_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, rspi_of_match);
 
+static void rspi_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rspi_parse_dt(struct device *dev, struct spi_controller *ctlr)
 {
+	struct reset_control *rstc;
 	u32 num_cs;
 	int error;
 
@@ -1238,6 +1245,24 @@ static int rspi_parse_dt(struct device *dev, struct spi_controller *ctlr)
 	}
 
 	ctlr->num_chipselect = num_cs;
+
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc),
+					     "failed to get reset ctrl\n");
+
+	error = reset_control_deassert(rstc);
+	if (error) {
+		dev_err(dev, "failed to deassert reset %d\n", error);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(dev, rspi_reset_control_assert, rstc);
+	if (error) {
+		dev_err(dev, "failed to register assert devm action, %d\n", error);
+		return error;
+	}
+
 	return 0;
 }
 #else
-- 
2.17.1


