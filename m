From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:02:53 +0100
Subject: [cip-dev] [PATCH 4.19.y 22/60] serial: sh-sci: Extract
	sci_dma_rx_chan_invalidate()
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-23-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 11b3770d54b28dcd905155a6d4aa551187ff00eb upstream.

The cookies and channel pointer for the DMA receive channel are
invalidated in two places, and one more is planned.
Extract this functionality in a common helper.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9e1a6af..2632bb2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1233,12 +1233,22 @@ static int sci_dma_rx_find_active(struct sci_port *s)
 	return -1;
 }
 
+static void sci_dma_rx_chan_invalidate(struct sci_port *s)
+{
+	unsigned int i;
+
+	s->chan_rx = NULL;
+	for (i = 0; i < ARRAY_SIZE(s->cookie_rx); i++)
+		s->cookie_rx[i] = -EINVAL;
+	s->active_rx = 0;
+}
+
 static void sci_rx_dma_release(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_rx_saved;
 
-	s->chan_rx_saved = s->chan_rx = NULL;
-	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
+	s->chan_rx_saved = NULL;
+	sci_dma_rx_chan_invalidate(s);
 	dmaengine_terminate_sync(chan);
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
@@ -1357,10 +1367,7 @@ static int sci_submit_rx(struct sci_port *s, bool port_lock_held)
 		spin_lock_irqsave(&port->lock, flags);
 	if (i)
 		dmaengine_terminate_async(chan);
-	for (i = 0; i < 2; i++)
-		s->cookie_rx[i] = -EINVAL;
-	s->active_rx = 0;
-	s->chan_rx = NULL;
+	sci_dma_rx_chan_invalidate(s);
 	sci_start_rx(port);
 	if (!port_lock_held)
 		spin_unlock_irqrestore(&port->lock, flags);
-- 
2.7.4
