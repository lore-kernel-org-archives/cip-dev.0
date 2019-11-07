From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:45 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 16/83] mmc: tmio: Remove redundant
	runtime PM calls
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 6aef2eecc4d4c9edb8c8d3e3a7f6af3cee42b2ec upstream.

Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
devices"), made some calls to the runtime PM API from the driver
redundant. Especially those which deals with runtime PM reference
counting, so let's remove them.

Cc: Ian Molton <ian@mnementh.co.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 6c09b1d..ff861f6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -271,9 +271,6 @@ static void tmio_mmc_reset_work(struct work_struct *work)
 
 	tmio_mmc_abort_dma(host);
 	mmc_request_done(host->mmc, mrq);
-
-	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
-	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 /* called with host->lock held, interrupts disabled */
@@ -303,9 +300,6 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 		tmio_mmc_abort_dma(host);
 
 	mmc_request_done(host->mmc, mrq);
-
-	pm_runtime_mark_last_busy(mmc_dev(host->mmc));
-	pm_runtime_put_autosuspend(mmc_dev(host->mmc));
 }
 
 static void tmio_mmc_done_work(struct work_struct *work)
@@ -817,8 +811,6 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	pm_runtime_get_sync(mmc_dev(mmc));
-
 	if (mrq->data) {
 		ret = tmio_mmc_start_data(host, mrq->data);
 		if (ret)
@@ -837,9 +829,6 @@ fail:
 	host->mrq = NULL;
 	mrq->cmd->error = ret;
 	mmc_request_done(mmc, mrq);
-
-	pm_runtime_mark_last_busy(mmc_dev(mmc));
-	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
@@ -923,8 +912,6 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct device *dev = &host->pdev->dev;
 	unsigned long flags;
 
-	pm_runtime_get_sync(mmc_dev(mmc));
-
 	mutex_lock(&host->ios_lock);
 
 	spin_lock_irqsave(&host->lock, flags);
@@ -979,9 +966,6 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->clk_cache = ios->clock;
 
 	mutex_unlock(&host->ios_lock);
-
-	pm_runtime_mark_last_busy(mmc_dev(mmc));
-	pm_runtime_put_autosuspend(mmc_dev(mmc));
 }
 
 static int tmio_mmc_get_ro(struct mmc_host *mmc)
@@ -992,11 +976,8 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 	if (ret >= 0)
 		return ret;
 
-	pm_runtime_get_sync(mmc_dev(mmc));
 	ret = !((pdata->flags & TMIO_MMC_WRPROTECT_DISABLE) ||
 		(sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
-	pm_runtime_mark_last_busy(mmc_dev(mmc));
-	pm_runtime_put_autosuspend(mmc_dev(mmc));
 
 	return ret;
 }
-- 
2.7.4
