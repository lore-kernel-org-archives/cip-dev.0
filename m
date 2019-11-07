From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:53 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 24/83] mmc: tmio/sdhi: distinguish
	between SCLKDIVEN and ILL_FUNC
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-25-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit a21553c9e0c236ae241d9f4333aafae24ae19dfc upstream.

This bit has a different meaning in SDHI and original TMIO. Document
that and use the proper naming.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 3 ++-
 drivers/mmc/host/tmio_mmc.h       | 3 ++-
 drivers/mmc/host/tmio_mmc_pio.c   | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index ea78c77..7bb2900 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -252,7 +252,8 @@ static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
 {
 	int timeout = 1000;
 
-	while (--timeout && !(sd_ctrl_read16(host, CTL_STATUS2) & (1 << 13)))
+	while (--timeout && !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS)
+			      & TMIO_STAT_SCLKDIVEN))
 		udelay(1);
 
 	if (!timeout) {
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 55f251f..8dd5ea4 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -70,7 +70,8 @@
 #define TMIO_STAT_DAT0		BIT(23)	/* only known on R-Car so far */
 #define TMIO_STAT_RXRDY         BIT(24)
 #define TMIO_STAT_TXRQ          BIT(25)
-#define TMIO_STAT_ILL_FUNC      BIT(29)
+#define TMIO_STAT_ILL_FUNC      BIT(29) /* only when !TMIO_MMC_HAS_IDLE_WAIT */
+#define TMIO_STAT_SCLKDIVEN     BIT(29) /* only when TMIO_MMC_HAS_IDLE_WAIT */
 #define TMIO_STAT_CMD_BUSY      BIT(30)
 #define TMIO_STAT_ILL_ACCESS    BIT(31)
 
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 3a9620f..dbad002 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -542,7 +542,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host)
 		 * waiting for one more interrupt fixes the problem.
 		 */
 		if (host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT) {
-			if (status & TMIO_STAT_ILL_FUNC)
+			if (status & TMIO_STAT_SCLKDIVEN)
 				done = true;
 		} else {
 			if (!(status & TMIO_STAT_CMD_BUSY))
-- 
2.7.4
