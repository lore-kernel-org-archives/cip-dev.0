Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B2AC7EE2D
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:05:22 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4739.1685963119643595485
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:05:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; 
   d="scan'208";a="165779642"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jun 2023 20:05:18 +0900
Received: from localhost.localdomain (unknown [10.226.93.143])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 00E4E41CEB16;
	Mon,  5 Jun 2023 20:05:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 1/7] tty: serial: sh-sci: Fix TE setting on SCI IP
Date: Mon,  5 Jun 2023 12:05:06 +0100
Message-Id: <20230605110512.111017-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:05:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11789

commit 1707ce2d1e4d701db28ba2250d9d72dcf762babc upstream.

As per the RZ/G2L users hardware manual (Rev.1.20 Sep, 2022), section
23.3.7 Serial Data Transmission (Asynchronous Mode) it is mentioned
that the TE (transmit enable) must be set after setting TIE (transmit
interrupt enable) or these 2 bits are set to 1 simultaneously by a
single instruction. So set these 2 bits in single instruction.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230412145053.114847-4-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6720c165523a..fe29b05f42c4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -596,6 +596,15 @@ static void sci_start_tx(struct uart_port *port)
 	if (!s->chan_tx || port->type == PORT_SCIFA || port->type == PORT_SCIFB) {
 		/* Set TIE (Transmit Interrupt Enable) bit in SCSCR */
 		ctrl = serial_port_in(port, SCSCR);
+
+		/*
+		 * For SCI, TE (transmit enable) must be set after setting TIE
+		 * (transmit interrupt enable) or in the same instruction to start
+		 * the transmit process.
+		 */
+		if (port->type == PORT_SCI)
+			ctrl |= SCSCR_TE;
+
 		serial_port_out(port, SCSCR, ctrl | SCSCR_TIE);
 	}
 }
@@ -2618,8 +2627,14 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		sci_set_mctrl(port, port->mctrl);
 	}
 
-	scr_val |= SCSCR_RE | SCSCR_TE |
-		   (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0));
+	/*
+	 * For SCI, TE (transmit enable) must be set after setting TIE
+	 * (transmit interrupt enable) or in the same instruction to
+	 * start the transmitting process. So skip setting TE here for SCI.
+	 */
+	if (port->type != PORT_SCI)
+		scr_val |= SCSCR_TE;
+	scr_val |= SCSCR_RE | (s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0));
 	serial_port_out(port, SCSCR, scr_val | s->hscif_tot);
 	if ((srr + 1 == 5) &&
 	    (port->type == PORT_SCIFA || port->type == PORT_SCIFB)) {
-- 
2.25.1


