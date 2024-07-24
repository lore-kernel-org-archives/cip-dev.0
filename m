Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324B8C3DA70
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 08:01:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.5867.1721808052528588612
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Jul 2024 01:01:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,232,1716217200"; 
   d="scan'208";a="212533069"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Jul 2024 17:01:07 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 75BEF41D149E;
	Wed, 24 Jul 2024 17:01:05 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/11] ravb: Correct buffer size to map for R-Car Rx
Date: Wed, 24 Jul 2024 08:00:43 +0000
Message-Id: <20240724080046.1500825-9-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
References: <20240724080046.1500825-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Jul 2024 08:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16607

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit a290d4cb892da3e9e163a40d0ab70ed1531cdc58 upstream.

When creating a helper to allocate and align an skb one location where
the skb data size was updated was missed. This can lead to a warning
being printed when the memory is being unmapped as it now always unmap
the maximum frame size, instead of the size after it have been
aligned.

This was correctly done for RZ/G2L but missed for R-Car.

Fixes: cfbad64706c1 ("ravb: Create helper to allocate skb and align it")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240308224237.496924-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a085f7f44aa3..0c0d50517d8e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -981,7 +981,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 			if (!skb)
 				break;	/* Better luck next round. */
 			dma_addr = dma_map_single(ndev->dev.parent, skb->data,
-						  le16_to_cpu(desc->ds_cc),
+						  priv->info->rx_max_frame_size,
 						  DMA_FROM_DEVICE);
 			skb_checksum_none_assert(skb);
 			/* We just set the data size to 0 for a failed mapping
-- 
2.25.1


