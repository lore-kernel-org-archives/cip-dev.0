Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6835FD7097
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:34 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73429.1773746244977443924
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VszUUiLh;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486b9675d36so3199835e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746243; x=1774351043; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIX0DBo16BKGuPvGLV3hCc9g2aBr4O5a7vfVlVL7pwo=;
        b=VszUUiLhAa8aAm95jDR760CMjqvEvUuaR5qNAQGX0zIKrM1vvwOrHmR+fwhLW6xORQ
         +Ry3jBqADPTnIann1mndck4swqULtYdC9HuXxt0zcmySm5EDZwcq1kAM2UQJhDaWmWxc
         CTXxGVg7e8dlZ2l/mPpuU7iEEdfhlCozNNSVdd97zg7P4/RwNCVY74WxrnCrcEJzZdu2
         1XNkjYdhT7b1zFdl82JRiPobkuaWlsdyhy6d6Wd2rTFbSHmgZMbvJ5ySQ55ohVTnmGai
         1PLoRF2APKKgI9LyrdKucbdEzWQibwhVIbW1Jcsc8p5of4jSzoSnS01RAYDzPDBzY2AF
         /w1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746243; x=1774351043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIX0DBo16BKGuPvGLV3hCc9g2aBr4O5a7vfVlVL7pwo=;
        b=c4NRVqZqpwThxXbbFcvehShqk8gSP3WKGkhpGj/F4H98VSBp6Uh/9jPpYSoTI8CuO2
         MV6xagwrDaCa3Jn9beDN50zYCE5u8JZ0/+DW9xCY4/Adr3kFadiEy0L8rYYstqmkU6TP
         8cUaxpNZjWhUGobfi1tQkEVzbt1gXANKeAX4pjo+LG2iKUUuEt8uaGDrwcN5f4PCB0cV
         OhC/QF/5WFNqXjl23xCqSiKWbXA+EXlq6HeQZa4l0T8VYiKVf89DQG9mGJMh//k/52v/
         lQ60Q3J5ICHd31KAj6CQcI1wxDQZatE7wejbev8pQSI9fBUeJciLIxwOebREpTqMM/Qu
         kXWw==
X-Gm-Message-State: AOJu0YyYGG9usoeZscnftlBt8fIQ5B3b1wZNDGArFiWyK+OSBCc+1npS
	pVvdUJzCMQ22fZDZ1OP0xbwawArJc9LajU6PM04ZLpmIEOWsi6Rt4Z+4KaIj4Q==
X-Gm-Gg: ATEYQzzI7VB/ardMBaMmojvcZMVLP4qQvaEFS/V7skeTSpge9BB4yrgHZY2C++NC26w
	b+YdtwJqI9fVT/3sAmkLNq4EsR8DluG+maVNQCgcFSoQ2BG5KPouCCcS1uVScOOpPW0bYRgc0my
	qHfrKrNpyLAkOhAQtAGtsZfjq9ytnbtSGtAH/C4q4Tx0BDdI7IydDDIB330roZlknojBAJ6dAqO
	MfD/GEqAeT0RI0tXlod/w6cJ7PmJNPv0Myp6U4hUTPQHHsOyISSwAOKut/00Sz/rXz4uoICOyVz
	dqZhmOOBH5uamnC7ekVr2gPdkSWEANj3cSdlhvMDEzSq4hntkOQUT4tr0SNhT6fQQmmJcxl0kAa
	3fTMYnHje3j/mcaTwCV2CowwKg2rwafgE8lyv/nBqko76LIe8co1PqFAOUkmF/cwRWaQOgcSiSH
	SQPymZgJXA/OZ6k8gEx56+l6eYpI0lFgcJWJzlArhnStpTrakC
X-Received: by 2002:a05:600c:3b14:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-485566d5178mr280708885e9.10.1773746242827;
        Tue, 17 Mar 2026 04:17:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:22 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/39] serial: sh-sci: Call sci_serial_{in,out}() directly
Date: Tue, 17 Mar 2026 11:16:29 +0000
Message-ID: <20260317111718.281633-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22437

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 6deab51402b129abea0e2f0a5e2ce27c06918973 ]

Unlike the 8250 serial driver complex, the sh-sci driver uses only a
single pair of functions to read and write serial port registers.
Hence there is no need to incur the overhead of calling them through
indirection, like the serial_port_{in,out}() wrappers do.

Replace all calls to these wrappers by direct calls to
sci_serial_{in,out}().

Remove the setup of the uart_port.serial_{in,out}() callbacks.  After
removal of all calls to serial_port_{in,out}() in the sh-sci driver, the
only remaining user is uart_xchar_out(), which the sh-sci driver does
not use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/51e79d601cb9d9d63822d3773d3cf05a96868612.1709548811.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Retained spin_lock_irq{save,restore} ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 231 +++++++++++++++++-------------------
 1 file changed, 112 insertions(+), 119 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 670e866dca13..f29268bcec35 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -628,13 +628,13 @@ static void sci_start_tx(struct uart_port *port)
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
-		u16 new, scr = serial_port_in(port, SCSCR);
+		u16 new, scr = sci_serial_in(port, SCSCR);
 		if (s->chan_tx)
 			new = scr | SCSCR_TDRQE;
 		else
 			new = scr & ~SCSCR_TDRQE;
 		if (new != scr)
-			serial_port_out(port, SCSCR, new);
+			sci_serial_out(port, SCSCR, new);
 	}
 
 	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
@@ -651,7 +651,7 @@ static void sci_start_tx(struct uart_port *port)
 	if (!s->chan_tx || s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE ||
 	    port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		/* Set TIE (Transmit Interrupt Enable) bit in SCSCR */
-		ctrl = serial_port_in(port, SCSCR);
+		ctrl = sci_serial_in(port, SCSCR);
 
 		/*
 		 * For SCI, TE (transmit enable) must be set after setting TIE
@@ -661,7 +661,7 @@ static void sci_start_tx(struct uart_port *port)
 		if (port->type == PORT_SCI)
 			ctrl |= SCSCR_TE;
 
-		serial_port_out(port, SCSCR, ctrl | SCSCR_TIE);
+		sci_serial_out(port, SCSCR, ctrl | SCSCR_TIE);
 	}
 }
 
@@ -670,14 +670,14 @@ static void sci_stop_tx(struct uart_port *port)
 	unsigned short ctrl;
 
 	/* Clear TIE (Transmit Interrupt Enable) bit in SCSCR */
-	ctrl = serial_port_in(port, SCSCR);
+	ctrl = sci_serial_in(port, SCSCR);
 
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 		ctrl &= ~SCSCR_TDRQE;
 
 	ctrl &= ~SCSCR_TIE;
 
-	serial_port_out(port, SCSCR, ctrl);
+	sci_serial_out(port, SCSCR, ctrl);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	if (to_sci_port(port)->chan_tx &&
@@ -692,41 +692,40 @@ static void sci_start_rx(struct uart_port *port)
 {
 	unsigned short ctrl;
 
-	ctrl = serial_port_in(port, SCSCR) | port_rx_irq_mask(port);
+	ctrl = sci_serial_in(port, SCSCR) | port_rx_irq_mask(port);
 
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 		ctrl &= ~SCSCR_RDRQE;
 
-	serial_port_out(port, SCSCR, ctrl);
+	sci_serial_out(port, SCSCR, ctrl);
 }
 
 static void sci_stop_rx(struct uart_port *port)
 {
 	unsigned short ctrl;
 
-	ctrl = serial_port_in(port, SCSCR);
+	ctrl = sci_serial_in(port, SCSCR);
 
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 		ctrl &= ~SCSCR_RDRQE;
 
 	ctrl &= ~port_rx_irq_mask(port);
 
-	serial_port_out(port, SCSCR, ctrl);
+	sci_serial_out(port, SCSCR, ctrl);
 }
 
 static void sci_clear_SCxSR(struct uart_port *port, unsigned int mask)
 {
 	if (port->type == PORT_SCI) {
 		/* Just store the mask */
-		serial_port_out(port, SCxSR, mask);
+		sci_serial_out(port, SCxSR, mask);
 	} else if (to_sci_port(port)->params->overrun_mask == SCIFA_ORER) {
 		/* SCIFA/SCIFB and SCIF on SH7705/SH7720/SH7721 */
 		/* Only clear the status bits we want to clear */
-		serial_port_out(port, SCxSR,
-				serial_port_in(port, SCxSR) & mask);
+		sci_serial_out(port, SCxSR, sci_serial_in(port, SCxSR) & mask);
 	} else {
 		/* Store the mask, clear parity/framing errors */
-		serial_port_out(port, SCxSR, mask & ~(SCIF_FERC | SCIF_PERC));
+		sci_serial_out(port, SCxSR, mask & ~(SCIF_FERC | SCIF_PERC));
 	}
 }
 
@@ -740,7 +739,7 @@ static int sci_poll_get_char(struct uart_port *port)
 	int c;
 
 	do {
-		status = serial_port_in(port, SCxSR);
+		status = sci_serial_in(port, SCxSR);
 		if (status & SCxSR_ERRORS(port)) {
 			sci_clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
 			continue;
@@ -751,10 +750,10 @@ static int sci_poll_get_char(struct uart_port *port)
 	if (!(status & SCxSR_RDxF(port)))
 		return NO_POLL_CHAR;
 
-	c = serial_port_in(port, SCxRDR);
+	c = sci_serial_in(port, SCxRDR);
 
 	/* Dummy read */
-	serial_port_in(port, SCxSR);
+	sci_serial_in(port, SCxSR);
 	sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 
 	return c;
@@ -766,10 +765,10 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 	unsigned short status;
 
 	do {
-		status = serial_port_in(port, SCxSR);
+		status = sci_serial_in(port, SCxSR);
 	} while (!(status & SCxSR_TDxE(port)));
 
-	serial_port_out(port, SCxTDR, c);
+	sci_serial_out(port, SCxTDR, c);
 	sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
@@ -788,8 +787,8 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 	}
 
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
-		u16 data = serial_port_in(port, SCPDR);
-		u16 ctrl = serial_port_in(port, SCPCR);
+		u16 data = sci_serial_in(port, SCPDR);
+		u16 ctrl = sci_serial_in(port, SCPCR);
 
 		/* Enable RXD and TXD pin functions */
 		ctrl &= ~(SCPCR_RXDC | SCPCR_TXDC);
@@ -821,7 +820,7 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 			status &= ~SCSPTR_RTSDT;
 		/* CTS# and SCK are inputs */
 		status &= ~(SCSPTR_CTSIO | SCSPTR_SCKIO);
-		serial_port_out(port, SCSPTR, status);
+		sci_serial_out(port, SCSPTR, status);
 	}
 }
 
@@ -833,13 +832,13 @@ static int sci_txfill(struct uart_port *port)
 
 	reg = sci_getreg(port, SCTFDR);
 	if (reg->size)
-		return serial_port_in(port, SCTFDR) & fifo_mask;
+		return sci_serial_in(port, SCTFDR) & fifo_mask;
 
 	reg = sci_getreg(port, SCFDR);
 	if (reg->size)
-		return serial_port_in(port, SCFDR) >> 8;
+		return sci_serial_in(port, SCFDR) >> 8;
 
-	return !(serial_port_in(port, SCxSR) & SCI_TDRE);
+	return !(sci_serial_in(port, SCxSR) & SCI_TDRE);
 }
 
 static int sci_txroom(struct uart_port *port)
@@ -855,13 +854,13 @@ static int sci_rxfill(struct uart_port *port)
 
 	reg = sci_getreg(port, SCRFDR);
 	if (reg->size)
-		return serial_port_in(port, SCRFDR) & fifo_mask;
+		return sci_serial_in(port, SCRFDR) & fifo_mask;
 
 	reg = sci_getreg(port, SCFDR);
 	if (reg->size)
-		return serial_port_in(port, SCFDR) & fifo_mask;
+		return sci_serial_in(port, SCFDR) & fifo_mask;
 
-	return (serial_port_in(port, SCxSR) & SCxSR_RDxF(port)) != 0;
+	return (sci_serial_in(port, SCxSR) & SCxSR_RDxF(port)) != 0;
 }
 
 /* ********************************************************************** *
@@ -877,14 +876,14 @@ static void sci_transmit_chars(struct uart_port *port)
 	unsigned short ctrl;
 	int count;
 
-	status = serial_port_in(port, SCxSR);
+	status = sci_serial_in(port, SCxSR);
 	if (!(status & SCxSR_TDxE(port))) {
-		ctrl = serial_port_in(port, SCSCR);
+		ctrl = sci_serial_in(port, SCSCR);
 		if (uart_circ_empty(xmit))
 			ctrl &= ~SCSCR_TIE;
 		else
 			ctrl |= SCSCR_TIE;
-		serial_port_out(port, SCSCR, ctrl);
+		sci_serial_out(port, SCSCR, ctrl);
 		return;
 	}
 
@@ -900,15 +899,15 @@ static void sci_transmit_chars(struct uart_port *port)
 			c = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		} else if (port->type == PORT_SCI && uart_circ_empty(xmit)) {
-			ctrl = serial_port_in(port, SCSCR);
+			ctrl = sci_serial_in(port, SCSCR);
 			ctrl &= ~SCSCR_TE;
-			serial_port_out(port, SCSCR, ctrl);
+			sci_serial_out(port, SCSCR, ctrl);
 			return;
 		} else {
 			break;
 		}
 
-		serial_port_out(port, SCxTDR, c);
+		sci_serial_out(port, SCxTDR, c);
 		s->tx_occurred = true;
 
 		port->icount.tx++;
@@ -920,10 +919,10 @@ static void sci_transmit_chars(struct uart_port *port)
 		uart_write_wakeup(port);
 	if (uart_circ_empty(xmit)) {
 		if (port->type == PORT_SCI) {
-			ctrl = serial_port_in(port, SCSCR);
+			ctrl = sci_serial_in(port, SCSCR);
 			ctrl &= ~SCSCR_TIE;
 			ctrl |= SCSCR_TEIE;
-			serial_port_out(port, SCSCR, ctrl);
+			sci_serial_out(port, SCSCR, ctrl);
 		}
 
 		sci_stop_tx(port);
@@ -937,7 +936,7 @@ static void sci_receive_chars(struct uart_port *port)
 	unsigned short status;
 	unsigned char flag;
 
-	status = serial_port_in(port, SCxSR);
+	status = sci_serial_in(port, SCxSR);
 	if (!(status & SCxSR_RDxF(port)))
 		return;
 
@@ -950,7 +949,7 @@ static void sci_receive_chars(struct uart_port *port)
 			break;
 
 		if (port->type == PORT_SCI) {
-			char c = serial_port_in(port, SCxRDR);
+			char c = sci_serial_in(port, SCxRDR);
 			if (uart_handle_sysrq_char(port, c))
 				count = 0;
 			else
@@ -961,11 +960,11 @@ static void sci_receive_chars(struct uart_port *port)
 
 				if (port->type == PORT_SCIF ||
 				    port->type == PORT_HSCIF) {
-					status = serial_port_in(port, SCxSR);
-					c = serial_port_in(port, SCxRDR);
+					status = sci_serial_in(port, SCxSR);
+					c = sci_serial_in(port, SCxRDR);
 				} else {
-					c = serial_port_in(port, SCxRDR);
-					status = serial_port_in(port, SCxSR);
+					c = sci_serial_in(port, SCxRDR);
+					status = sci_serial_in(port, SCxSR);
 				}
 				if (uart_handle_sysrq_char(port, c)) {
 					count--; i--;
@@ -986,7 +985,7 @@ static void sci_receive_chars(struct uart_port *port)
 			}
 		}
 
-		serial_port_in(port, SCxSR); /* dummy read */
+		sci_serial_in(port, SCxSR); /* dummy read */
 		sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 
 		copied += count;
@@ -998,8 +997,8 @@ static void sci_receive_chars(struct uart_port *port)
 		tty_flip_buffer_push(tport);
 	} else {
 		/* TTY buffers full; read from RX reg to prevent lockup */
-		serial_port_in(port, SCxRDR);
-		serial_port_in(port, SCxSR); /* dummy read */
+		sci_serial_in(port, SCxRDR);
+		sci_serial_in(port, SCxSR); /* dummy read */
 		sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 	}
 }
@@ -1007,7 +1006,7 @@ static void sci_receive_chars(struct uart_port *port)
 static int sci_handle_errors(struct uart_port *port)
 {
 	int copied = 0;
-	unsigned short status = serial_port_in(port, SCxSR);
+	unsigned short status = sci_serial_in(port, SCxSR);
 	struct tty_port *tport = &port->state->port;
 	struct sci_port *s = to_sci_port(port);
 
@@ -1054,10 +1053,10 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	if (!reg->size)
 		return 0;
 
-	status = serial_port_in(port, s->params->overrun_reg);
+	status = sci_serial_in(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
 		status &= ~s->params->overrun_mask;
-		serial_port_out(port, s->params->overrun_reg, status);
+		sci_serial_out(port, s->params->overrun_reg, status);
 
 		port->icount.overrun++;
 
@@ -1072,7 +1071,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 static int sci_handle_breaks(struct uart_port *port)
 {
 	int copied = 0;
-	unsigned short status = serial_port_in(port, SCxSR);
+	unsigned short status = sci_serial_in(port, SCxSR);
 	struct tty_port *tport = &port->state->port;
 
 	if (uart_handle_break(port))
@@ -1105,7 +1104,7 @@ static int scif_set_rtrg(struct uart_port *port, int rx_trig)
 
 	/* HSCIF can be set to an arbitrary level. */
 	if (sci_getreg(port, HSRTRGR)->size) {
-		serial_port_out(port, HSRTRGR, rx_trig);
+		sci_serial_out(port, HSRTRGR, rx_trig);
 		return rx_trig;
 	}
 
@@ -1146,9 +1145,9 @@ static int scif_set_rtrg(struct uart_port *port, int rx_trig)
 		return 1;
 	}
 
-	serial_port_out(port, SCFCR,
-		(serial_port_in(port, SCFCR) &
-		~(SCFCR_RTRG1 | SCFCR_RTRG0)) | bits);
+	sci_serial_out(port, SCFCR,
+		       (sci_serial_in(port, SCFCR) &
+			~(SCFCR_RTRG1 | SCFCR_RTRG0)) | bits);
 
 	return rx_trig;
 }
@@ -1156,9 +1155,9 @@ static int scif_set_rtrg(struct uart_port *port, int rx_trig)
 static int scif_rtrg_enabled(struct uart_port *port)
 {
 	if (sci_getreg(port, HSRTRGR)->size)
-		return serial_port_in(port, HSRTRGR) != 0;
+		return sci_serial_in(port, HSRTRGR) != 0;
 	else
-		return (serial_port_in(port, SCFCR) &
+		return (sci_serial_in(port, SCFCR) &
 			(SCFCR_RTRG0 | SCFCR_RTRG1)) != 0;
 }
 
@@ -1279,8 +1278,8 @@ static void sci_dma_tx_complete(void *arg)
 		s->cookie_tx = -EINVAL;
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
 		    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
-			u16 ctrl = serial_port_in(port, SCSCR);
-			serial_port_out(port, SCSCR, ctrl & ~SCSCR_TIE);
+			u16 ctrl = sci_serial_in(port, SCSCR);
+			sci_serial_out(port, SCSCR, ctrl & ~SCSCR_TIE);
 			if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 				/* Switch irq from DMA to SCIF */
 				dmaengine_pause(s->chan_tx_saved);
@@ -1362,7 +1361,7 @@ static void sci_dma_rx_reenable_irq(struct sci_port *s)
 	u16 scr;
 
 	/* Direct new serial port interrupts back to CPU */
-	scr = serial_port_in(port, SCSCR);
+	scr = sci_serial_in(port, SCSCR);
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
 	    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 		enable_irq(s->irqs[SCIx_RXI_IRQ]);
@@ -1371,7 +1370,7 @@ static void sci_dma_rx_reenable_irq(struct sci_port *s)
 		else
 			scr &= ~SCSCR_RDRQE;
 	}
-	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
+	sci_serial_out(port, SCSCR, scr | SCSCR_RIE);
 }
 
 static void sci_dma_rx_complete(void *arg)
@@ -1798,8 +1797,8 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	if (s->chan_rx) {
-		u16 scr = serial_port_in(port, SCSCR);
-		u16 ssr = serial_port_in(port, SCxSR);
+		u16 scr = sci_serial_in(port, SCSCR);
+		u16 ssr = sci_serial_in(port, SCxSR);
 
 		/* Disable future Rx interrupts */
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
@@ -1817,10 +1816,10 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 
 			scr &= ~SCSCR_RIE;
 		}
-		serial_port_out(port, SCSCR, scr);
+		sci_serial_out(port, SCSCR, scr);
 		/* Clear current interrupt */
-		serial_port_out(port, SCxSR,
-				ssr & ~(SCIF_DR | SCxSR_RDxF(port)));
+		sci_serial_out(port, SCxSR,
+			       ssr & ~(SCIF_DR | SCxSR_RDxF(port)));
 		dev_dbg(port->dev, "Rx IRQ %lu: setup t-out in %u us\n",
 			jiffies, s->rx_timeout);
 		start_hrtimer_us(&s->rx_timer, s->rx_timeout);
@@ -1870,9 +1869,9 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 		return sci_tx_interrupt(irq, ptr);
 
 	spin_lock_irqsave(&port->lock, flags);
-	ctrl = serial_port_in(port, SCSCR);
+	ctrl = sci_serial_in(port, SCSCR);
 	ctrl &= ~(SCSCR_TE | SCSCR_TEIE);
-	serial_port_out(port, SCSCR, ctrl);
+	sci_serial_out(port, SCSCR, ctrl);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return IRQ_HANDLED;
@@ -1886,7 +1885,7 @@ static irqreturn_t sci_br_interrupt(int irq, void *ptr)
 	sci_handle_breaks(port);
 
 	/* drop invalid character received before break was detected */
-	serial_port_in(port, SCxRDR);
+	sci_serial_in(port, SCxRDR);
 
 	sci_clear_SCxSR(port, SCxSR_BREAK_CLEAR(port));
 
@@ -1900,7 +1899,7 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 
 	if (s->irqs[SCIx_ERI_IRQ] == s->irqs[SCIx_BRI_IRQ]) {
 		/* Break and Error interrupts are muxed */
-		unsigned short ssr_status = serial_port_in(port, SCxSR);
+		unsigned short ssr_status = sci_serial_in(port, SCxSR);
 
 		/* Break Interrupt */
 		if (ssr_status & SCxSR_BRK(port))
@@ -1915,7 +1914,7 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 	if (port->type == PORT_SCI) {
 		if (sci_handle_errors(port)) {
 			/* discard character in rx buffer */
-			serial_port_in(port, SCxSR);
+			sci_serial_in(port, SCxSR);
 			sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 		}
 	} else {
@@ -1940,12 +1939,12 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	struct sci_port *s = to_sci_port(port);
 	irqreturn_t ret = IRQ_NONE;
 
-	ssr_status = serial_port_in(port, SCxSR);
-	scr_status = serial_port_in(port, SCSCR);
+	ssr_status = sci_serial_in(port, SCxSR);
+	scr_status = sci_serial_in(port, SCSCR);
 	if (s->params->overrun_reg == SCxSR)
 		orer_status = ssr_status;
 	else if (sci_getreg(port, s->params->overrun_reg)->size)
-		orer_status = serial_port_in(port, s->params->overrun_reg);
+		orer_status = sci_serial_in(port, s->params->overrun_reg);
 
 	err_enabled = scr_status & port_rx_irq_mask(port);
 
@@ -2122,7 +2121,7 @@ static void sci_free_irq(struct sci_port *port)
 
 static unsigned int sci_tx_empty(struct uart_port *port)
 {
-	unsigned short status = serial_port_in(port, SCxSR);
+	unsigned short status = sci_serial_in(port, SCxSR);
 	unsigned short in_tx_fifo = sci_txfill(port);
 	struct sci_port *s = to_sci_port(port);
 
@@ -2137,27 +2136,27 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 static void sci_set_rts(struct uart_port *port, bool state)
 {
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
-		u16 data = serial_port_in(port, SCPDR);
+		u16 data = sci_serial_in(port, SCPDR);
 
 		/* Active low */
 		if (state)
 			data &= ~SCPDR_RTSD;
 		else
 			data |= SCPDR_RTSD;
-		serial_port_out(port, SCPDR, data);
+		sci_serial_out(port, SCPDR, data);
 
 		/* RTS# is output */
-		serial_port_out(port, SCPCR,
-				serial_port_in(port, SCPCR) | SCPCR_RTSC);
+		sci_serial_out(port, SCPCR,
+			       sci_serial_in(port, SCPCR) | SCPCR_RTSC);
 	} else if (sci_getreg(port, SCSPTR)->size) {
-		u16 ctrl = serial_port_in(port, SCSPTR);
+		u16 ctrl = sci_serial_in(port, SCSPTR);
 
 		/* Active low */
 		if (state)
 			ctrl &= ~SCSPTR_RTSDT;
 		else
 			ctrl |= SCSPTR_RTSDT;
-		serial_port_out(port, SCSPTR, ctrl);
+		sci_serial_out(port, SCSPTR, ctrl);
 	}
 }
 
@@ -2165,10 +2164,10 @@ static bool sci_get_cts(struct uart_port *port)
 {
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		/* Active low */
-		return !(serial_port_in(port, SCPDR) & SCPDR_CTSD);
+		return !(sci_serial_in(port, SCPDR) & SCPDR_CTSD);
 	} else if (sci_getreg(port, SCSPTR)->size) {
 		/* Active low */
-		return !(serial_port_in(port, SCSPTR) & SCSPTR_CTSDT);
+		return !(sci_serial_in(port, SCSPTR) & SCSPTR_CTSDT);
 	}
 
 	return true;
@@ -2198,9 +2197,8 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		 */
 		reg = sci_getreg(port, SCFCR);
 		if (reg->size)
-			serial_port_out(port, SCFCR,
-					serial_port_in(port, SCFCR) |
-					SCFCR_LOOP);
+			sci_serial_out(port, SCFCR,
+				       sci_serial_in(port, SCFCR) | SCFCR_LOOP);
 	}
 
 	mctrl_gpio_set(s->gpios, mctrl);
@@ -2219,8 +2217,8 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	} else if (s->autorts) {
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 			/* Enable RTS# pin function */
-			serial_port_out(port, SCPCR,
-				serial_port_in(port, SCPCR) & ~SCPCR_RTSC);
+			sci_serial_out(port, SCPCR,
+				sci_serial_in(port, SCPCR) & ~SCPCR_RTSC);
 		}
 
 		/* Enable Auto RTS */
@@ -2279,8 +2277,8 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 	}
 
 	spin_lock_irqsave(&port->lock, flags);
-	scsptr = serial_port_in(port, SCSPTR);
-	scscr = serial_port_in(port, SCSCR);
+	scsptr = sci_serial_in(port, SCSPTR);
+	scscr = sci_serial_in(port, SCSCR);
 
 	if (break_state == -1) {
 		scsptr = (scsptr | SCSPTR_SPB2IO) & ~SCSPTR_SPB2DT;
@@ -2290,8 +2288,8 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 		scscr |= SCSCR_TE;
 	}
 
-	serial_port_out(port, SCSPTR, scsptr);
-	serial_port_out(port, SCSCR, scscr);
+	sci_serial_out(port, SCSPTR, scsptr);
+	sci_serial_out(port, SCSCR, scscr);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -2332,9 +2330,9 @@ static void sci_shutdown(struct uart_port *port)
 	 * Stop RX and TX, disable related interrupts, keep clock source
 	 * and HSCIF TOT bits
 	 */
-	scr = serial_port_in(port, SCSCR);
-	serial_port_out(port, SCSCR, scr &
-			(SCSCR_CKE1 | SCSCR_CKE0 | s->hscif_tot));
+	scr = sci_serial_in(port, SCSCR);
+	sci_serial_out(port, SCSCR,
+		       scr & (SCSCR_CKE1 | SCSCR_CKE0 | s->hscif_tot));
 	spin_unlock_irqrestore(&port->lock, flags);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
@@ -2483,19 +2481,19 @@ static void sci_reset(struct uart_port *port)
 	unsigned int status;
 	struct sci_port *s = to_sci_port(port);
 
-	serial_port_out(port, SCSCR, s->hscif_tot);	/* TE=0, RE=0, CKE1=0 */
+	sci_serial_out(port, SCSCR, s->hscif_tot);	/* TE=0, RE=0, CKE1=0 */
 
 	reg = sci_getreg(port, SCFCR);
 	if (reg->size)
-		serial_port_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
+		sci_serial_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
 
 	sci_clear_SCxSR(port,
 			SCxSR_RDxF_CLEAR(port) & SCxSR_ERROR_CLEAR(port) &
 			SCxSR_BREAK_CLEAR(port));
 	if (sci_getreg(port, SCLSR)->size) {
-		status = serial_port_in(port, SCLSR);
+		status = sci_serial_in(port, SCLSR);
 		status &= ~(SCLSR_TO | SCLSR_ORER);
-		serial_port_out(port, SCLSR, status);
+		sci_serial_out(port, SCLSR, status);
 	}
 
 	if (s->rx_trigger > 1) {
@@ -2633,8 +2631,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * It controls the mux to select (H)SCK or frequency divided clock.
 	 */
 	if (best_clk >= 0 && sci_getreg(port, SCCKS)->size) {
-		serial_port_out(port, SCDL, dl);
-		serial_port_out(port, SCCKS, sccks);
+		sci_serial_out(port, SCDL, dl);
+		sci_serial_out(port, SCCKS, sccks);
 	}
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -2647,7 +2645,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	bits = tty_get_frame_size(termios->c_cflag);
 
 	if (sci_getreg(port, SEMR)->size)
-		serial_port_out(port, SEMR, 0);
+		sci_serial_out(port, SEMR, 0);
 
 	if (best_clk >= 0) {
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
@@ -2662,9 +2660,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			case 27: smr_val |= SCSMR_SRC_27; break;
 			}
 		smr_val |= cks;
-		serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
-		serial_port_out(port, SCSMR, smr_val);
-		serial_port_out(port, SCBRR, brr);
+		sci_serial_out(port, SCSCR, scr_val | s->hscif_tot);
+		sci_serial_out(port, SCSMR, smr_val);
+		sci_serial_out(port, SCBRR, brr);
 		if (sci_getreg(port, HSSRR)->size) {
 			unsigned int hssrr = srr | HSCIF_SRE;
 			/* Calculate deviation from intended rate at the
@@ -2686,7 +2684,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 					 HSCIF_SRHP_MASK;
 				hssrr |= HSCIF_SRDE;
 			}
-			serial_port_out(port, HSSRR, hssrr);
+			sci_serial_out(port, HSSRR, hssrr);
 		}
 
 		/* Wait one bit interval */
@@ -2694,10 +2692,10 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	} else {
 		/* Don't touch the bit rate configuration */
 		scr_val = s->cfg->scscr & (SCSCR_CKE1 | SCSCR_CKE0);
-		smr_val |= serial_port_in(port, SCSMR) &
+		smr_val |= sci_serial_in(port, SCSMR) &
 			   (SCSMR_CKEDG | SCSMR_SRC_MASK | SCSMR_CKS);
-		serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
-		serial_port_out(port, SCSMR, smr_val);
+		sci_serial_out(port, SCSCR, scr_val | s->hscif_tot);
+		sci_serial_out(port, SCSMR, smr_val);
 	}
 
 	sci_init_pins(port, termios->c_cflag);
@@ -2706,7 +2704,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	s->autorts = false;
 	reg = sci_getreg(port, SCFCR);
 	if (reg->size) {
-		unsigned short ctrl = serial_port_in(port, SCFCR);
+		unsigned short ctrl = sci_serial_in(port, SCFCR);
 
 		if ((port->flags & UPF_HARD_FLOW) &&
 		    (termios->c_cflag & CRTSCTS)) {
@@ -2723,7 +2721,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		 */
 		ctrl &= ~(SCFCR_RFRST | SCFCR_TFRST);
 
-		serial_port_out(port, SCFCR, ctrl);
+		sci_serial_out(port, SCFCR, ctrl);
 	}
 	if (port->flags & UPF_HARD_FLOW) {
 		/* Refresh (Auto) RTS */
@@ -2738,7 +2736,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (port->type != PORT_SCI)
 		scr_val |= SCSCR_TE;
 	scr_val |= SCSCR_RE | (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0));
-	serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
+	sci_serial_out(port, SCSCR, scr_val | s->hscif_tot);
 	if ((srr + 1 == 5) &&
 	    (port->type == PORT_SCIFA || port->type == PORT_SCIFB)) {
 		/*
@@ -3106,9 +3104,6 @@ static int sci_init_single(struct platform_device *dev,
 	port->irq		= sci_port->irqs[SCIx_RXI_IRQ];
 	port->irqflags		= 0;
 
-	port->serial_in		= sci_serial_in;
-	port->serial_out	= sci_serial_out;
-
 	return 0;
 }
 
@@ -3140,21 +3135,21 @@ static void serial_console_write(struct console *co, const char *s,
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* first save SCSCR then disable interrupts, keep clock source */
-	ctrl = serial_port_in(port, SCSCR);
+	ctrl = sci_serial_in(port, SCSCR);
 	ctrl_temp = SCSCR_RE | SCSCR_TE |
 		    (sci_port->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
 		    (ctrl & (SCSCR_CKE1 | SCSCR_CKE0));
-	serial_port_out(port, SCSCR, ctrl_temp | sci_port->hscif_tot);
+	sci_serial_out(port, SCSCR, ctrl_temp | sci_port->hscif_tot);
 
 	uart_console_write(port, s, count, serial_console_putchar);
 
 	/* wait until fifo is empty and last bit has been transmitted */
 	bits = SCxSR_TDxE(port) | SCxSR_TEND(port);
-	while ((serial_port_in(port, SCxSR) & bits) != bits)
+	while ((sci_serial_in(port, SCxSR) & bits) != bits)
 		cpu_relax();
 
 	/* restore the SCSCR */
-	serial_port_out(port, SCSCR, ctrl);
+	sci_serial_out(port, SCSCR, ctrl);
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -3715,8 +3710,6 @@ static int __init early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->port.serial_in = sci_serial_in;
-	device->port.serial_out	= sci_serial_out;
 	device->port.type = type;
 	sci_ports[0].port = device->port;
 	port_cfg.type = type;
-- 
2.43.0


