From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:48 +0100
Subject: [cip-dev] [PATCH 05/19] dmaengine: rcar-dmac: use result of updated
	get_residue in tx_status
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

The hardware might have complete the transfer but the interrupt handler
might not have had a chance to run. If rcar_dmac_chan_get_residue()
which reads HW registers finds that there is no residue return
DMA_COMPLETE.

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Niklas: add explanation in commit message]
Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>

(cherry picked from commit 3544d2878817bd139dda238cdd86a15e1c03d037)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index a5f38fa..e465aaf 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1202,6 +1202,10 @@ static enum dma_status rcar_dmac_tx_status(struct dma_chan *chan,
 	residue = rcar_dmac_chan_get_residue(rchan, cookie);
 	spin_unlock_irqrestore(&rchan->lock, flags);
 
+	/* if there's no residue, the cookie is complete */
+	if (!residue)
+		return DMA_COMPLETE;
+
 	dma_set_residue(txstate, residue);
 
 	return status;
-- 
2.7.4
