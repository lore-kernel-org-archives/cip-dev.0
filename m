Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354CDC83F21
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:09:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74873.1752487753247271222
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: /6sC5AjpRjO6WK99Q1jIvg==
X-CSE-MsgGUID: kugVDzJOTOiBmO0vMOdr3Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:09:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5C9C841D4BDF;
	Mon, 14 Jul 2025 19:09:15 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 34/57] can: rcar_canfd: Simplify clock handling
Date: Mon, 14 Jul 2025 11:07:15 +0100
Message-ID: <20250714100802.80035-35-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:09:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19462

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit dd20d16dae83733d7c98c167b8d935e7b63db7c7 upstream.

The main CAN clock is either the internal CANFD clock, or the external
CAN clock.  Hence replace the two-valued enum by a simple boolean flag.
Consolidate all CANFD clock handling inside a single branch.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/2cf38c10b83c8e5c04d68b17a930b6d9dbf66f40.1716973640.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 93e39d51d3ca..364ca8360757 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -509,12 +509,6 @@
  */
 #define RCANFD_CFFIFO_IDX		0
 
-/* fCAN clock select register settings */
-enum rcar_canfd_fcanclk {
-	RCANFD_CANFDCLK = 0,		/* CANFD clock */
-	RCANFD_EXTCLK,			/* Externally input clock */
-};
-
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
@@ -546,8 +540,8 @@ struct rcar_canfd_global {
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
-	enum rcar_canfd_fcanclk fcan;	/* CANFD or Ext clock */
 	unsigned long channels_mask;	/* Enabled channels mask */
+	bool extclk;			/* CANFD or Ext clock */
 	bool fdmode;			/* CAN FD or Classical CAN only mode */
 	struct reset_control *rstc1;
 	struct reset_control *rstc2;
@@ -778,7 +772,7 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 		cfg |= RCANFD_GCFG_CMPOC;
 
 	/* Set External Clock if selected */
-	if (gpriv->fcan != RCANFD_CANFDCLK)
+	if (gpriv->extclk)
 		cfg |= RCANFD_GCFG_DCS;
 
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCFG, cfg);
@@ -1935,16 +1929,12 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(gpriv->can_clk),
 					     "cannot get canfd clock\n");
 
-		gpriv->fcan = RCANFD_CANFDCLK;
-
+		/* CANFD clock may be further divided within the IP */
+		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
-		gpriv->fcan = RCANFD_EXTCLK;
+		fcan_freq = clk_get_rate(gpriv->can_clk);
+		gpriv->extclk = true;
 	}
-	fcan_freq = clk_get_rate(gpriv->can_clk);
-
-	if (gpriv->fcan == RCANFD_CANFDCLK)
-		/* CANFD clock is further divided by (1/2) within the IP */
-		fcan_freq /= info->postdiv;
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
@@ -2055,7 +2045,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (clk %d, fdmode %d)\n",
-		 gpriv->fcan, gpriv->fdmode);
+		 gpriv->extclk, gpriv->fdmode);
 	return 0;
 
 fail_channel:
-- 
2.43.0


