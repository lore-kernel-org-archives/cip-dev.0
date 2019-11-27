From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:44 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 06/22] mmc: tmio: rename tmio_mmc_{pio
	=> core}.c
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 426e95d1766bad20e59f219af64fdd50c39bcfee upstream.

Rename tmio_mmc_pio.c to tmio_mmc_core.c to more accurately reflect its
function: to provide core code for the tmio-mmc and sh-mobole-sdhi drivers.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/Makefile                            | 1 -
 drivers/mmc/host/{tmio_mmc_pio.c => tmio_mmc_core.c} | 0
 2 files changed, 1 deletion(-)
 rename drivers/mmc/host/{tmio_mmc_pio.c => tmio_mmc_core.c} (100%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index bf399b8..2b75a43 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_MMC_S3C)   	+= s3cmci.o
 obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
-tmio_mmc_core-y			:= tmio_mmc_pio.o
 obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o tmio_mmc_dma.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_core.c
similarity index 100%
rename from drivers/mmc/host/tmio_mmc_pio.c
rename to drivers/mmc/host/tmio_mmc_core.c
-- 
2.7.4
