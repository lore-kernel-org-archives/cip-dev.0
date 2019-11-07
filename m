From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:10 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 41/83] mmc: tmio: Add tuning support
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-42-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

commit 4f11997773b6b452b5a0d620c5ac5050e75c227e upstream.

Add tuning support for use with SDR104 mode

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h     | 14 ++++++++++
 drivers/mmc/host/tmio_mmc_pio.c | 62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 8b4869e..ba2838c 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -153,6 +153,7 @@ struct tmio_mmc_host {
 	struct mutex		ios_lock;	/* protect set_ios() context */
 	bool			native_hotplug;
 	bool			sdio_irq_enabled;
+	u32			scc_tappos;
 
 	/* Mandatory callback */
 	int (*clk_enable)(struct tmio_mmc_host *host);
@@ -168,6 +169,19 @@ struct tmio_mmc_host {
 					   struct mmc_ios *ios);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	void (*hw_reset)(struct tmio_mmc_host *host);
+	void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
+	bool (*check_scc_error)(struct tmio_mmc_host *host);
+
+	/*
+	 * Mandatory callback for tuning to occur which is optional for SDR50
+	 * and mandatory for SDR104.
+	 */
+	unsigned int (*init_tuning)(struct tmio_mmc_host *host);
+	int (*select_tuning)(struct tmio_mmc_host *host);
+
+	/* Tuning values: 1 for success, 0 for failure */
+	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
+	unsigned int tap_num;
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 4bb0553..37703bf 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -36,6 +36,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/mfd/tmio.h>
+#include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
@@ -298,6 +299,9 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (mrq->cmd->error || (mrq->data && mrq->data->error))
 		tmio_mmc_abort_dma(host);
 
+	if (host->check_scc_error)
+		host->check_scc_error(host);
+
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -800,6 +804,55 @@ static void tmio_mmc_hw_reset(struct mmc_host *mmc)
 		host->hw_reset(host);
 }
 
+static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	int i, ret = 0;
+
+	if (!host->tap_num) {
+		if (!host->init_tuning || !host->select_tuning)
+			/* Tuning is not supported */
+			goto out;
+
+		host->tap_num = host->init_tuning(host);
+		if (!host->tap_num)
+			/* Tuning is not supported */
+			goto out;
+	}
+
+	if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
+		dev_warn_once(&host->pdev->dev,
+		      "Too many taps, skipping tuning. Please consider updating size of taps field of tmio_mmc_host\n");
+		goto out;
+	}
+
+	bitmap_zero(host->taps, host->tap_num * 2);
+
+	/* Issue CMD19 twice for each tap */
+	for (i = 0; i < 2 * host->tap_num; i++) {
+		if (host->prepare_tuning)
+			host->prepare_tuning(host, i % host->tap_num);
+
+		ret = mmc_send_tuning(mmc, opcode, NULL);
+		if (ret && ret != -EILSEQ)
+			goto out;
+		if (ret == 0)
+			set_bit(i, host->taps);
+
+		mdelay(1);
+	}
+
+	ret = host->select_tuning(host);
+
+out:
+	if (ret < 0) {
+		dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
+		tmio_mmc_hw_reset(mmc);
+	}
+
+	return ret;
+}
+
 /* Process requests from the MMC layer */
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
@@ -1017,6 +1070,7 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
 	.hw_reset	= tmio_mmc_hw_reset,
+	.execute_tuning = tmio_mmc_execute_tuning,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
@@ -1263,6 +1317,11 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_suspend);
 
+static bool tmio_mmc_can_retune(struct tmio_mmc_host *host)
+{
+	return host->tap_num && mmc_can_retune(host->mmc);
+}
+
 int tmio_mmc_host_runtime_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
@@ -1276,6 +1335,9 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 
 	tmio_mmc_enable_dma(host, true);
 
+	if (tmio_mmc_can_retune(host) && host->select_tuning(host))
+		dev_warn(&host->pdev->dev, "Tuning selection failed\n");
+
 	return 0;
 }
 EXPORT_SYMBOL(tmio_mmc_host_runtime_resume);
-- 
2.7.4
