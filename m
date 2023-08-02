Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A786C04A6A
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 14:49:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.16985.1690987741337269922
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 07:49:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,249,1684767600"; 
   d="scan'208";a="171683722"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 02 Aug 2023 23:49:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.171])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7EB82425F697;
	Wed,  2 Aug 2023 23:48:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip] tty: serial: sh-sci: Fix sleeping in atomic context
Date: Wed,  2 Aug 2023 15:48:56 +0100
Message-Id: <20230802144856.578404-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 14:49:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12539

commit 57c984f6fe20ebb9306d6e8c09b4f67fe63298c6 upstream.

Fix sleeping in atomic context warning as reported by the Smatch static
checker tool by replacing disable_irq->disable_irq_nosync.

Reported by: Dan Carpenter <dan.carpenter@linaro.org>

Fixes: 8749061be196 ("tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support")
Cc: stable@kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230704154818.406913-1-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 774762143f4e..cde5f8bf4111 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -590,7 +590,7 @@ static void sci_start_tx(struct uart_port *port)
 	    dma_submit_error(s->cookie_tx)) {
 		if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
 			/* Switch irq from SCIF to DMA */
-			disable_irq(s->irqs[SCIx_TXI_IRQ]);
+			disable_irq_nosync(s->irqs[SCIx_TXI_IRQ]);
 
 		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
-- 
2.25.1


