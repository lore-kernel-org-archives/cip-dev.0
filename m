From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:35:53 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 14/31] mmc: sh_mobile_sdhi: remove
	superfluous check in hw_reset
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 97c64b2cd57608f7064810780056d17944f49128 upstream.

The capability for HW_RESET is only activated if SDR104 is present, so
no need to check for SDR104 in the function itself again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 9bf1f5e..d3d1db0 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -468,9 +468,6 @@ static void sh_mobile_sdhi_hw_reset(struct tmio_mmc_host *host)
 {
 	struct sh_mobile_sdhi *priv;
 
-	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
-		return;
-
 	priv = host_to_priv(host);
 
 	/* Reset SCC */
-- 
2.7.4
