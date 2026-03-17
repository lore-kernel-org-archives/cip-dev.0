Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C1FD7094
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:34 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73586.1773746251398500203
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AUSDV8Qy;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso34688025e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746249; x=1774351049; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzSuVxfmh25TTk5LjhGpgN78GJFfMHRUz38agAjeOhI=;
        b=AUSDV8QyGVTZxUWiHFwEvhIzM9aPTklTg8f9k4xSLqwrHDsGo/0o/cRl5jsbTKgR1S
         +Fv3+jlbZmpz9EgXrKx4mdIBXBWjUXzvn76BROAAd9XARd1x8YfU/qMdkoN3kinRnKyG
         f9UZGDfL3JYg0mULi+9ucSew60rO5tVN6iN2fHLOOYIx+uvKnESYbWTXim/WCEdnOR2s
         3YtOm0VH2LWN7hhW6GWocfjmA/Qyrxu7e4kJlEKDFF/yJhJ7TOA9shZSuIZnMZcyq0yJ
         6iTr6faeRLvLDrM2A3lsw/eBh9SzB61ZmmfWsffFz74wGa82vo2aImeP5DREOrU2VZdw
         oiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746249; x=1774351049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzSuVxfmh25TTk5LjhGpgN78GJFfMHRUz38agAjeOhI=;
        b=tAI6TEJLXh2TS4VRfQp14W6gcZTUI0wIB7qSha+JAITpauf/7hH+/qPYb87vmU+wTX
         1jQtxx/RSVyj1CTx7X94JBOdcQJFIglLXIpRc9Kn128an2dXIWcc6sYVKefJdrr4r53r
         LbAVlV17g97heL5U/GiR3aSAjWW1jc6orEDmbuo1UPZazffLbm0A2iGTcE0VLaR9lku8
         SfONQwhP4iMRcurzHh7RBFsvAHmn3AW0iUnQYPJxrA3/sZI/J9a8xJu365b+d0Qn2QIh
         cxntAQrLY/Ni8grIzdHFZPzUCb95RZe1M61IedZ8b5eVj8dWFQcgFFExNuUxeU2+fL3N
         kPKA==
X-Gm-Message-State: AOJu0YzQ9s0jvqg6XCM6NSGBMN1kPfhJyuGs7O2nzgeqMxTvph9vmNeM
	hDxxLpERMxV4dcU02Im4/cN5JTIIE2k9YtsCpN3a1jc9fcjMF/Gkp+JLxmi4ig==
X-Gm-Gg: ATEYQzzz1jPN5SKTtkdxyjEzszam5UDYEaOkZ1J0TtDE+A8WPa98XGHh/QKsUr1clU/
	WcW0f6kvr0s4ZN3KRpG7Wx/okxzX9KHZV5BCCdKHq5F+wC1E/6IFkVnvRgFByvEEJA/TKuha1RA
	ju/qjBfVJWFtZ0ilymSfqgCEU2KfacalNqxcj9vv36gfMnNnWBorJaUq/XoNzrsG4r8vtZUUfjS
	l9CfYRfhIf5DJmKKPGjRA9jIcDLMLZMOaKVVJdtqHv+PmYL1p3/cuPmGH1ZvkyI334kToA7nLKP
	sHtBjxkoQS+rDqMQgvtAc7pI7djs2m/LR/fPuuqDPARIOAQGq5IpN9KviYLq0gHTYqYAUfRXxPA
	fhoWHRsMyB31Gl/9OrpYcWlUCoTwVExW3rNtG0llwky/JX4OfjNHBCOn3iOoVvS/Ai1qTnI4+8d
	m3w3SQ0a/fJ/cBBoXi4rdUF5dvXU7QbmaOHU4IHGqGE4o2uiEFhWQ8aQK4+cE=
X-Received: by 2002:a05:600c:8b55:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-485566fd0dfmr265887765e9.21.1773746249245;
        Tue, 17 Mar 2026 04:17:29 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:28 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 12/39] serial: sh-sci: Use private port ID
Date: Tue, 17 Mar 2026 11:16:37 +0000
Message-ID: <20260317111718.281633-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22445

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

[Upstream commit 1d26517d11de7fc9408c22429b8e75963314420d ]

New port types cannot be added in serial_core.h, which is shared with
userspace.
In order to support new port types, the coming new ones will have
BIT(7) set in the id value, and in this case, uartport->type is
set to PORT_GENERIC.
This commit therefore changes all the places where the port type is
read, by not relying on uartport->type but on the private
value stored in struct sci_port.

Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250630202323.279809-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Retained spin_lock_irq* and uart_circ_* ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci-common.h |   3 +
 drivers/tty/serial/sh-sci.c        | 159 ++++++++++++++++-------------
 2 files changed, 92 insertions(+), 70 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index bd9d9cfac1c8..fcddf66780c9 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -142,6 +142,9 @@ struct sci_port {
 	int				rx_fifo_timeout;
 	u16				hscif_tot;
 
+	u8				type;
+	u8				regtype;
+
 	const struct sci_port_ops *ops;
 
 	bool has_rtscts;
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 53a750813600..3b8d9cf4d257 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -76,6 +76,8 @@
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
 
+#define SCI_PUBLIC_PORT_ID(port) (((port) & BIT(7)) ? PORT_GENERIC : (port))
+
 static struct sci_port sci_ports[SCI_NPORTS];
 static unsigned long sci_ports_in_use;
 static struct uart_driver sci_uart_driver;
@@ -581,7 +583,7 @@ static void sci_start_tx(struct uart_port *port)
 	unsigned short ctrl;
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB) {
 		u16 new, scr = sci_serial_in(port, SCSCR);
 		if (s->chan_tx)
 			new = scr | SCSCR_TDRQE;
@@ -593,7 +595,7 @@ static void sci_start_tx(struct uart_port *port)
 
 	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
 	    dma_submit_error(s->cookie_tx)) {
-		if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
+		if (s->regtype == SCIx_RZ_SCIFA_REGTYPE)
 			/* Switch irq from SCIF to DMA */
 			disable_irq_nosync(s->irqs[SCIx_TXI_IRQ]);
 
@@ -602,8 +604,8 @@ static void sci_start_tx(struct uart_port *port)
 	}
 #endif
 
-	if (!s->chan_tx || s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE ||
-	    port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+	if (!s->chan_tx || s->regtype == SCIx_RZ_SCIFA_REGTYPE ||
+	    s->type == PORT_SCIFA || s->type == PORT_SCIFB) {
 		/* Set TIE (Transmit Interrupt Enable) bit in SCSCR */
 		ctrl = sci_serial_in(port, SCSCR);
 
@@ -612,7 +614,7 @@ static void sci_start_tx(struct uart_port *port)
 		 * (transmit interrupt enable) or in the same instruction to start
 		 * the transmit process.
 		 */
-		if (port->type == PORT_SCI)
+		if (s->type == PORT_SCI)
 			ctrl |= SCSCR_TE;
 
 		sci_serial_out(port, SCSCR, ctrl | SCSCR_TIE);
@@ -621,12 +623,13 @@ static void sci_start_tx(struct uart_port *port)
 
 static void sci_stop_tx(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
 	unsigned short ctrl;
 
 	/* Clear TIE (Transmit Interrupt Enable) bit in SCSCR */
 	ctrl = sci_serial_in(port, SCSCR);
 
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB)
 		ctrl &= ~SCSCR_TDRQE;
 
 	ctrl &= ~SCSCR_TIE;
@@ -634,21 +637,22 @@ static void sci_stop_tx(struct uart_port *port)
 	sci_serial_out(port, SCSCR, ctrl);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-	if (to_sci_port(port)->chan_tx &&
-	    !dma_submit_error(to_sci_port(port)->cookie_tx)) {
-		dmaengine_terminate_async(to_sci_port(port)->chan_tx);
-		to_sci_port(port)->cookie_tx = -EINVAL;
+	if (s->chan_tx &&
+	    !dma_submit_error(s->cookie_tx)) {
+		dmaengine_terminate_async(s->chan_tx);
+		s->cookie_tx = -EINVAL;
 	}
 #endif
 }
 
 static void sci_start_rx(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
 	unsigned short ctrl;
 
 	ctrl = sci_serial_in(port, SCSCR) | port_rx_irq_mask(port);
 
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB)
 		ctrl &= ~SCSCR_RDRQE;
 
 	sci_serial_out(port, SCSCR, ctrl);
@@ -656,11 +660,12 @@ static void sci_start_rx(struct uart_port *port)
 
 static void sci_stop_rx(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
 	unsigned short ctrl;
 
 	ctrl = sci_serial_in(port, SCSCR);
 
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB)
 		ctrl &= ~SCSCR_RDRQE;
 
 	ctrl &= ~port_rx_irq_mask(port);
@@ -670,10 +675,12 @@ static void sci_stop_rx(struct uart_port *port)
 
 static void sci_clear_SCxSR(struct uart_port *port, unsigned int mask)
 {
-	if (port->type == PORT_SCI) {
+	struct sci_port *s = to_sci_port(port);
+
+	if (s->type == PORT_SCI) {
 		/* Just store the mask */
 		sci_serial_out(port, SCxSR, mask);
-	} else if (to_sci_port(port)->params->overrun_mask == SCIFA_ORER) {
+	} else if (s->params->overrun_mask == SCIFA_ORER) {
 		/* SCIFA/SCIFB and SCIF on SH7705/SH7720/SH7721 */
 		/* Only clear the status bits we want to clear */
 		sci_serial_out(port, SCxSR, sci_serial_in(port, SCxSR) & mask);
@@ -743,13 +750,13 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 		return;
 	}
 
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB) {
 		u16 data = sci_serial_in(port, SCPDR);
 		u16 ctrl = sci_serial_in(port, SCPCR);
 
 		/* Enable RXD and TXD pin functions */
 		ctrl &= ~(SCPCR_RXDC | SCPCR_TXDC);
-		if (to_sci_port(port)->has_rtscts) {
+		if (s->has_rtscts) {
 			/* RTS# is output, active low, unless autorts */
 			if (!(port->mctrl & TIOCM_RTS)) {
 				ctrl |= SCPCR_RTSC;
@@ -766,7 +773,7 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 		}
 		sci_serial_out(port, SCPDR, data);
 		sci_serial_out(port, SCPCR, ctrl);
-	} else if (sci_getreg(port, SCSPTR)->size && s->cfg->regtype != SCIx_RZV2H_SCIF_REGTYPE) {
+	} else if (sci_getreg(port, SCSPTR)->size && s->regtype != SCIx_RZV2H_SCIF_REGTYPE) {
 		u16 status = sci_serial_in(port, SCSPTR);
 
 		/* RTS# is always output; and active low, unless autorts */
@@ -855,7 +862,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		} else if (!uart_circ_empty(xmit) && !stopped) {
 			c = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		} else if (port->type == PORT_SCI && uart_circ_empty(xmit)) {
+		} else if (s->type == PORT_SCI && uart_circ_empty(xmit)) {
 			ctrl = sci_serial_in(port, SCSCR);
 			ctrl &= ~SCSCR_TE;
 			sci_serial_out(port, SCSCR, ctrl);
@@ -875,7 +882,7 @@ static void sci_transmit_chars(struct uart_port *port)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 	if (uart_circ_empty(xmit)) {
-		if (port->type == PORT_SCI) {
+		if (s->type == PORT_SCI) {
 			ctrl = sci_serial_in(port, SCSCR);
 			ctrl &= ~SCSCR_TIE;
 			ctrl |= SCSCR_TEIE;
@@ -906,7 +913,7 @@ static void sci_receive_chars(struct uart_port *port)
 		if (count == 0)
 			break;
 
-		if (port->type == PORT_SCI) {
+		if (s->type == PORT_SCI) {
 			char c = sci_serial_in(port, SCxRDR);
 			if (uart_handle_sysrq_char(port, c))
 				count = 0;
@@ -916,8 +923,8 @@ static void sci_receive_chars(struct uart_port *port)
 			for (i = 0; i < count; i++) {
 				char c;
 
-				if (port->type == PORT_SCIF ||
-				    port->type == PORT_HSCIF) {
+				if (s->type == PORT_SCIF ||
+				    s->type == PORT_HSCIF) {
 					status = sci_serial_in(port, SCxSR);
 					c = sci_serial_in(port, SCxRDR);
 				} else {
@@ -1054,6 +1061,7 @@ static int sci_handle_breaks(struct uart_port *port)
 
 static int scif_set_rtrg(struct uart_port *port, int rx_trig)
 {
+	struct sci_port *s = to_sci_port(port);
 	unsigned int bits;
 
 	if (rx_trig >= port->fifosize)
@@ -1067,7 +1075,7 @@ static int scif_set_rtrg(struct uart_port *port, int rx_trig)
 		return rx_trig;
 	}
 
-	switch (port->type) {
+	switch (s->type) {
 	case PORT_SCIF:
 		if (rx_trig < 4) {
 			bits = 0;
@@ -1152,7 +1160,7 @@ static ssize_t rx_fifo_trigger_store(struct device *dev,
 		return ret;
 
 	sci->rx_trigger = sci->ops->set_rtrg(port, r);
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+	if (sci->type == PORT_SCIFA || sci->type == PORT_SCIFB)
 		sci->ops->set_rtrg(port, 1);
 
 	return count;
@@ -1168,7 +1176,7 @@ static ssize_t rx_fifo_timeout_show(struct device *dev,
 	struct sci_port *sci = to_sci_port(port);
 	int v;
 
-	if (port->type == PORT_HSCIF)
+	if (sci->type == PORT_HSCIF)
 		v = sci->hscif_tot >> HSSCR_TOT_SHIFT;
 	else
 		v = sci->rx_fifo_timeout;
@@ -1190,7 +1198,7 @@ static ssize_t rx_fifo_timeout_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (port->type == PORT_HSCIF) {
+	if (sci->type == PORT_HSCIF) {
 		if (r < 0 || r > 3)
 			return -EINVAL;
 		sci->hscif_tot = r << HSSCR_TOT_SHIFT;
@@ -1235,11 +1243,11 @@ static void sci_dma_tx_complete(void *arg)
 		schedule_work(&s->work_tx);
 	} else {
 		s->cookie_tx = -EINVAL;
-		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
-		    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
+		if (s->type == PORT_SCIFA || s->type == PORT_SCIFB ||
+		    s->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 			u16 ctrl = sci_serial_in(port, SCSCR);
 			sci_serial_out(port, SCSCR, ctrl & ~SCSCR_TIE);
-			if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
+			if (s->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 				/* Switch irq from DMA to SCIF */
 				dmaengine_pause(s->chan_tx_saved);
 				enable_irq(s->irqs[SCIx_TXI_IRQ]);
@@ -1321,10 +1329,10 @@ static void sci_dma_rx_reenable_irq(struct sci_port *s)
 
 	/* Direct new serial port interrupts back to CPU */
 	scr = sci_serial_in(port, SCSCR);
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
-	    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB ||
+	    s->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 		enable_irq(s->irqs[SCIx_RXI_IRQ]);
-		if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
+		if (s->regtype == SCIx_RZ_SCIFA_REGTYPE)
 			s->ops->set_rtrg(port, s->rx_trigger);
 		else
 			scr &= ~SCSCR_RDRQE;
@@ -1565,8 +1573,8 @@ static enum hrtimer_restart sci_dma_rx_timer_fn(struct hrtimer *t)
 			tty_flip_buffer_push(&port->state->port);
 	}
 
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
-	    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB ||
+	    s->regtype == SCIx_RZ_SCIFA_REGTYPE)
 		sci_dma_rx_submit(s, true);
 
 	sci_dma_rx_reenable_irq(s);
@@ -1690,8 +1698,8 @@ static void sci_request_dma(struct uart_port *port)
 
 		s->chan_rx_saved = s->chan_rx = chan;
 
-		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
-		    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
+		if (s->type == PORT_SCIFA || s->type == PORT_SCIFB ||
+		    s->regtype == SCIx_RZ_SCIFA_REGTYPE)
 			sci_dma_rx_submit(s, false);
 	}
 }
@@ -1761,10 +1769,10 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 		u16 ssr = sci_serial_in(port, SCxSR);
 
 		/* Disable future Rx interrupts */
-		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB ||
-		    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
+		if (s->type == PORT_SCIFA || s->type == PORT_SCIFB ||
+		    s->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 			disable_irq_nosync(s->irqs[SCIx_RXI_IRQ]);
-			if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
+			if (s->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 				s->ops->set_rtrg(port, 1);
 				scr |= SCSCR_RIE;
 			} else {
@@ -1828,7 +1836,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 	unsigned long flags;
 	u32 ctrl;
 
-	if (port->type != PORT_SCI)
+	if (s->type != PORT_SCI)
 		return sci_tx_interrupt(irq, ptr);
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -1875,7 +1883,7 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 	}
 
 	/* Handle errors */
-	if (port->type == PORT_SCI) {
+	if (s->type == PORT_SCI) {
 		if (sci_handle_errors(port)) {
 			/* discard character in rx buffer */
 			sci_serial_in(port, SCxSR);
@@ -2099,7 +2107,9 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 
 static void sci_set_rts(struct uart_port *port, bool state)
 {
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+	struct sci_port *s = to_sci_port(port);
+
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB) {
 		u16 data = sci_serial_in(port, SCPDR);
 
 		/* Active low */
@@ -2126,7 +2136,9 @@ static void sci_set_rts(struct uart_port *port, bool state)
 
 static bool sci_get_cts(struct uart_port *port)
 {
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+	struct sci_port *s = to_sci_port(port);
+
+	if (s->type == PORT_SCIFA || s->type == PORT_SCIFB) {
 		/* Active low */
 		return !(sci_serial_in(port, SCPDR) & SCPDR_CTSD);
 	} else if (sci_getreg(port, SCSPTR)->size) {
@@ -2172,21 +2184,21 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	if (!(mctrl & TIOCM_RTS)) {
 		/* Disable Auto RTS */
-		if (s->cfg->regtype != SCIx_RZV2H_SCIF_REGTYPE)
+		if (s->regtype != SCIx_RZV2H_SCIF_REGTYPE)
 			sci_serial_out(port, SCFCR,
 				       sci_serial_in(port, SCFCR) & ~SCFCR_MCE);
 
 		/* Clear RTS */
 		sci_set_rts(port, 0);
 	} else if (s->autorts) {
-		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		if (s->type == PORT_SCIFA || s->type == PORT_SCIFB) {
 			/* Enable RTS# pin function */
 			sci_serial_out(port, SCPCR,
 				sci_serial_in(port, SCPCR) & ~SCPCR_RTSC);
 		}
 
 		/* Enable Auto RTS */
-		if (s->cfg->regtype != SCIx_RZV2H_SCIF_REGTYPE)
+		if (s->regtype != SCIx_RZV2H_SCIF_REGTYPE)
 			sci_serial_out(port, SCFCR,
 				       sci_serial_in(port, SCFCR) | SCFCR_MCE);
 	} else {
@@ -2323,7 +2335,7 @@ static int sci_sck_calc(struct sci_port *s, unsigned int bps,
 	int err, min_err = INT_MAX;
 	unsigned int sr;
 
-	if (s->port.type != PORT_HSCIF)
+	if (s->type != PORT_HSCIF)
 		freq *= 2;
 
 	for_each_sr(sr, s) {
@@ -2350,7 +2362,7 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 	int err, min_err = INT_MAX;
 	unsigned int sr, dl;
 
-	if (s->port.type != PORT_HSCIF)
+	if (s->type != PORT_HSCIF)
 		freq *= 2;
 
 	for_each_sr(sr, s) {
@@ -2383,7 +2395,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 	unsigned int sr, br, prediv, scrate, c;
 	int err, min_err = INT_MAX;
 
-	if (s->port.type != PORT_HSCIF)
+	if (s->type != PORT_HSCIF)
 		freq *= 2;
 
 	/*
@@ -2468,8 +2480,8 @@ static void sci_reset(struct uart_port *port)
 			s->ops->set_rtrg(port, 1);
 			timer_setup(&s->rx_fifo_timer, rx_fifo_timer_fn, 0);
 		} else {
-			if (port->type == PORT_SCIFA ||
-			    port->type == PORT_SCIFB)
+			if (s->type == PORT_SCIFA ||
+			    s->type == PORT_SCIFB)
 				s->ops->set_rtrg(port, 1);
 			else
 				s->ops->set_rtrg(port, s->rx_trigger);
@@ -2529,8 +2541,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 
 	/* Optional Undivided External Clock */
-	if (s->clk_rates[SCI_SCK] && port->type != PORT_SCIFA &&
-	    port->type != PORT_SCIFB) {
+	if (s->clk_rates[SCI_SCK] && s->type != PORT_SCIFA &&
+	    s->type != PORT_SCIFB) {
 		err = sci_sck_calc(s, baud, &srr1);
 		if (abs(err) < abs(min_err)) {
 			best_clk = SCI_SCK;
@@ -2615,7 +2627,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		sci_serial_out(port, SEMR, 0);
 
 	if (best_clk >= 0) {
-		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
+		if (s->type == PORT_SCIFA || s->type == PORT_SCIFB)
 			switch (srr + 1) {
 			case 5:  smr_val |= SCSMR_SRC_5;  break;
 			case 7:  smr_val |= SCSMR_SRC_7;  break;
@@ -2700,12 +2712,12 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * (transmit interrupt enable) or in the same instruction to
 	 * start the transmitting process. So skip setting TE here for SCI.
 	 */
-	if (port->type != PORT_SCI)
+	if (s->type != PORT_SCI)
 		scr_val |= SCSCR_TE;
 	scr_val |= SCSCR_RE | (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0));
 	sci_serial_out(port, SCSCR, scr_val | s->hscif_tot);
 	if ((srr + 1 == 5) &&
-	    (port->type == PORT_SCIFA || port->type == PORT_SCIFB)) {
+	    (s->type == PORT_SCIFA || s->type == PORT_SCIFB)) {
 		/*
 		 * In asynchronous mode, when the sampling rate is 1/5, first
 		 * received data may become invalid on some SCIFA and SCIFB.
@@ -2749,7 +2761,9 @@ void sci_pm(struct uart_port *port, unsigned int state,
 
 static const char *sci_type(struct uart_port *port)
 {
-	switch (port->type) {
+	struct sci_port *s = to_sci_port(port);
+
+	switch (s->type) {
 	case PORT_IRDA:
 		return "irda";
 	case PORT_SCI:
@@ -2833,8 +2847,7 @@ void sci_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE) {
 		struct sci_port *sport = to_sci_port(port);
-
-		port->type = sport->cfg->type;
+		port->type = SCI_PUBLIC_PORT_ID(sport->type);
 		sci_request_port(port);
 	}
 }
@@ -2972,7 +2985,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	struct clk *clk;
 	unsigned int i;
 
-	if (sci_port->cfg->type == PORT_HSCIF)
+	if (sci_port->type == PORT_HSCIF)
 		clk_names[SCI_SCK] = "hsck";
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
@@ -3058,6 +3071,9 @@ static int sci_init_single(struct platform_device *dev,
 
 	sci_port->cfg	= p;
 
+	sci_port->type	= p->type;
+	sci_port->regtype = p->regtype;
+
 	port->iotype	= UPIO_MEM;
 	port->line	= index;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SH_SCI_CONSOLE);
@@ -3136,11 +3152,11 @@ static int sci_init_single(struct platform_device *dev,
 			return ret;
 	}
 
-	port->type		= p->type;
+	port->type		= SCI_PUBLIC_PORT_ID(p->type);
 	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
 	port->fifosize		= sci_port->params->fifosize;
 
-	if (port->type == PORT_SCI && !dev->dev.of_node) {
+	if (p->type == PORT_SCI && !dev->dev.of_node) {
 		if (sci_port->reg_size >= 0x20)
 			port->regshift = 2;
 		else
@@ -3318,13 +3334,13 @@ static struct uart_driver sci_uart_driver = {
 
 static int sci_remove(struct platform_device *dev)
 {
-	struct sci_port *port = platform_get_drvdata(dev);
-	unsigned int type = port->port.type;	/* uart_remove_... clears it */
+	struct sci_port *s = platform_get_drvdata(dev);
+	unsigned int type = s->type;	/* uart_remove_... clears it */
 
-	sci_ports_in_use &= ~BIT(port->port.line);
-	uart_remove_one_port(&sci_uart_driver, &port->port);
+	sci_ports_in_use &= ~BIT(s->port.line);
+	uart_remove_one_port(&sci_uart_driver, &s->port);
 
-	if (port->port.fifosize > 1)
+	if (s->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
@@ -3680,8 +3696,8 @@ static int sci_probe(struct platform_device *dev)
 		if (ret)
 			return ret;
 	}
-	if (sp->port.type == PORT_SCIFA || sp->port.type == PORT_SCIFB ||
-	    sp->port.type == PORT_HSCIF) {
+	if (sp->type == PORT_SCIFA || sp->type == PORT_SCIFB ||
+	    sp->type == PORT_HSCIF) {
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
 			if (sp->port.fifosize > 1) {
@@ -3797,8 +3813,11 @@ int __init scix_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->port.type = data->type;
+	device->port.type = SCI_PUBLIC_PORT_ID(data->type);
+
 	sci_ports[0].port = device->port;
+	sci_ports[0].type = data->type;
+	sci_ports[0].regtype = data->regtype;
 
 	port_cfg.type = data->type;
 	port_cfg.regtype = data->regtype;
-- 
2.43.0


