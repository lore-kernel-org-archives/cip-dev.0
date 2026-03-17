Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23984FD7083
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:33 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73587.1773746252197463136
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=b15EOn4I;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-485409ab264so4402635e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746250; x=1774351050; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pI+Rlu/YTQiZMh8RPY/RxA2KH6jRCNE8L66zfKol6s=;
        b=b15EOn4I+wNyYeTGXP40MXW1bk544FSOlkb4mIQIWAHGqPoBw2RcdWtEOT8D0h1AiL
         wausjxALJ0pLIBG4IWKwN77eHla418fyF/FZCnLUpKbmPxJ1Xp7i7w4lHj2nYZDxXGSo
         uIRG78fcBqX+jrFoI1Ux18efiPFkQG9lUuvhFqkSmeQUTcRPufOGXhWJ+a1xD7Hsj1YN
         CVKovPJocqTKVzOoM7QdvdiJhIpFiO6h1qWFYflvZm4ItCT1vUcgliCJSJKB8YJebwu+
         R6uMlccJBDVvIaacfVAMNxmhgJb/ov98nds/zmcUBNDE+E1sZQv2FTc2VctY6Zu0mfwf
         37Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746250; x=1774351050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5pI+Rlu/YTQiZMh8RPY/RxA2KH6jRCNE8L66zfKol6s=;
        b=QjjG9iOUNrJ0q1g90dTf8DrRfA7g7/4i8JbCIaUscKSAtC9y9G38NKLZkRyzRuKoVe
         rCcMHmyem9Fp7k02IdkDeoF5rUs5TM6iAh0YpXtxS2SpH1O73dbAMkrAylixUKdcyUVB
         xLSVt9ucGjrdaAftSna7meqZgAw7B9nBePu1gm1PS9JTSGzqTMz2iB4P/iQ3T3Zn91IJ
         LTH3zxHm/hb/4KNNaWf/O0DQY4YvOVeRz0GEUeX7eFddOOdTAGbWe5JYLAc7LxNOcnwk
         SPJoNRlU5KcXcBHfbWQdulK0n0DVhS4S8DAatXGGF3Rv/N6boYvv4iZhk+KgTwJ/zJf7
         03NQ==
X-Gm-Message-State: AOJu0Yy4Uhp0OhbydTY09JB/QGRVcXCu7v7DaZW4liKaDsLDR3qvWViV
	PCXdgIUCM2Q+xk1CxVEIb0/dF0kqEMze+iRzd7HPIYY2UX5kAGIbGcMohkLmBg==
X-Gm-Gg: ATEYQzz3buBxl9eu+KrodElePA6n75bsT9RLkZsXfZXQ5dwg5WqDi8CCCjqkZBJLZGk
	/9U2VyPLARN1HzWsK5viAwmPOOL0zGEcrXTR+AClb2zwyx0q1vloWbuYn+UGzWQRAm+kDk93N3+
	/ktjRSdb61PpOdwgVCuomFzuWeEOzBUnIkD9ujM6fCbjEMOKvQJPEFZ9svJqPjZxFWje177d/wu
	0jbLM5met45kjVKSc0K/ufayPWRicsH2qca/lJTj6rBdD9asC5Vzq7Zuou+PSG3l6cKh5ZWiPo/
	g5BShcwSbb2nXuXlSNhc9PwNoR/fqRrLNmnlqLbY1l2jmvHCUWnORZ9baRlUg6oZfWgMvHcAtZH
	OlXU58LpUsbTxiqRhH8yQG+ewgLzvShWQHOJuHwwvJcFJfvJaHG++cOI4Arpf5dBPjb39+VWKJ+
	+rgMsZ+jRUS/wFQCdpVOkE2UxwPIsvcmTYRGjYXBhtwiRrJ3MeQrnneGfVVjM=
X-Received: by 2002:a05:600c:3587:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4856eab6a29mr45800275e9.6.1773746250003;
        Tue, 17 Mar 2026 04:17:30 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 13/39] serial: sh-sci: Add support for RZ/T2H SCI
Date: Tue, 17 Mar 2026 11:16:38 +0000
Message-ID: <20260317111718.281633-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22446

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

[ Upstream commit 0666e3fe95ab55c295984f2f51277ec27d3f190c ]

Define a new RSCI port type, and the RSCI 32 bits registers set.
The RZ/T2H SCI has a a fifo, and a quite different set of registers
from the original SH SCI ones.
DMA is not supported yet.

Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250630202323.279809-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Dropped double quotes around EXPORT_SYMBOL_NS_GPL and MODULE_IMPORT_NS
  Adjusted Makefile. Replaced kfifo_*()->uart_circ_*() in
  rsci_transmit_chars() to make similar implementation with
  sci_transmit_chars() for fixing tx issue with 6.1 kernel.
]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/Kconfig         |   7 +
 drivers/tty/serial/Makefile        |   1 +
 drivers/tty/serial/rsci.c          | 483 +++++++++++++++++++++++++++++
 drivers/tty/serial/rsci.h          |  10 +
 drivers/tty/serial/sh-sci-common.h |   5 +
 drivers/tty/serial/sh-sci.c        |  53 +++-
 6 files changed, 549 insertions(+), 10 deletions(-)
 create mode 100644 drivers/tty/serial/rsci.c
 create mode 100644 drivers/tty/serial/rsci.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 71951b543d4c..35c724293635 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -672,6 +672,13 @@ config SERIAL_SH_SCI_DMA
 	depends on SERIAL_SH_SCI && DMA_ENGINE
 	default ARCH_RENESAS
 
+config SERIAL_RSCI
+	tristate "Support for Renesas RZ/T2H SCI variant"
+	depends on SERIAL_SH_SCI
+	help
+	  Support for the RZ/T2H SCI variant with fifo.
+	  Say Y if you want to be able to use the RZ/T2H SCI serial port.
+
 config SERIAL_HS_LPC32XX
 	tristate "LPC32XX high speed serial port support"
 	depends on ARCH_LPC32XX || COMPILE_TEST
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 238a9557b487..3e6672f08fd1 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
 obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
 obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
 obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
+obj-$(CONFIG_SERIAL_RSCI)		+= rsci.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
new file mode 100644
index 000000000000..af6dd4b54787
--- /dev/null
+++ b/drivers/tty/serial/rsci.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/serial_core.h>
+#include <linux/serial_sci.h>
+#include <linux/tty_flip.h>
+#include "rsci.h"
+
+MODULE_IMPORT_NS(SH_SCI);
+
+/* RSCI registers */
+#define RDR	0x00
+#define TDR	0x04
+#define CCR0	0x08
+#define CCR1	0x0C
+#define CCR2	0x10
+#define CCR3	0x14
+#define CCR4	0x18
+#define FCR	0x24
+#define DCR	0x30
+#define CSR	0x48
+#define FRSR	0x50
+#define FTSR	0x54
+#define CFCLR	0x68
+#define FFCLR	0x70
+
+/* RDR (Receive Data Register) */
+#define RDR_FFER		BIT(12) /* FIFO Framing Error */
+#define RDR_FPER		BIT(11) /* FIFO Parity Error */
+#define RDR_RDAT_MSK		GENMASK(8, 0)
+
+/* TDR (Transmit Data Register) */
+#define TDR_MPBT		BIT(9)	/* Multiprocessor Transfer */
+#define TDR_TDAT_9BIT_LSHIFT	0
+#define TDR_TDAT_9BIT_VAL	0x1FF
+#define TDR_TDAT_9BIT_MSK	(TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)
+
+/* CCR0 (Common Control Register 0) */
+#define CCR0_SSE		BIT(24)	/* SSn# Pin Function Enable */
+#define CCR0_TEIE		BIT(21)	/* Transmit End Interrupt Enable */
+#define CCR0_TIE		BIT(20)	/* Transmit Interrupt Enable */
+#define CCR0_RIE		BIT(16)	/* Receive Interrupt Enable */
+#define CCR0_IDSEL		BIT(10)	/* ID Frame Select */
+#define CCR0_DCME		BIT(9)	/* Data Compare Match Enable */
+#define CCR0_MPIE		BIT(8)	/* Multiprocessor Interrupt Enable */
+#define CCR0_TE			BIT(4)	/* Transmit Enable */
+#define CCR0_RE			BIT(0)	/* Receive Enable */
+
+/* CCR1 (Common Control Register 1) */
+#define CCR1_NFEN		BIT(28)	/* Digital Noise Filter Function */
+#define CCR1_SHARPS		BIT(20)	/* Half -duplex Communication Select */
+#define CCR1_SPLP		BIT(16)	/* Loopback Control */
+#define CCR1_RINV		BIT(13)	/* RxD invert */
+#define CCR1_TINV		BIT(12)	/* TxD invert */
+#define CCR1_PM			BIT(9)	/* Parity Mode */
+#define CCR1_PE			BIT(8)	/* Parity Enable */
+#define CCR1_SPB2IO		BIT(5)	/* Serial Port Break I/O */
+#define CCR1_SPB2DT		BIT(4)	/* Serial Port Break Data Select */
+#define CCR1_CTSPEN		BIT(1)	/* CTS External Pin Enable */
+#define CCR1_CTSE		BIT(0)	/* CTS Enable */
+
+/* FCR (FIFO Control Register) */
+#define FCR_RFRST		BIT(23)	/* Receive FIFO Data Register Reset */
+#define FCR_TFRST		BIT(15)	/* Transmit FIFO Data Register Reset */
+#define FCR_DRES		BIT(0)	/* Incoming Data Ready Error Select */
+#define FCR_RTRG4_0		GENMASK(20, 16)
+#define FCR_TTRG		GENMASK(12, 8)
+
+/* CSR (Common Status Register) */
+#define CSR_RDRF		BIT(31)	/* Receive Data Full */
+#define CSR_TEND		BIT(30)	/* Transmit End Flag */
+#define CSR_TDRE		BIT(29)	/* Transmit Data Empty */
+#define CSR_FER			BIT(28)	/* Framing Error */
+#define CSR_PER			BIT(27)	/* Parity Error */
+#define CSR_MFF			BIT(26)	/* Mode Fault Error */
+#define CSR_ORER		BIT(24)	/* Overrun Error */
+#define CSR_DFER		BIT(18)	/* Data Compare Match Framing Error */
+#define CSR_DPER		BIT(17)	/* Data Compare Match Parity Error */
+#define CSR_DCMF		BIT(16)	/* Data Compare Match */
+#define CSR_RXDMON		BIT(15)	/* Serial Input Data Monitor */
+#define CSR_ERS			BIT(4)	/* Error Signal Status */
+
+#define SCxSR_ERRORS(port)	(to_sci_port(port)->params->error_mask)
+#define SCxSR_ERROR_CLEAR(port)	(to_sci_port(port)->params->error_clear)
+
+#define RSCI_DEFAULT_ERROR_MASK	(CSR_PER | CSR_FER)
+
+#define RSCI_RDxF_CLEAR		(CFCLR_RDRFC)
+#define RSCI_ERROR_CLEAR	(CFCLR_PERC | CFCLR_FERC)
+#define RSCI_TDxE_CLEAR		(CFCLR_TDREC)
+#define RSCI_BREAK_CLEAR	(CFCLR_PERC | CFCLR_FERC | CFCLR_ORERC)
+
+/* FRSR (FIFO Receive Status Register) */
+#define FRSR_R5_0		GENMASK(13, 8)	/* Receive FIFO Data Count */
+#define FRSR_DR			BIT(0)	/* Receive Data Ready */
+
+/* CFCLR (Common Flag CLear Register) */
+#define CFCLR_RDRFC		BIT(31)	/* RDRF Clear */
+#define CFCLR_TDREC		BIT(29)	/* TDRE Clear */
+#define CFCLR_FERC		BIT(28)	/* FER Clear */
+#define CFCLR_PERC		BIT(27)	/* PER Clear */
+#define CFCLR_MFFC		BIT(26)	/* MFF Clear */
+#define CFCLR_ORERC		BIT(24)	/* ORER Clear */
+#define CFCLR_DFERC		BIT(18)	/* DFER Clear */
+#define CFCLR_DPERC		BIT(17)	/* DPER Clear */
+#define CFCLR_DCMFC		BIT(16)	/* DCMF Clear */
+#define CFCLR_ERSC		BIT(4)	/* ERS Clear */
+#define CFCLR_CLRFLAG		(CFCLR_RDRFC | CFCLR_FERC | CFCLR_PERC | \
+				 CFCLR_MFFC | CFCLR_ORERC | CFCLR_DFERC | \
+				 CFCLR_DPERC | CFCLR_DCMFC | CFCLR_ERSC)
+
+/* FFCLR (FIFO Flag CLear Register) */
+#define FFCLR_DRC		BIT(0)	/* DR Clear */
+
+#define DCR_DEPOL		BIT(0)
+
+static u32 rsci_serial_in(struct uart_port *p, int offset)
+{
+	return readl(p->membase + offset);
+}
+
+static void rsci_serial_out(struct uart_port *p, int offset, int value)
+{
+	writel(value, p->membase + offset);
+}
+
+static void rsci_clear_DRxC(struct uart_port *port)
+{
+	rsci_serial_out(port, CFCLR, CFCLR_RDRFC);
+	rsci_serial_out(port, FFCLR, FFCLR_DRC);
+}
+
+static void rsci_clear_SCxSR(struct uart_port *port, unsigned int mask)
+{
+	rsci_serial_out(port, CFCLR, mask);
+}
+
+static void rsci_start_rx(struct uart_port *port)
+{
+	unsigned int ctrl;
+
+	ctrl = rsci_serial_in(port, CCR0);
+	ctrl |= CCR0_RIE;
+	rsci_serial_out(port, CCR0, ctrl);
+}
+
+static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
+			     const struct ktermios *old)
+{
+	struct sci_port *s = to_sci_port(port);
+	unsigned long flags;
+
+	sci_port_enable(s);
+	uart_port_lock_irqsave(port, &flags);
+
+	/* For now, only RX enabling is supported */
+	if (termios->c_cflag & CREAD)
+		rsci_start_rx(port);
+
+	uart_port_unlock_irqrestore(port, flags);
+	sci_port_disable(s);
+}
+
+static int rsci_txfill(struct uart_port *port)
+{
+	return rsci_serial_in(port, FTSR);
+}
+
+static int rsci_rxfill(struct uart_port *port)
+{
+	u32 val = rsci_serial_in(port, FRSR);
+
+	return FIELD_GET(FRSR_R5_0, val);
+}
+
+static unsigned int rsci_tx_empty(struct uart_port *port)
+{
+	unsigned int status = rsci_serial_in(port, CSR);
+	unsigned int in_tx_fifo = rsci_txfill(port);
+
+	return (status & CSR_TEND) && !in_tx_fifo ? TIOCSER_TEMT : 0;
+}
+
+static void rsci_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* Not supported yet */
+}
+
+static unsigned int rsci_get_mctrl(struct uart_port *port)
+{
+	/* Not supported yet */
+	return 0;
+}
+
+static void rsci_clear_CFC(struct uart_port *port, unsigned int mask)
+{
+	rsci_serial_out(port, CFCLR, mask);
+}
+
+static void rsci_start_tx(struct uart_port *port)
+{
+	struct sci_port *sp = to_sci_port(port);
+	u32 ctrl;
+
+	if (sp->chan_tx)
+		return;
+
+	/*
+	 * TE (Transmit Enable) must be set after setting TIE
+	 * (Transmit Interrupt Enable) or in the same instruction
+	 * to start the transmit process.
+	 */
+	ctrl = rsci_serial_in(port, CCR0);
+	ctrl |= CCR0_TIE | CCR0_TE;
+	rsci_serial_out(port, CCR0, ctrl);
+}
+
+static void rsci_stop_tx(struct uart_port *port)
+{
+	u32 ctrl;
+
+	ctrl = rsci_serial_in(port, CCR0);
+	ctrl &= ~CCR0_TIE;
+	rsci_serial_out(port, CCR0, ctrl);
+}
+
+static void rsci_stop_rx(struct uart_port *port)
+{
+	u32 ctrl;
+
+	ctrl = rsci_serial_in(port, CCR0);
+	ctrl &= ~CCR0_RIE;
+	rsci_serial_out(port, CCR0, ctrl);
+}
+
+static int rsci_txroom(struct uart_port *port)
+{
+	return port->fifosize - rsci_txfill(port);
+}
+
+static void rsci_transmit_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned int stopped = uart_tx_stopped(port);
+	u32 status, ctrl;
+	int count;
+
+	status = rsci_serial_in(port, CSR);
+	if (!(status & CSR_TDRE)) {
+		ctrl = rsci_serial_in(port, CCR0);
+		if (uart_circ_empty(xmit))
+			ctrl &= ~CCR0_TIE;
+		else
+			ctrl |= CCR0_TIE;
+		rsci_serial_out(port, CCR0, ctrl);
+		return;
+	}
+
+	count = rsci_txroom(port);
+
+	do {
+		unsigned char c;
+
+		if (port->x_char) {
+			c = port->x_char;
+			port->x_char = 0;
+		} else if (!uart_circ_empty(xmit) && !stopped) {
+			c = xmit->buf[xmit->tail];
+			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		} else {
+			break;
+		}
+
+		rsci_clear_CFC(port, CFCLR_TDREC);
+		rsci_serial_out(port, TDR, c);
+
+		port->icount.tx++;
+	} while (--count > 0);
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit)) {
+		ctrl = rsci_serial_in(port, CCR0);
+		ctrl &= ~CCR0_TIE;
+		ctrl |= CCR0_TEIE;
+		rsci_serial_out(port, CCR0, ctrl);
+	}
+}
+
+static void rsci_receive_chars(struct uart_port *port)
+{
+	struct tty_port *tport = &port->state->port;
+	u32 rdat, status, frsr_status = 0;
+	int i, count, copied = 0;
+	unsigned char flag;
+
+	status = rsci_serial_in(port, CSR);
+	frsr_status = rsci_serial_in(port, FRSR);
+
+	if (!(status & CSR_RDRF) && !(frsr_status & FRSR_DR))
+		return;
+
+	while (1) {
+		/* Don't copy more bytes than there is room for in the buffer */
+		count = tty_buffer_request_room(tport, rsci_rxfill(port));
+
+		/* If for any reason we can't copy more data, we're done! */
+		if (count == 0)
+			break;
+
+		for (i = 0; i < count; i++) {
+			char c;
+
+			rdat = rsci_serial_in(port, RDR);
+			/* 9-bits data is not supported yet */
+			c = rdat & RDR_RDAT_MSK;
+
+			if (uart_handle_sysrq_char(port, c)) {
+				count--;
+				i--;
+				continue;
+			}
+
+			/* Store data and status.
+			 * Non FIFO mode is not supported
+			 */
+			if (rdat & RDR_FFER) {
+				flag = TTY_FRAME;
+				port->icount.frame++;
+			} else if (rdat & RDR_FPER) {
+				flag = TTY_PARITY;
+				port->icount.parity++;
+			} else {
+				flag = TTY_NORMAL;
+			}
+
+			tty_insert_flip_char(tport, c, flag);
+		}
+
+		rsci_serial_in(port, CSR); /* dummy read */
+		rsci_clear_DRxC(port);
+
+		copied += count;
+		port->icount.rx += count;
+	}
+
+	if (copied) {
+		/* Tell the rest of the system the news. New characters! */
+		tty_flip_buffer_push(tport);
+	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		rsci_serial_in(port, RDR);
+		rsci_serial_in(port, CSR); /* dummy read */
+		rsci_clear_DRxC(port);
+	}
+}
+
+static void rsci_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	u32 status;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout_atomic(port->membase + CSR, status,
+						(status & CSR_TDRE), 100,
+						USEC_PER_SEC);
+	if (ret != 0) {
+		dev_err(port->dev,
+			"Error while sending data in UART TX : %d\n", ret);
+		goto done;
+	}
+	rsci_serial_out(port, TDR, c);
+done:
+	rsci_clear_SCxSR(port, CFCLR_TDREC);
+}
+
+static void rsci_prepare_console_write(struct uart_port *port, u32 ctrl)
+{
+	struct sci_port *s = to_sci_port(port);
+	u32 ctrl_temp =
+		s->params->param_bits->rxtx_enable | CCR0_TIE |
+		s->hscif_tot;
+	rsci_serial_out(port, CCR0, ctrl_temp);
+}
+
+static const char *rsci_type(struct uart_port *port)
+{
+	return "rsci";
+}
+
+static size_t rsci_suspend_regs_size(void)
+{
+	return 0;
+}
+
+static void rsci_shutdown_complete(struct uart_port *port)
+{
+	/*
+	 * Stop RX and TX, disable related interrupts, keep clock source
+	 */
+	rsci_serial_out(port, CCR0, 0);
+}
+
+static const struct sci_common_regs rsci_common_regs = {
+	.status = CSR,
+	.control = CCR0,
+};
+
+static const struct sci_port_params_bits rsci_port_param_bits = {
+	.rxtx_enable = CCR0_RE | CCR0_TE,
+	.te_clear = CCR0_TE | CCR0_TEIE,
+	.poll_sent_bits = CSR_TDRE | CSR_TEND,
+};
+
+static const struct sci_port_params rsci_port_params = {
+	.fifosize = 16,
+	.overrun_reg = CSR,
+	.overrun_mask = CSR_ORER,
+	.sampling_rate_mask = SCI_SR(32),
+	.error_mask = RSCI_DEFAULT_ERROR_MASK,
+	.error_clear = RSCI_ERROR_CLEAR,
+	.param_bits = &rsci_port_param_bits,
+	.common_regs = &rsci_common_regs,
+};
+
+static const struct uart_ops rsci_uart_ops = {
+	.tx_empty	= rsci_tx_empty,
+	.set_mctrl	= rsci_set_mctrl,
+	.get_mctrl	= rsci_get_mctrl,
+	.start_tx	= rsci_start_tx,
+	.stop_tx	= rsci_stop_tx,
+	.stop_rx	= rsci_stop_rx,
+	.startup	= sci_startup,
+	.shutdown	= sci_shutdown,
+	.set_termios	= rsci_set_termios,
+	.pm		= sci_pm,
+	.type		= rsci_type,
+	.release_port	= sci_release_port,
+	.request_port	= sci_request_port,
+	.config_port	= sci_config_port,
+	.verify_port	= sci_verify_port,
+};
+
+static const struct sci_port_ops rsci_port_ops = {
+	.read_reg		= rsci_serial_in,
+	.write_reg		= rsci_serial_out,
+	.clear_SCxSR		= rsci_clear_SCxSR,
+	.transmit_chars		= rsci_transmit_chars,
+	.receive_chars		= rsci_receive_chars,
+	.poll_put_char		= rsci_poll_put_char,
+	.prepare_console_write	= rsci_prepare_console_write,
+	.suspend_regs_size	= rsci_suspend_regs_size,
+	.shutdown_complete	= rsci_shutdown_complete,
+};
+
+struct sci_of_data of_sci_rsci_data = {
+	.type = SCI_PORT_RSCI,
+	.ops = &rsci_port_ops,
+	.uart_ops = &rsci_uart_ops,
+	.params = &rsci_port_params,
+};
+
+#ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
+
+static int __init rsci_early_console_setup(struct earlycon_device *device,
+					   const char *opt)
+{
+	return scix_early_console_setup(device, &of_sci_rsci_data);
+}
+
+OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g077-rsci", rsci_early_console_setup);
+
+#endif /* CONFIG_SERIAL_SH_SCI_EARLYCON */
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RSCI serial driver");
diff --git a/drivers/tty/serial/rsci.h b/drivers/tty/serial/rsci.h
new file mode 100644
index 000000000000..2af3f28b465a
--- /dev/null
+++ b/drivers/tty/serial/rsci.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __RSCI_H__
+#define __RSCI_H__
+
+#include "sh-sci-common.h"
+
+extern struct sci_of_data of_sci_rsci_data;
+
+#endif /* __RSCI_H__ */
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index fcddf66780c9..e3c028df14f1 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -5,6 +5,11 @@
 
 #include <linux/serial_core.h>
 
+/* Private port IDs */
+enum SCI_PORT_TYPE {
+	SCI_PORT_RSCI = BIT(7) | 0,
+};
+
 enum SCI_CLKS {
 	SCI_FCK,		/* Functional Clock */
 	SCI_SCK,		/* Optional External Clock */
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3b8d9cf4d257..d941d4757842 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -55,6 +55,7 @@
 #include <asm/platform_early.h>
 #endif
 
+#include "rsci.h"
 #include "serial_mctrl_gpio.h"
 #include "sh-sci.h"
 #include "sh-sci-common.h"
@@ -551,6 +552,7 @@ void sci_port_enable(struct sci_port *sci_port)
 	}
 	sci_port->port.uartclk = sci_port->clk_rates[SCI_FCK];
 }
+EXPORT_SYMBOL_NS_GPL(sci_port_enable, SH_SCI);
 
 void sci_port_disable(struct sci_port *sci_port)
 {
@@ -564,6 +566,7 @@ void sci_port_disable(struct sci_port *sci_port)
 
 	pm_runtime_put_sync(sci_port->port.dev);
 }
+EXPORT_SYMBOL_NS_GPL(sci_port_disable, SH_SCI);
 
 static inline unsigned long port_rx_irq_mask(struct uart_port *port)
 {
@@ -1836,7 +1839,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 	unsigned long flags;
 	u32 ctrl;
 
-	if (s->type != PORT_SCI)
+	if (s->type != PORT_SCI && s->type != SCI_PORT_RSCI)
 		return sci_tx_interrupt(irq, ptr);
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -2297,6 +2300,7 @@ int sci_startup(struct uart_port *port)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(sci_startup, SH_SCI);
 
 void sci_shutdown(struct uart_port *port)
 {
@@ -2327,6 +2331,7 @@ void sci_shutdown(struct uart_port *port)
 	sci_free_irq(s);
 	sci_free_dma(port);
 }
+EXPORT_SYMBOL_NS_GPL(sci_shutdown, SH_SCI);
 
 static int sci_sck_calc(struct sci_port *s, unsigned int bps,
 			unsigned int *srr)
@@ -2758,6 +2763,7 @@ void sci_pm(struct uart_port *port, unsigned int state,
 		break;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(sci_pm, SH_SCI);
 
 static const char *sci_type(struct uart_port *port)
 {
@@ -2820,6 +2826,7 @@ void sci_release_port(struct uart_port *port)
 
 	release_mem_region(port->mapbase, sport->reg_size);
 }
+EXPORT_SYMBOL_NS_GPL(sci_release_port, SH_SCI);
 
 int sci_request_port(struct uart_port *port)
 {
@@ -2842,6 +2849,7 @@ int sci_request_port(struct uart_port *port)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(sci_request_port, SH_SCI);
 
 void sci_config_port(struct uart_port *port, int flags)
 {
@@ -2851,6 +2859,7 @@ void sci_config_port(struct uart_port *port, int flags)
 		sci_request_port(port);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(sci_config_port, SH_SCI);
 
 int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
@@ -2860,6 +2869,7 @@ int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(sci_verify_port, SH_SCI);
 
 static void sci_prepare_console_write(struct uart_port *port, u32 ctrl)
 {
@@ -2985,14 +2995,27 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	struct clk *clk;
 	unsigned int i;
 
-	if (sci_port->type == PORT_HSCIF)
+	if (sci_port->type == PORT_HSCIF) {
 		clk_names[SCI_SCK] = "hsck";
+	} else if (sci_port->type == SCI_PORT_RSCI) {
+		clk_names[SCI_FCK] = "operation";
+		clk_names[SCI_BRG_INT] = "bus";
+	}
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
-		clk = devm_clk_get_optional(dev, clk_names[i]);
+		const char *name = clk_names[i];
+
+		clk = devm_clk_get_optional(dev, name);
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 
+		if (!clk && sci_port->type == SCI_PORT_RSCI &&
+		    (i == SCI_FCK || i == SCI_BRG_INT)) {
+			return dev_err_probe(dev, -ENODEV,
+					     "failed to get %s\n",
+					     name);
+		}
+
 		if (!clk && i == SCI_FCK) {
 			/*
 			 * Not all SH platforms declare a clock lookup entry
@@ -3003,13 +3026,13 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			if (IS_ERR(clk))
 				return dev_err_probe(dev, PTR_ERR(clk),
 						     "failed to get %s\n",
-						     clk_names[i]);
+						     name);
 		}
 
 		if (!clk)
-			dev_dbg(dev, "failed to get %s\n", clk_names[i]);
+			dev_dbg(dev, "failed to get %s\n", name);
 		else
-			dev_dbg(dev, "clk %s is %pC rate %lu\n", clk_names[i],
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", name,
 				clk, clk_get_rate(clk));
 		sci_port->clks[i] = clk;
 	}
@@ -3093,10 +3116,10 @@ static int sci_init_single(struct platform_device *dev,
 	}
 
 	/*
-	 * The fourth interrupt on SCI port is transmit end interrupt, so
+	 * The fourth interrupt on SCI and RSCI port is transmit end interrupt, so
 	 * shuffle the interrupts.
 	 */
-	if (p->type == PORT_SCI)
+	if (p->type == PORT_SCI || p->type == SCI_PORT_RSCI)
 		swap(sci_port->irqs[SCIx_BRI_IRQ], sci_port->irqs[SCIx_TEI_IRQ]);
 
 	/* The SCI generates several interrupts. They can be muxed together or
@@ -3130,6 +3153,9 @@ static int sci_init_single(struct platform_device *dev,
 		else
 			sci_port->rx_trigger = 8;
 		break;
+	case SCI_PORT_RSCI:
+		sci_port->rx_trigger = 15;
+		break;
 	default:
 		sci_port->rx_trigger = 1;
 		break;
@@ -3342,7 +3368,8 @@ static int sci_remove(struct platform_device *dev)
 
 	if (s->port.fifosize > 1)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
-	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF)
+	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF ||
+	    type == SCI_PORT_RSCI)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 
 	return 0;
@@ -3438,6 +3465,12 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
 		.compatible = "renesas,scif-r9a09g057",
 		.data = &of_sci_scif_rzv2h,
 	},
+#ifdef CONFIG_SERIAL_RSCI
+	{
+		.compatible = "renesas,r9a09g077-rsci",
+		.data = &of_sci_rsci_data,
+	},
+#endif	/* CONFIG_SERIAL_RSCI */
 	/* Family-specific types */
 	{
 		.compatible = "renesas,rcar-gen1-scif",
@@ -3697,7 +3730,7 @@ static int sci_probe(struct platform_device *dev)
 			return ret;
 	}
 	if (sp->type == PORT_SCIFA || sp->type == PORT_SCIFB ||
-	    sp->type == PORT_HSCIF) {
+	    sp->type == PORT_HSCIF || sp->type == SCI_PORT_RSCI) {
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
 			if (sp->port.fifosize > 1) {
-- 
2.43.0


