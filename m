From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 13 Dec 2019 21:56:56 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip] net: davinci_cpdma: use dma_addr_t for
	DMA address
Message-ID: <20191213205656.GA2788@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

I have this in 4.4-rt-cip, and it would make my life easier if I
applied it to 4.4-cip. Would that be ok to do?

Thanks and best regards,
								Pavel

commit 3af83ff3e56ec9b96ef15a2e249e3019cd2e5245
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Sep 18 17:00:45 2019 +0900

    net: davinci_cpdma: use dma_addr_t for DMA address
    
    commit 84092996673211f16ef3b942a191d7952e9dfea9 upstream.
    
    The davinci_cpdma mixes up physical addresses as seen from the CPU
    and DMA addresses as seen from a DMA master, since it can operate
    on both normal memory or an on-chip buffer. If dma_addr_t is
    different from phys_addr_t, this means we get a compile-time warning
    about the type mismatch:
    
    ethernet/ti/davinci_cpdma.c: In function 'cpdma_desc_pool_create':
    ethernet/ti/davinci_cpdma.c:182:48: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
       pool->cpumap = dma_alloc_coherent(dev, size, &pool->phys,
    In file included from ethernet/ti/davinci_cpdma.c:21:0:
    dma-mapping.h:398:21: note: expected 'dma_addr_t * {aka long long unsigned int *}' but argument is of type 'phys_addr_t * {aka unsigned int *}'
     static inline void *dma_alloc_coherent(struct device *dev, size_t size,
    
    This slightly restructures the code so the address we use for
    mapping RAM into a DMA address is always a dma_addr_t, avoiding
    the warning. The code is correct even if both types are 32-bit
    because the DMA master in this device only supports 32-bit addressing
    anyway, independent of the types that are used.
    
    We still assign this value to pool->phys, and that is wrong if
    the driver is ever used with an IOMMU, but that value appears to
    be never used, so there is no problem really. I've added a couple
    of comments about where we do things that are slightly violating
    the API.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 657b65bf5cac..18bf3a8fdc50 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -82,7 +82,7 @@ struct cpdma_desc {
 
 struct cpdma_desc_pool {
 	phys_addr_t		phys;
-	u32			hw_addr;
+	dma_addr_t		hw_addr;
 	void __iomem		*iomap;		/* ioremap map */
 	void			*cpumap;	/* dma_alloc map */
 	int			desc_size, mem_size;
@@ -152,7 +152,7 @@ struct cpdma_chan {
  * abstract out these details
  */
 static struct cpdma_desc_pool *
-cpdma_desc_pool_create(struct device *dev, u32 phys, u32 hw_addr,
+cpdma_desc_pool_create(struct device *dev, u32 phys, dma_addr_t hw_addr,
 				int size, int align)
 {
 	int bitmap_size;
@@ -176,13 +176,13 @@ cpdma_desc_pool_create(struct device *dev, u32 phys, u32 hw_addr,
 
 	if (phys) {
 		pool->phys  = phys;
-		pool->iomap = ioremap(phys, size);
+		pool->iomap = ioremap(phys, size); /* should be memremap? */
 		pool->hw_addr = hw_addr;
 	} else {
-		pool->cpumap = dma_alloc_coherent(dev, size, &pool->phys,
+		pool->cpumap = dma_alloc_coherent(dev, size, &pool->hw_addr,
 						  GFP_KERNEL);
-		pool->iomap = pool->cpumap;
-		pool->hw_addr = pool->phys;
+		pool->iomap = (void __iomem __force *)pool->cpumap;
+		pool->phys = pool->hw_addr; /* assumes no IOMMU, don't use this value */
 	}
 
 	if (pool->iomap)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191213/07e7d11a/attachment.sig>
