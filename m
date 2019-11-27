From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:43 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 05/22] mmc: tmio: always unmap DMA
	before waiting for interrupt
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 5f07ef8f603ace496ca8c20eef446c5ae7a10474 upstream.

In the (maybe academical) case, we don't get a DATAEND interrupt after
DMA completed, we will wait endlessly for the completion to complete.
This is not bad per se, since we have a more generic completion tracking
a timeout. In that rare case, however, the DMA buffer will not get
unmapped and we have a leak. Reorder the code, so unmapping will always
take place.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index e743684..72596bf 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -45,8 +45,6 @@ static void tmio_mmc_dma_callback(void *arg)
 {
 	struct tmio_mmc_host *host = arg;
 
-	wait_for_completion(&host->dma_dataend);
-
 	spin_lock_irq(&host->lock);
 
 	if (!host->data)
@@ -61,6 +59,11 @@ static void tmio_mmc_dma_callback(void *arg)
 			     host->sg_ptr, host->sg_len,
 			     DMA_TO_DEVICE);
 
+	spin_unlock_irq(&host->lock);
+
+	wait_for_completion(&host->dma_dataend);
+
+	spin_lock_irq(&host->lock);
 	tmio_mmc_do_data_irq(host);
 out:
 	spin_unlock_irq(&host->lock);
-- 
2.7.4
