From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  5 Sep 2019 09:37:14 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip repost 3/6] mmc: renesas_sdhi: prevent
	overflow for max_req_size
In-Reply-To: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567672637-29449-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2a55c1eac78822321d08cb89b1ac2e06e37fd9ff upstream.

max_req_size is calculated by 'max_blk_size * max_blk_count' in the TMIO
core. So, specifying U32_MAX as max_blk_count will overflow this
calculation. It will cause no harm in practice because the immense high
number will overflow into another immense high number. However, it is
not good coding practice, so calculate max_blk_count so that
max_req_size will fit into unsigned int on ARM32/64.

Thanks to the Renesas BSP team for the bug report!

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 8 ++++----
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 07669d3..7b0bc15 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -96,8 +96,8 @@ static const struct renesas_sdhi_of_data of_rcar_r8a7795_compatible = {
 	.scc_offset	= 0x1000,
 	.taps		= rcar_gen3_scc_taps,
 	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
-	/* DMAC can handle 0xffffffff blk count but only 1 segment */
-	.max_blk_count	= 0xffffffff,
+	/* DMAC can handle 32bit blk count but only 1 segment */
+	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
 };
 
@@ -111,8 +111,8 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 	.scc_offset	= 0x1000,
 	.taps		= rcar_gen3_scc_taps,
 	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
-	/* DMAC can handle 0xffffffff blk count but only 1 segment */
-	.max_blk_count	= 0xffffffff,
+	/* DMAC can handle 32bit blk count but only 1 segment */
+	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 	.max_segs	= 1,
 };
 
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index c3d63ed..80ee745 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -68,7 +68,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.scc_offset	= 0x0300,
 	.taps		= rcar_gen2_scc_taps,
 	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
-	.max_blk_count  = 0xffffffff,
+	.max_blk_count	= UINT_MAX / TMIO_MAX_BLK_SIZE,
 };
 
 /* Definitions for sampling clocks */
-- 
2.7.4
