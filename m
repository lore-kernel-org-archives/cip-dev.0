From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:46 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 08/22] mmc: renesas-sdhi: rename
	sh_mobile_sdhi.c => renesas_sdhi_core.c
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit b5b6a5f4f06c0624886b2166e2e8580327f0b943 upstream.

Rename the source file SDHI. A follow-up patch will make it a library
file used by a different top-level module file.

The name "renesas" is chosen as the SDHI driver is applicable to a wider
range of SoCs than SH-Mobile it seems to be a more appropriate name.
However, the SDHI driver source itself, is left as sh_mobile_sdhi to
avoid unnecessary churn.

the name "core" was chosen to reflect the desired role of this file,
to provide core functionality to the sdhi driver. A follow-up patch will
move the file into that role.

Internal symbols have also been renamed to reflect the filename change.

The .name member of struct platform_driver and parameter to
MODULE_ALIAS() have not been changed in order to avoid the complication
of potentially breaking SH SoCs which still use platform drivers.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[biju: Backported to 4.4 kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/Kconfig                           |   2 +-
 drivers/mmc/host/Makefile                          |   2 +-
 .../host/{sh_mobile_sdhi.c => renesas_sdhi_core.c} | 136 ++++++++++-----------
 3 files changed, 70 insertions(+), 70 deletions(-)
 rename drivers/mmc/host/{sh_mobile_sdhi.c => renesas_sdhi_core.c} (82%)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2e6d2ff..eaf40ec 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -565,7 +565,7 @@ config MMC_SDHI
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
-	  SuperH and ARM SH-Mobile SoCs
+	  Renesas SuperH, ARM and ARM64 based SoCs
 
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 7ab00194..c3c85c9 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
-obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o renesas_sdhi_sys_dmac.o
+obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_core.o renesas_sdhi_sys_dmac.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/renesas_sdhi_core.c
similarity index 82%
rename from drivers/mmc/host/sh_mobile_sdhi.c
rename to drivers/mmc/host/renesas_sdhi_core.c
index c963e62..ee60e90 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -46,14 +46,14 @@
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
 
-#define host_to_priv(host) container_of((host)->pdata, struct sh_mobile_sdhi, mmc_data)
+#define host_to_priv(host) container_of((host)->pdata, struct renesas_sdhi, mmc_data)
 
-struct sh_mobile_sdhi_scc {
+struct renesas_sdhi_scc {
 	unsigned long clk_rate;	/* clock rate for SDR104 */
 	u32 tap;		/* sampling clock position for SDR104 */
 };
 
-struct sh_mobile_sdhi_of_data {
+struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
 	u32	      tmio_ocr_mask;
 	unsigned long capabilities;
@@ -62,22 +62,22 @@ struct sh_mobile_sdhi_of_data {
 	dma_addr_t dma_rx_offset;
 	unsigned bus_shift;
 	int scc_offset;
-	struct sh_mobile_sdhi_scc *taps;
+	struct renesas_sdhi_scc *taps;
 	int taps_num;
 };
 
-static const struct sh_mobile_sdhi_of_data of_default_cfg = {
+static const struct renesas_sdhi_of_data of_default_cfg = {
 	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
 };
 
-static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
+static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
 			  TMIO_MMC_CLK_ACTUAL,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
 
 /* Definitions for sampling clocks */
-static struct sh_mobile_sdhi_scc rcar_gen2_scc_taps[] = {
+static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
 	{
 		.clk_rate = 156000000,
 		.tap = 0x00000703,
@@ -88,7 +88,7 @@ static struct sh_mobile_sdhi_scc rcar_gen2_scc_taps[] = {
 	},
 };
 
-static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
+static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
 			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
@@ -100,14 +100,14 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 };
 
 /* Definitions for sampling clocks */
-static struct sh_mobile_sdhi_scc rcar_gen3_scc_taps[] = {
+static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 	{
 		.clk_rate = 0,
 		.tap = 0x00000300,
 	},
 };
 
-static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
+static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
 			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
@@ -117,7 +117,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 	.taps_num	= ARRAY_SIZE(rcar_gen3_scc_taps),
 };
 
-static const struct of_device_id sh_mobile_sdhi_of_match[] = {
+static const struct of_device_id renesas_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh7372" },
 	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
@@ -134,9 +134,9 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
 	{},
 };
-MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
+MODULE_DEVICE_TABLE(of, renesas_sdhi_of_match);
 
-struct sh_mobile_sdhi {
+struct renesas_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
 	struct tmio_mmc_dma dma_priv;
@@ -145,13 +145,13 @@ struct sh_mobile_sdhi {
 	void __iomem *scc_ctl;
 };
 
-static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
+static void renesas_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 {
 	u32 val;
 
 	/*
 	 * see also
-	 *	sh_mobile_sdhi_of_data :: dma_buswidth
+	 *	renesas_sdhi_of_data :: dma_buswidth
 	 */
 	switch (sd_ctrl_read16(host, CTL_VERSION)) {
 	case SDHI_VER_GEN2_SDR50:
@@ -177,10 +177,10 @@ static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 	sd_ctrl_write16(host, EXT_ACC, val);
 }
 
-static int sh_mobile_sdhi_clk_enable(struct tmio_mmc_host *host)
+static int renesas_sdhi_clk_enable(struct tmio_mmc_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
-	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct renesas_sdhi *priv = host_to_priv(host);
 	int ret = clk_prepare_enable(priv->clk);
 	if (ret < 0)
 		return ret;
@@ -201,15 +201,15 @@ static int sh_mobile_sdhi_clk_enable(struct tmio_mmc_host *host)
 	mmc->f_min = max(clk_round_rate(priv->clk, 1) / 512, 1L);
 
 	/* enable 16bit data access on SDBUF as default */
-	sh_mobile_sdhi_sdbuf_width(host, 16);
+	renesas_sdhi_sdbuf_width(host, 16);
 
 	return 0;
 }
 
-static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
+static unsigned int renesas_sdhi_clk_update(struct tmio_mmc_host *host,
 					      unsigned int new_clock)
 {
-	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
 	int i, ret;
 
@@ -245,25 +245,25 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
 	return ret == 0 ? best_freq : clk_get_rate(priv->clk);
 }
 
-static void sh_mobile_sdhi_clk_disable(struct tmio_mmc_host *host)
+static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
 {
-	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct renesas_sdhi *priv = host_to_priv(host);
 
 	clk_disable_unprepare(priv->clk);
 }
 
-static int sh_mobile_sdhi_card_busy(struct mmc_host *mmc)
+static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
 	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
 }
 
-static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
+static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 						      struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct renesas_sdhi *priv = host_to_priv(host);
 	struct pinctrl_state *pin_state;
 	int ret;
 
@@ -314,21 +314,21 @@ static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
-				struct sh_mobile_sdhi *priv, int addr)
+				struct renesas_sdhi *priv, int addr)
 {
 	return readl(priv->scc_ctl + (addr << host->bus_shift));
 }
 
 static inline void sd_scc_write32(struct tmio_mmc_host *host,
-				  struct sh_mobile_sdhi *priv,
+				  struct renesas_sdhi *priv,
 				  int addr, u32 val)
 {
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
-static unsigned int sh_mobile_sdhi_init_tuning(struct tmio_mmc_host *host)
+static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 {
-	struct sh_mobile_sdhi *priv;
+	struct renesas_sdhi *priv;
 
 	priv = host_to_priv(host);
 
@@ -365,10 +365,10 @@ static unsigned int sh_mobile_sdhi_init_tuning(struct tmio_mmc_host *host)
 		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_MASK;
 }
 
-static void sh_mobile_sdhi_prepare_tuning(struct tmio_mmc_host *host,
+static void renesas_sdhi_prepare_tuning(struct tmio_mmc_host *host,
 					 unsigned long tap)
 {
-	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct renesas_sdhi *priv = host_to_priv(host);
 
 	/* Set sampling clock position */
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, tap);
@@ -376,9 +376,9 @@ static void sh_mobile_sdhi_prepare_tuning(struct tmio_mmc_host *host,
 
 #define SH_MOBILE_SDHI_MAX_TAP 3
 
-static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host)
+static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 {
-	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned long tap_cnt;  /* counter of tuning success */
 	unsigned long tap_set;  /* tap position */
 	unsigned long tap_start;/* start position of tuning success */
@@ -434,9 +434,9 @@ static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host)
 }
 
 
-static bool sh_mobile_sdhi_check_scc_error(struct tmio_mmc_host *host)
+static bool renesas_sdhi_check_scc_error(struct tmio_mmc_host *host)
 {
-	struct sh_mobile_sdhi *priv = host_to_priv(host);
+	struct renesas_sdhi *priv = host_to_priv(host);
 
 	/* Check SCC error */
 	if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL) &
@@ -451,9 +451,9 @@ static bool sh_mobile_sdhi_check_scc_error(struct tmio_mmc_host *host)
 	return false;
 }
 
-static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
+static void renesas_sdhi_hw_reset(struct tmio_mmc_host *host)
 {
-	struct sh_mobile_sdhi *priv;
+	struct renesas_sdhi *priv;
 
 	priv = host_to_priv(host);
 
@@ -477,7 +477,7 @@ static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
 }
 
-static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
+static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host)
 {
 	int timeout = 1000;
 
@@ -493,7 +493,7 @@ static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
 	return 0;
 }
 
-static int sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
+static int renesas_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 {
 	switch (addr)
 	{
@@ -506,13 +506,13 @@ static int sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 	case CTL_TRANSACTION_CTL:
 	case CTL_DMA_ENABLE:
 	case EXT_ACC:
-		return sh_mobile_sdhi_wait_idle(host);
+		return renesas_sdhi_wait_idle(host);
 	}
 
 	return 0;
 }
 
-static int sh_mobile_sdhi_multi_io_quirk(struct mmc_card *card,
+static int renesas_sdhi_multi_io_quirk(struct mmc_card *card,
 					 unsigned int direction, int blk_size)
 {
 	/*
@@ -530,18 +530,18 @@ static int sh_mobile_sdhi_multi_io_quirk(struct mmc_card *card,
 	return blk_size;
 }
 
-static void sh_mobile_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
+static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
 
 	/* enable 32bit access if DMA mode if possibile */
-	sh_mobile_sdhi_sdbuf_width(host, enable ? 32 : 16);
+	renesas_sdhi_sdbuf_width(host, enable ? 32 : 16);
 }
 
-static int sh_mobile_sdhi_probe(struct platform_device *pdev)
+static int renesas_sdhi_probe(struct platform_device *pdev)
 {
-	const struct sh_mobile_sdhi_of_data *of_data = of_device_get_match_data(&pdev->dev);
-	struct sh_mobile_sdhi *priv;
+	const struct renesas_sdhi_of_data *of_data = of_device_get_match_data(&pdev->dev);
+	struct renesas_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
@@ -553,7 +553,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (!res)
 		return -EINVAL;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct renesas_sdhi), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -593,18 +593,18 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	}
 
 	host->dma		= dma_priv;
-	host->write16_hook	= sh_mobile_sdhi_write16_hook;
-	host->clk_enable	= sh_mobile_sdhi_clk_enable;
-	host->clk_update	= sh_mobile_sdhi_clk_update;
-	host->clk_disable	= sh_mobile_sdhi_clk_disable;
-	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
+	host->write16_hook	= renesas_sdhi_write16_hook;
+	host->clk_enable	= renesas_sdhi_clk_enable;
+	host->clk_update	= renesas_sdhi_clk_update;
+	host->clk_disable	= renesas_sdhi_clk_disable;
+	host->multi_io_quirk	= renesas_sdhi_multi_io_quirk;
 
 	/* SDR speeds are only available on Gen2+ */
 	if (mmc_data->flags & TMIO_MMC_MIN_RCAR2) {
 		/* card_busy caused issues on r8a73a4 (pre-Gen2) CD-less SDHI */
-		host->card_busy	= sh_mobile_sdhi_card_busy;
+		host->card_busy	= renesas_sdhi_card_busy;
 		host->start_signal_voltage_switch =
-			sh_mobile_sdhi_start_signal_voltage_switch;
+			renesas_sdhi_start_signal_voltage_switch;
 	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -615,7 +615,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		*mmc_data = *mmd;
 
 	dma_priv->filter = shdma_chan_filter;
-	dma_priv->enable = sh_mobile_sdhi_enable_dma;
+	dma_priv->enable = renesas_sdhi_enable_dma;
 
 	mmc_data->alignment_shift = 1; /* 2-byte alignment */
 	mmc_data->capabilities |= MMC_CAP_MMC_HIGHSPEED;
@@ -647,7 +647,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (of_data && of_data->scc_offset &&
 	    (host->mmc->caps & MMC_CAP_UHS_SDR104 ||
 	     host->mmc->caps2 & MMC_CAP2_HS200_1_8V_SDR)) {
-		const struct sh_mobile_sdhi_scc *taps = of_data->taps;
+		const struct renesas_sdhi_scc *taps = of_data->taps;
 		bool hit = false;
 
 		host->mmc->caps |= MMC_CAP_HW_RESET;
@@ -665,11 +665,11 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 			dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
 
 		priv->scc_ctl = host->ctl + of_data->scc_offset;
-		host->init_tuning = sh_mobile_sdhi_init_tuning;
-		host->prepare_tuning = sh_mobile_sdhi_prepare_tuning;
-		host->select_tuning = sh_mobile_sdhi_select_tuning;
-		host->check_scc_error = sh_mobile_sdhi_check_scc_error;
-		host->hw_reset = sh_mobile_sdhi_hw_reset;
+		host->init_tuning = renesas_sdhi_init_tuning;
+		host->prepare_tuning = renesas_sdhi_prepare_tuning;
+		host->select_tuning = renesas_sdhi_select_tuning;
+		host->check_scc_error = renesas_sdhi_check_scc_error;
+		host->hw_reset = renesas_sdhi_hw_reset;
 	}
 
 	i = 0;
@@ -705,7 +705,7 @@ eprobe:
 	return ret;
 }
 
-static int sh_mobile_sdhi_remove(struct platform_device *pdev)
+static int renesas_sdhi_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -723,19 +723,19 @@ static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
 			NULL)
 };
 
-static struct platform_driver sh_mobile_sdhi_driver = {
+static struct platform_driver renesas_sdhi_driver = {
 	.driver		= {
 		.name	= "sh_mobile_sdhi",
 		.pm	= &tmio_mmc_dev_pm_ops,
-		.of_match_table = sh_mobile_sdhi_of_match,
+		.of_match_table = renesas_sdhi_of_match,
 	},
-	.probe		= sh_mobile_sdhi_probe,
-	.remove		= sh_mobile_sdhi_remove,
+	.probe		= renesas_sdhi_probe,
+	.remove		= renesas_sdhi_remove,
 };
 
-module_platform_driver(sh_mobile_sdhi_driver);
+module_platform_driver(renesas_sdhi_driver);
 
-MODULE_DESCRIPTION("SuperH Mobile SDHI driver");
+MODULE_DESCRIPTION("Renesas SDHI driver");
 MODULE_AUTHOR("Magnus Damm");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:sh_mobile_sdhi");
-- 
2.7.4
