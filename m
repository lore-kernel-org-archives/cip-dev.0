Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63AEC43217
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:54:56 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.10134.1639659295185867930
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:54:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="104171923"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2021 21:54:51 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B4C884010737;
	Thu, 16 Dec 2021 21:54:50 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/24] serial: sh-sci: Add support for RZ/G2L SoC
Date: Thu, 16 Dec 2021 12:54:24 +0000
Message-Id: <20211216125446.15451-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7127

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3b2cd60689fa439481f535ee4463fb223a276f43 upstream.

Add serial support for RZ/G2L SoC with earlycon and
extended mode register support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210603221758.10305-11-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 12 +++++++++++-
 drivers/tty/serial/sh-sci.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f700bfaef129..c3fd49480ad3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -289,7 +289,7 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 	},
 
 	/*
-	 * The "SCIFA" that is in RZ/T and RZ/A2.
+	 * The "SCIFA" that is in RZ/A2, RZ/G2L and RZ/T.
 	 * It looks like a normal SCIF with FIFO data, but with a
 	 * compressed address space. Also, the break out of interrupts
 	 * are different: ERI/BRI, RXI, TXI, TEI, DRI.
@@ -306,6 +306,7 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCFDR]		= { 0x0E, 16 },
 			[SCSPTR]	= { 0x10, 16 },
 			[SCLSR]		= { 0x12, 16 },
+			[SEMR]		= { 0x14, 8 },
 		},
 		.fifosize = 16,
 		.overrun_reg = SCLSR,
@@ -2527,6 +2528,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (termios->c_cflag & PARENB)
 		bits++;
 
+	if (sci_getreg(port, SEMR)->size)
+		serial_port_out(port, SEMR, 0);
+
 	if (best_clk >= 0) {
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 			switch (srr + 1) {
@@ -3194,6 +3198,10 @@ static const struct of_device_id of_sci_match[] = {
 		.compatible = "renesas,scif-r7s9210",
 		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
 	},
+	{
+		.compatible = "renesas,scif-r9a07g044",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
+	},
 	/* Family-specific types */
 	{
 		.compatible = "renesas,rcar-gen1-scif",
@@ -3476,6 +3484,7 @@ static int __init rzscifa_early_console_setup(struct earlycon_device *device,
 	port_cfg.regtype = SCIx_RZ_SCIFA_REGTYPE;
 	return early_console_setup(device, PORT_SCIF);
 }
+
 static int __init scifa_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
@@ -3495,6 +3504,7 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index c0dfe4382898..c0ae78632dda 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -31,6 +31,7 @@ enum {
 	SCCKS,				/* BRG Clock Select Register */
 	HSRTRGR,			/* Rx FIFO Data Count Trigger Register */
 	HSTTRGR,			/* Tx FIFO Data Count Trigger Register */
+	SEMR,				/* Serial extended mode register */
 
 	SCIx_NR_REGS,
 };
-- 
2.17.1


