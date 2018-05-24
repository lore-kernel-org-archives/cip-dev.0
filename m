From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 May 2018 17:05:09 +0100
Subject: [cip-dev] [RFC PATCH 6/7] dmaengine: usb-dmac: fix endless loop in
	usb_dmac_chan_terminate_all()
In-Reply-To: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527177910-65275-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch fixes an issue that list_for_each_entry() in
usb_dmac_chan_terminate_all() is possible to cause endless loop because
this will move own desc to the desc_freed. So, this driver should use
list_for_each_entry_safe() instead of list_for_each_entry().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit d9f5efade2cfd729138a7cafb46d01044da40f5e)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/dma/sh/usb-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 56410ea..6682b3e 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -448,7 +448,7 @@ usb_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
 {
 	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
-	struct usb_dmac_desc *desc;
+	struct usb_dmac_desc *desc, *_desc;
 	unsigned long flags;
 	LIST_HEAD(head);
 	LIST_HEAD(list);
@@ -459,7 +459,7 @@ static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
 	if (uchan->desc)
 		uchan->desc = NULL;
 	list_splice_init(&uchan->desc_got, &list);
-	list_for_each_entry(desc, &list, node)
+	list_for_each_entry_safe(desc, _desc, &list, node)
 		list_move_tail(&desc->node, &uchan->desc_freed);
 	spin_unlock_irqrestore(&uchan->vc.lock, flags);
 	vchan_dma_desc_free_list(&uchan->vc, &head);
-- 
2.7.4
