From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 13:00:39 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 09/17] mmc: renesas_sdhi: consolidate
	DMAC CONFIG options
In-Reply-To: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
References: <1574341247-46652-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574341247-46652-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit c813e10a6bbad9ef56bc115c64d48c5a7d0a7dd5 upstream.

The description in the Makefile is odd.  Fix the CONFIG selection
in a cleaner way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/Kconfig  | 4 ++--
 drivers/mmc/host/Makefile | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 54d98ee..7b947ce 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -563,8 +563,6 @@ config MMC_SDHI
 	depends on SUPERH || ARM
 	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	select MMC_TMIO_CORE
-	select MMC_SDHI_SYS_DMAC if (SUPERH || ARM)
-	select MMC_SDHI_INTERNAL_DMAC if ARM64
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  Renesas SuperH, ARM and ARM64 based SoCs
@@ -572,6 +570,7 @@ config MMC_SDHI
 config MMC_SDHI_SYS_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
 	depends on MMC_SDHI
+	default MMC_SDHI if (SUPERH || ARM)
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
 	  using SYS-DMAC via DMA Engine. This supports the controllers
@@ -581,6 +580,7 @@ config MMC_SDHI_INTERNAL_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
 	depends on ARM64 || COMPILE_TEST
 	depends on MMC_SDHI
+	default MMC_SDHI if ARM64
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
 	  using on-chip bus mastering. This supports the controllers
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index f10bb0c..5de0c72 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -37,12 +37,8 @@ obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_core.o
-ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_SYS_DMAC)),y)
-obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_sys_dmac.o
-endif
-ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_INTERNAL_DMAC)),y)
-obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_internal_dmac.o
-endif
+obj-$(CONFIG_MMC_SDHI_SYS_DMAC)		+= renesas_sdhi_sys_dmac.o
+obj-$(CONFIG_MMC_SDHI_INTERNAL_DMAC)	+= renesas_sdhi_internal_dmac.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
-- 
2.7.4
