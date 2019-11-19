From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:36:03 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 24/31] mmc: tmio: discard obsolete SDIO
	irqs before enabling irqs
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-25-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit ee28981535f4261ed5d127ddf4d1a3f8778f520d upstream.

Before enabling SDIO irqs, clear the status bit, so we discard old and
stale interrupts. Needed to get two wireless cards working. Use the
newly introduced macro in all places.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h     |  2 ++
 drivers/mmc/host/tmio_mmc_pio.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index ba2838c..e414670 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -90,6 +90,8 @@
 #define TMIO_SDIO_STAT_EXWT	0x8000
 #define TMIO_SDIO_MASK_ALL	0xc007
 
+#define TMIO_SDIO_SETBITS_MASK	0x0006
+
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
 #define TMIO_MASK_ALL           0x837f031d
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 32f6cb8..3ec58b44 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -134,12 +134,21 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
 	if (enable && !host->sdio_irq_enabled) {
+		u16 sdio_status;
+
 		/* Keep device active while SDIO irq is enabled */
 		pm_runtime_get_sync(mmc_dev(mmc));
-		host->sdio_irq_enabled = true;
 
+		host->sdio_irq_enabled = true;
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
 					~TMIO_SDIO_STAT_IOIRQ;
+
+		/* Clear obsolete interrupts before enabling */
+		sdio_status = sd_ctrl_read16(host, CTL_SDIO_STATUS) & ~TMIO_SDIO_MASK_ALL;
+		if (host->pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
+			sdio_status |= TMIO_SDIO_SETBITS_MASK;
+		sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
+
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 	} else if (!enable && host->sdio_irq_enabled) {
 		host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
@@ -723,7 +732,7 @@ static bool __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 
 	sdio_status = status & ~TMIO_SDIO_MASK_ALL;
 	if (pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
-		sdio_status |= 6;
+		sdio_status |= TMIO_SDIO_SETBITS_MASK;
 
 	sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
 
-- 
2.7.4
