Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED084C4828C
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 20:34:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.7342.1706646832721062867
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 12:34:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="196182821"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2024 05:34:01 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D1B7540A3D1D;
	Wed, 31 Jan 2024 05:33:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RFC PATCH 5.10.y-cip 06/39] dma-mapping: add a dma_init_global_coherent helper
Date: Tue, 30 Jan 2024 20:33:13 +0000
Message-Id: <20240130203346.94488-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 20:34:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14518

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
index a5f89fc4d6df1..ac3c9f2bc975f 100644
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
index 9610ed291f297..78a951f6e2c78 100644
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


