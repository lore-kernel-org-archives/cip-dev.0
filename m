Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5693C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:55:03 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.10189.1639659298966442092
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:55:02 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="104171940"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2021 21:55:02 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3B5CA4010737;
	Thu, 16 Dec 2021 21:55:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/24] clk: renesas: rzg2l: Add multi clock PM
 support
Date: Thu, 16 Dec 2021 12:54:32 +0000
Message-Id: <20211216125446.15451-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:55:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7133

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 2fa9fd69b3ee015a873e44f7c645ad7bcb79d290 upstream.

Add multi clock PM support for cpg driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210626081344.5783-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/renesas-rzg2l-cpg.c | 51 ++++++++++++++-----------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/renesas/renesas-rzg2l-cpg.c b/drivers/clk/renesas/renesas-rzg2l-cpg.c
index 5009b9e48b13..1941f13bd922 100644
--- a/drivers/clk/renesas/renesas-rzg2l-cpg.c
+++ b/drivers/clk/renesas/renesas-rzg2l-cpg.c
@@ -594,42 +594,49 @@ static int rzg2l_cpg_attach_dev(struct generic_pm_domain *unused, struct device
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args clkspec;
+	bool once = true;
 	struct clk *clk;
 	int error;
 	int i = 0;
 
 	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
 					   &clkspec)) {
-		if (rzg2l_cpg_is_pm_clk(&clkspec))
-			goto found;
-
-		of_node_put(clkspec.np);
+		if (rzg2l_cpg_is_pm_clk(&clkspec)) {
+			if (once) {
+				once = false;
+				error = pm_clk_create(dev);
+				if (error) {
+					of_node_put(clkspec.np);
+					goto err;
+				}
+			}
+			clk = of_clk_get_from_provider(&clkspec);
+			of_node_put(clkspec.np);
+			if (IS_ERR(clk)) {
+				error = PTR_ERR(clk);
+				goto fail_destroy;
+			}
+
+			error = pm_clk_add_clk(dev, clk);
+			if (error) {
+				dev_err(dev, "pm_clk_add_clk failed %d\n",
+					error);
+				goto fail_put;
+			}
+		} else {
+			of_node_put(clkspec.np);
+		}
 		i++;
 	}
 
 	return 0;
 
-found:
-	clk = of_clk_get_from_provider(&clkspec);
-	of_node_put(clkspec.np);
-
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	error = pm_clk_create(dev);
-	if (error)
-		goto fail_put;
-
-	error = pm_clk_add_clk(dev, clk);
-	if (error)
-		goto fail_destroy;
-
-	return 0;
+fail_put:
+	clk_put(clk);
 
 fail_destroy:
 	pm_clk_destroy(dev);
-fail_put:
-	clk_put(clk);
+err:
 	return error;
 }
 
-- 
2.17.1


