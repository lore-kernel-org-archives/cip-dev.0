From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 13:35:41 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/31] mmc: sh_mobile_sdhi: add ocr_mask
	option
In-Reply-To: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574170570-15179-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Chris Brandt <chris.brandt@renesas.com>

commit f19417f38264f9a2f7b4627aa4060133c237b211 upstream.

In moving platforms from board files to DT, there still needs to be a way
to set the ocr_mask setting for the tmio driver during probe. Without this
setting, the probe will fail because the supported voltages are not known.

This patch will also traditional platform registration platforms to
migrate to DT.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 3d186cc..9124246 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -49,6 +49,7 @@
 
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
+	u32	      tmio_ocr_mask;
 	unsigned long capabilities;
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
@@ -370,6 +371,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
 
 		mmc_data->flags |= of_data->tmio_flags;
+		mmc_data->ocr_mask = of_data->tmio_ocr_mask;
 		mmc_data->capabilities |= of_data->capabilities;
 		mmc_data->capabilities2 |= of_data->capabilities2;
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
-- 
2.7.4
