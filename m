From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:02:01 +0000
Subject: [cip-dev] [PATCH 05/15] serial: sh-sci: Do not open-code
	sci_getreg()
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace open-coded variants of sci_getreg() by function calls, and drop
intermediate variables where appropriate.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit abbf121fb6dae6657388a32feac346e5e1debdbd)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cf91172..f96f44c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -624,7 +624,6 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 {
 	struct sci_port *s = to_sci_port(port);
-	const struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
 
 	/*
 	 * Use port-specific handler if provided.
@@ -638,7 +637,7 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 	 * For the generic path SCSPTR is necessary. Bail out if that's
 	 * unavailable, too.
 	 */
-	if (!reg->size)
+	if (!sci_getreg(port, SCSPTR)->size)
 		return;
 
 	if ((s->cfg->capabilities & SCIx_HAVE_RTSCTS) &&
@@ -1787,12 +1786,10 @@ static void sci_enable_ms(struct uart_port *port)
 
 static void sci_break_ctl(struct uart_port *port, int break_state)
 {
-	struct sci_port *s = to_sci_port(port);
-	const struct plat_sci_reg *reg = sci_regmap[s->cfg->regtype] + SCSPTR;
 	unsigned short scscr, scsptr;
 
 	/* check wheter the port has SCSPTR */
-	if (!reg->size) {
+	if (!sci_getreg(port, SCSPTR)->size) {
 		/*
 		 * Not supported by hardware. Most parts couple break and rx
 		 * interrupts together, with break detection always enabled.
-- 
2.7.4
