From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:00 +0200
Subject: [cip-dev] [PATCH 03/25] serial: 8250_pci: remove exar code
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <5d3a433cb1901cc5af514990c73cf3c8a188e98d.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

commit 5d1a2388edee77930c8b542cf8be0c92342dbeb4 upstream.

Remove the Exar specific codes from 8250_pci and blacklist those chips
so that the new Exar serial driver binds to the devices.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c | 336 +------------------------------------
 drivers/tty/serial/8250/Kconfig    |   1 +
 2 files changed, 4 insertions(+), 333 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index cf7f6151e66a..b961d688ab48 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1752,9 +1752,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
 #endif
 }
 
-#define PCI_DEVICE_ID_EXAR_XR17V4358	0x4358
-#define PCI_DEVICE_ID_EXAR_XR17V8358	0x8358
-
 #define UART_EXAR_MPIOINT_7_0	0x8f	/* MPIOINT[7:0] */
 #define UART_EXAR_MPIOLVL_7_0	0x90	/* MPIOLVL[7:0] */
 #define UART_EXAR_MPIO3T_7_0	0x91	/* MPIO3T[7:0] */
@@ -1767,71 +1764,6 @@ static int pci_eg20t_init(struct pci_dev *dev)
 #define UART_EXAR_MPIOINV_15_8	0x98	/* MPIOINV[15:8] */
 #define UART_EXAR_MPIOSEL_15_8	0x99	/* MPIOSEL[15:8] */
 #define UART_EXAR_MPIOOD_15_8	0x9a	/* MPIOOD[15:8] */
-
-static int
-pci_xr17c154_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	port->port.flags |= UPF_EXAR_EFR;
-	return pci_default_setup(priv, board, port, idx);
-}
-
-static inline int
-xr17v35x_has_slave(struct serial_private *priv)
-{
-	const int dev_id = priv->dev->device;
-
-	return ((dev_id == PCI_DEVICE_ID_EXAR_XR17V4358) ||
-	        (dev_id == PCI_DEVICE_ID_EXAR_XR17V8358));
-}
-
-static int
-pci_xr17v35x_setup(struct serial_private *priv,
-		  const struct pciserial_board *board,
-		  struct uart_8250_port *port, int idx)
-{
-	u8 __iomem *p;
-
-	p = pci_ioremap_bar(priv->dev, 0);
-	if (p == NULL)
-		return -ENOMEM;
-
-	port->port.flags |= UPF_EXAR_EFR;
-
-	/*
-	 * Setup the uart clock for the devices on expansion slot to
-	 * half the clock speed of the main chip (which is 125MHz)
-	 */
-	if (xr17v35x_has_slave(priv) && idx >= 8)
-		port->port.uartclk = (7812500 * 16 / 2);
-
-	/*
-	 * Setup Multipurpose Input/Output pins.
-	 */
-	if (idx == 0) {
-		writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
-		writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
-		writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
-		writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
-		writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
-		writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
-		writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
-		writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
-		writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
-		writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
-		writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
-		writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
-	}
-	writeb(0x00, p + UART_EXAR_8XMODE);
-	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
-	writeb(128, p + UART_EXAR_TXTRG);
-	writeb(128, p + UART_EXAR_RXTRG);
-	iounmap(p);
-
-	return pci_default_setup(priv, board, port, idx);
-}
-
 #define PCI_DEVICE_ID_COMMTECH_4222PCI335 0x0004
 #define PCI_DEVICE_ID_COMMTECH_4224PCI335 0x0002
 #define PCI_DEVICE_ID_COMMTECH_2324PCI335 0x000a
@@ -1945,9 +1877,6 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 #define PCI_VENDOR_ID_AGESTAR		0x5372
 #define PCI_DEVICE_ID_AGESTAR_9375	0x6872
 #define PCI_VENDOR_ID_ASIX		0x9710
-#define PCI_DEVICE_ID_COMMTECH_4224PCIE	0x0020
-#define PCI_DEVICE_ID_COMMTECH_4228PCIE	0x0021
-#define PCI_DEVICE_ID_COMMTECH_4222PCIE	0x0022
 #define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
 #define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
 #define PCI_DEVICE_ID_INTEL_QRK_UART	0x0936
@@ -2452,65 +2381,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.setup		= pci_timedia_setup,
 	},
 	/*
-	 * Exar cards
-	 */
-	{
-		.vendor = PCI_VENDOR_ID_EXAR,
-		.device = PCI_DEVICE_ID_EXAR_XR17C152,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17c154_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_EXAR,
-		.device = PCI_DEVICE_ID_EXAR_XR17C154,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17c154_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_EXAR,
-		.device = PCI_DEVICE_ID_EXAR_XR17C158,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17c154_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_EXAR,
-		.device = PCI_DEVICE_ID_EXAR_XR17V352,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17v35x_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_EXAR,
-		.device = PCI_DEVICE_ID_EXAR_XR17V354,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17v35x_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_EXAR,
-		.device = PCI_DEVICE_ID_EXAR_XR17V358,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17v35x_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_EXAR,
-		.device = PCI_DEVICE_ID_EXAR_XR17V4358,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17v35x_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_EXAR,
-		.device = PCI_DEVICE_ID_EXAR_XR17V8358,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17v35x_setup,
-	},
-	/*
 	 * Xircom cards
 	 */
 	{
@@ -2758,27 +2628,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice	= PCI_ANY_ID,
 		.setup		= pci_fastcom335_setup,
 	},
-	{
-		.vendor = PCI_VENDOR_ID_COMMTECH,
-		.device = PCI_DEVICE_ID_COMMTECH_4222PCIE,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17v35x_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_COMMTECH,
-		.device = PCI_DEVICE_ID_COMMTECH_4224PCIE,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17v35x_setup,
-	},
-	{
-		.vendor = PCI_VENDOR_ID_COMMTECH,
-		.device = PCI_DEVICE_ID_COMMTECH_4228PCIE,
-		.subvendor	= PCI_ANY_ID,
-		.subdevice	= PCI_ANY_ID,
-		.setup		= pci_xr17v35x_setup,
-	},
 	/*
 	 * Broadcom TruManage (NetXtreme)
 	 */
@@ -2993,15 +2842,6 @@ enum pci_board_num_t {
 	pbn_computone_6,
 	pbn_computone_8,
 	pbn_sbsxrsio,
-	pbn_exar_XR17C152,
-	pbn_exar_XR17C154,
-	pbn_exar_XR17C158,
-	pbn_exar_XR17V352,
-	pbn_exar_XR17V354,
-	pbn_exar_XR17V358,
-	pbn_exar_XR17V4358,
-	pbn_exar_XR17V8358,
-	pbn_exar_ibm_saturn,
 	pbn_pasemi_1682M,
 	pbn_ni8430_2,
 	pbn_ni8430_4,
@@ -3651,76 +3491,6 @@ static struct pciserial_board pci_boards[] = {
 		.reg_shift	= 4,
 	},
 	/*
-	 * Exar Corp. XR17C15[248] Dual/Quad/Octal UART
-	 *  Only basic 16550A support.
-	 *  XR17C15[24] are not tested, but they should work.
-	 */
-	[pbn_exar_XR17C152] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 2,
-		.base_baud	= 921600,
-		.uart_offset	= 0x200,
-	},
-	[pbn_exar_XR17C154] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 4,
-		.base_baud	= 921600,
-		.uart_offset	= 0x200,
-	},
-	[pbn_exar_XR17C158] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 8,
-		.base_baud	= 921600,
-		.uart_offset	= 0x200,
-	},
-	[pbn_exar_XR17V352] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 2,
-		.base_baud	= 7812500,
-		.uart_offset	= 0x400,
-		.reg_shift	= 0,
-		.first_offset	= 0,
-	},
-	[pbn_exar_XR17V354] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 4,
-		.base_baud	= 7812500,
-		.uart_offset	= 0x400,
-		.reg_shift	= 0,
-		.first_offset	= 0,
-	},
-	[pbn_exar_XR17V358] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 8,
-		.base_baud	= 7812500,
-		.uart_offset	= 0x400,
-		.reg_shift	= 0,
-		.first_offset	= 0,
-	},
-	[pbn_exar_XR17V4358] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 12,
-		.base_baud	= 7812500,
-		.uart_offset	= 0x400,
-		.reg_shift	= 0,
-		.first_offset	= 0,
-	},
-	[pbn_exar_XR17V8358] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 16,
-		.base_baud	= 7812500,
-		.uart_offset	= 0x400,
-		.reg_shift	= 0,
-		.first_offset	= 0,
-	},
-	[pbn_exar_ibm_saturn] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 1,
-		.base_baud	= 921600,
-		.uart_offset	= 0x200,
-	},
-
-	/*
 	 * PA Semi PWRficient PA6T-1682M on-chip UART
 	 */
 	[pbn_pasemi_1682M] = {
@@ -3909,6 +3679,9 @@ static const struct pci_device_id blacklist[] = {
 	{ PCI_VDEVICE(INTEL, 0x081d), },
 	{ PCI_VDEVICE(INTEL, 0x1191), },
 	{ PCI_VDEVICE(INTEL, 0x19d8), },
+
+	/* Exar devices */
+	{ PCI_VDEVICE(EXAR, PCI_ANY_ID), },
 };
 
 /*
@@ -4347,58 +4120,6 @@ static struct pci_device_id serial_pci_tbl[] = {
 		PCI_VENDOR_ID_AFAVLAB,
 		PCI_SUBDEVICE_ID_AFAVLAB_P061, 0, 0,
 		pbn_b0_4_1152000 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232, 0, 0,
-		pbn_b0_2_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232, 0, 0,
-		pbn_b0_4_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232, 0, 0,
-		pbn_b0_8_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1, 0, 0,
-		pbn_b0_2_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2, 0, 0,
-		pbn_b0_4_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4, 0, 0,
-		pbn_b0_8_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2, 0, 0,
-		pbn_b0_2_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4, 0, 0,
-		pbn_b0_4_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8, 0, 0,
-		pbn_b0_8_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485, 0, 0,
-		pbn_b0_2_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485, 0, 0,
-		pbn_b0_4_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
-		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485, 0, 0,
-		pbn_b0_8_1843200_200 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
-		PCI_VENDOR_ID_IBM, PCI_SUBDEVICE_ID_IBM_SATURN_SERIAL_ONE_PORT,
-		0, 0, pbn_exar_ibm_saturn },
-
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_U530,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_bt_1_115200 },
@@ -5126,45 +4847,6 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b3_8_115200 },
-
-	/*
-	 * Exar Corp. XR17C15[248] Dual/Quad/Octal UART
-	 */
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C152,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17C152 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C154,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17C154 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17C158 },
-	/*
-	 * Exar Corp. XR17V[48]35[248] Dual/Quad/Octal/Hexa PCIe UARTs
-	 */
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V352,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17V352 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V354,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17V354 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V358,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17V358 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V4358,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17V4358 },
-	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17V8358,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17V8358 },
 	/*
 	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
 	 */
@@ -5788,18 +5470,6 @@ static struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0,
 		0, pbn_b0_8_1152000_200 },
-	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4222PCIE,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17V352 },
-	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4224PCIE,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17V354 },
-	{	PCI_VENDOR_ID_COMMTECH, PCI_DEVICE_ID_COMMTECH_4228PCIE,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0,
-		0, pbn_exar_XR17V358 },
 
 	/* Fintek PCI serial cards */
 	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 92e3697a771c..f69b0905468f 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -119,6 +119,7 @@ config SERIAL_8250_PCI
 config SERIAL_8250_EXAR
         tristate "8250/16550 PCI device support"
         depends on SERIAL_8250_PCI
+	default SERIAL_8250
 
 config SERIAL_8250_HP300
 	tristate
-- 
2.12.3
