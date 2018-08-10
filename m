From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:51 +0100
Subject: [cip-dev] [PATCH 08/19] dmaengine: rcar-dmac: Fix residue reporting
	for pending descriptors
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Cookies corresponding to pending transfers have a residue value equal to
the full size of the corresponding descriptor. The driver miscomputes
that and uses the size of the active descriptor instead. Fix it.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[geert: Also check desc.active list]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit 55bd582b4d8c2266bc43cbae2ddfce31b489618f)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 0ba6b8c..7ad7b2f 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1145,6 +1145,7 @@ static unsigned int rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
 	struct rcar_dmac_desc *desc = chan->desc.running;
 	struct rcar_dmac_xfer_chunk *running = NULL;
 	struct rcar_dmac_xfer_chunk *chunk;
+	enum dma_status status;
 	unsigned int residue = 0;
 	unsigned int dptr = 0;
 
@@ -1152,12 +1153,38 @@ static unsigned int rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
 		return 0;
 
 	/*
+	 * If the cookie corresponds to a descriptor that has been completed
+	 * there is no residue. The same check has already been performed by the
+	 * caller but without holding the channel lock, so the descriptor could
+	 * now be complete.
+	 */
+	status = dma_cookie_status(&chan->chan, cookie, NULL);
+	if (status == DMA_COMPLETE)
+		return 0;
+
+	/*
 	 * If the cookie doesn't correspond to the currently running transfer
 	 * then the descriptor hasn't been processed yet, and the residue is
 	 * equal to the full descriptor size.
 	 */
-	if (cookie != desc->async_tx.cookie)
-		return desc->size;
+	if (cookie != desc->async_tx.cookie) {
+		list_for_each_entry(desc, &chan->desc.pending, node) {
+			if (cookie == desc->async_tx.cookie)
+				return desc->size;
+		}
+		list_for_each_entry(desc, &chan->desc.active, node) {
+			if (cookie == desc->async_tx.cookie)
+				return desc->size;
+		}
+
+		/*
+		 * No descriptor found for the cookie, there's thus no residue.
+		 * This shouldn't happen if the calling driver passes a correct
+		 * cookie value.
+		 */
+		WARN(1, "No descriptor for cookie!");
+		return 0;
+	}
 
 	/*
 	 * In descriptor mode the descriptor running pointer is not maintained
-- 
2.7.4
