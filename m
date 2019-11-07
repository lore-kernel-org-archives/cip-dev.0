From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:31 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/83] mmc: tmio_dma: remove debug
	messages with little information
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 254d1456560fa42d4ca901c9b9308e87c951fee1 upstream.

When compiling the driver with CONFIG_MMC_DEBUG set, I got build
warnings. They have been 'fixed' meanwhile. However, because these debug
messages look random anyhow (some duplicate information printed etc),
let's just drop them and rather re-add something consistent if that
should ever be needed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_dma.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 4a0d6b8..6754358 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -94,10 +94,7 @@ static void tmio_mmc_start_dma_rx(struct tmio_mmc_host *host)
 			desc = NULL;
 			ret = cookie;
 		}
-		dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
-			__func__, host->sg_len, ret, cookie, host->mrq);
 	}
-
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
@@ -115,9 +112,6 @@ pio:
 		dev_warn(&host->pdev->dev,
 			 "DMA failed: %d, falling back to PIO\n", ret);
 	}
-
-	dev_dbg(&host->pdev->dev, "%s(): desc %p, sg[%d]\n", __func__,
-		desc, host->sg_len);
 }
 
 static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
@@ -174,10 +168,7 @@ static void tmio_mmc_start_dma_tx(struct tmio_mmc_host *host)
 			desc = NULL;
 			ret = cookie;
 		}
-		dev_dbg(&host->pdev->dev, "%s(): mapped %d -> %d, cookie %d, rq %p\n",
-			__func__, host->sg_len, ret, cookie, host->mrq);
 	}
-
 pio:
 	if (!desc) {
 		/* DMA failed, fall back to PIO */
@@ -195,8 +186,6 @@ pio:
 		dev_warn(&host->pdev->dev,
 			 "DMA failed: %d, falling back to PIO\n", ret);
 	}
-
-	dev_dbg(&host->pdev->dev, "%s(): desc %p\n", __func__, desc);
 }
 
 void tmio_mmc_start_dma(struct tmio_mmc_host *host,
-- 
2.7.4
