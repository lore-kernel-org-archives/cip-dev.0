From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:19 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 50/83] mmc: sh_mobile_sdhi: remove
	superfluous check in SCC error check
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-51-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 03c5b0d90300fc725fc1fb644872b522483a2d7e upstream.

The function will only be available if SDR104 was detected in probe,
so no need to check in the function itself again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 30956c7..59cc513 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -444,12 +444,7 @@ static int sh_mobile_sdhi_select_tuning(struct tmio_mmc_host *host)
 
 static bool sh_mobile_sdhi_check_scc_error(struct tmio_mmc_host *host)
 {
-	struct sh_mobile_sdhi *priv;
-
-	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
-		return 0;
-
-	priv = host_to_priv(host);
+	struct sh_mobile_sdhi *priv = host_to_priv(host);
 
 	/* Check SCC error */
 	if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL) &
-- 
2.7.4
