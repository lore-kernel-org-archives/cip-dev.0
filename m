From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:03:02 +0100
Subject: [cip-dev] [PATCH 4.19.y 31/60] mmc: renesas_sdhi_internal_dmac: set
	scatter/gather max segment size
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-32-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

commit 54541815b43f4e49c82628bf28bbb31d86d2f58a upstream.

Fix warning when running with CONFIG_DMA_API_DEBUG_SG=y by allocating a
device_dma_parameters structure and filling in the max segment size. The
size used is the result of a discussion with Renesas hardware engineers
and unfortunately not found in the datasheet.

  renesas_sdhi_internal_dmac ee140000.sd: DMA-API: mapping sg segment
  longer than device claims to support [len=126976] [max=65536]

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
[wsa: simplified some logic after validating intended dma_parms life cycle
      and added comment]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 0129837..fb7adcb 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -311,12 +311,20 @@ static const struct soc_device_attribute gen3_soc_whitelist[] = {
 static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 {
 	const struct soc_device_attribute *soc = soc_device_match(gen3_soc_whitelist);
+	struct device *dev = &pdev->dev;
 
 	if (!soc)
 		return -ENODEV;
 
 	global_flags |= (unsigned long)soc->data;
 
+	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL);
+	if (!dev->dma_parms)
+		return -ENOMEM;
+
+	/* value is max of SD_SECCNT. Confirmed by HW engineers */
+	dma_set_max_seg_size(dev, 0xffffffff);
+
 	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
 }
 
-- 
2.7.4
