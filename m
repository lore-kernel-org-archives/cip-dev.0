Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D532EC88CB4
	for <webhook@archiver.kernel.org>; Tue, 13 Jun 2023 13:26:46 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.13093.1686662799866397439
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 06:26:40 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,239,1681138800"; 
   d="scan'208";a="163406189"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2023 22:26:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 624A242701B6;
	Tue, 13 Jun 2023 22:26:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 6/7] serial: 8250_em: Add serial8250_em_{reg_update(),out_helper()}
Date: Tue, 13 Jun 2023 14:26:19 +0100
Message-Id: <20230613132620.150832-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
References: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jun 2023 13:26:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11994

commit b22ea7df56b2ee1f9a0212210b51f83a3c2c75c6 upstream.

As per RZ/V2M hardware manual(Rev.1.30 Jun, 2022), UART IP has a
restriction as mentioned below.

40.6.1 Point for Caution when Changing the Register Settings:

When changing the settings of the following registers, a PRESETn master
reset or FIFO reset + SW reset (FCR[2],FCR[1], HCR0[7]) must be input to
re-initialize them.

Target Registers: FCR, LCR, MCR, DLL, DLM, HCR0.

Add serial8250_em_reg_update() and serial8250_em_serial_out_helper() to
handle this restriction. serial8250_em_serial_out_helper() is identical to
previous serial8250_em_serial_out() except that UART_FCR macro is removed
from serial8250_em_serial_out_helper() as it is now handled by serial8250_
em_serial_out().

DLL/DLM register can be updated only by setting LCR[7]. So the
updation of LCR[7] will perform reset for DLL/DLM register changes.

EMMA mobile has the same register set as RZ/V2M and this patch is tested on
EMEV2 board. So, there is no harm in applying the same restriction here as
well as the HW manual for EMMA mobile is not updated for a long time.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230227114152.22265-8-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/8250/8250_em.c | 67 ++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 7614ced9377e..25a9ecf26be6 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -18,6 +18,7 @@
 
 #define UART_DLL_EM 9
 #define UART_DLM_EM 10
+#define UART_HCR0_EM 11
 
 /*
  * A high value for UART_FCR_EM avoids overlapping with existing UART_*
@@ -26,11 +27,14 @@
 #define UART_FCR_EM 0x10003
 #define UART_FCR_EM_HW 3
 
+#define UART_HCR0_EM_SW_RESET	BIT(7) /* SW Reset */
+
 struct serial8250_em_priv {
 	int line;
 };
 
-static void serial8250_em_serial_out(struct uart_port *p, int offset, int value)
+static void serial8250_em_serial_out_helper(struct uart_port *p, int offset,
+					    int value)
 {
 	switch (offset) {
 	case UART_TX: /* TX @ 0x00 */
@@ -41,7 +45,6 @@ static void serial8250_em_serial_out(struct uart_port *p, int offset, int value)
 	case UART_SCR: /* SCR @ 0x20 (+1) */
 		writel(value, p->membase + ((offset + 1) << 2));
 		break;
-	case UART_FCR:
 	case UART_FCR_EM:
 		writel(value, p->membase + (UART_FCR_EM_HW << 2));
 		break;
@@ -50,6 +53,7 @@ static void serial8250_em_serial_out(struct uart_port *p, int offset, int value)
 		fallthrough;
 	case UART_DLL_EM: /* DLL @ 0x24 (+9) */
 	case UART_DLM_EM: /* DLM @ 0x28 (+9) */
+	case UART_HCR0_EM: /* HCR0 @ 0x2c */
 		writel(value, p->membase + (offset << 2));
 		break;
 	}
@@ -60,6 +64,7 @@ static unsigned int serial8250_em_serial_in(struct uart_port *p, int offset)
 	switch (offset) {
 	case UART_RX: /* RX @ 0x00 */
 		return readb(p->membase);
+	case UART_LCR: /* LCR @ 0x10 (+1) */
 	case UART_MCR: /* MCR @ 0x14 (+1) */
 	case UART_LSR: /* LSR @ 0x18 (+1) */
 	case UART_MSR: /* MSR @ 0x1c (+1) */
@@ -71,11 +76,69 @@ static unsigned int serial8250_em_serial_in(struct uart_port *p, int offset)
 	case UART_IIR: /* IIR @ 0x08 */
 	case UART_DLL_EM: /* DLL @ 0x24 (+9) */
 	case UART_DLM_EM: /* DLM @ 0x28 (+9) */
+	case UART_HCR0_EM: /* HCR0 @ 0x2c */
 		return readl(p->membase + (offset << 2));
 	}
 	return 0;
 }
 
+static void serial8250_em_reg_update(struct uart_port *p, int off, int value)
+{
+	unsigned int ier, fcr, lcr, mcr, hcr0;
+
+	ier = serial8250_em_serial_in(p, UART_IER);
+	fcr = serial8250_em_serial_in(p, UART_FCR_EM);
+	lcr = serial8250_em_serial_in(p, UART_LCR);
+	mcr = serial8250_em_serial_in(p, UART_MCR);
+	hcr0 = serial8250_em_serial_in(p, UART_HCR0_EM);
+
+	serial8250_em_serial_out_helper(p, UART_FCR_EM, fcr |
+							UART_FCR_CLEAR_RCVR |
+							UART_FCR_CLEAR_XMIT);
+	serial8250_em_serial_out_helper(p, UART_HCR0_EM, hcr0 |
+							 UART_HCR0_EM_SW_RESET);
+	serial8250_em_serial_out_helper(p, UART_HCR0_EM, hcr0 &
+							 ~UART_HCR0_EM_SW_RESET);
+
+	switch (off) {
+	case UART_FCR_EM:
+		fcr = value;
+		break;
+	case UART_LCR:
+		lcr = value;
+		break;
+	case UART_MCR:
+		mcr = value;
+		break;
+	}
+
+	serial8250_em_serial_out_helper(p, UART_IER, ier);
+	serial8250_em_serial_out_helper(p, UART_FCR_EM, fcr);
+	serial8250_em_serial_out_helper(p, UART_MCR, mcr);
+	serial8250_em_serial_out_helper(p, UART_LCR, lcr);
+	serial8250_em_serial_out_helper(p, UART_HCR0_EM, hcr0);
+}
+
+static void serial8250_em_serial_out(struct uart_port *p, int offset, int value)
+{
+	switch (offset) {
+	case UART_TX:
+	case UART_SCR:
+	case UART_IER:
+	case UART_DLL_EM:
+	case UART_DLM_EM:
+		serial8250_em_serial_out_helper(p, offset, value);
+		break;
+	case UART_FCR:
+		serial8250_em_reg_update(p, UART_FCR_EM, value);
+		break;
+	case UART_LCR:
+	case UART_MCR:
+		serial8250_em_reg_update(p, offset, value);
+		break;
+	}
+}
+
 static int serial8250_em_serial_dl_read(struct uart_8250_port *up)
 {
 	return serial_in(up, UART_DLL_EM) | serial_in(up, UART_DLM_EM) << 8;
-- 
2.25.1


