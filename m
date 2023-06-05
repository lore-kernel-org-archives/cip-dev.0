Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8420AC7EE2A
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:05:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.4742.1685963126906425926
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:05:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; 
   d="scan'208";a="162244579"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jun 2023 20:05:26 +0900
Received: from localhost.localdomain (unknown [10.226.93.143])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 73C9941CEAF2;
	Mon,  5 Jun 2023 20:05:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/7] tty: serial: sh-sci: Remove setting {src,dst}_{addr,addr_width} based on DMA direction
Date: Mon,  5 Jun 2023 12:05:09 +0100
Message-Id: <20230605110512.111017-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:05:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11792

commit f1d81e3cf0e91bf3455a643b87184c2288cfba8e upstream.

The direction field in the DMA config is deprecated. The sh-sci driver
sets {src,dst}_{addr,addr_width} based on the DMA direction and
it results in dmaengine_slave_config() failure as RZ DMAC driver
validates {src,dst}_addr_width values independent of DMA direction.

Fix this issue by passing both {src,dst}_{addr,addr_width}
values independent of DMA direction.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230322074717.6057-1-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6cc971de7831..1396554c327a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1572,15 +1572,12 @@ static struct dma_chan *sci_request_dma_chan(struct uart_port *port,
 
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.direction = dir;
-	if (dir == DMA_MEM_TO_DEV) {
-		cfg.dst_addr = port->mapbase +
-			(sci_getreg(port, SCxTDR)->offset << port->regshift);
-		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	} else {
-		cfg.src_addr = port->mapbase +
-			(sci_getreg(port, SCxRDR)->offset << port->regshift);
-		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-	}
+	cfg.dst_addr = port->mapbase +
+		(sci_getreg(port, SCxTDR)->offset << port->regshift);
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	cfg.src_addr = port->mapbase +
+		(sci_getreg(port, SCxRDR)->offset << port->regshift);
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret) {
-- 
2.25.1


