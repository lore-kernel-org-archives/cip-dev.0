From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:52 +0100
Subject: [cip-dev] [PATCH 09/19] dmaengine: rcar-dmac: ensure CHCR DE bit is
	actually 0 after clearing
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-10-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMAC reads data from source device, and buffered it until transferable
size for sink device. Because of this behavior, DMAC is including
buffered data .

Now, CHCR DE bit is controlling DMA transfer enable/disable.

If DE bit was cleared during data transferring, or during buffering,
it will flush buffered data if source device was peripheral device
(The buffered data will be removed if source device was memory).
Because of this behavior, driver should ensure that DE bit is actually
0 after clearing.

This patch adds new rcar_dmac_chcr_de_barrier() and call it after CHCR
register access.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Tested-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit a8d46a7f5d17ca9cbe9e9c7d1d23dc6ea437e141)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/dma/sh/rcar-dmac.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 7ad7b2f..15b9751dc 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -716,6 +717,24 @@ static int rcar_dmac_fill_hwdesc(struct rcar_dmac_chan *chan,
 /* -----------------------------------------------------------------------------
  * Stop and reset
  */
+static void rcar_dmac_chcr_de_barrier(struct rcar_dmac_chan *chan)
+{
+	u32 chcr;
+	unsigned int i;
+
+	/*
+	 * Ensure that the setting of the DE bit is actually 0 after
+	 * clearing it.
+	 */
+	for (i = 0; i < 1024; i++) {
+		chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
+		if (!(chcr & RCAR_DMACHCR_DE))
+			return;
+		udelay(1);
+	}
+
+	dev_err(chan->chan.device->dev, "CHCR DE check error\n");
+}
 
 static void rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
 {
@@ -724,6 +743,7 @@ static void rcar_dmac_chan_halt(struct rcar_dmac_chan *chan)
 	chcr &= ~(RCAR_DMACHCR_DSE | RCAR_DMACHCR_DSIE | RCAR_DMACHCR_IE |
 		  RCAR_DMACHCR_TE | RCAR_DMACHCR_DE);
 	rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr);
+	rcar_dmac_chcr_de_barrier(chan);
 }
 
 static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
@@ -1373,6 +1393,8 @@ static irqreturn_t rcar_dmac_isr_channel(int irq, void *dev)
 	if (chcr & RCAR_DMACHCR_TE)
 		mask |= RCAR_DMACHCR_DE;
 	rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr & ~mask);
+	if (mask & RCAR_DMACHCR_DE)
+		rcar_dmac_chcr_de_barrier(chan);
 
 	if (chcr & RCAR_DMACHCR_DSE)
 		ret |= rcar_dmac_isr_desc_stage_end(chan);
-- 
2.7.4
