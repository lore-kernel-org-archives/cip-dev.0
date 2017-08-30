From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:05:59 +0200
Subject: [cip-dev] [PATCH 02/25] serial: 8250_pci: Use symbolic constants
	for EXAR's MPIO registers
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <dd1ef73e412d2e51dd26ea0792e126a3333eda0b.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit b6fce7382d72274336aeafe6e44da755a371ed32 upstream.

Less magic that only requires comments.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c | 55 +++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index cf3da51a3536..cf7f6151e66a 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1755,6 +1755,19 @@ static int pci_eg20t_init(struct pci_dev *dev)
 #define PCI_DEVICE_ID_EXAR_XR17V4358	0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358	0x8358
 
+#define UART_EXAR_MPIOINT_7_0	0x8f	/* MPIOINT[7:0] */
+#define UART_EXAR_MPIOLVL_7_0	0x90	/* MPIOLVL[7:0] */
+#define UART_EXAR_MPIO3T_7_0	0x91	/* MPIO3T[7:0] */
+#define UART_EXAR_MPIOINV_7_0	0x92	/* MPIOINV[7:0] */
+#define UART_EXAR_MPIOSEL_7_0	0x93	/* MPIOSEL[7:0] */
+#define UART_EXAR_MPIOOD_7_0	0x94	/* MPIOOD[7:0] */
+#define UART_EXAR_MPIOINT_15_8	0x95	/* MPIOINT[15:8] */
+#define UART_EXAR_MPIOLVL_15_8	0x96	/* MPIOLVL[15:8] */
+#define UART_EXAR_MPIO3T_15_8	0x97	/* MPIO3T[15:8] */
+#define UART_EXAR_MPIOINV_15_8	0x98	/* MPIOINV[15:8] */
+#define UART_EXAR_MPIOSEL_15_8	0x99	/* MPIOSEL[15:8] */
+#define UART_EXAR_MPIOOD_15_8	0x9a	/* MPIOOD[15:8] */
+
 static int
 pci_xr17c154_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
@@ -1797,18 +1810,18 @@ pci_xr17v35x_setup(struct serial_private *priv,
 	 * Setup Multipurpose Input/Output pins.
 	 */
 	if (idx == 0) {
-		writeb(0x00, p + 0x8f); /*MPIOINT[7:0]*/
-		writeb(0x00, p + 0x90); /*MPIOLVL[7:0]*/
-		writeb(0x00, p + 0x91); /*MPIO3T[7:0]*/
-		writeb(0x00, p + 0x92); /*MPIOINV[7:0]*/
-		writeb(0x00, p + 0x93); /*MPIOSEL[7:0]*/
-		writeb(0x00, p + 0x94); /*MPIOOD[7:0]*/
-		writeb(0x00, p + 0x95); /*MPIOINT[15:8]*/
-		writeb(0x00, p + 0x96); /*MPIOLVL[15:8]*/
-		writeb(0x00, p + 0x97); /*MPIO3T[15:8]*/
-		writeb(0x00, p + 0x98); /*MPIOINV[15:8]*/
-		writeb(0x00, p + 0x99); /*MPIOSEL[15:8]*/
-		writeb(0x00, p + 0x9a); /*MPIOOD[15:8]*/
+		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
+		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
+		writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
+		writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
+		writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
+		writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
+		writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
 	}
 	writeb(0x00, p + UART_EXAR_8XMODE);
 	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
@@ -1844,20 +1857,20 @@ pci_fastcom335_setup(struct serial_private *priv,
 		switch (priv->dev->device) {
 		case PCI_DEVICE_ID_COMMTECH_4222PCI335:
 		case PCI_DEVICE_ID_COMMTECH_4224PCI335:
-			writeb(0x78, p + 0x90); /* MPIOLVL[7:0] */
-			writeb(0x00, p + 0x92); /* MPIOINV[7:0] */
-			writeb(0x00, p + 0x93); /* MPIOSEL[7:0] */
+			writeb(0x78, p + UART_EXAR_MPIOLVL_7_0);
+			writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
+			writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
 			break;
 		case PCI_DEVICE_ID_COMMTECH_2324PCI335:
 		case PCI_DEVICE_ID_COMMTECH_2328PCI335:
-			writeb(0x00, p + 0x90); /* MPIOLVL[7:0] */
-			writeb(0xc0, p + 0x92); /* MPIOINV[7:0] */
-			writeb(0xc0, p + 0x93); /* MPIOSEL[7:0] */
+			writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
+			writeb(0xc0, p + UART_EXAR_MPIOINV_7_0);
+			writeb(0xc0, p + UART_EXAR_MPIOSEL_7_0);
 			break;
 		}
-		writeb(0x00, p + 0x8f); /* MPIOINT[7:0] */
-		writeb(0x00, p + 0x91); /* MPIO3T[7:0] */
-		writeb(0x00, p + 0x94); /* MPIOOD[7:0] */
+		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
+		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
+		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
 	}
 	writeb(0x00, p + UART_EXAR_8XMODE);
 	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
-- 
2.12.3
