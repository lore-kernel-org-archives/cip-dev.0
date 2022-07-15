Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F02EC3F2D4
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:24 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3871.1657869794050960984
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955843"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0F36840138EB;
	Fri, 15 Jul 2022 16:23:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/24] dmaengine: sh: Kconfig: Make RZ_DMAC depend
 on ARCH_RZG2L
Date: Fri, 15 Jul 2022 08:22:31 +0100
Message-Id: <20220715072244.2298757-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8797

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 448a0994cc698d41d056f14fb9065305b14f3c75 upstream.

The DMAC block is identical on Renesas RZ/G2L, RZ/G2UL and RZ/V2L SoC's, so
instead of adding dependency for each SoC's add dependency on ARCH_RZG2L.
The ARCH_RZG2L config option is already selected by ARCH_R9A07G043,
ARCH_R9A07G044 and ARCH_R9A07G054.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220406080417.14593-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index b35d705f79e7..c0b2997ab7fd 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -50,7 +50,7 @@ config RENESAS_USB_DMAC
 
 config RZ_DMAC
 	tristate "Renesas RZ/{G2L,V2L} DMA Controller"
-	depends on ARCH_R9A07G044 || ARCH_R9A07G054 || COMPILE_TEST
+	depends on ARCH_RZG2L || COMPILE_TEST
 	select RENESAS_DMA
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.25.1


