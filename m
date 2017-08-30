From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:08 +0200
Subject: [cip-dev] [PATCH 11/25] serial: exar: Leave MPIOs as output for
	Commtech adapters
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <dd7d73e982576e80761df1b482a846c6a1c48f2c.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit bea8be656185a2808a2f255f4a91ff18215a9d0c upstream.

Commtech adapters apparently need the original setting as outputs, see
https://marc.info/?l=linux-gpio&m=149557425201323&w=2. Account for that.

Fixes: 7dea8165f1d6 ("serial: exar: Preconfigure xr17v35x MPIOs as output")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_exar.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 8d392ad207cf..e78ed54a696b 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -158,19 +158,26 @@ pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 	return default_setup(priv, pcidev, idx, offset, port);
 }
 
-static void setup_gpio(u8 __iomem *p)
+static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 {
+	/*
+	 * The Commtech adapters required the MPIOs to be driven low. The Exar
+	 * devices will export them as GPIOs, so we pre-configure them safely
+	 * as inputs.
+	 */
+	u8 dir = pcidev->vendor == PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
+
 	writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
 	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
-	writeb(0xff, p + UART_EXAR_MPIOSEL_7_0);
+	writeb(dir,  p + UART_EXAR_MPIOSEL_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
 	writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
-	writeb(0xff, p + UART_EXAR_MPIOSEL_15_8);
+	writeb(dir,  p + UART_EXAR_MPIOSEL_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
 }
 
@@ -223,7 +230,7 @@ pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 
 	if (idx == 0) {
 		/* Setup Multipurpose Input/Output pins. */
-		setup_gpio(p);
+		setup_gpio(pcidev, p);
 
 		port->port.private_data = xr17v35x_register_gpio(pcidev);
 	}
-- 
2.12.3
