From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:50 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 12/22] mmc: tmio,
	renesas-sdhi: add dataend to DMA ops
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 92d0f925e6344a24b12a6eeb4f1030ec0e70e8d1 upstream.

Add dataend to DMA ops to allow DMAC implementation dependent
handling of DMA data end.

Also implement the operation for SDHI.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  6 ++++++
 drivers/mmc/host/tmio_mmc.h              |  1 +
 drivers/mmc/host/tmio_mmc_core.c         | 10 ++++++++--
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index d7757dd..86a81fd 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -114,6 +114,11 @@ static void renesas_sdhi_sys_dmac_abort_dma(struct tmio_mmc_host *host)
 	renesas_sdhi_sys_dmac_enable_dma(host, true);
 }
 
+static void renesas_sdhi_sys_dmac_dataend_dma(struct tmio_mmc_host *host)
+{
+	complete(&host->dma_dataend);
+}
+
 static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 {
 	struct tmio_mmc_host *host = arg;
@@ -439,6 +444,7 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
 	.request = renesas_sdhi_sys_dmac_request_dma,
 	.release = renesas_sdhi_sys_dmac_release_dma,
 	.abort = renesas_sdhi_sys_dmac_abort_dma,
+	.dataend = renesas_sdhi_sys_dmac_dataend_dma,
 };
 
 static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index cd5b4f3..17ea4b6 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -120,6 +120,7 @@ struct tmio_mmc_dma_ops {
 			struct tmio_mmc_data *pdata);
 	void (*release)(struct tmio_mmc_host *host);
 	void (*abort)(struct tmio_mmc_host *host);
+	void (*dataend)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index f93a773..ed49a76 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -86,6 +86,12 @@ static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
 		host->dma_ops->abort(host);
 }
 
+static inline void tmio_mmc_dataend_dma(struct tmio_mmc_host *host)
+{
+	if (host->dma_ops)
+		host->dma_ops->dataend(host);
+}
+
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
 {
 	host->sdcard_irq_mask &= ~(i & TMIO_MASK_IRQ);
@@ -636,11 +642,11 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
 
 		if (done) {
 			tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
-			complete(&host->dma_dataend);
+			tmio_mmc_dataend_dma(host);
 		}
 	} else if (host->chan_rx && (data->flags & MMC_DATA_READ) && !host->force_pio) {
 		tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
-		complete(&host->dma_dataend);
+		tmio_mmc_dataend_dma(host);
 	} else {
 		tmio_mmc_do_data_irq(host);
 		tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_READOP | TMIO_MASK_WRITEOP);
-- 
2.7.4
