Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEA2C3DA6E
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 23:07:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34647.1703113618141908312
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Dec 2023 15:06:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,292,1695654000"; 
   d="scan'208";a="191072679"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Dec 2023 08:06:56 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.50])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AAA3D40BF9C6;
	Thu, 21 Dec 2023 08:06:54 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 03/30] mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option dependant on ARCH_RENESAS
Date: Wed, 20 Dec 2023 23:06:19 +0000
Message-Id: <20231220230646.219816-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 23:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14139

commit bbe6dc429bf52b0062c2a9b39f850cfd317289a7 upstream.

MMC_SDHI_INTERNAL_DMAC config option has dependency on ARM64 and
R7S9210/R8A77470 this dependency will keep growing for future SoCs for
varying architectures. So to simplify this configuration make
MMC_SDHI_INTERNAL_DMAC solely depend on ARCH_RENESAS, as all Renesas
SoCs inherently depend on the ARCH_RENESAS config option.

This allows selecting MMC_SDHI_INTERNAL_DMAC config option for RZ/Five SoC
which is based on RISC-V architecture.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/20230901122701.318082-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9b5a2cb110b3..f057ca43840a 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -730,9 +730,9 @@ config MMC_SDHI_SYS_DMAC
 
 config MMC_SDHI_INTERNAL_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
-	depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on MMC_SDHI
-	default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470)
+	default MMC_SDHI if ARCH_RENESAS
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
 	  using on-chip bus mastering. This supports the controllers
-- 
2.34.1


