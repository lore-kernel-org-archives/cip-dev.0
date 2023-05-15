Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B562C77B7D
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 08:54:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.84062.1684140842138353029
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 01:54:04 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,276,1677510000"; 
   d="scan'208";a="159396962"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 May 2023 17:54:03 +0900
Received: from localhost.localdomain (unknown [10.226.93.20])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AB273400BC0B;
	Mon, 15 May 2023 17:54:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/4] dmaengine: sh: rz-dmac: Remove unused rz_dmac_chan.*_word_size
Date: Mon, 15 May 2023 09:53:51 +0100
Message-Id: <20230515085352.25794-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 08:54:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11449

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 86de3bbfe45e5a7e64d4f24a1c034725072420d8 upstream.

The src_word_size and dst_word_size members of the rz_dmac_chan
structure were never used, so they can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/021bdf56f1716276a55bcfb1ea81bba5f1d42b3d.1679910274.git.geert+renesas@glider.be
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6b62e01ba658..9479f29692d3 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -67,8 +67,6 @@ struct rz_dmac_chan {
 	struct rz_dmac_desc *desc;
 	int descs_allocated;
 
-	enum dma_slave_buswidth src_word_size;
-	enum dma_slave_buswidth dst_word_size;
 	dma_addr_t src_per_address;
 	dma_addr_t dst_per_address;
 
@@ -603,9 +601,7 @@ static int rz_dmac_config(struct dma_chan *chan,
 	u32 val;
 
 	channel->src_per_address = config->src_addr;
-	channel->src_word_size = config->src_addr_width;
 	channel->dst_per_address = config->dst_addr;
-	channel->dst_word_size = config->dst_addr_width;
 
 	val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
 	if (val == CHCFG_DS_INVALID)
-- 
2.25.1


