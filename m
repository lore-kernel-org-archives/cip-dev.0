Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A968C433F5
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 13:32:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.5175.1640007108515707926
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 05:32:07 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000";
   d="scan'208";a="104110997"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2021 22:32:07 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 522014005E10;
	Mon, 20 Dec 2021 22:32:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 20/22] dmaengine: sh: make array ds_lut static
Date: Mon, 20 Dec 2021 13:31:37 +0000
Message-Id: <20211220133139.21624-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 13:32:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7217

From: Colin Ian King <colin.king@canonical.com>

commit 4c0eee50658746b0333d35a75d3db6e0aac08ef9 upstream.

Don't populate the read-only array ds_lut on the stack but instead it
static. Also makes the object code smaller by 163 bytes:

Before:
   text    data     bss     dec     hex filename
  23508    4796       0   28304    6e90 ./drivers/dma/sh/rz-dmac.o

After:
   text    data     bss     dec     hex filename
  23281    4860       0   28141    6ded ./drivers/dma/sh/rz-dmac.o

(gcc version 11.2.0)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20210915112038.12407-1-colin.king@canonical.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d9f2cfef878e..ee2872e7d64c 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -574,7 +574,7 @@ static void rz_dmac_issue_pending(struct dma_chan *chan)
 static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth ds)
 {
 	u8 i;
-	const enum dma_slave_buswidth ds_lut[] = {
+	static const enum dma_slave_buswidth ds_lut[] = {
 		DMA_SLAVE_BUSWIDTH_1_BYTE,
 		DMA_SLAVE_BUSWIDTH_2_BYTES,
 		DMA_SLAVE_BUSWIDTH_4_BYTES,
-- 
2.17.1


