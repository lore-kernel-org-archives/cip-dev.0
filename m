From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:48 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 19/83] mmc: tmio: simplify irq handler
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-20-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 958401266e5812619b04765bef23712a72badd55 upstream.

Having just one irq handler again, let's include the 'card_status'
function in the main handler which is way more readable. Drop a useless
debug output while here. It should be a dev_dbg in case we ever need it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 1e050a4..f4f509c 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -626,19 +626,6 @@ out:
 	spin_unlock(&host->lock);
 }
 
-static void tmio_mmc_card_irq_status(struct tmio_mmc_host *host,
-				       int *ireg, int *status)
-{
-	*status = sd_ctrl_read32(host, CTL_STATUS);
-	*ireg = *status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
-
-	pr_debug_status(*status);
-	pr_debug_status(*ireg);
-
-	/* Clear the status except the interrupt status */
-	sd_ctrl_write32(host, CTL_STATUS, TMIO_MASK_IRQ);
-}
-
 static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
 				      int ireg, int status)
 {
@@ -718,9 +705,15 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	struct tmio_mmc_host *host = devid;
 	unsigned int ireg, status;
 
-	pr_debug("MMC IRQ begin\n");
+	status = sd_ctrl_read32(host, CTL_STATUS);
+	ireg = status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
+
+	pr_debug_status(status);
+	pr_debug_status(ireg);
+
+	/* Clear the status except the interrupt status */
+	sd_ctrl_write32(host, CTL_STATUS, TMIO_MASK_IRQ);
 
-	tmio_mmc_card_irq_status(host, &ireg, &status);
 	if (__tmio_mmc_card_detect_irq(host, ireg, status))
 		return IRQ_HANDLED;
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
-- 
2.7.4
