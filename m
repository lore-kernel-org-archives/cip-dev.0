From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:07 +0200
Subject: [cip-dev] [PATCH 10/25] serial: exar: Preconfigure xr17v35x MPIOs
	as output
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <c26872cb5ae27f2aa840a10bdf18ebfb25ad38e8.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 7dea8165f1d6434dc7572004363f86339f0f4322 upstream.

This is the safe default for GPIOs with unknown external wiring.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 9af4266eff96..8d392ad207cf 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -164,13 +164,13 @@ static void setup_gpio(u8 __iomem *p)
 	writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
 	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
-	writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
+	writeb(0xff, p + UART_EXAR_MPIOSEL_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
 	writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
 	writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
-	writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
+	writeb(0xff, p + UART_EXAR_MPIOSEL_15_8);
 	writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
 }
 
-- 
2.12.3
