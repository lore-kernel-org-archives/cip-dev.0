Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C45C7EE2F
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:05:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.4742.1685963126906425926
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:05:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; 
   d="scan'208";a="162244589"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jun 2023 20:05:31 +0900
Received: from localhost.localdomain (unknown [10.226.93.143])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6E15D41CEB16;
	Mon,  5 Jun 2023 20:05:29 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 6/7] tty: serial: sh-sci: Add RZ/G2L SCIFA DMA rx support
Date: Mon,  5 Jun 2023 12:05:11 +0100
Message-Id: <20230605110512.111017-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:05:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11794

commit cf383d123869574d1de4304ed73771d3eb5a3d40 upstream.

SCIFA IP on RZ/G2L SoC has the same signal for both interrupt
and DMA transfer request. Setting DMARS register for DMA transfer
makes the signal to work as a DMA transfer request signal and
subsequent interrupt requests to the interrupt controller
are masked. Similarly clearing DMARS register makes signal to work as
interrupt signal and subsequent interrupt requests to the interrupt
controller are unmasked.

Add SCIFA DMA rx support for RZ/G2L alike SoCs by disabling RXI line
interrupt and setting DMARS registers by DMA api for DMA transfer request.

Apart from this, we must set FIFO trigger to 1 for the expected behavior
of the receive transmission.

While at it replace the parameter irq to s->irqs[SCIx_RXI_IRQ] in
disable_irq_nosync() to match enable_irq() in sci_dma_rx_reenable_irq().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230412145053.114847-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cb94ad8ea883..774762143f4e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1316,9 +1316,13 @@ static void sci_dma_rx_reenable_irq(struct sci_port *s)
 
 	/* Direct new serial port interrupts back to CPU */
 	scr = serial_port_in(port, SCSCR);
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
-		scr &= ~SCSCR_RDRQE;
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
+	    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 		enable_irq(s->irqs[SCIx_RXI_IRQ]);
+		if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
+			scif_set_rtrg(port, s->rx_trigger);
+		else
+			scr &= ~SCSCR_RDRQE;
 	}
 	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
 }
@@ -1557,7 +1561,8 @@ static enum hrtimer_restart sci_dma_rx_timer_fn(struct hrtimer *t)
 			tty_flip_buffer_push(&port->state->port);
 	}
 
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
+	    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
 		sci_dma_rx_submit(s, true);
 
 	sci_dma_rx_reenable_irq(s);
@@ -1681,7 +1686,8 @@ static void sci_request_dma(struct uart_port *port)
 
 		s->chan_rx_saved = s->chan_rx = chan;
 
-		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
+		    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
 			sci_dma_rx_submit(s, false);
 	}
 }
@@ -1734,9 +1740,15 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 		u16 ssr = serial_port_in(port, SCxSR);
 
 		/* Disable future Rx interrupts */
-		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
-			disable_irq_nosync(irq);
-			scr |= SCSCR_RDRQE;
+		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
+		    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
+			disable_irq_nosync(s->irqs[SCIx_RXI_IRQ]);
+			if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
+				scif_set_rtrg(port, 1);
+				scr |= SCSCR_RIE;
+			} else {
+				scr |= SCSCR_RDRQE;
+			}
 		} else {
 			if (sci_dma_rx_submit(s, false) < 0)
 				goto handle_pio;
-- 
2.25.1


