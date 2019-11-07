From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:26 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 57/83] mmc: host: tmio:
	SDIO_STATUS_QUIRK is rather SDIO_STATUS_SETBITS
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-58-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 20dd03734cac41a0545dd24f5e81d8ff0c80874b upstream.

QUIRK sounds like there is something wrong, but actually there are just
some bits which need to be 1. Rename it to be more clear.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 6 ++----
 drivers/mmc/host/tmio_mmc_pio.c   | 2 +-
 include/linux/mfd/tmio.h          | 6 ++----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 8e90670..a723550 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -640,10 +640,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	 */
 	mmc_data->flags |= TMIO_MMC_HAVE_CMD12_CTRL;
 
-	/*
-	 * All SDHI need SDIO_INFO1 reserved bit
-	 */
-	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_QUIRK;
+	/* All SDHI have SDIO status bits which must be 1 */
+	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
 	ret = tmio_mmc_host_probe(host, mmc_data);
 	if (ret < 0)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 0a3f411..a0b5db3 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -724,7 +724,7 @@ static bool __tmio_mmc_sdio_irq(int irq, void *devid)
 	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdio_irq_mask;
 
 	sdio_status = status & ~TMIO_SDIO_MASK_ALL;
-	if (pdata->flags & TMIO_MMC_SDIO_STATUS_QUIRK)
+	if (pdata->flags & TMIO_MMC_SDIO_STATUS_SETBITS)
 		sdio_status |= 6;
 
 	sd_ctrl_write16(host, CTL_SDIO_STATUS, sdio_status);
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index fba44ab..a1520d8 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -94,10 +94,8 @@
  */
 #define TMIO_MMC_HAVE_CMD12_CTRL	(1 << 7)
 
-/*
- * Some controllers needs to set 1 on SDIO status reserved bits
- */
-#define TMIO_MMC_SDIO_STATUS_QUIRK	(1 << 8)
+/* Controller has some SDIO status bits which must be 1 */
+#define TMIO_MMC_SDIO_STATUS_SETBITS	(1 << 8)
 
 /*
  * Some controllers have a 32-bit wide data port register
-- 
2.7.4
