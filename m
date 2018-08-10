From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:46 +0100
Subject: [cip-dev] [PATCH 03/19] dmaengine: rcar-dmac: clear pertinence
	number of channels
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMACHCLR clears each channels, but its channel number is based on
its SoC or IP. Current driver is using fixed 0x7fff (= for 15ch),
it is not good match for Gen3 or Gen2 Audio DMAC. This patch fixes it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit 20c169aceb459575681c4f4578d0e312bd1436c1)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 2b36d1c..115ddaa 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -413,7 +413,7 @@ static int rcar_dmac_init(struct rcar_dmac *dmac)
 	u16 dmaor;
 
 	/* Clear all channels and enable the DMAC globally. */
-	rcar_dmac_write(dmac, RCAR_DMACHCLR, 0x7fff);
+	rcar_dmac_write(dmac, RCAR_DMACHCLR, GENMASK(dmac->n_channels - 1, 0));
 	rcar_dmac_write(dmac, RCAR_DMAOR,
 			RCAR_DMAOR_PRI_FIXED | RCAR_DMAOR_DME);
 
-- 
2.7.4
