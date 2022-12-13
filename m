Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85EBC10F1B
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 17:23:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.80098.1670952213713388034
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Dec 2022 09:23:33 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,242,1665414000"; 
   d="scan'208";a="146043464"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2022 02:23:32 +0900
Received: from localhost.localdomain (unknown [10.226.93.72])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ED4A54053D02;
	Wed, 14 Dec 2022 02:23:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 5/7] can: rcar_canfd: Add shared_global_irqs to struct rcar_canfd_hw_info
Date: Tue, 13 Dec 2022 17:23:14 +0000
Message-Id: <20221213172316.1848032-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
References: <20221213172316.1848032-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Dec 2022 17:23:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10226

commit 841645cfc773cdd0a21c67357c53845f2e972f91 upstream.

RZ/G2L has separate IRQ lines for receive FIFO and global error interrupt
whereas R-Car has shared IRQ line.

Add shared_global_irqs to struct rcar_canfd_hw_info to select the driver to
choose between shared and separate irq registration for global
interrupts.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20221027082158.95895-4-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 5727189094d6..6480e8835dc6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -496,6 +496,8 @@ struct rcar_canfd_global;
 
 struct rcar_canfd_hw_info {
 	enum rcanfd_chip_id chip_id;
+	/* hardware features */
+	unsigned shared_global_irqs:1;	/* Has shared global irqs */
 };
 
 /* Channel priv data */
@@ -568,6 +570,7 @@ static const struct can_bittiming_const rcar_canfd_bittiming_const = {
 
 static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.chip_id = RENESAS_RCAR_GEN3,
+	.shared_global_irqs = 1,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -1781,7 +1784,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	if (of_child && of_device_is_available(of_child))
 		channels_mask |= BIT(1);	/* Channel 1 */
 
-	if (info->chip_id == RENESAS_RCAR_GEN3) {
+	if (info->shared_global_irqs) {
 		ch_irq = platform_get_irq_byname_optional(pdev, "ch_int");
 		if (ch_irq < 0) {
 			/* For backward compatibility get irq by index */
@@ -1870,7 +1873,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	gpriv->base = addr;
 
 	/* Request IRQ that's common for both channels */
-	if (info->chip_id == RENESAS_RCAR_GEN3) {
+	if (info->shared_global_irqs) {
 		err = devm_request_irq(&pdev->dev, ch_irq,
 				       rcar_canfd_channel_interrupt, 0,
 				       "canfd.ch_int", gpriv);
-- 
2.25.1


