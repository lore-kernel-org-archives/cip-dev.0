From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:20 +0200
Subject: [cip-dev] [PATCH 23/25] serial: exar: Factor out platform hooks
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <aa6c51db76eb4049c15cb393251d6e52224d4261.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 0d963ebf57d4c6374b3a33050a18af23c1e2ede1 upstream.

This prepares the addition of IOT2040 platform support by preparing the
needed setup and rs485_config hooks.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_exar.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 477d1b8af107..fd721097f179 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -50,6 +50,11 @@
 
 struct exar8250;
 
+struct exar8250_platform {
+	int (*rs485_config)(struct uart_port *, struct serial_rs485 *);
+	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
+};
+
 /**
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
@@ -183,7 +188,7 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 }
 
 static void *
-xr17v35x_register_gpio(struct pci_dev *pcidev)
+__xr17v35x_register_gpio(struct pci_dev *pcidev)
 {
 	struct platform_device *pdev;
 
@@ -202,17 +207,36 @@ xr17v35x_register_gpio(struct pci_dev *pcidev)
 	return pdev;
 }
 
+static int xr17v35x_register_gpio(struct pci_dev *pcidev,
+				  struct uart_8250_port *port)
+{
+	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
+		port->port.private_data =
+			__xr17v35x_register_gpio(pcidev);
+
+	return 0;
+}
+
+static const struct exar8250_platform exar8250_default_platform = {
+	.register_gpio = xr17v35x_register_gpio,
+};
+
 static int
 pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
 {
 	const struct exar8250_board *board = priv->board;
+	const struct exar8250_platform *platform;
 	unsigned int offset = idx * 0x400;
 	unsigned int baud = 7812500;
 	u8 __iomem *p;
 	int ret;
 
+	platform = &exar8250_default_platform;
+
 	port->port.uartclk = baud * 16;
+	port->port.rs485_config = platform->rs485_config;
+
 	/*
 	 * Setup the uart clock for the devices on expansion slot to
 	 * half the clock speed of the main chip (which is 125MHz)
@@ -235,12 +259,10 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		/* Setup Multipurpose Input/Output pins. */
 		setup_gpio(pcidev, p);
 
-		if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
-			port->port.private_data =
-				xr17v35x_register_gpio(pcidev);
+		ret = platform->register_gpio(pcidev, port);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void pci_xr17v35x_exit(struct pci_dev *pcidev)
-- 
2.12.3
