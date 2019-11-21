From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 13:00:34 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 04/17] mmc: renesas-sdhi: make
	renesas_sdhi_sys_dmac main module file
In-Reply-To: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574341247-46652-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 9d08428afb722fedaea699a32aaf603a8f1ebd5a upstream.

Make renesas_sdhi_sys_dmac.c a top-level module file that makes use of
library code supplied by renesas_sdhi_core.c

This is in order to facilitate adding other variants of SDHI;
in particular SDHI using different DMA controllers.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[Arnd: Fixed module build error]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[Biju: Backported to 4.4 Kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h          |  23 +++++-
 drivers/mmc/host/renesas_sdhi_core.c     | 128 ++-----------------------------
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 109 +++++++++++++++++++++++++-
 3 files changed, 135 insertions(+), 125 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index f65d936c..eb3ea15 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -12,7 +12,28 @@
 #ifndef RENESAS_SDHI_H
 #define RENESAS_SDHI_H
 
+#include <linux/platform_device.h>
 #include "tmio_mmc.h"
 
-const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void);
+struct renesas_sdhi_scc {
+	unsigned long clk_rate;	/* clock rate for SDR104 */
+	u32 tap;		/* sampling clock position for SDR104 */
+};
+
+struct renesas_sdhi_of_data {
+	unsigned long tmio_flags;
+	u32	      tmio_ocr_mask;
+	unsigned long capabilities;
+	unsigned long capabilities2;
+	enum dma_slave_buswidth dma_buswidth;
+	dma_addr_t dma_rx_offset;
+	unsigned bus_shift;
+	int scc_offset;
+	struct renesas_sdhi_scc *taps;
+	int taps_num;
+};
+
+int renesas_sdhi_probe(struct platform_device *pdev,
+                       const struct tmio_mmc_dma_ops *dma_ops);
+int renesas_sdhi_remove(struct platform_device *pdev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index ee60e90..36e2f61 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1,5 +1,5 @@
 /*
- * SuperH Mobile SDHI
+ * Renesas SDHI
  *
  * Copyright (C) 2016 Sang Engineering, Wolfram Sang
  * Copyright (C) 2015-16 Renesas Electronics Corporation
@@ -23,8 +23,6 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
@@ -48,94 +46,6 @@
 
 #define host_to_priv(host) container_of((host)->pdata, struct renesas_sdhi, mmc_data)
 
-struct renesas_sdhi_scc {
-	unsigned long clk_rate;	/* clock rate for SDR104 */
-	u32 tap;		/* sampling clock position for SDR104 */
-};
-
-struct renesas_sdhi_of_data {
-	unsigned long tmio_flags;
-	u32	      tmio_ocr_mask;
-	unsigned long capabilities;
-	unsigned long capabilities2;
-	enum dma_slave_buswidth dma_buswidth;
-	dma_addr_t dma_rx_offset;
-	unsigned bus_shift;
-	int scc_offset;
-	struct renesas_sdhi_scc *taps;
-	int taps_num;
-};
-
-static const struct renesas_sdhi_of_data of_default_cfg = {
-	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
-};
-
-static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-};
-
-/* Definitions for sampling clocks */
-static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
-	{
-		.clk_rate = 156000000,
-		.tap = 0x00000703,
-	},
-	{
-		.clk_rate = 0,
-		.tap = 0x00000300,
-	},
-};
-
-static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
-	.dma_rx_offset	= 0x2000,
-	.scc_offset	= 0x0300,
-	.taps		= rcar_gen2_scc_taps,
-	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
-};
-
-/* Definitions for sampling clocks */
-static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
-	{
-		.clk_rate = 0,
-		.tap = 0x00000300,
-	},
-};
-
-static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
-			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
-	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-	.bus_shift	= 2,
-	.scc_offset	= 0x1000,
-	.taps		= rcar_gen3_scc_taps,
-	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
-};
-
-static const struct of_device_id renesas_sdhi_of_match[] = {
-	{ .compatible = "renesas,sdhi-shmobile" },
-	{ .compatible = "renesas,sdhi-sh7372" },
-	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
-	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7743", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7745", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
-	{},
-};
-MODULE_DEVICE_TABLE(of, renesas_sdhi_of_match);
-
 struct renesas_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
@@ -538,9 +448,10 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 	renesas_sdhi_sdbuf_width(host, enable ? 32 : 16);
 }
 
-static int renesas_sdhi_probe(struct platform_device *pdev)
+int renesas_sdhi_probe(struct platform_device *pdev,
+		       const struct tmio_mmc_dma_ops *dma_ops)
 {
-	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data(&pdev->dev);
+	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data( &pdev->dev);
 	struct renesas_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
@@ -639,7 +550,7 @@ static int renesas_sdhi_probe(struct platform_device *pdev)
 	/* All SDHI have SDIO status bits which must be 1 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_SETBITS;
 
-	ret = tmio_mmc_host_probe(host, mmc_data, renesas_sdhi_get_dma_ops());
+	ret = tmio_mmc_host_probe(host, mmc_data, dma_ops);
 	if (ret < 0)
 		goto efree;
 
@@ -704,8 +615,9 @@ efree:
 eprobe:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(renesas_sdhi_probe);
 
-static int renesas_sdhi_remove(struct platform_device *pdev)
+int renesas_sdhi_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -714,28 +626,4 @@ static int renesas_sdhi_remove(struct platform_device *pdev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-			pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			tmio_mmc_host_runtime_resume,
-			NULL)
-};
-
-static struct platform_driver renesas_sdhi_driver = {
-	.driver		= {
-		.name	= "sh_mobile_sdhi",
-		.pm	= &tmio_mmc_dev_pm_ops,
-		.of_match_table = renesas_sdhi_of_match,
-	},
-	.probe		= renesas_sdhi_probe,
-	.remove		= renesas_sdhi_remove,
-};
-
-module_platform_driver(renesas_sdhi_driver);
-
-MODULE_DESCRIPTION("Renesas SDHI driver");
-MODULE_AUTHOR("Magnus Damm");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:sh_mobile_sdhi");
+EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index ca96e33..82a37d1 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -13,13 +13,86 @@
 #include <linux/dmaengine.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/scatterlist.h>
 
+#include "renesas_sdhi.h"
 #include "tmio_mmc.h"
 
 #define TMIO_MMC_MIN_DMA_LEN 8
 
+static const struct renesas_sdhi_of_data of_default_cfg = {
+	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
+};
+
+static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+};
+
+/* Definitions for sampling clocks */
+static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
+	{
+		.clk_rate = 156000000,
+		.tap = 0x00000703,
+	},
+	{
+		.clk_rate = 0,
+		.tap = 0x00000300,
+	},
+};
+
+static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.dma_buswidth	= DMA_SLAVE_BUSWIDTH_4_BYTES,
+	.dma_rx_offset	= 0x2000,
+	.scc_offset	= 0x0300,
+	.taps		= rcar_gen2_scc_taps,
+	.taps_num	= ARRAY_SIZE(rcar_gen2_scc_taps),
+};
+
+/* Definitions for sampling clocks */
+static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
+	{
+		.clk_rate = 0,
+		.tap = 0x00000300,
+	},
+};
+
+static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.bus_shift	= 2,
+	.scc_offset	= 0x1000,
+	.taps		= rcar_gen3_scc_taps,
+	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
+};
+
+static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
+	{ .compatible = "renesas,sdhi-shmobile" },
+	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7743", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7745", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
+	{},
+};
+MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
+
+
 static void renesas_sdhi_sys_dmac_enable_dma(struct tmio_mmc_host *host,
 					     bool enable)
 {
@@ -46,8 +119,6 @@ static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 {
 	struct tmio_mmc_host *host = arg;
 
-	wait_for_completion(&host->dma_dataend);
-
 	spin_lock_irq(&host->lock);
 
 	if (!host->data)
@@ -62,6 +133,11 @@ static void renesas_sdhi_sys_dmac_dma_callback(void *arg)
 			     host->sg_ptr, host->sg_len,
 			     DMA_TO_DEVICE);
 
+	spin_unlock_irq(&host->lock);
+
+	wait_for_completion(&host->dma_dataend);
+
+	spin_lock_irq(&host->lock);
 	tmio_mmc_do_data_irq(host);
 out:
 	spin_unlock_irq(&host->lock);
@@ -362,7 +438,32 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_sys_dmac_dma_ops = {
 	.abort = renesas_sdhi_sys_dmac_abort_dma,
 };
 
-const struct tmio_mmc_dma_ops *renesas_sdhi_get_dma_ops(void)
+static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
 {
-	return &renesas_sdhi_sys_dmac_dma_ops;
+	return renesas_sdhi_probe(pdev, &renesas_sdhi_sys_dmac_dma_ops);
 }
+
+static const struct dev_pm_ops renesas_sdhi_sys_dmac_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+			pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+			tmio_mmc_host_runtime_resume,
+			NULL)
+};
+
+static struct platform_driver renesas_sys_dmac_sdhi_driver = {
+	.driver		= {
+		.name	= "sh_mobile_sdhi",
+		.pm	= &renesas_sdhi_sys_dmac_dev_pm_ops,
+		.of_match_table = renesas_sdhi_sys_dmac_of_match,
+	},
+	.probe		= renesas_sdhi_sys_dmac_probe,
+	.remove		= renesas_sdhi_remove,
+};
+
+module_platform_driver(renesas_sys_dmac_sdhi_driver);
+
+MODULE_DESCRIPTION("Renesas SDHI driver");
+MODULE_AUTHOR("Magnus Damm");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:sh_mobile_sdhi");
-- 
2.7.4
