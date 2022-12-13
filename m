Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00050C4167B
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 17:23:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.79731.1670952204464812552
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 09:23:28 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,241,1665414000"; 
   d="scan'208";a="143214812"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 02:23:27 +0900
Received: from localhost.localdomain (unknown [10.226.93.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E01094053D05;
	Wed, 14 Dec 2022 02:23:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/7] can: rcar_canfd: Use devm_reset_control_get_optional_exclusive
Date: Tue, 13 Dec 2022 17:23:12 +0000
Message-Id: <20221213172316.1848032-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
References: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 17:23:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10224

commit 68399ff574e4faf42b8d85da9339ca3ee2892cc7 upstream.

Replace devm_reset_control_get_exclusive->devm_reset_control_
get_optional_exclusive so that we can avoid unnecessary
SoC specific check in probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20221025155657.1426948-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index a44277f31f69..e485efc00b49 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1805,17 +1805,17 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->fdmode = fdmode;
 	gpriv->chip_id = chip_id;
 
-	if (gpriv->chip_id == RENESAS_RZG2L) {
-		gpriv->rstc1 = devm_reset_control_get_exclusive(&pdev->dev, "rstp_n");
-		if (IS_ERR(gpriv->rstc1))
-			return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc1),
-					     "failed to get rstp_n\n");
-
-		gpriv->rstc2 = devm_reset_control_get_exclusive(&pdev->dev, "rstc_n");
-		if (IS_ERR(gpriv->rstc2))
-			return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc2),
-					     "failed to get rstc_n\n");
-	}
+	gpriv->rstc1 = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								 "rstp_n");
+	if (IS_ERR(gpriv->rstc1))
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc1),
+				     "failed to get rstp_n\n");
+
+	gpriv->rstc2 = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								 "rstc_n");
+	if (IS_ERR(gpriv->rstc2))
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpriv->rstc2),
+				     "failed to get rstc_n\n");
 
 	/* Peripheral clock */
 	gpriv->clkp = devm_clk_get(&pdev->dev, "fck");
-- 
2.25.1


