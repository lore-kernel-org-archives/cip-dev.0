From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:06:03 +0200
Subject: [cip-dev] [PATCH 06/25] serial: exar: Fix feature control register
	constants
In-Reply-To: <cover.1504119982.git.jan.kiszka@siemens.com>
References: <cover.1504119982.git.jan.kiszka@siemens.com>
Message-ID: <8f2efd6cba603acef4f24593f11872a9a4a7456b.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 7795753661f1a9423c3c8fbde322f6a2a8b94b68 upstream.

According to the XR17V352 manual, bit 4 is IrDA control and bit 5 for
485. Fortunately, no driver used them so far.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/serial_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 1e5ac4e776da..cdb9f97a63c7 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -366,8 +366,8 @@
 #define UART_EXAR_DVID		0x8d	/* Device identification */
 
 #define UART_EXAR_FCTR		0x08	/* Feature Control Register */
-#define UART_FCTR_EXAR_IRDA	0x08	/* IrDa data encode select */
-#define UART_FCTR_EXAR_485	0x10	/* Auto 485 half duplex dir ctl */
+#define UART_FCTR_EXAR_IRDA	0x10	/* IrDa data encode select */
+#define UART_FCTR_EXAR_485	0x20	/* Auto 485 half duplex dir ctl */
 #define UART_FCTR_EXAR_TRGA	0x00	/* FIFO trigger table A */
 #define UART_FCTR_EXAR_TRGB	0x60	/* FIFO trigger table B */
 #define UART_FCTR_EXAR_TRGC	0x80	/* FIFO trigger table C */
-- 
2.12.3
