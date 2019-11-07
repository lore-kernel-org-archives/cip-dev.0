From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:15 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 46/83] mmc: sh_mobile_sdhi: simplify
	accessing DT data
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-47-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit dc9f1a8d790ee766c47eca163261225680691e64 upstream.

By using the helper of_device_get_match_data(), we can skip some
checking and make the code simpler.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index d1ec75c..9af62dd 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -555,8 +555,7 @@ static void sh_mobile_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
 
 static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
+	const struct sh_mobile_sdhi_of_data *of_data = of_device_get_match_data(&pdev->dev);
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
 	struct tmio_mmc_data *mmd = pdev->dev.platform_data;
@@ -597,9 +596,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 	}
 
-	if (of_id && of_id->data) {
-		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
 
+	if (of_data) {
 		mmc_data->flags |= of_data->tmio_flags;
 		mmc_data->ocr_mask = of_data->tmio_ocr_mask;
 		mmc_data->capabilities |= of_data->capabilities;
@@ -670,14 +668,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (host->mmc->caps & MMC_CAP_UHS_SDR104) {
 		host->mmc->caps |= MMC_CAP_HW_RESET;
 
-		if (of_id && of_id->data) {
-			const struct sh_mobile_sdhi_of_data *of_data;
-			const struct sh_mobile_sdhi_scc *taps;
+		if (of_data) {
+			const struct sh_mobile_sdhi_scc *taps = of_data->taps;
 			bool hit = false;
 
-			of_data = of_id->data;
-			taps = of_data->taps;
-
 			for (i = 0; i < of_data->taps_num; i++) {
 				if (taps[i].clk_rate == 0 ||
 				    taps[i].clk_rate == host->mmc->f_max) {
-- 
2.7.4
