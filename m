From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:08 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 21/57] serial: sh-sci: Extract
	sci_dma_rx_reenable_irq()
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-22-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 38766e4b612ba10844afadf2fce12f8f90465c64 upstream.

Extract the functionality to direct new serial port interrupts back to
the CPU into its own helper, to prepare for using it from a second
callsite.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 2632bb2..d5bd3f7 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1264,6 +1264,20 @@ static void start_hrtimer_us(struct hrtimer *hrt, unsigned long usec)
 	hrtimer_start(hrt, t, HRTIMER_MODE_REL);
 }
 
+static void sci_dma_rx_reenable_irq(struct sci_port *s)
+{
+	struct uart_port *port = &s->port;
+	u16 scr;
+
+	/* Direct new serial port interrupts back to CPU */
+	scr = serial_port_in(port, SCSCR);
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		scr &= ~SCSCR_RDRQE;
+		enable_irq(s->irqs[SCIx_RXI_IRQ]);
+	}
+	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
+}
+
 static void sci_dma_rx_complete(void *arg)
 {
 	struct sci_port *s = arg;
@@ -1451,7 +1465,6 @@ static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
 	unsigned long flags;
 	unsigned int read;
 	int active, count;
-	u16 scr;
 
 	dev_dbg(port->dev, "DMA Rx timed out\n");
 
@@ -1501,13 +1514,7 @@ static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 		sci_submit_rx(s, true);
 
-	/* Direct new serial port interrupts back to CPU */
-	scr = serial_port_in(port, SCSCR);
-	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
-		scr &= ~SCSCR_RDRQE;
-		enable_irq(s->irqs[SCIx_RXI_IRQ]);
-	}
-	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
+	sci_dma_rx_reenable_irq(s);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.7.4
