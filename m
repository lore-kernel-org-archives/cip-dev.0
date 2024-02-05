Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23828C4829B
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.61927.1707136930508628546
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="196827694"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:09 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 609E04001DDB;
	Mon,  5 Feb 2024 21:42:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 15/48] dma-mapping: add a dma_init_global_coherent helper
Date: Mon,  5 Feb 2024 12:41:02 +0000
Message-Id: <20240205124135.14779-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14684

From: Christoph Hellwig <hch@lst.de>

commit 39a2d3506b2d53c569a6db13d65b2f3728c4feec upstream.

Add a new helper to initialize the global coherent pool.  This both
cleans up the existing initialization which indirects through the
reserved_mem_ops that are normally only used for struct device, and
also allows using the global pool for non-devicetree architectures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/dma-map-ops.h |  2 +-
 kernel/dma/coherent.c       | 32 ++++++++++++++------------------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index a5f89fc4d6df..ac3c9f2bc975 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -176,7 +176,7 @@ void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
 int dma_release_from_global_coherent(int order, void *vaddr);
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
 		size_t size, int *ret);
-
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 9610ed291f29..78a951f6e2c7 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -300,6 +300,18 @@ int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
 					vaddr, size, ret);
 }
 
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
+{
+	struct dma_coherent_mem *mem;
+
+	mem = dma_init_coherent_memory(phys_addr, phys_addr, size, true);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
+	dma_coherent_default_memory = mem;
+	pr_info("DMA: default coherent area is set\n");
+	return 0;
+}
+
 /*
  * Support for reserved memory regions defined in device tree
  */
@@ -367,26 +379,10 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 
 static int __init dma_init_reserved_memory(void)
 {
-	const struct reserved_mem_ops *ops;
-	int ret;
-
 	if (!dma_reserved_default_memory)
 		return -ENOMEM;
-
-	ops = dma_reserved_default_memory->ops;
-
-	/*
-	 * We rely on rmem_dma_device_init() does not propagate error of
-	 * dma_assign_coherent_memory() for "NULL" device.
-	 */
-	ret = ops->device_init(dma_reserved_default_memory, NULL);
-
-	if (!ret) {
-		dma_coherent_default_memory = dma_reserved_default_memory->priv;
-		pr_info("DMA: default coherent area is set\n");
-	}
-
-	return ret;
+	return dma_init_global_coherent(dma_reserved_default_memory->base,
+					dma_reserved_default_memory->size);
 }
 
 core_initcall(dma_init_reserved_memory);
-- 
2.34.1


