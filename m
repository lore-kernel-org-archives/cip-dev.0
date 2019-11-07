From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:33 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 04/83] mmc: tmio: remove stale comments
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 6d2bcbe5d1ee44271b30d445b55c49219b33fc6e upstream.

These don't make sense anymore. Since commit 5d60e500541ed1 ("mmc: tmio:
add new TMIO_MMC_HAVE_HIGH_REG flags"), we don't deal with a resource
here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 66c65fe..99df39a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -178,7 +178,6 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 {
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0000);
 		msleep(10);
@@ -195,7 +194,6 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
 
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
 		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
 		msleep(10);
@@ -206,7 +204,6 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
-	/* implicit BUG_ON(!res) */
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
 	msleep(10);
-- 
2.7.4
