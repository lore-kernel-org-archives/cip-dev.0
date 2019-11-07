From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:18 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 49/83] mmc: sh_mobile_sdhi: improve
	prerequisites for tuning
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-50-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit e831ead3b3ddc4227cef10dc63d919fd7242d7b8 upstream.

Prerequisites for tuning are the same as for hw_reset. We need an SCC
and a supported mode. Populate the tuning related functions only when
those conditions are met. This also removes a tiny race window.
Previously, the functions were populated when the SCC offset was not
initialized which could have led to an OOPS.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index d3d1db0..30956c7 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -617,11 +617,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		host->card_busy	= sh_mobile_sdhi_card_busy;
 		host->start_signal_voltage_switch =
 			sh_mobile_sdhi_start_signal_voltage_switch;
-		host->init_tuning	= sh_mobile_sdhi_init_tuning;
-		host->prepare_tuning	= sh_mobile_sdhi_prepare_tuning;
-		host->select_tuning	= sh_mobile_sdhi_select_tuning;
-		host->check_scc_error	= sh_mobile_sdhi_check_scc_error;
-		host->hw_reset		= sh_mobile_sdhi_hw_reset;
 	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -662,6 +657,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto efree;
 
+	/* Enable tuning iff we have an SCC and a supported mode */
 	if (of_data && of_data->scc_offset && host->mmc->caps & MMC_CAP_UHS_SDR104) {
 		const struct sh_mobile_sdhi_scc *taps = of_data->taps;
 		bool hit = false;
@@ -681,6 +677,11 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 			dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
 
 		priv->scc_ctl = host->ctl + of_data->scc_offset;
+		host->init_tuning = sh_mobile_sdhi_init_tuning;
+		host->prepare_tuning = sh_mobile_sdhi_prepare_tuning;
+		host->select_tuning = sh_mobile_sdhi_select_tuning;
+		host->check_scc_error = sh_mobile_sdhi_check_scc_error;
+		host->hw_reset = sh_mobile_sdhi_hw_reset;
 	}
 
 	i = 0;
-- 
2.7.4
