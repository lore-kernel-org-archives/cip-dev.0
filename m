From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:02:05 +0000
Subject: [cip-dev] [PATCH 09/15] serial: sh-sci: Add pin initialization for
	SCIFA/SCIFB
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-10-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Before, the driver relied on initialization by the boot loader, or by
implicit reset state.

Note that unlike on (H)SCIF, the RTS/CTS bits exist only if dedicated
RTS/CTS pins are available, which depends on the SoC and UART instance.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit e9d7a45a039913497a57887d85f5decfda4679f0)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e725023..e351c6f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -633,7 +633,21 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 		return;
 	}
 
-	if (sci_getreg(port, SCSPTR)->size) {
+	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
+		u16 ctrl = serial_port_in(port, SCPCR);
+
+		/* Enable RXD and TXD pin functions */
+		ctrl &= ~(SCPCR_RXDC | SCPCR_TXDC);
+		if (to_sci_port(port)->cfg->capabilities & SCIx_HAVE_RTSCTS) {
+			/* RTS# is output, driven 1 */
+			ctrl |= SCPCR_RTSC;
+			serial_port_out(port, SCPDR,
+				serial_port_in(port, SCPDR) | SCPDR_RTSD);
+			/* Enable CTS# pin function */
+			ctrl &= ~SCPCR_CTSC;
+		}
+		serial_port_out(port, SCPCR, ctrl);
+	} else if (sci_getreg(port, SCSPTR)->size) {
 		u16 status = serial_port_in(port, SCSPTR);
 
 		/* RTS# is output, driven 1 */
-- 
2.7.4
