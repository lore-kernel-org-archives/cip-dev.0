From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:02:06 +0000
Subject: [cip-dev] [PATCH 10/15] serial: sh-sci: Fix support for
	hardware-assisted RTS/CTS
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The existing support for hardware-assisted RTS/CTS is rudimentary and
doesn't work.

Add support for hardware-assisted RTS/CTS hardware flow control for the
(H)SCIF, SCIFA, and SCIFB variants.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 33f50ffc253854cf6cd556786ae893c7454a1a67)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 90 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e351c6f..4e53fa4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -117,6 +117,8 @@ struct sci_port {
 	struct timer_list		rx_timer;
 	unsigned int			rx_timeout;
 #endif
+
+	bool autorts;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -1732,6 +1734,46 @@ static unsigned int sci_tx_empty(struct uart_port *port)
 	return (status & SCxSR_TEND(port)) && !in_tx_fifo ? TIOCSER_TEMT : 0;
 }
 
+static void sci_set_rts(struct uart_port *port, bool state)
+{
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		u16 data = serial_port_in(port, SCPDR);
+
+		/* Active low */
+		if (state)
+			data &= ~SCPDR_RTSD;
+		else
+			data |= SCPDR_RTSD;
+		serial_port_out(port, SCPDR, data);
+
+		/* RTS# is output */
+		serial_port_out(port, SCPCR,
+				serial_port_in(port, SCPCR) | SCPCR_RTSC);
+	} else if (sci_getreg(port, SCSPTR)->size) {
+		u16 ctrl = serial_port_in(port, SCSPTR);
+
+		/* Active low */
+		if (state)
+			ctrl &= ~SCSPTR_RTSDT;
+		else
+			ctrl |= SCSPTR_RTSDT;
+		serial_port_out(port, SCSPTR, ctrl);
+	}
+}
+
+static bool sci_get_cts(struct uart_port *port)
+{
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		/* Active low */
+		return !(serial_port_in(port, SCPDR) & SCPDR_CTSD);
+	} else if (sci_getreg(port, SCSPTR)->size) {
+		/* Active low */
+		return !(serial_port_in(port, SCSPTR) & SCSPTR_CTSDT);
+	}
+
+	return true;
+}
+
 /*
  * Modem control is a bit of a mixed bag for SCI(F) ports. Generally
  * CTS/RTS is supported in hardware by at least one port and controlled
@@ -1762,6 +1804,31 @@ static void sci_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	}
 
 	mctrl_gpio_set(s->gpios, mctrl);
+
+	if (!(s->cfg->capabilities & SCIx_HAVE_RTSCTS))
+		return;
+
+	if (!(mctrl & TIOCM_RTS)) {
+		/* Disable Auto RTS */
+		serial_port_out(port, SCFCR,
+				serial_port_in(port, SCFCR) & ~SCFCR_MCE);
+
+		/* Clear RTS */
+		sci_set_rts(port, 0);
+	} else if (s->autorts) {
+		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+			/* Enable RTS# pin function */
+			serial_port_out(port, SCPCR,
+				serial_port_in(port, SCPCR) & ~SCPCR_RTSC);
+		}
+
+		/* Enable Auto RTS */
+		serial_port_out(port, SCFCR,
+				serial_port_in(port, SCFCR) | SCFCR_MCE);
+	} else {
+		/* Set RTS */
+		sci_set_rts(port, 1);
+	}
 }
 
 static unsigned int sci_get_mctrl(struct uart_port *port)
@@ -1774,10 +1841,14 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
 
 	/*
 	 * CTS/RTS is handled in hardware when supported, while nothing
-	 * else is wired up. Keep it simple and simply assert CTS/DSR/CAR.
+	 * else is wired up.
 	 */
-	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS)))
+	if (s->autorts) {
+		if (sci_get_cts(port))
+			mctrl |= TIOCM_CTS;
+	} else if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_CTS))) {
 		mctrl |= TIOCM_CTS;
+	}
 	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DSR)))
 		mctrl |= TIOCM_DSR;
 	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, UART_GPIO_DCD)))
@@ -1850,6 +1921,7 @@ static void sci_shutdown(struct uart_port *port)
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	s->autorts = false;
 	mctrl_gpio_disable_ms(to_sci_port(port)->gpios);
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -2035,15 +2107,18 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	sci_init_pins(port, termios->c_cflag);
 
+	port->status &= ~UPSTAT_AUTOCTS;
+	s->autorts = false;
 	reg = sci_getreg(port, SCFCR);
 	if (reg->size) {
 		unsigned short ctrl = serial_port_in(port, SCFCR);
 
-		if (s->cfg->capabilities & SCIx_HAVE_RTSCTS) {
-			if (termios->c_cflag & CRTSCTS)
-				ctrl |= SCFCR_MCE;
-			else
-				ctrl &= ~SCFCR_MCE;
+		if ((port->flags & UPF_HARD_FLOW) &&
+		    (termios->c_cflag & CRTSCTS)) {
+			/* There is no CTS interrupt to restart the hardware */
+			port->status |= UPSTAT_AUTOCTS;
+			/* MCE is enabled when RTS is raised */
+			s->autorts = true;
 		}
 
 		/*
@@ -2687,6 +2762,7 @@ static int sci_probe_single(struct platform_device *dev,
 			dev_err(&dev->dev, "Conflicting RTS/CTS config\n");
 			return -EINVAL;
 		}
+		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-- 
2.7.4
