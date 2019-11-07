From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:08 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 39/83] mmc: tmio: Add hw reset support
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-40-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

commit e8f36b5d3b54a49df02c950050659a5082e2c880 upstream.

Add hw reset support.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h     | 1 +
 drivers/mmc/host/tmio_mmc_pio.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index d3d24e1..8b4869e 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -167,6 +167,7 @@ struct tmio_mmc_host {
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	void (*hw_reset)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index c255af8..4bb0553 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -792,6 +792,14 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	return 0;
 }
 
+static void tmio_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (host->hw_reset)
+		host->hw_reset(host);
+}
+
 /* Process requests from the MMC layer */
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
@@ -1008,6 +1016,7 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
+	.hw_reset	= tmio_mmc_hw_reset,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
-- 
2.7.4
