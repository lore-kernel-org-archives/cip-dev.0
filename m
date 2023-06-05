Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96150C7EE2D
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:05:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.4742.1685963126906425926
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:05:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; 
   d="scan'208";a="162244586"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jun 2023 20:05:28 +0900
Received: from localhost.localdomain (unknown [10.226.93.143])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EB28541CEAF2;
	Mon,  5 Jun 2023 20:05:26 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 5/7] tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support
Date: Mon,  5 Jun 2023 12:05:10 +0100
Message-Id: <20230605110512.111017-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:05:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11793

commit 8749061be196b41a874d71c073c03171bf2741b2 upstream.

SCIFA IP on RZ/G2L SoC has the same signal for both interrupt
and DMA transfer request. Setting DMARS register for DMA transfer
makes the signal to work as a DMA transfer request signal and
subsequent interrupt requests to the interrupt controller
are masked. Similarly clearing DMARS register makes signal to work as
interrupt signal and subsequent interrupt requests to the interrupt
controller are unmasked.

Add SCIFA DMA tx support for RZ/G2L alike SoCs by disabling TXI line
interrupt and setting DMARS registers by DMA api for DMA transfer request.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230412145053.114847-2-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1396554c327a..cb94ad8ea883 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -588,12 +588,17 @@ static void sci_start_tx(struct uart_port *port)
 
 	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
 	    dma_submit_error(s->cookie_tx)) {
+		if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
+			/* Switch irq from SCIF to DMA */
+			disable_irq(s->irqs[SCIx_TXI_IRQ]);
+
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
 	}
 #endif
 
-	if (!s->chan_tx || port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+	if (!s->chan_tx || s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE ||
+	    port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		/* Set TIE (Transmit Interrupt Enable) bit in SCSCR */
 		ctrl = serial_port_in(port, SCSCR);
 
@@ -1231,9 +1236,15 @@ static void sci_dma_tx_complete(void *arg)
 		schedule_work(&s->work_tx);
 	} else {
 		s->cookie_tx = -EINVAL;
-		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
+		    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 			u16 ctrl = serial_port_in(port, SCSCR);
 			serial_port_out(port, SCSCR, ctrl & ~SCSCR_TIE);
+			if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
+				/* Switch irq from DMA to SCIF */
+				dmaengine_pause(s->chan_tx_saved);
+				enable_irq(s->irqs[SCIx_TXI_IRQ]);
+			}
 		}
 	}
 
-- 
2.25.1


