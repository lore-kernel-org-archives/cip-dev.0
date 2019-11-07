From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:38 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 09/83] mmc: sdhi: Add r8a7795 support
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit a72e8b170069e98e1f5ca2a2855ee399148a9152 upstream.

Registers are 64bit apart, so we refactor bus_shift handling a little and set
it based on the DT compatible. Also, EXT_ACC is different. It has been tested
on a Salvator-X (Gen3) and, to check for regressions, on a Lager (Gen2).

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[ Removed Kconfig changes, binding and compatible option ]
---
 drivers/mmc/host/sh_mobile_sdhi.c | 46 ++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index bf6c3ac..90d042d 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -1,6 +1,8 @@
 /*
  * SuperH Mobile SDHI
  *
+ * Copyright (C) 2016 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2015-16 Renesas Electronics Corporation
  * Copyright (C) 2009 Magnus Damm
  *
  * This program is free software; you can redistribute it and/or modify
@@ -43,6 +45,7 @@ struct sh_mobile_sdhi_of_data {
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
 	dma_addr_t dma_rx_offset;
+	unsigned bus_shift;
 };
 
 static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
@@ -65,6 +68,13 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 	.dma_rx_offset	= 0x2000,
 };
 
+static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_FAST_CLK_CHG,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED,
+	.bus_shift	= 2,
+};
+
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh7372" },
@@ -105,6 +115,15 @@ static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 	case 0xCB0D:
 		val = (width == 32) ? 0x0000 : 0x0001;
 		break;
+	case 0xCC10: /* Gen3, SD only */
+	case 0xCD10: /* Gen3, SD + MMC */
+		if (width == 64)
+			val = 0x0000;
+		else if (width == 32)
+			val = 0x0101;
+		else
+			val = 0x0001;
+		break;
 	default:
 		/* nothing to do */
 		return;
@@ -234,16 +253,26 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 	}
 
+	if (of_id && of_id->data) {
+		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
+
+		mmc_data->flags |= of_data->tmio_flags;
+		mmc_data->capabilities |= of_data->capabilities;
+		mmc_data->capabilities2 |= of_data->capabilities2;
+		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
+		dma_priv->dma_buswidth = of_data->dma_buswidth;
+		host->bus_shift = of_data->bus_shift;
+	}
+
 	host->dma		= dma_priv;
 	host->write16_hook	= sh_mobile_sdhi_write16_hook;
 	host->clk_enable	= sh_mobile_sdhi_clk_enable;
 	host->clk_disable	= sh_mobile_sdhi_clk_disable;
 	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
-	/* SD control register space size is 0x100, 0x200 for bus_shift=1 */
-	if (resource_size(res) > 0x100)
+
+	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
+	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
 		host->bus_shift = 1;
-	else
-		host->bus_shift = 0;
 
 	if (mmd)
 		*mmc_data = *mmd;
@@ -275,15 +304,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_QUIRK;
 
-	if (of_id && of_id->data) {
-		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
-		mmc_data->flags |= of_data->tmio_flags;
-		mmc_data->capabilities |= of_data->capabilities;
-		mmc_data->capabilities2 |= of_data->capabilities2;
-		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
-		dma_priv->dma_buswidth = of_data->dma_buswidth;
-	}
-
 	ret = tmio_mmc_host_probe(host, mmc_data);
 	if (ret < 0)
 		goto efree;
-- 
2.7.4
