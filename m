Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB1FC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:35:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.59275.1722267330628502832
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:35:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213909354"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:35:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6ADFF4017D6C;
	Tue, 30 Jul 2024 00:35:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/13] dmaengine: sh: rz-dmac: Fix lockdep assert warning
Date: Mon, 29 Jul 2024 16:34:55 +0100
Message-ID: <20240729153504.510443-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:35:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16678

commit 0e53aa3464e9a0a82bd3b926ba5999a11569c9ba upstream.

Fix the below lockdep assert warning by holding vc.lock for
vchan_get_all_descriptors().

WARNING: virt-dma.h:188 rz_dmac_terminate_all
pc : rz_dmac_terminate_all

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240625170119.173595-1-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f777addda8ba..2d31c583508a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -540,8 +540,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&channel->vc.lock, flags);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
-	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_get_all_descriptors(&channel->vc, &head);
+	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
 
 	return 0;
-- 
2.43.0


