From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:35:56 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 17/31] mmc: sh_mobile_sdhi: remove
	superfluous check in init_tuning
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 7f9096f1c89ea698c22fde91285de2ef3eabd614 upstream.

The function will only be available if SDR104 was detected in probe,
so no need to check in the function itself again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 59cc513..d851535 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -335,9 +335,6 @@ static unsigned int sh_mobile_sdhi_init_tuning(struct tmio_mmc_host *host)
 {
 	struct sh_mobile_sdhi *priv;
 
-	if (!(host->mmc->caps & MMC_CAP_UHS_SDR104))
-		return 0;
-
 	priv = host_to_priv(host);
 
 	/* set sampling clock selection range */
-- 
2.7.4
