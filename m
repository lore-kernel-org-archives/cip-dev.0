Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B06C433FE
	for <webhook@archiver.kernel.org>; Wed,  2 Nov 2022 19:02:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.10304.1667415726028643175
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Nov 2022 12:02:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.95,234,1661785200"; 
   d="scan'208";a="138796872"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Nov 2022 04:02:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.181])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 15E7840CBDDB;
	Thu,  3 Nov 2022 04:02:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] can: rcar_canfd: fix channel specific IRQ handling for RZ/G2L
Date: Wed,  2 Nov 2022 19:02:00 +0000
Message-Id: <20221102190200.1166569-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Nov 2022 19:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9894

commit d887087c896881715c1a82f1d4f71fbfe5344ffd upstream.

RZ/G2L has separate channel specific IRQs for transmit and error
interrupts. But the IRQ handler processes both channels, even if there
no interrupt occurred on one of the channels.

This patch fixes the issue by passing a channel specific context
parameter instead of global one for the IRQ register and the IRQ
handler, it just handles the channel which is triggered the interrupt.

Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/all/20221025155657.1426948-3-biju.das.jz@bp.renesas.com
Cc: stable@vger.kernel.org
[mkl: adjust commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[biju: fixed the conflicts manually]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 8acae71eb8bf..feba57833cdc 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1195,11 +1195,9 @@ static void rcar_canfd_handle_channel_tx(struct rcar_canfd_global *gpriv, u32 ch
 
 static irqreturn_t rcar_canfd_channel_tx_interrupt(int irq, void *dev_id)
 {
-	struct rcar_canfd_global *gpriv = dev_id;
-	u32 ch;
+	struct rcar_canfd_channel *priv = dev_id;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS)
-		rcar_canfd_handle_channel_tx(gpriv, ch);
+	rcar_canfd_handle_channel_tx(priv->gpriv, priv->channel);
 
 	return IRQ_HANDLED;
 }
@@ -1227,11 +1225,9 @@ static void rcar_canfd_handle_channel_err(struct rcar_canfd_global *gpriv, u32 c
 
 static irqreturn_t rcar_canfd_channel_err_interrupt(int irq, void *dev_id)
 {
-	struct rcar_canfd_global *gpriv = dev_id;
-	u32 ch;
+	struct rcar_canfd_channel *priv = dev_id;
 
-	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS)
-		rcar_canfd_handle_channel_err(gpriv, ch);
+	rcar_canfd_handle_channel_err(priv->gpriv, priv->channel);
 
 	return IRQ_HANDLED;
 }
@@ -1649,6 +1645,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 	priv->ndev = ndev;
 	priv->base = gpriv->base;
 	priv->channel = ch;
+	priv->gpriv = gpriv;
 	priv->can.clock.freq = fcan_freq;
 	dev_info(&pdev->dev, "can_clk rate is %u\n", priv->can.clock.freq);
 
@@ -1677,7 +1674,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 		}
 		err = devm_request_irq(&pdev->dev, err_irq,
 				       rcar_canfd_channel_err_interrupt, 0,
-				       irq_name, gpriv);
+				       irq_name, priv);
 		if (err) {
 			dev_err(&pdev->dev, "devm_request_irq CH Err(%d) failed, error %d\n",
 				err_irq, err);
@@ -1691,7 +1688,7 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 		}
 		err = devm_request_irq(&pdev->dev, tx_irq,
 				       rcar_canfd_channel_tx_interrupt, 0,
-				       irq_name, gpriv);
+				       irq_name, priv);
 		if (err) {
 			dev_err(&pdev->dev, "devm_request_irq Tx (%d) failed, error %d\n",
 				tx_irq, err);
@@ -1715,7 +1712,6 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	priv->can.do_set_mode = rcar_canfd_do_set_mode;
 	priv->can.do_get_berr_counter = rcar_canfd_get_berr_counter;
-	priv->gpriv = gpriv;
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	netif_napi_add(ndev, &priv->napi, rcar_canfd_rx_poll,
-- 
2.25.1


