From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:48 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 10/22] mmc: renesas-sdhi: improve
	checkpatch cleanness
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 2fe35968feccaee61413edbe54bec66bc80a67a7 upstream.

Trivial updates to improve checkpatch cleanness.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h          |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c     | 43 ++++++++++++++++----------------
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 25 +++++++++++--------
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index eb3ea15..781fe4c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -34,6 +34,6 @@ struct renesas_sdhi_of_data {
 };
 
 int renesas_sdhi_probe(struct platform_device *pdev,
-                       const struct tmio_mmc_dma_ops *dma_ops);
+		       const struct tmio_mmc_dma_ops *dma_ops);
 int renesas_sdhi_remove(struct platform_device *pdev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 36e2f61..a64a3ba 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -44,7 +44,8 @@
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
 
-#define host_to_priv(host) container_of((host)->pdata, struct renesas_sdhi, mmc_data)
+#define host_to_priv(host) \
+	container_of((host)->pdata, struct renesas_sdhi, mmc_data)
 
 struct renesas_sdhi {
 	struct clk *clk;
@@ -92,6 +93,7 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 	struct mmc_host *mmc = host->mmc;
 	struct renesas_sdhi *priv = host_to_priv(host);
 	int ret = clk_prepare_enable(priv->clk);
+
 	if (ret < 0)
 		return ret;
 
@@ -117,7 +119,7 @@ static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 }
 
 static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
-					      unsigned int new_clock)
+					    unsigned int new_clock)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
@@ -166,11 +168,12 @@ static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
-	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
+	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) &
+		 TMIO_STAT_DAT0);
 }
 
 static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
-						      struct mmc_ios *ios)
+						    struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -276,7 +279,7 @@ static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 }
 
 static void renesas_sdhi_prepare_tuning(struct tmio_mmc_host *host,
-					 unsigned long tap)
+					unsigned long tap)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 
@@ -309,9 +312,9 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	tap_start = 0;
 	tap_end = 0;
 	for (i = 0; i < host->tap_num * 2; i++) {
-		if (test_bit(i, host->taps))
+		if (test_bit(i, host->taps)) {
 			ntap++;
-		else {
+		} else {
 			if (ntap > tap_cnt) {
 				tap_start = i - ntap;
 				tap_end = i - 1;
@@ -343,7 +346,6 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	return 0;
 }
 
-
 static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
@@ -405,8 +407,7 @@ static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host)
 
 static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 {
-	switch (addr)
-	{
+	switch (addr) {
 	case CTL_SD_CMD:
 	case CTL_STOP_INTERNAL_ACTION:
 	case CTL_XFER_BLK_COUNT:
@@ -423,7 +424,7 @@ static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 }
 
 static int renesas_sdhi_multi_io_quirk(struct mmc_card *card,
-					 unsigned int direction, int blk_size)
+				       unsigned int direction, int blk_size)
 {
 	/*
 	 * In Renesas controllers, when performing a
@@ -451,20 +452,23 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops)
 {
-	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data( &pdev->dev);
-	struct renesas_sdhi *priv;
-	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
+	const struct renesas_sdhi_of_data *of_data;
+	struct tmio_mmc_data *mmc_data;
+	struct tmio_mmc_dma *dma_priv;
 	struct tmio_mmc_host *host;
+	struct renesas_sdhi *priv;
 	struct resource *res;
 	int irq, ret, i;
-	struct tmio_mmc_dma *dma_priv;
+
+	of_data = of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(struct renesas_sdhi), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct renesas_sdhi),
+			    GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -492,7 +496,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		goto eprobe;
 	}
 
-
 	if (of_data) {
 		mmc_data->flags |= of_data->tmio_flags;
 		mmc_data->ocr_mask = of_data->tmio_ocr_mask;
@@ -542,9 +545,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	 */
 	mmc_data->flags |= TMIO_MMC_SDIO_IRQ;
 
-	/*
-	 * All SDHI have CMD12 controll bit
-	 */
+	/* All SDHI have CMD12 control bit */
 	mmc_data->flags |= TMIO_MMC_HAVE_CMD12_CTRL;
 
 	/* All SDHI have SDIO status bits which must be 1 */
@@ -590,7 +591,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			break;
 		i++;
 		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
-				  dev_name(&pdev->dev), host);
+				       dev_name(&pdev->dev), host);
 		if (ret)
 			goto eirq;
 	}
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 82a37d1..d7757dd 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -92,7 +92,6 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
 
-
 static void renesas_sdhi_sys_dmac_enable_dma(struct tmio_mmc_host *host,
 					     bool enable)
 {
@@ -184,8 +183,8 @@ static void renesas_sdhi_sys_dmac_start_dma_rx(struct tmio_mmc_host *host)
 
 	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_FROM_DEVICE);
 	if (ret > 0)
-		desc = dmaengine_prep_slave_sg(chan, sg, ret,
-			DMA_DEV_TO_MEM, DMA_CTRL_ACK);
+		desc = dmaengine_prep_slave_sg(chan, sg, ret, DMA_DEV_TO_MEM,
+					       DMA_CTRL_ACK);
 
 	if (desc) {
 		reinit_completion(&host->dma_dataend);
@@ -253,6 +252,7 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 	if (!aligned) {
 		unsigned long flags;
 		void *sg_vaddr = tmio_mmc_kmap_atomic(sg, &flags);
+
 		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
 		memcpy(host->bounce_buf, sg_vaddr, host->bounce_sg.length);
 		tmio_mmc_kunmap_atomic(sg, &flags, sg_vaddr);
@@ -262,8 +262,8 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 
 	ret = dma_map_sg(chan->device->dev, sg, host->sg_len, DMA_TO_DEVICE);
 	if (ret > 0)
-		desc = dmaengine_prep_slave_sg(chan, sg, ret,
-			DMA_MEM_TO_DEV, DMA_CTRL_ACK);
+		desc = dmaengine_prep_slave_sg(chan, sg, ret, DMA_MEM_TO_DEV,
+					       DMA_CTRL_ACK);
 
 	if (desc) {
 		reinit_completion(&host->dma_dataend);
@@ -296,7 +296,7 @@ pio:
 }
 
 static void renesas_sdhi_sys_dmac_start_dma(struct tmio_mmc_host *host,
-			       struct mmc_data *data)
+					    struct mmc_data *data)
 {
 	if (data->flags & MMC_DATA_READ) {
 		if (host->chan_rx)
@@ -334,7 +334,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 {
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->dma || (!host->pdev->dev.of_node &&
-		(!pdata->chan_priv_tx || !pdata->chan_priv_rx)))
+			   (!pdata->chan_priv_tx || !pdata->chan_priv_rx)))
 		return;
 
 	if (!host->chan_tx && !host->chan_rx) {
@@ -360,7 +360,8 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 			return;
 
 		cfg.direction = DMA_MEM_TO_DEV;
-		cfg.dst_addr = res->start + (CTL_SD_DATA_PORT << host->bus_shift);
+		cfg.dst_addr = res->start +
+			(CTL_SD_DATA_PORT << host->bus_shift);
 		cfg.dst_addr_width = host->dma->dma_buswidth;
 		if (!cfg.dst_addr_width)
 			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -416,11 +417,13 @@ static void renesas_sdhi_sys_dmac_release_dma(struct tmio_mmc_host *host)
 {
 	if (host->chan_tx) {
 		struct dma_chan *chan = host->chan_tx;
+
 		host->chan_tx = NULL;
 		dma_release_channel(chan);
 	}
 	if (host->chan_rx) {
 		struct dma_chan *chan = host->chan_rx;
+
 		host->chan_rx = NULL;
 		dma_release_channel(chan);
 	}
@@ -445,10 +448,10 @@ static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
 
 static const struct dev_pm_ops renesas_sdhi_sys_dmac_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-			pm_runtime_force_resume)
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			tmio_mmc_host_runtime_resume,
-			NULL)
+			   tmio_mmc_host_runtime_resume,
+			   NULL)
 };
 
 static struct platform_driver renesas_sys_dmac_sdhi_driver = {
-- 
2.7.4
