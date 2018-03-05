From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:01:59 +0000
Subject: [cip-dev] [PATCH 03/15] serial: sh-sci: Always set TIOCM_CTS in
	.get_mctrl() callback
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Documentation/serial/driver clearly states:

    If the port does not support CTS, DCD or DSR, the driver should
    indicate that the signal is permanently active.

Hence always set TIOCM_CTS, as we currently don't look at the CTS
hardware line state at all.

FWIW, this fixes the transmit path when hardware-assisted flow control
is enabled, and userspace enables CRTSCTS.
The receive path is still broken, as RTS is never asserted.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 71e98e0e2aede08d6e0a0f3d94ea28b591ef4306)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 80d0ffe..5f148f3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1756,9 +1756,9 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
 {
 	/*
 	 * CTS/RTS is handled in hardware when supported, while nothing
-	 * else is wired up. Keep it simple and simply assert DSR/CAR.
+	 * else is wired up. Keep it simple and simply assert CTS/DSR/CAR.
 	 */
-	return TIOCM_DSR | TIOCM_CAR;
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
 }
 
 static void sci_break_ctl(struct uart_port *port, int break_state)
-- 
2.7.4
