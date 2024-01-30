Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08614C48286
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 20:34:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7251.1706646835418574585
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 12:34:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="192272195"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2024 05:34:03 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D131940A3D21;
	Wed, 31 Jan 2024 05:34:01 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RFC PATCH 5.10.y-cip 07/39] dma-mapping: make the global coherent pool conditional
Date: Tue, 30 Jan 2024 20:33:14 +0000
Message-Id: <20240130203346.94488-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 20:34:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14519

From: Christoph Hellwig <hch@lst.de>

commit 22f9feb49950885cdb6e37513f134d154175e743 upstream.

Only build the code to support the global coherent pool if support for
it is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/dma-map-ops.h | 18 ++++++++------
 kernel/dma/coherent.c       | 49 ++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index ac3c9f2bc975f..b8ea283a60e07 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -170,13 +170,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, size_t size, int *ret);
-
-void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
-		dma_addr_t *dma_handle);
-int dma_release_from_global_coherent(int order, void *vaddr);
-int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
-		size_t size, int *ret);
-int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
@@ -186,7 +179,16 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+#endif /* CONFIG_DMA_DECLARE_COHERENT */
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
+void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
+		dma_addr_t *dma_handle);
+int dma_release_from_global_coherent(int order, void *vaddr);
+int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
+		size_t size, int *ret);
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
+#else
 static inline void *dma_alloc_from_global_coherent(struct device *dev,
 		ssize_t size, dma_addr_t *dma_handle)
 {
@@ -201,7 +203,7 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 {
 	return 0;
 }
-#endif /* CONFIG_DMA_DECLARE_COHERENT */
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 78a951f6e2c78..6243b4d340875 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -20,8 +20,6 @@ struct dma_coherent_mem {
 	bool		use_dev_dma_pfn_offset;
 };
 
-static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
-
 static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
 {
 	if (dev && dev->dma_mem)
@@ -191,16 +189,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 	return 1;
 }
 
-void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
-				     dma_addr_t *dma_handle)
-{
-	if (!dma_coherent_default_memory)
-		return NULL;
-
-	return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
-					 dma_handle);
-}
-
 static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
 				       int order, void *vaddr)
 {
@@ -236,15 +224,6 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 	return __dma_release_from_coherent(mem, order, vaddr);
 }
 
-int dma_release_from_global_coherent(int order, void *vaddr)
-{
-	if (!dma_coherent_default_memory)
-		return 0;
-
-	return __dma_release_from_coherent(dma_coherent_default_memory, order,
-			vaddr);
-}
-
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 		struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
 {
@@ -290,6 +269,28 @@ int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
 }
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
+static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
+
+void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
+				     dma_addr_t *dma_handle)
+{
+	if (!dma_coherent_default_memory)
+		return NULL;
+
+	return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
+					 dma_handle);
+}
+
+int dma_release_from_global_coherent(int order, void *vaddr)
+{
+	if (!dma_coherent_default_memory)
+		return 0;
+
+	return __dma_release_from_coherent(dma_coherent_default_memory, order,
+			vaddr);
+}
+
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
 				   size_t size, int *ret)
 {
@@ -311,6 +312,7 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
 	pr_info("DMA: default coherent area is set\n");
 	return 0;
 }
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 /*
  * Support for reserved memory regions defined in device tree
@@ -320,7 +322,9 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
 #include <linux/of_fdt.h>
 #include <linux/of_reserved_mem.h>
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
 static struct reserved_mem *dma_reserved_default_memory __initdata;
+#endif
 
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
@@ -377,6 +381,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 	return 0;
 }
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
 static int __init dma_init_reserved_memory(void)
 {
 	if (!dma_reserved_default_memory)
@@ -384,8 +389,8 @@ static int __init dma_init_reserved_memory(void)
 	return dma_init_global_coherent(dma_reserved_default_memory->base,
 					dma_reserved_default_memory->size);
 }
-
 core_initcall(dma_init_reserved_memory);
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
 #endif
-- 
2.34.1


