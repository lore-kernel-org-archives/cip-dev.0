From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:21 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 52/83] mmc: sh_mobile_sdhi: enable HS200
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-53-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit b1c95170f97ef19ff63a6da1eb2c70899186aecc upstream.

Setup tuning when the board is HS200 enabled.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index d851535..8e90670 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -650,7 +650,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto efree;
 
 	/* Enable tuning iff we have an SCC and a supported mode */
-	if (of_data && of_data->scc_offset && host->mmc->caps & MMC_CAP_UHS_SDR104) {
+	if (of_data && of_data->scc_offset &&
+	    (host->mmc->caps & MMC_CAP_UHS_SDR104 ||
+	     host->mmc->caps2 & MMC_CAP2_HS200_1_8V_SDR)) {
 		const struct sh_mobile_sdhi_scc *taps = of_data->taps;
 		bool hit = false;
 
-- 
2.7.4
