Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA075C433FE
	for <webhook@archiver.kernel.org>; Mon, 31 Jan 2022 12:19:36 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.31578.1643631568680544584
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 04:19:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,330,1635174000";
   d="scan'208";a="108231936"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2022 21:19:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EEDCD4347FEA;
	Mon, 31 Jan 2022 21:19:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 23/27] serial: sh-sci: Add support to
 deassert/assert reset line
Date: Mon, 31 Jan 2022 12:18:59 +0000
Message-Id: <20220131121903.8620-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Jan 2022 12:19:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7544

commit 862f72187a41008df2cce3f8e97f57070cbc7060 upstream.

On RZ/G2L SoC we need to explicitly deassert the reset line
for the device to work, use this opportunity to deassert/assert
reset line in sh-sci driver.

This patch adds support to read the "resets" property (if available)
from DT and perform deassert/assert when required.

Also, propagate the error to the caller of sci_parse_dt() instead of
returning NULL in case of failure.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211110232920.19198-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 39 ++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c3fd49480ad3..517aff5f76da 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -37,6 +37,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/scatterlist.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
@@ -3235,23 +3236,47 @@ static const struct of_device_id of_sci_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_sci_match);
 
+static void sci_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 					  unsigned int *dev_id)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct reset_control *rstc;
 	struct plat_sci_port *p;
 	struct sci_port *sp;
 	const void *data;
-	int id;
+	int id, ret;
 
 	if (!IS_ENABLED(CONFIG_OF) || !np)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	data = of_device_get_match_data(&pdev->dev);
 
+	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rstc))
+		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
+					     "failed to get reset ctrl\n"));
+
+	ret = reset_control_deassert(rstc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to deassert reset %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev, sci_reset_control_assert, rstc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register assert devm action, %d\n",
+			ret);
+		return ERR_PTR(ret);
+	}
+
 	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
 	if (!p)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	/* Get the line number from the aliases node. */
 	id = of_alias_get_id(np, "serial");
@@ -3259,11 +3284,11 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 		id = ffz(sci_ports_in_use);
 	if (id < 0) {
 		dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	if (id >= ARRAY_SIZE(sci_ports)) {
 		dev_err(&pdev->dev, "serial%d out of range\n", id);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	sp = &sci_ports[id];
@@ -3350,8 +3375,8 @@ static int sci_probe(struct platform_device *dev)
 
 	if (dev->dev.of_node) {
 		p = sci_parse_dt(dev, &dev_id);
-		if (p == NULL)
-			return -EINVAL;
+		if (IS_ERR(p))
+			return PTR_ERR(p);
 	} else {
 		p = dev->dev.platform_data;
 		if (p == NULL) {
-- 
2.17.1


