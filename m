From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:41 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 12/83] mmc: tmio: Add UHS-I mode support
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 452e5eef6d311e52f657b34d999758107ec3dd4a upstream.

Based on work by Shinobu Uehara and Ben Dooks. This adds the voltage
switch operation needed for all UHS-I modes, but not the tuning needed
for SDR-104 which will come later.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h     |  2 ++
 drivers/mmc/host/tmio_mmc_pio.c | 12 +++++++++++-
 include/linux/mmc/tmio.h        |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b44b589..b1819c7 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -101,6 +101,8 @@ struct tmio_mmc_host {
 	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
+	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
+					   struct mmc_ios *ios);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index d34de57..1935706 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1010,12 +1010,20 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
 	return blk_size;
 }
 
-static const struct mmc_host_ops tmio_mmc_ops = {
+static int tmio_mmc_card_busy(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	return !(sd_ctrl_read32(host, CTL_STATUS2) & TMIO_STATUS2_DAT0);
+}
+
+static struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
 	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
+	.card_busy	= tmio_mmc_card_busy,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 };
 
@@ -1114,7 +1122,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		goto host_free;
 	}
 
+	tmio_mmc_ops.start_signal_voltage_switch = _host->start_signal_voltage_switch;
 	mmc->ops = &tmio_mmc_ops;
+
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = 32;
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
index 5f5cd80..b2f28e9 100644
--- a/include/linux/mmc/tmio.h
+++ b/include/linux/mmc/tmio.h
@@ -63,6 +63,8 @@
 #define TMIO_STAT_CMD_BUSY      0x40000000
 #define TMIO_STAT_ILL_ACCESS    0x80000000
 
+#define TMIO_STATUS2_DAT0	BIT(7)
+
 #define	CLK_CTL_DIV_MASK	0xff
 #define	CLK_CTL_SCLKEN		BIT(8)
 
-- 
2.7.4
