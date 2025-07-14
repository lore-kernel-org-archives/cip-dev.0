Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F974C83F27
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:18:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74913.1752488245150104217
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: CNg+lzIQREK7hgRn+3JMJg==
X-CSE-MsgGUID: ObaaeJ/7SWy/AKLGTBUB+Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 97C31400D4D1;
	Mon, 14 Jul 2025 19:17:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 31/36] can: rcar_canfd: Add external_clk variable to struct rcar_canfd_hw_info
Date: Mon, 14 Jul 2025 11:16:31 +0100
Message-ID: <20250714101650.80381-32-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:18:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19517

commit e5258b337de26c97cf210858407e0fc881bc0e3d upstream.

All existing SoCs support an external clock, but RZ/G3E has only internal
clocks. Add external_clk variable to struct rcar_canfd_hw_info to handle
this difference.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20250417054320.14100-18-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 67f7b5f6376c4..0bf0e88dfe257 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -541,6 +541,7 @@ struct rcar_canfd_hw_info {
 	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
+	unsigned external_clk:1;	/* Has external clock */
 };
 
 /* Channel priv data */
@@ -690,6 +691,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
+	.external_clk = 1,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -705,6 +707,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.shared_global_irqs = 1,
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
+	.external_clk = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -720,6 +723,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.multi_channel_irqs = 1,
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
+	.external_clk = 1,
 };
 
 /* Helper functions */
@@ -2048,7 +2052,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		fcan_freq = clk_get_rate(gpriv->can_clk) / info->postdiv;
 	} else {
 		fcan_freq = clk_get_rate(gpriv->can_clk);
-		gpriv->extclk = true;
+		gpriv->extclk = gpriv->info->external_clk;
 	}
 
 	addr = devm_platform_ioremap_resource(pdev, 0);
-- 
2.43.0


