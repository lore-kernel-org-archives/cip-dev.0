Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F649C48299
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:56 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.61492.1707136962714935870
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="196827755"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:50 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EBF7E400515B;
	Mon,  5 Feb 2024 21:42:48 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 35/48] cache: ax45mp_cache: Add non coherent support
Date: Mon,  5 Feb 2024 12:41:22 +0000
Message-Id: <20240205124135.14779-36-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14704

As support for non-coherent DMA is missing in 5.10-cip for RISC-V
architecture, introducing a new patch to support non-coherent DMA
support on RZ/Five SoC.

This enables the required config and the callbacks required to handle
the non-coherent DMA support for Renesas RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/cache/Kconfig        |  3 ++
 drivers/cache/ax45mp_cache.c | 54 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 3370a5f0e77f..400cb09f6bd4 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -3,6 +3,9 @@ menu "Cache Drivers"
 
 config AX45MP_L2_CACHE
 	bool "Andes Technology AX45MP L2 Cache controller"
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SETUP_DMA_OPS
 	help
 	  Support for the L2 cache controller on Andes Technology AX45MP platforms.
 
diff --git a/drivers/cache/ax45mp_cache.c b/drivers/cache/ax45mp_cache.c
index 7984b90d04f2..f7db1ed3e973 100644
--- a/drivers/cache/ax45mp_cache.c
+++ b/drivers/cache/ax45mp_cache.c
@@ -132,6 +132,60 @@ static void ax45mp_dma_cache_wback(phys_addr_t paddr, size_t size)
 	local_irq_restore(flags);
 }
 
+static void ax45mp_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
+{
+	ax45mp_dma_cache_wback(paddr, size);
+	ax45mp_dma_cache_inv(paddr, size);
+}
+
+void arch_sync_dma_for_device(phys_addr_t paddr,
+			      size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		ax45mp_dma_cache_wback(paddr, size);
+		break;
+
+	case DMA_FROM_DEVICE:
+		fallthrough;
+
+	case DMA_BIDIRECTIONAL:
+		/* Skip the invalidate here if it's done later */
+		if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU))
+			ax45mp_dma_cache_wback(paddr, size);
+		else
+			ax45mp_dma_cache_wback_inv(paddr, size);
+		break;
+
+	default:
+		break;
+	}
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr,
+			   size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		/* FROM_DEVICE invalidate needed if speculative CPU prefetch only */
+		ax45mp_dma_cache_inv(paddr, size);
+		break;
+
+	default:
+		break;
+	}
+}
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+			const struct iommu_ops *iommu, bool coherent)
+{
+	dev->dma_coherent = coherent;
+}
+
 static int ax45mp_get_l2_line_size(struct device_node *np)
 {
 	int ret;
-- 
2.34.1


