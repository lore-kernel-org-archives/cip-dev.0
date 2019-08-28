From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:09 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 22/57] serial: sh-sci: Fix fallback
	to PIO in sci_dma_rx_complete()
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-23-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 26f073993665683f1debf4d66d8bc274ac6df771 upstream.

When submitting a DMA request fails in sci_dma_rx_complete(), the driver
tries to fall back to PIO, but that does not work: no more data will be
received, or the kernel will even crash.

Fix this similar as in (but not identical to) sci_submit_rx():
  - On SCIF, PIO cannot take over if any DMA transactions are pending,
    hence they must be terminated first.
  - All active cookies must be invalidated, else rx_timer_fn() may
    trigger a NULL pointer dereference.
  - Restarting the port is not needed, as it is already running, but
    serial port interrupts must be directed back from the DMA engine to
    the CPU.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d5bd3f7..29dce54 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1327,8 +1327,9 @@ static void sci_dma_rx_complete(void *arg)
 	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 	/* Switch to PIO */
 	spin_lock_irqsave(&port->lock, flags);
-	s->chan_rx = NULL;
-	sci_start_rx(port);
+	dmaengine_terminate_async(chan);
+	sci_dma_rx_chan_invalidate(s);
+	sci_dma_rx_reenable_irq(s);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-- 
2.7.4
