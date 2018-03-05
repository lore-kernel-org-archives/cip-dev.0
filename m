From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:02:04 +0000
Subject: [cip-dev] [PATCH 08/15] serial: sh-sci: Correct pin initialization
	on (H)SCIF
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Correct pin initialization on (H)SCIF:
  - RTS must be deasserted (it's active low),
  - SCK must be an input, as it may be used as the optional external
    clock input.

Initial pin configuration must always be done:
  - Regardless of the presence of dedicated RTS and CTS pins: if the
    register exists, the RTS/CTS bits exist, too,
  - Regardless of hardware flow control being enabled or not: RTS must
    be deasserted.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit d2b9775d795ec05fb42504c0f47dd06ba5fd709e)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f96f44c..e725023 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -633,21 +633,14 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 		return;
 	}
 
-	/*
-	 * For the generic path SCSPTR is necessary. Bail out if that's
-	 * unavailable, too.
-	 */
-	if (!sci_getreg(port, SCSPTR)->size)
-		return;
-
-	if ((s->cfg->capabilities & SCIx_HAVE_RTSCTS) &&
-	    ((!(cflag & CRTSCTS)))) {
-		unsigned short status;
-
-		status = serial_port_in(port, SCSPTR);
-		status &= ~SCSPTR_CTSIO;
-		status |= SCSPTR_RTSIO;
-		serial_port_out(port, SCSPTR, status); /* Set RTS = 1 */
+	if (sci_getreg(port, SCSPTR)->size) {
+		u16 status = serial_port_in(port, SCSPTR);
+
+		/* RTS# is output, driven 1 */
+		status |= SCSPTR_RTSIO | SCSPTR_RTSDT;
+		/* CTS# and SCK are inputs */
+		status &= ~(SCSPTR_CTSIO | SCSPTR_SCKIO);
+		serial_port_out(port, SCSPTR, status);
 	}
 }
 
-- 
2.7.4
