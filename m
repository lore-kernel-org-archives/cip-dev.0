Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F4FC77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:05:22 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4739.1685963119643595485
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:05:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; 
   d="scan'208";a="165779648"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jun 2023 20:05:21 +0900
Received: from localhost.localdomain (unknown [10.226.93.143])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 79BD141CEB18;
	Mon,  5 Jun 2023 20:05:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/7] tty: serial: sh-sci: Add support for tx end interrupt handling
Date: Mon,  5 Jun 2023 12:05:07 +0100
Message-Id: <20230605110512.111017-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:05:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11790

commit d61ae331d6f35183b38e0c992bc01bf15d8591c3 upstream.

As per the RZ/G2L users hardware manual (Rev.1.20 Sep, 2022), section
23.3.7 Serial Data Transmission (Asynchronous Mode), it is mentioned
that, set the SCR.TIE bit to 0 and SCR.TEIE bit to 1, after the last
data to be transmitted are written to the TDR.

This will generate tx end interrupt and in the handler set SCR.TE and
SCR.TEIE to 0.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230412145053.114847-5-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 31 ++++++++++++++++++++++++++++---
 drivers/tty/serial/sh-sci.h |  3 +++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fe29b05f42c4..39db677a84e7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -855,9 +855,16 @@ static void sci_transmit_chars(struct uart_port *port)
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-	if (uart_circ_empty(xmit))
-		sci_stop_tx(port);
+	if (uart_circ_empty(xmit)) {
+		if (port->type == PORT_SCI) {
+			ctrl = serial_port_in(port, SCSCR);
+			ctrl &= ~SCSCR_TIE;
+			ctrl |= SCSCR_TEIE;
+			serial_port_out(port, SCSCR, ctrl);
+		}
 
+		sci_stop_tx(port);
+	}
 }
 
 /* On SH3, SCIF may read end-of-break as a space->mark char */
@@ -1766,6 +1773,24 @@ static irqreturn_t sci_tx_interrupt(int irq, void *ptr)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
+{
+	struct uart_port *port = ptr;
+	unsigned long flags;
+	unsigned short ctrl;
+
+	if (port->type != PORT_SCI)
+		return sci_tx_interrupt(irq, ptr);
+
+	spin_lock_irqsave(&port->lock, flags);
+	ctrl = serial_port_in(port, SCSCR);
+	ctrl &= ~(SCSCR_TE | SCSCR_TEIE);
+	serial_port_out(port, SCSCR, ctrl);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t sci_br_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
@@ -1902,7 +1927,7 @@ static const struct sci_irq_desc {
 
 	[SCIx_TEI_IRQ] = {
 		.desc = "tx end",
-		.handler = sci_tx_interrupt,
+		.handler = sci_tx_end_interrupt,
 	},
 
 	/*
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index c0ae78632dda..0b65563c4e9e 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -59,6 +59,9 @@ enum {
 #define SCSMR_SRC_19	0x0600	/* Sampling rate 1/19 */
 #define SCSMR_SRC_27	0x0700	/* Sampling rate 1/27 */
 
+/* Serial Control Register, SCI only bits */
+#define SCSCR_TEIE	BIT(2)  /* Transmit End Interrupt Enable */
+
 /* Serial Control Register, SCIFA/SCIFB only bits */
 #define SCSCR_TDRQE	BIT(15)	/* Tx Data Transfer Request Enable */
 #define SCSCR_RDRQE	BIT(14)	/* Rx Data Transfer Request Enable */
-- 
2.25.1


