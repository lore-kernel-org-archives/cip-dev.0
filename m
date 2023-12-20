Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608B0C3DA6E
	for <webhook@archiver.kernel.org>; Wed, 20 Dec 2023 23:07:24 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.34655.1703113637691238152
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Dec 2023 15:07:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,292,1695654000"; 
   d="scan'208";a="187185265"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Dec 2023 08:07:17 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.50])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7378A40BFAAD;
	Thu, 21 Dec 2023 08:07:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 12/30] riscv: dma-mapping: switch over to generic implementation
Date: Wed, 20 Dec 2023 23:06:28 +0000
Message-Id: <20231220230646.219816-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Dec 2023 23:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14148

commit 935730160738a478dbf4b61cf0cfc29c1442fb4e upstream.

Add helper functions for cache wback/inval/clean and use them
arch_sync_dma_for_device()/arch_sync_dma_for_cpu() functions. The proposed
changes are in preparation for switching over to generic implementation.

Reorganization of the code is based on the patch (Link[0]) from Arnd.
For now I have dropped CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU check as this
will be enabled by default upon selection of RISCV_DMA_NONCOHERENT
and also dropped arch_dma_mark_dcache_clean().

Link[0]: https://lore.kernel.org/all/20230327121317.4081816-22-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20230816232336.164413-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/mm/dma-noncoherent.c | 60 ++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
index fc6377a64c8d..06b8fea58e20 100644
--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -12,21 +12,61 @@
 
 static bool noncoherent_supported __ro_after_init;
 
-void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-			      enum dma_data_direction dir)
+static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
+{
+	void *vaddr = phys_to_virt(paddr);
+
+	ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+}
+
+static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
+{
+	void *vaddr = phys_to_virt(paddr);
+
+	ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
+}
+
+static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
 {
 	void *vaddr = phys_to_virt(paddr);
 
+	ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
+}
+
+static inline bool arch_sync_dma_clean_before_fromdevice(void)
+{
+	return true;
+}
+
+static inline bool arch_sync_dma_cpu_needs_post_dma_flush(void)
+{
+	return true;
+}
+
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+			      enum dma_data_direction dir)
+{
 	switch (dir) {
 	case DMA_TO_DEVICE:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+		arch_dma_cache_wback(paddr, size);
 		break;
+
 	case DMA_FROM_DEVICE:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
-		break;
+		if (!arch_sync_dma_clean_before_fromdevice()) {
+			arch_dma_cache_inv(paddr, size);
+			break;
+		}
+		fallthrough;
+
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
+		/* Skip the invalidate here if it's done later */
+		if (IS_ENABLED(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) &&
+		    arch_sync_dma_cpu_needs_post_dma_flush())
+			arch_dma_cache_wback(paddr, size);
+		else
+			arch_dma_cache_wback_inv(paddr, size);
 		break;
+
 	default:
 		break;
 	}
@@ -35,15 +75,17 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 			   enum dma_data_direction dir)
 {
-	void *vaddr = phys_to_virt(paddr);
-
 	switch (dir) {
 	case DMA_TO_DEVICE:
 		break;
+
 	case DMA_FROM_DEVICE:
 	case DMA_BIDIRECTIONAL:
-		ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
+		/* FROM_DEVICE invalidate needed if speculative CPU prefetch only */
+		if (arch_sync_dma_cpu_needs_post_dma_flush())
+			arch_dma_cache_inv(paddr, size);
 		break;
+
 	default:
 		break;
 	}
-- 
2.34.1


