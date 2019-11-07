From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:48 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 79/83] mmc: renesas_sdhi: Add r8a77470
	SDHI1 support
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-80-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 60ab43ba6b6e0f888aab3ce0f84a8aaf15d15079 upstream.

The RZ/G1C (a.k.a. R8A77470) comes with three SDHI interfaces,
SDHI0 and SDHI2 are compatible with the R-Car Gen2 SDHIs, SDHI1
is compatible with R-Car Gen3 SDHIs and it can be used as
eMMC as well. This patch adds driver compatibility, and makes
sure both drivers get compiled for the R8A77470.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[ Removed reset and updated clk and power domain properties ]
---
 drivers/mmc/host/Kconfig                      | 4 ++--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7b947ce..359ec493 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -578,9 +578,9 @@ config MMC_SDHI_SYS_DMAC
 
 config MMC_SDHI_INTERNAL_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
-	depends on ARM64 || COMPILE_TEST
+	depends on ARM64 || ARCH_R8A77470 || COMPILE_TEST
 	depends on MMC_SDHI
-	default MMC_SDHI if ARM64
+	default MMC_SDHI if (ARM64 || ARCH_R8A77470)
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
 	  using on-chip bus mastering. This supports the controllers
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index d41ff35..8056325 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -84,6 +84,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
 };
 
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
+	{ .compatible = "renesas,sdhi-mmc-r8a77470", .data = &of_rcar_gen3_compatible, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
-- 
2.7.4
