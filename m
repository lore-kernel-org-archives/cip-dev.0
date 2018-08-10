From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:47 +0100
Subject: [cip-dev] [PATCH 04/19] dmaengine: rcar-dmac: use list_add() on
	rcar_dmac_desc_put()
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

For each descriptor, in addition to the memory used by the descriptors
structure itself, the driver allocates a list of chunks as well as a
buffer for hardware descriptors. Descriptors themselves are preallocated,
and allocation of the chunks and buffer is performed the first time the
descriptor is used. The memory isn't freed when the transfer is completed,
as the chunks and buffer will be needed again when the descriptor is
reused internally, so the driver keeps the memory around.

If only a few descriptors are used concurrently, the current
list_add_tail() implementation will result in all preallocated descriptors
being used before going back to the first one, and will thus allocate
chunks and a buffer for all preallocated descriptors. Using list_add()
will put the complete descriptor at the head of the list of available
descriptors, so the next transfer will be more likely to reuse a
descriptor that already has associated memory instead of one that has
never been used before.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit 3565fe53334cd3f0d59ff5db0872de9370775a19)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 115ddaa..a5f38fa 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -510,7 +510,7 @@ static void rcar_dmac_desc_put(struct rcar_dmac_chan *chan,
 
 	spin_lock_irqsave(&chan->lock, flags);
 	list_splice_tail_init(&desc->chunks, &chan->desc.chunks_free);
-	list_add_tail(&desc->node, &chan->desc.free);
+	list_add(&desc->node, &chan->desc.free);
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
-- 
2.7.4
