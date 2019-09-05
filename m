From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  5 Sep 2019 09:37:13 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip repost 2/6] mmc: tmio: introduce macro
	for max block size
In-Reply-To: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567672637-29449-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 609e5fba56fc0ad8e2a5917f64b964c2f4979bc5 upstream.

We will need it later for other calculations.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h      | 2 ++
 drivers/mmc/host/tmio_mmc_core.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 7c40a7e..5904ed4 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -110,6 +110,8 @@
 		TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT)
 #define TMIO_MASK_IRQ     (TMIO_MASK_READOP | TMIO_MASK_WRITEOP | TMIO_MASK_CMD)
 
+#define TMIO_MAX_BLK_SIZE 512
+
 struct tmio_mmc_data;
 struct tmio_mmc_host;
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 7d13ca9..daf4803 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1269,7 +1269,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = pdata->max_segs ? : 32;
-	mmc->max_blk_size = 512;
+	mmc->max_blk_size = TMIO_MAX_BLK_SIZE;
 	mmc->max_blk_count = pdata->max_blk_count ? :
 		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-- 
2.7.4
