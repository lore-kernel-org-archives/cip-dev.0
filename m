Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9CC43219
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 13:32:05 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.5175.1640007108515707926
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 05:32:05 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000";
   d="scan'208";a="104110993"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Dec 2021 22:32:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B59484005E10;
	Mon, 20 Dec 2021 22:32:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 18/22] dmaengine: sh: fix some NULL dereferences
Date: Mon, 20 Dec 2021 13:31:35 +0000
Message-Id: <20211220133139.21624-19-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 13:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7215

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 11a427be2c4749954e8b868ef5301dc65ca5a14b upstream.

The dma_free_coherent() function needs a valid device pointer or it will
crash.

Fixes: 550c591a89a1 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20210827085410.GA9183@kili
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 3d1c239de306..f9f30cbeccbe 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -919,7 +919,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	for (i = 0; i < channel_num; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
 
-		dma_free_coherent(NULL,
+		dma_free_coherent(&pdev->dev,
 				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
@@ -936,7 +936,7 @@ static int rz_dmac_remove(struct platform_device *pdev)
 	for (i = 0; i < dmac->n_channels; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
 
-		dma_free_coherent(NULL,
+		dma_free_coherent(&pdev->dev,
 				  sizeof(struct rz_lmdesc) * DMAC_NR_LMDESC,
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
-- 
2.17.1


