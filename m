Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C61C4829A
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.61921.1707136925597951761
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="196827690"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:05 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 65D3440065B6;
	Mon,  5 Feb 2024 21:42:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 13/48] dma-mapping: allow using the global coherent pool for !ARM
Date: Mon,  5 Feb 2024 12:41:00 +0000
Message-Id: <20240205124135.14779-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14682

From: Christoph Hellwig <hch@lst.de>

commit 70d6aa0ecfed253a2b14659a6c77359af6d9b3ee upstream.

Switch an ifdef so that the global coherent pool is initialized for
any architecture that selects the DMA_GLOBAL_POOL symbol insted of
hardcoding ARM.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 kernel/dma/coherent.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 5b5b6c7ec7f2..d97edd70d353 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -361,7 +361,9 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: regions without no-map are not yet supported\n");
 		return -EINVAL;
 	}
+#endif
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
 	if (of_get_flat_dt_prop(node, "linux,dma-default", NULL)) {
 		WARN(dma_reserved_default_memory,
 		     "Reserved memory: region for default DMA coherent area is redefined\n");
-- 
2.34.1


