From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:50 +0100
Subject: [cip-dev] [PATCH 07/19] dmaengine: rcar-dmac: Fixed active
	descriptor initializing
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-8-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

Running descriptor pointer is set to NULL upon freeing resources. Other-
wise, rcar_dmac_issue_pending might not start new transfers

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit 48c73659abae103a2f8531f825ce7a3f8dedbb39)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 8959262..0ba6b8c 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -990,6 +990,8 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
 	list_splice_init(&rchan->desc.done, &list);
 	list_splice_init(&rchan->desc.wait, &list);
 
+	rchan->desc.running = NULL;
+
 	list_for_each_entry(desc, &list, node)
 		rcar_dmac_realloc_hwdesc(rchan, desc, 0);
 
-- 
2.7.4
