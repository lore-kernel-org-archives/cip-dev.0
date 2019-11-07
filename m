From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:47 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 18/83] mmc: tmio: remove now unneeded
	seperate irq handlers
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-19-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 4da986703882b2987b5731e8b31b88eece8c2fbb upstream.

We removed installation of separate handlers previously, so we can also
remove the separate handlers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[ Backported to 4.4 kernel ]
---
 drivers/mmc/host/tmio_mmc.h     |  3 ---
 drivers/mmc/host/tmio_mmc_pio.c | 36 +++++++-----------------------------
 2 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b1819c7..032188b 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -115,9 +115,6 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
-irqreturn_t tmio_mmc_sdcard_irq(int irq, void *devid);
-irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid);
-irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid);
 
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ff861f6..1e050a4 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -658,18 +658,6 @@ static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid)
-{
-	unsigned int ireg, status;
-	struct tmio_mmc_host *host = devid;
-
-	tmio_mmc_card_irq_status(host, &ireg, &status);
-	__tmio_mmc_card_detect_irq(host, ireg, status);
-
-	return IRQ_HANDLED;
-}
-EXPORT_SYMBOL(tmio_mmc_card_detect_irq);
-
 static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 				 int ireg, int status)
 {
@@ -699,19 +687,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-irqreturn_t tmio_mmc_sdcard_irq(int irq, void *devid)
-{
-	unsigned int ireg, status;
-	struct tmio_mmc_host *host = devid;
-
-	tmio_mmc_card_irq_status(host, &ireg, &status);
-	__tmio_mmc_sdcard_irq(host, ireg, status);
-
-	return IRQ_HANDLED;
-}
-EXPORT_SYMBOL(tmio_mmc_sdcard_irq);
-
-irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
+static bool tmio_mmc_sdio_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
@@ -720,7 +696,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
 	unsigned int sdio_status;
 
 	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
-		return IRQ_NONE;
+		return false;
 
 	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
 	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
@@ -734,9 +710,8 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
 	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
 		mmc_signal_sdio_irq(mmc);
 
-	return IRQ_RETVAL(ireg);
+	return ireg;
 }
-EXPORT_SYMBOL(tmio_mmc_sdio_irq);
 
 irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
@@ -751,7 +726,10 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	return tmio_mmc_sdio_irq(irq, devid);
+	if (tmio_mmc_sdio_irq(irq, devid))
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
 }
 EXPORT_SYMBOL(tmio_mmc_irq);
 
-- 
2.7.4
