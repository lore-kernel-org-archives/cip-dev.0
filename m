From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:35:52 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 13/31] mmc: sh_mobile_sdhi: improve
	prerequisite for hw_reset
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 6ade9a2c2da855ff38e74c4298976400feca968e upstream.

We need a SCC unit for hw_reset. Those units can only be described in
of_data. So, of_data and a valid SCC offset are prerequisites for
enabling the hw_reset capability. Merge the two 'if' conditions into one
and add a check for an scc offset.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 9af62dd..9bf1f5e 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -665,27 +665,25 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto efree;
 
-	if (host->mmc->caps & MMC_CAP_UHS_SDR104) {
+	if (of_data && of_data->scc_offset && host->mmc->caps & MMC_CAP_UHS_SDR104) {
+		const struct sh_mobile_sdhi_scc *taps = of_data->taps;
+		bool hit = false;
+
 		host->mmc->caps |= MMC_CAP_HW_RESET;
 
-		if (of_data) {
-			const struct sh_mobile_sdhi_scc *taps = of_data->taps;
-			bool hit = false;
-
-			for (i = 0; i < of_data->taps_num; i++) {
-				if (taps[i].clk_rate == 0 ||
-				    taps[i].clk_rate == host->mmc->f_max) {
-					host->scc_tappos = taps->tap;
-					hit = true;
-					break;
-				}
+		for (i = 0; i < of_data->taps_num; i++) {
+			if (taps[i].clk_rate == 0 ||
+			    taps[i].clk_rate == host->mmc->f_max) {
+				host->scc_tappos = taps->tap;
+				hit = true;
+				break;
 			}
+		}
 
-			if (!hit)
-				dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
+		if (!hit)
+			dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
 
-			priv->scc_ctl = host->ctl + of_data->scc_offset;
-		}
+		priv->scc_ctl = host->ctl + of_data->scc_offset;
 	}
 
 	i = 0;
-- 
2.7.4
