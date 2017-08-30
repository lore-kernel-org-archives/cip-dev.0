From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:05 +0200
Subject: [cip-dev] [PATCH 08/25] serial: pci: Remove unused pci_boards
	entries
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <7f328c5a323d2b9db979b2962eea00704031f415.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 0d560a1d549379e46139fb9eeae0b43328c76dea upstream.

Became obsolete with the split-out of 8250_exar.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 8437fec53126..144d23aa6e6d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2651,10 +2651,6 @@ enum pci_board_num_t {
 	pbn_b0_2_1843200,
 	pbn_b0_4_1843200,
 
-	pbn_b0_2_1843200_200,
-	pbn_b0_4_1843200_200,
-	pbn_b0_8_1843200_200,
-
 	pbn_b0_1_4000000,
 
 	pbn_b0_bt_1_115200,
@@ -2871,24 +2867,6 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset	= 8,
 	},
 
-	[pbn_b0_2_1843200_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 2,
-		.base_baud	= 1843200,
-		.uart_offset	= 0x200,
-	},
-	[pbn_b0_4_1843200_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 4,
-		.base_baud	= 1843200,
-		.uart_offset	= 0x200,
-	},
-	[pbn_b0_8_1843200_200] = {
-		.flags		= FL_BASE0,
-		.num_ports	= 8,
-		.base_baud	= 1843200,
-		.uart_offset	= 0x200,
-	},
 	[pbn_b0_1_4000000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
-- 
2.12.3
