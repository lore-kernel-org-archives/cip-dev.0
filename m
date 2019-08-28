From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:06 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 19/57] serial: sh-sci: Fix crash in
	rx_timer_fn() on PIO fallback
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-20-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 2e948218b7c1262a3830823d6620eb227e3d4e3a upstream.

When falling back to PIO, active_rx must be set to a different value
than cookie_rx[i], else sci_dma_rx_find_active() will incorrectly find a
match, leading to a NULL pointer dereference in rx_timer_fn() later.

Use zero instead, which is the same value as after driver
initialization.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5550289..9e1a6af 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1359,7 +1359,7 @@ static int sci_submit_rx(struct sci_port *s, bool port_lock_held)
 		dmaengine_terminate_async(chan);
 	for (i = 0; i < 2; i++)
 		s->cookie_rx[i] = -EINVAL;
-	s->active_rx = -EINVAL;
+	s->active_rx = 0;
 	s->chan_rx = NULL;
 	sci_start_rx(port);
 	if (!port_lock_held)
-- 
2.7.4
