Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63B4C3271E
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 12:52:57 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.16121.1720183966307535087
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 05:52:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="214373468"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2024 21:52:54 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 86B3144B8E9A;
	Fri,  5 Jul 2024 21:52:52 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/10] cache: ax45mp_cache: Align end size to cache boundary in ax45mp_dma_cache_wback()
Date: Fri,  5 Jul 2024 13:52:30 +0100
Message-Id: <20240705125230.125392-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 12:52:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16405

commit 9bd405c48b0ac4de087c0c4440fd79597201b8a7 upstream.

Align the end size to cache boundary size in ax45mp_dma_cache_wback()
callback likewise done in ax45mp_dma_cache_inv() callback.

Additionally return early in case of start == end.

Fixes: d34599bcd2e4 ("cache: Add L2 cache management for Andes AX45MP RISC-V core")
Reported-by: Pavel Machek <pavel@denx.de>
Link: https://lore.kernel.org/cip-dev/ZYsdKDiw7G+kxQ3m@duo.ucw.cz/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/cache/ax45mp_cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
index f7db1ed3e973e..b6cc01d0d4870 100644
--- a/drivers/cache/ax45mp_cache.c
+++ b/drivers/cache/ax45mp_cache.c
@@ -125,8 +125,12 @@ static void ax45mp_dma_cache_wback(phys_addr_t paddr, size_t size)
 	unsigned long line_size;
 	unsigned long flags;
 
+	if (unlikely(start == end))
+		return;
+
 	line_size = ax45mp_priv.ax45mp_cache_line_size;
 	start = start & (~(line_size - 1));
+	end = ((end + line_size - 1) & (~(line_size - 1)));
 	local_irq_save(flags);
 	ax45mp_cpu_dcache_wb_range(start, end);
 	local_irq_restore(flags);
-- 
2.34.1


