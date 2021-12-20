Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C3C433FE
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 13:32:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5236.1640007107229541697
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 05:32:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000";
   d="scan'208";a="104578478"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 22:32:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C8C5A4005E10;
	Mon, 20 Dec 2021 22:31:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/22] dmaengine: Extend the dma_slave_width for
 128 bytes
Date: Mon, 20 Dec 2021 13:31:32 +0000
Message-Id: <20211220133139.21624-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 13:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7212

From: Biju Das <biju.das.jz@bp.renesas.com>

commit ab959c7d4ea086852f35c7ff20ecd79b7471cfad upstream.

Add DMA_SLAVE_BUSWIDTH_128_BYTES to dma_slave_width for DMA engines
and users to select 128 bytes as bus width.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210806095322.2326-3-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/dmaengine.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index dd357a747780..256592c0a365 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -378,6 +378,7 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
 	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
 	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
+	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
 };
 
 /**
@@ -396,7 +397,7 @@ enum dma_slave_buswidth {
  * @src_addr_width: this is the width in bytes of the source (RX)
  * register where DMA data shall be read. If the source
  * is memory this may be ignored depending on architecture.
- * Legal values: 1, 2, 3, 4, 8, 16, 32, 64.
+ * Legal values: 1, 2, 3, 4, 8, 16, 32, 64, 128.
  * @dst_addr_width: same as src_addr_width but for destination
  * target (TX) mutatis mutandis.
  * @src_maxburst: the maximum number of words (note: words, as in
-- 
2.17.1


