Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CE1C00140
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:13:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.8954.1660299214547583633
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600";
   d="scan'208";a="129340333"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3C9444243969;
	Fri, 12 Aug 2022 19:13:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 08/11] spi: spi-rspi: : use proper DMAENGINE API
 for termination
Date: Fri, 12 Aug 2022 11:13:14 +0100
Message-Id: <20220812101317.12380-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:13:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9180

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 29176edd6e7ad7333d0bb19a309b2104fa4f4341 upstream.

dmaengine_terminate_all() is deprecated in favor of explicitly saying if
it should be sync or async. Here, we want dmaengine_terminate_sync()
because there is no other synchronization code in the driver to handle
an async case.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20210623095843.3228-2-wsa+renesas@sang-engineering.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 7ddb140b07ea..27b5a9cfc904 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -619,9 +619,9 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 			ret = -ETIMEDOUT;
 		}
 		if (tx)
-			dmaengine_terminate_all(rspi->ctlr->dma_tx);
+			dmaengine_terminate_sync(rspi->ctlr->dma_tx);
 		if (rx)
-			dmaengine_terminate_all(rspi->ctlr->dma_rx);
+			dmaengine_terminate_sync(rspi->ctlr->dma_rx);
 	}
 
 	rspi_disable_irq(rspi, irq_mask);
@@ -635,7 +635,7 @@ static int rspi_dma_transfer(struct rspi_data *rspi, struct sg_table *tx,
 
 no_dma_tx:
 	if (rx)
-		dmaengine_terminate_all(rspi->ctlr->dma_rx);
+		dmaengine_terminate_sync(rspi->ctlr->dma_rx);
 no_dma_rx:
 	if (ret == -EAGAIN) {
 		dev_warn_once(&rspi->ctlr->dev,
-- 
2.17.1


