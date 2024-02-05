Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23714C48298
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 12:42:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.61925.1707136928406421430
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Feb 2024 04:42:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,245,1701097200"; 
   d="scan'208";a="192915831"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2024 21:42:07 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6217340065B6;
	Mon,  5 Feb 2024 21:42:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/48] dma-mapping: simplify dma_init_coherent_memory
Date: Mon,  5 Feb 2024 12:41:01 +0000
Message-Id: <20240205124135.14779-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240205124135.14779-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 12:42:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14683

From: Christoph Hellwig <hch@lst.de>

commit a6933571f34a9aee843fff2aa4b96949c57d6274 upstream.

Return the allocated dma_coherent_mem structure, set the
use_dma_pfn_offset and print the failure warning inside of
dma_init_coherent_memory instead of leaving that to the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 kernel/dma/coherent.c | 78 ++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index d97edd70d353..9610ed291f29 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -37,51 +37,44 @@ static inline dma_addr_t dma_get_device_base(struct device *dev,
 	return mem->device_base;
 }
 
-static int dma_init_coherent_memory(phys_addr_t phys_addr,
-		dma_addr_t device_addr, size_t size,
-		struct dma_coherent_mem **mem)
+static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
+		dma_addr_t device_addr, size_t size, bool use_dma_pfn_offset)
 {
-	struct dma_coherent_mem *dma_mem = NULL;
-	void *mem_base = NULL;
+	struct dma_coherent_mem *dma_mem;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
-	int ret;
+	void *mem_base;
 
-	if (!size) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!size)
+		return ERR_PTR(-EINVAL);
 
 	mem_base = memremap(phys_addr, size, MEMREMAP_WC);
-	if (!mem_base) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!mem_base)
+		return ERR_PTR(-EINVAL);
+
 	dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
-	if (!dma_mem) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dma_mem)
+		goto out_unmap_membase;
 	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!dma_mem->bitmap) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dma_mem->bitmap)
+		goto out_free_dma_mem;
 
 	dma_mem->virt_base = mem_base;
 	dma_mem->device_base = device_addr;
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
+	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
 	spin_lock_init(&dma_mem->spinlock);
 
-	*mem = dma_mem;
-	return 0;
+	return dma_mem;
 
-out:
+out_free_dma_mem:
 	kfree(dma_mem);
-	if (mem_base)
-		memunmap(mem_base);
-	return ret;
+out_unmap_membase:
+	memunmap(mem_base);
+	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
+		&phys_addr, size / SZ_1M);
+	return ERR_PTR(-ENOMEM);
 }
 
 static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
@@ -130,9 +123,9 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 	struct dma_coherent_mem *mem;
 	int ret;
 
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
-	if (ret)
-		return ret;
+	mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
 
 	ret = dma_assign_coherent_memory(dev, mem);
 	if (ret)
@@ -319,21 +312,16 @@ static struct reserved_mem *dma_reserved_default_memory __initdata;
 
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
-	struct dma_coherent_mem *mem = rmem->priv;
-	int ret;
-
-	if (!mem) {
-		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, &mem);
-		if (ret) {
-			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
-				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-			return ret;
-		}
+	if (!rmem->priv) {
+		struct dma_coherent_mem *mem;
+
+		mem = dma_init_coherent_memory(rmem->base, rmem->base,
+					       rmem->size, true);
+		if (IS_ERR(mem))
+			return PTR_ERR(mem);
+		rmem->priv = mem;
 	}
-	mem->use_dev_dma_pfn_offset = true;
-	rmem->priv = mem;
-	dma_assign_coherent_memory(dev, mem);
+	dma_assign_coherent_memory(dev, rmem->priv);
 	return 0;
 }
 
-- 
2.34.1


