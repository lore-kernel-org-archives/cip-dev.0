Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29BFC83003
	for <webhook@archiver.kernel.org>; Tue, 13 Jun 2023 13:23:56 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.12898.1686662626826205243
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 06:23:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,239,1681138800"; 
   d="scan'208";a="166947033"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2023 22:23:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 17533426DCCE;
	Tue, 13 Jun 2023 22:23:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 5/7] serial: 8250_em: Use pseudo offset for UART_FCR
Date: Tue, 13 Jun 2023 14:23:37 +0100
Message-Id: <20230613132339.150671-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jun 2023 13:23:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11985

commit 59d6558fb5fd750777edfde028ea1f9e7eed8a46 upstream.

UART_FCR shares the same offset with UART_IIR. We cannot use UART_FCR
in serial8250_em_serial_in() as it overlaps with UART_IIR.

Define UART_FCR_EM macro with a high value to avoid overlapping
with existing UART_* register defines and define another macro
UART_FCR_EM_HW for the real offset.

Use these macros in serial8250_em_serial{_in/_out} function to
read/write FCR register.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230227114152.22265-7-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/8250/8250_em.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index dcf1761e8ef5..7614ced9377e 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -19,6 +19,13 @@
 #define UART_DLL_EM 9
 #define UART_DLM_EM 10
 
+/*
+ * A high value for UART_FCR_EM avoids overlapping with existing UART_*
+ * register defines. UART_FCR_EM_HW is the real HW register offset.
+ */
+#define UART_FCR_EM 0x10003
+#define UART_FCR_EM_HW 3
+
 struct serial8250_em_priv {
 	int line;
 };
@@ -29,12 +36,15 @@ static void serial8250_em_serial_out(struct uart_port *p, int offset, int value)
 	case UART_TX: /* TX @ 0x00 */
 		writeb(value, p->membase);
 		break;
-	case UART_FCR: /* FCR @ 0x0c (+1) */
 	case UART_LCR: /* LCR @ 0x10 (+1) */
 	case UART_MCR: /* MCR @ 0x14 (+1) */
 	case UART_SCR: /* SCR @ 0x20 (+1) */
 		writel(value, p->membase + ((offset + 1) << 2));
 		break;
+	case UART_FCR:
+	case UART_FCR_EM:
+		writel(value, p->membase + (UART_FCR_EM_HW << 2));
+		break;
 	case UART_IER: /* IER @ 0x04 */
 		value &= 0x0f; /* only 4 valid bits - not Xscale */
 		fallthrough;
@@ -55,6 +65,8 @@ static unsigned int serial8250_em_serial_in(struct uart_port *p, int offset)
 	case UART_MSR: /* MSR @ 0x1c (+1) */
 	case UART_SCR: /* SCR @ 0x20 (+1) */
 		return readl(p->membase + ((offset + 1) << 2));
+	case UART_FCR_EM:
+		return readl(p->membase + (UART_FCR_EM_HW << 2));
 	case UART_IER: /* IER @ 0x04 */
 	case UART_IIR: /* IIR @ 0x08 */
 	case UART_DLL_EM: /* DLL @ 0x24 (+9) */
-- 
2.25.1


