From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:43 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 14/83] mmc: tmio: always start clock
	after frequency calculation
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 7fbc030da800d07193da4a4355ca2e197cf00cfb upstream.

Starting the clock is always done after frequency change anyhow, so we can
do it directly after the clock calculation and remove the specific calls.
This is the first part of doing proper clock de-/activation at calculation
time.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 1935706..99139b8 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -154,6 +154,18 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	}
 }
 
+static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
+
+	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
+		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
+		msleep(10);
+	}
+}
+
 static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 				unsigned int new_clock)
 {
@@ -182,6 +194,8 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG))
 		msleep(10);
+
+	tmio_mmc_clk_start(host);
 }
 
 static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
@@ -196,18 +210,6 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
 	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 5 : 10);
 }
 
-static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
-{
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-		sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-	msleep(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG ? 1 : 10);
-
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
-		sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
-		msleep(10);
-	}
-}
-
 static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
@@ -953,14 +955,12 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		tmio_mmc_clk_stop(host);
 		break;
 	case MMC_POWER_UP:
-		tmio_mmc_set_clock(host, ios->clock);
 		tmio_mmc_power_on(host, ios->vdd);
-		tmio_mmc_clk_start(host);
+		tmio_mmc_set_clock(host, ios->clock);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	case MMC_POWER_ON:
 		tmio_mmc_set_clock(host, ios->clock);
-		tmio_mmc_clk_start(host);
 		tmio_mmc_set_bus_width(host, ios->bus_width);
 		break;
 	}
@@ -1269,10 +1269,8 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	tmio_mmc_reset(host);
 	tmio_mmc_clk_enable(host);
 
-	if (host->clk_cache) {
+	if (host->clk_cache)
 		tmio_mmc_set_clock(host, host->clk_cache);
-		tmio_mmc_clk_start(host);
-	}
 
 	tmio_mmc_enable_dma(host, true);
 
-- 
2.7.4
