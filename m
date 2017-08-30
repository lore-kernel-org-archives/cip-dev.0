From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:02 +0200
Subject: [cip-dev] [PATCH 05/25] serial: exar: Fix initialization of EXAR
	registers for ports > 0
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <8ad4efe06739a452a078cb7e29947b7cdb7c7497.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 5b5f252d67afd7bd5b923c664206d60800bf5054 upstream.

So far, pci_xr17v35x_setup always initialized 8XMODE, FCTR & Co. for
port 0 because it used the address of that port instead of moving the
pointer according to the port number. Fix this and remove the unneeded
temporary ioremap by moving default_setup up and reusing the membase it
fills into the port structure.

Fixes: 14faa8cce88e ("tty/8250 Add support for Commtech's Fastcom Async-335 and Fastcom Async-PCIe cards")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_exar.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 58469d9d6515..f489f25643c5 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -157,27 +157,23 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	if (board->has_slave && idx >= 8)
 		port->port.uartclk /= 2;
 
-	p = pci_ioremap_bar(pcidev, 0);
-	if (!p)
-		return -ENOMEM;
+	ret = default_setup(priv, pcidev, idx, offset, port);
+	if (ret)
+		return ret;
 
-	/* Setup Multipurpose Input/Output pins. */
-	if (idx == 0)
-		setup_gpio(p);
+	p = port->port.membase;
 
 	writeb(0x00, p + UART_EXAR_8XMODE);
 	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
 	writeb(128, p + UART_EXAR_TXTRG);
 	writeb(128, p + UART_EXAR_RXTRG);
-	iounmap(p);
 
-	ret = default_setup(priv, pcidev, idx, offset, port);
-	if (ret)
-		return ret;
+	if (idx == 0) {
+		/* Setup Multipurpose Input/Output pins. */
+		setup_gpio(p);
 
-	if (idx == 0)
-		port->port.private_data =
-			xr17v35x_register_gpio(pcidev);
+		port->port.private_data = xr17v35x_register_gpio(pcidev);
+	}
 
 	return 0;
 }
-- 
2.12.3
