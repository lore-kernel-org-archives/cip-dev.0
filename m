From: mosipov@ilbers.de (Maxim Yu. Osipov)
Date: Mon, 27 Nov 2017 16:37:21 +0100
Subject: [cip-dev] [PATCH] tty: serial: imx: disable irq after suspend
Message-ID: <20171127153721.24110-1-mosipov@ilbers.de>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 81b289cc14ba349cc4707cf664aa1c72d7dff1d7 upstream.

If any key on console is pressed when board is suspended,
board hangs.

Driver's interrupt handler must be guaranteed not to run while
resume/suspend_noirq() are being executed. See include/linux/pm.h
for details.

Tested on i.MX6 based board.

The idea of this fix is based on commit in official i.MX kernel tree:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git
commit 81e8e7d91d81 ("tty: serial: imx: disable irq after suspend")

Disable rx irq after suspend to avoid interrupt coming in early resume.

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Maxim Yu. Osipov <mosipov@ilbers.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 016e4be05cec..fae8c83708b1 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2108,6 +2108,7 @@ static int imx_serial_port_suspend(struct device *dev)
 	serial_imx_enable_wakeup(sport, true);
 
 	uart_suspend_port(&imx_reg, &sport->port);
+	disable_irq(sport->port.irq);
 
 	return 0;
 }
@@ -2121,6 +2122,7 @@ static int imx_serial_port_resume(struct device *dev)
 	serial_imx_enable_wakeup(sport, false);
 
 	uart_resume_port(&imx_reg, &sport->port);
+	enable_irq(sport->port.irq);
 
 	return 0;
 }
-- 
2.11.0
