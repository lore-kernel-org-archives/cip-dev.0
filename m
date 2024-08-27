Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05AFC54731
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 21:06:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1395.1724792795110927160
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 14:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.10,181,1719846000"; 
   d="scan'208";a="216747538"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Aug 2024 06:06:34 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ABC5540031E0;
	Wed, 28 Aug 2024 06:06:32 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y cip v2 9/9] ravb: RAVB should select PAGE_POOL
Date: Tue, 27 Aug 2024 22:06:09 +0100
Message-Id: <20240827210609.12695-10-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
References: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 21:06:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16828

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 721478fe6a5cd243e289105e3fdd0ecdd9d39ac3 upstream.

If CONFIG_PAGE_POOL is not enabled:

    aarch64-linux-gnu-ld: Unexpected GOT/PLT entries detected!
    aarch64-linux-gnu-ld: Unexpected run-time procedure linkages detected!
    aarch64-linux-gnu-ld: drivers/net/ethernet/renesas/ravb_main.o: in function `ravb_rx_ring_refill':
    ravb_main.c:(.text+0x8d8): undefined reference to `page_pool_alloc_pages'
    aarch64-linux-gnu-ld: ravb_main.c:(.text+0x944): undefined reference to `page_pool_alloc_frag'
    aarch64-linux-gnu-ld: drivers/net/ethernet/renesas/ravb_main.o: in function `ravb_ring_init':
    ravb_main.c:(.text+0x1d4c): undefined reference to `page_pool_create'

Fixes: 966726324b7b1400 ("net: ravb: Allocate RX buffers via page pool")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/fa61b464ae1aa7630e9024f091991937941d49f1.1718113630.git.geert+renesas@glider.be
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index 0dd8c5860a54..9696f0784d16 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -36,6 +36,7 @@ config RAVB
 	select CRC32
 	select MII
 	select MDIO_BITBANG
+	select PAGE_POOL
 	select PHYLIB
 	select RESET_CONTROLLER
 	help
-- 
2.43.0


