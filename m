From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 13:00:36 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 06/17] mmc: tmio,
	renesas-sdhi: add max_{segs, blk_count} to tmio_mmc_data
In-Reply-To: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574341247-46652-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 603aa14d3daaa7073bab4c472025c4963030e0cc upstream.

Allow TMIO and SDHI driver implementations to provide values for
max_segs and max_blk_count.

A follow-up patch will set these values for Renesas Gen3 SoCs
the using an SDHI driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h      | 2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 2 ++
 drivers/mmc/host/tmio_mmc_core.c     | 6 +++---
 include/linux/mfd/tmio.h             | 2 ++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 781fe4c..6e33266 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -31,6 +31,8 @@ struct renesas_sdhi_of_data {
 	int scc_offset;
 	struct renesas_sdhi_scc *taps;
 	int taps_num;
+	unsigned int max_blk_count;
+	unsigned short max_segs;
 };
 
 int renesas_sdhi_probe(struct platform_device *pdev,
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index a64a3ba..2f8c7b8 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -502,6 +502,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->capabilities |= of_data->capabilities;
 		mmc_data->capabilities2 |= of_data->capabilities2;
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
+		mmc_data->max_blk_count = of_data->max_blk_count;
+		mmc_data->max_segs = of_data->max_segs;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 	}
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 0132a52..f93a773 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1222,10 +1222,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
-	mmc->max_segs = 32;
+	mmc->max_segs = pdata->max_segs ? : 32;
 	mmc->max_blk_size = 512;
-	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size) *
-		mmc->max_segs;
+	mmc->max_blk_count = pdata->max_blk_count ? :
+		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index a1520d8..662fedc 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -128,6 +128,8 @@ struct tmio_mmc_data {
 	unsigned int			cd_gpio;
 	int				alignment_shift;
 	dma_addr_t			dma_rx_offset;
+	unsigned int			max_blk_count;
+	unsigned short			max_segs;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-- 
2.7.4
