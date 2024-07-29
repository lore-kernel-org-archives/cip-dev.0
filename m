Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86179C52CDA
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 14:30:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.57351.1722263431883170875
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 07:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217875305"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Jul 2024 23:30:31 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9106C4017F37;
	Mon, 29 Jul 2024 23:30:29 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y cip 07/11] ravb: Correct buffer size to map for R-Car Rx
Date: Mon, 29 Jul 2024 14:30:07 +0000
Message-Id: <20240729143011.1920068-8-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
References: <20240729143011.1920068-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 14:30:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16640

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
index fd2c9d7e4cef..eae042c7d654 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -977,7 +977,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
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


