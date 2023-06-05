Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC7C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:05:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4676.1685963124830278665
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:05:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; 
   d="scan'208";a="162244572"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jun 2023 20:05:23 +0900
Received: from localhost.localdomain (unknown [10.226.93.143])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F35B741CEB16;
	Mon,  5 Jun 2023 20:05:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/7] tty: serial: sh-sci: Fix end of transmission on SCI
Date: Mon,  5 Jun 2023 12:05:08 +0100
Message-Id: <20230605110512.111017-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:05:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11791

commit f06c2a9000ebecbb461196e59ce063f742272902 upstream.

We need to set TE to "0" (i.e., disable serial transmission) to
get the expected behavior of the end of serial transmission.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230412145053.114847-6-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 39db677a84e7..6cc971de7831 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -842,6 +842,11 @@ static void sci_transmit_chars(struct uart_port *port)
 		} else if (!uart_circ_empty(xmit) && !stopped) {
 			c = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
+		} else if (port->type == PORT_SCI && uart_circ_empty(xmit)) {
+			ctrl = serial_port_in(port, SCSCR);
+			ctrl &= ~SCSCR_TE;
+			serial_port_out(port, SCSCR, ctrl);
+			return;
 		} else {
 			break;
 		}
-- 
2.25.1


