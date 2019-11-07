From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:59 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 30/83] mmc: sh_mobile_sdhi: properly
	document R-Car versions
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-31-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit a2a16c77a1a2c951b5930c3182e2737cb13e1a53 upstream.

Replace hardcoded values with meaningful names and document what we
know.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 814391b..62b6605 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -39,6 +39,12 @@
 
 #define EXT_ACC           0xe4
 
+#define SDHI_VER_GEN2_SDR50	0x490c
+/* very old datasheets said 0x490c for SDR104, too. They are wrong! */
+#define SDHI_VER_GEN2_SDR104	0xcb0d
+#define SDHI_VER_GEN3_SD	0xcc10
+#define SDHI_VER_GEN3_SDMMC	0xcd10
+
 #define host_to_priv(host) container_of((host)->pdata, struct sh_mobile_sdhi, mmc_data)
 
 struct sh_mobile_sdhi_of_data {
@@ -113,14 +119,14 @@ static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 	 *	sh_mobile_sdhi_of_data :: dma_buswidth
 	 */
 	switch (sd_ctrl_read16(host, CTL_VERSION)) {
-	case 0x490C:
+	case SDHI_VER_GEN2_SDR50:
 		val = (width == 32) ? 0x0001 : 0x0000;
 		break;
-	case 0xCB0D:
+	case SDHI_VER_GEN2_SDR104:
 		val = (width == 32) ? 0x0000 : 0x0001;
 		break;
-	case 0xCC10: /* Gen3, SD only */
-	case 0xCD10: /* Gen3, SD + MMC */
+	case SDHI_VER_GEN3_SD:
+	case SDHI_VER_GEN3_SDMMC:
 		if (width == 64)
 			val = 0x0000;
 		else if (width == 32)
-- 
2.7.4
