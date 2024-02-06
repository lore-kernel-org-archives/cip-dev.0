Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B976DC4829F
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:27:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20160.1707222473919030006
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:27:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="196960596"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Feb 2024 21:27:53 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C58AC4005E16;
	Tue,  6 Feb 2024 21:27:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 08/44] dma-direct: add support for dma_coherent_default_memory
Date: Tue,  6 Feb 2024 12:26:58 +0000
Message-Id: <20240206122734.13477-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:27:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14792

From: Christoph Hellwig <hch@lst.de>

commit faf4ef823ac5f3b6a34a73b76c52895dee3dce55 upstream.

Add an option to allocate uncached memory for dma_alloc_coherent from
the global dma_coherent_default_memory.  This will allow to move
arm-nommu (and eventually other platforms) to use generic code for
allocating uncached memory from a pre-populated pool.

Note that this is a different pool from the one that platforms that
can remap at runtime use for GFP_ATOMIC allocations for now, although
there might be opportunities to eventually end up with a common codebase
for the two use cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
[PL: define page_order variable used by dma_release_from_global_coherent()]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 kernel/dma/Kconfig  |  4 ++++
 kernel/dma/direct.c | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c99de4a214588..87883d4e1ce3e 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -97,6 +97,10 @@ config DMA_COHERENT_POOL
 	select GENERIC_ALLOCATOR
 	bool
 
+config DMA_GLOBAL_POOL
+	select DMA_DECLARE_COHERENT
+	bool
+
 config DMA_REMAP
 	bool
 	depends on MMU
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2922250f93b44..34ac5a2c7efc2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -156,9 +156,14 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
 	    !dev_is_dma_coherent(dev))
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev))
+		return dma_alloc_from_global_coherent(dev, size, dma_handle);
+
 	/*
 	 * Remapping or decrypting memory may block. If either is required and
 	 * we can't block, allocate the memory from the atomic pools.
@@ -253,11 +258,21 @@ void dma_direct_free(struct device *dev, size_t size,
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
 	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
 	    !dev_is_dma_coherent(dev)) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 		return;
 	}
 
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev)) {
+		unsigned int page_order = get_order(size);
+
+		if (!dma_release_from_global_coherent(page_order, cpu_addr))
+			WARN_ON_ONCE(1);
+		return;
+	}
+
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
@@ -458,6 +473,8 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
+	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
+		return ret;
 
 	if (vma->vm_pgoff >= count || user_count > count - vma->vm_pgoff)
 		return -ENXIO;
-- 
2.34.1


