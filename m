From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:35:48 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 09/31] mmc: tmio: fix wrong bitmask for
	SDIO irqs
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 0c4bf5beff79fd32c5a3b2b511ed6527861ada18 upstream.

Commit 7729c7a232a953 ("mmc: tmio: Provide separate interrupt handlers")
refactored the sdio irq handler and wrongly used the mask for SD irqs,
not for SDIO irqs. This doesn't really matter in practice because both
values keep the only interrupt we are interested in. But still, this is
wrong and wants to be fixed.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b569ef3..5460fda 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -723,7 +723,7 @@ static bool tmio_mmc_sdio_irq(int irq, void *devid)
 		return false;
 
 	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
-	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
+	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdio_irq_mask;
 
 	sdio_status = status & ~TMIO_SDIO_MASK_ALL;
 	if (pdata->flags & TMIO_MMC_SDIO_STATUS_QUIRK)
-- 
2.7.4
