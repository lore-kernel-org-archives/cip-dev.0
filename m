Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1B2C4167B
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 17:23:38 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.79736.1670952218516071572
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 09:23:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,241,1665414000"; 
   d="scan'208";a="143214823"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Dec 2022 02:23:38 +0900
Received: from localhost.localdomain (unknown [10.226.93.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 077E94053D07;
	Wed, 14 Dec 2022 02:23:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 7/7] can: rcar_canfd: Add multi_channel_irqs to struct rcar_canfd_hw_info
Date: Tue, 13 Dec 2022 17:23:16 +0000
Message-Id: <20221213172316.1848032-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
References: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 17:23:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10228

commit ea6ff7792203ad6786bda75d1dabf33311c8bef4 upstream.

RZ/G2L has separate IRQ lines for tx and error interrupt for each
channel whereas R-Car has a combined IRQ line for all the channel
specific tx and error interrupts.

Add multi_channel_irqs to struct rcar_canfd_hw_info to select the
driver to choose between combined and separate irq registration for
channel interrupts. This patch also removes enum rcanfd_chip_id and
chip_id from both struct rcar_canfd_hw_info, as it is unused.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20221027082158.95895-6-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[biju: Removed RCar V3U related changes]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fa0b3de0b628..987a899d4527 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -41,11 +41,6 @@
 
 #define RCANFD_DRV_NAME			"rcar_canfd"
 
-enum rcanfd_chip_id {
-	RENESAS_RCAR_GEN3 = 0,
-	RENESAS_RZG2L,
-};
-
 /* Global register bits */
 
 /* RSCFDnCFDGRMCFG */
@@ -495,10 +490,10 @@ enum rcar_canfd_fcanclk {
 struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
-	enum rcanfd_chip_id chip_id;
 	u8 postdiv;
 	/* hardware features */
 	unsigned shared_global_irqs:1;	/* Has shared global irqs */
+	unsigned multi_channel_irqs:1;	/* Has multiple channel irqs */
 };
 
 /* Channel priv data */
@@ -570,14 +565,13 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 };
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
-	.chip_id = RENESAS_RCAR_GEN3,
 	.postdiv = 2,
 	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
-	.chip_id = RENESAS_RZG2L,
 	.postdiv = 1,
+	.multi_channel_irqs = 1,
 };
 
 /* Helper functions */
@@ -1665,7 +1659,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv->can.clock.freq = fcan_freq;
 	dev_info(&pdev->dev, "can_clk rate is %u\n", priv->can.clock.freq);
 
-	if (info->chip_id == RENESAS_RZG2L) {
+	if (info->multi_channel_irqs) {
 		char *irq_name;
 		int err_irq;
 		int tx_irq;
-- 
2.25.1


