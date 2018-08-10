From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:49 +0100
Subject: [cip-dev] [PATCH 06/19] dmaengine: rcar-dmac: warn if transfer
	cannot start as TE = 1
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

The documentation states one should make sure both DE and TE are cleared
before starting a transaction. This patch extends the current warning to
look at both DE and TE.

Based on previous work from Muhammad Hamza Farooq.

Suggested-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit 0f78e3b58f5f99c991613db4477f893b53da5520)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index e465aaf..8959262 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -311,7 +311,7 @@ static bool rcar_dmac_chan_is_busy(struct rcar_dmac_chan *chan)
 {
 	u32 chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
 
-	return (chcr & (RCAR_DMACHCR_DE | RCAR_DMACHCR_TE)) == RCAR_DMACHCR_DE;
+	return !!(chcr & (RCAR_DMACHCR_DE | RCAR_DMACHCR_TE));
 }
 
 static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
-- 
2.7.4
