From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:33 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 64/83] mmc: tmio: drop filenames from
	comment at top of source
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-65-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit b21f13d8f7bf1b65b2e5396fbd8bfb857627b666 upstream.

Reshuffle the comment at the top of the source
dropping filenames and moving up human readable strings.

This seems to be somewhat more useful information to start the
source file with. It is also less fragile, f.e. to file renames.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.c     | 8 +++-----
 drivers/mmc/host/tmio_mmc.h     | 7 +++----
 drivers/mmc/host/tmio_mmc_dma.c | 4 +---
 drivers/mmc/host/tmio_mmc_pio.c | 8 +++-----
 4 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e897e7f..ff14311 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -1,5 +1,7 @@
 /*
- * linux/drivers/mmc/host/tmio_mmc.c
+ * Driver for the MMC / SD / SDIO cell found in:
+ *
+ * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  *
  * Copyright (C) 2007 Ian Molton
  * Copyright (C) 2004 Ian Molton
@@ -7,10 +9,6 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * Driver for the MMC / SD / SDIO cell found in:
- *
- * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  */
 
 #include <linux/device.h>
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 3164e7c..d01776e 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -1,5 +1,7 @@
 /*
- * linux/drivers/mmc/host/tmio_mmc.h
+ * Driver for the MMC / SD / SDIO cell found in:
+ *
+ * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  *
  * Copyright (C) 2016 Sang Engineering, Wolfram Sang
  * Copyright (C) 2015-16 Renesas Electronics Corporation
@@ -10,9 +12,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Driver for the MMC / SD / SDIO cell found in:
- *
- * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  */
 
 #ifndef TMIO_MMC_H
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index cef1eb4..f668441 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -1,13 +1,11 @@
 /*
- * linux/drivers/mmc/tmio_mmc_dma.c
+ * DMA function for TMIO MMC implementations
  *
  * Copyright (C) 2010-2011 Guennadi Liakhovetski
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
- *
- * DMA function for TMIO MMC implementations
  */
 
 #include <linux/device.h>
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 4764f96..9b95158 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1,5 +1,7 @@
 /*
- * linux/drivers/mmc/host/tmio_mmc_pio.c
+ * Driver for the MMC / SD / SDIO IP found in:
+ *
+ * TC6393XB, TC6391XB, TC6387XB, T7L66XB, ASIC3, SH-Mobile SoCs
  *
  * Copyright (C) 2016 Sang Engineering, Wolfram Sang
  * Copyright (C) 2015-16 Renesas Electronics Corporation
@@ -11,10 +13,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Driver for the MMC / SD / SDIO IP found in:
- *
- * TC6393XB, TC6391XB, TC6387XB, T7L66XB, ASIC3, SH-Mobile SoCs
- *
  * This driver draws mainly on scattered spec sheets, Reverse engineering
  * of the toshiba e800  SD driver and some parts of the 2.4 ASIC3 driver (4 bit
  * support). (Further 4 bit support from a later datasheet).
-- 
2.7.4
