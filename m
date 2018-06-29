From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:57 +0100
Subject: [cip-dev] [PATCH 56/86] ARM: shmobile: rcar-gen2: Make
	rcar_gen2_dma_contiguous static
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-57-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

make C=1:

    arch/arm/mach-shmobile/setup-rcar-gen2.c:186:12: warning: symbol 'rcar_gen2_dma_contiguous' was not declared. Should it be static?

Make it static, and move it inside the function to avoid a "defined but
not used" warning if CONFIG_DMA_CMA=n.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 0c1690705417ac1b33f01125552349e3cfc9766d)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 828ce09..50d7438 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -168,8 +168,6 @@ static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
 	return 0;
 }
 
-struct cma *rcar_gen2_dma_contiguous;
-
 void __init rcar_gen2_reserve(void)
 {
 	struct memory_reserve_config mrc;
@@ -180,9 +178,12 @@ void __init rcar_gen2_reserve(void)
 
 	of_scan_flat_dt(rcar_gen2_scan_mem, &mrc);
 #ifdef CONFIG_DMA_CMA
-	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size))
+	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size)) {
+		static struct cma *rcar_gen2_dma_contiguous;
+
 		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
 					    &rcar_gen2_dma_contiguous, true);
+	}
 #endif
 }
 
-- 
2.7.4
