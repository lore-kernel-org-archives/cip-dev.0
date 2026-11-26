Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15967.1795706534297540251
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B28B60E87;
	Thu, 26 Nov 2026 15:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03EE1F000C4;
	Thu, 26 Nov 2026 15:22:11 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 04/27] dmaengine: sh: rz-dmac: Protect the driver specific lists
Date: Thu, 26 Nov 2026 17:21:40 +0200
Message-ID: <20261126152204.1297798-5-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25114
Content-Type: text/plain; charset="utf-8"

commit abb863e6213dc41a58ef8bb3289b7e77460dabf3 upstream.

The driver lists (ld_free, ld_queue) are used in
rz_dmac_free_chan_resources(), rz_dmac_terminate_all(),
rz_dmac_issue_pending(), and rz_dmac_irq_handler_thread(), all under
the virtual channel lock. Take the same lock in rz_dmac_prep_slave_sg()
and rz_dmac_prep_dma_memcpy() as well to avoid concurrency issues, since
these functions also check whether the lists are empty and update or
remove list entries.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-2-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: replaced scoped_guard() with
 spin_lock_irqsave()/spin_unlock_irqrestore()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 3115ff2ab595..70410def8181 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -10,6 +10,7 @@
  */
=20
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
@@ -423,6 +424,7 @@ static int rz_dmac_alloc_chan_resources(struct dma_ch=
an *chan)
 		if (!desc)
 			break;
=20
+		/* No need to lock. This is called only for the 1st client. */
 		list_add_tail(&desc->node, &channel->ld_free);
 		channel->descs_allocated++;
 	}
@@ -474,12 +476,17 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_=
addr_t dest, dma_addr_t src,
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	struct rz_dmac_desc *desc;
+	unsigned long lock_flags;
=20
 	dev_dbg(dmac->dev, "%s channel: %d src=3D0x%pad dst=3D0x%pad len=3D%zu\=
n",
 		__func__, channel->index, &src, &dest, len);
=20
-	if (list_empty(&channel->ld_free))
+	spin_lock_irqsave(&channel->vc.lock, lock_flags);
+
+	if (list_empty(&channel->ld_free)) {
+		spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
 		return NULL;
+	}
=20
 	desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc, node)=
;
=20
@@ -490,6 +497,9 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_ad=
dr_t dest, dma_addr_t src,
 	desc->direction =3D DMA_MEM_TO_MEM;
=20
 	list_move_tail(channel->ld_free.next, &channel->ld_queue);
+
+	spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
+
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
=20
@@ -501,12 +511,17 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct=
 scatterlist *sgl,
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
 	struct rz_dmac_desc *desc;
+	unsigned long lock_flags;
 	struct scatterlist *sg;
 	int dma_length =3D 0;
 	int i =3D 0;
=20
-	if (list_empty(&channel->ld_free))
+	spin_lock_irqsave(&channel->vc.lock, lock_flags);
+
+	if (list_empty(&channel->ld_free)) {
+		spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
 		return NULL;
+	}
=20
 	desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc, node)=
;
=20
@@ -526,6 +541,9 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
 		desc->dest =3D channel->dst_per_address;
=20
 	list_move_tail(channel->ld_free.next, &channel->ld_queue);
+
+	spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
+
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
=20
--=20
2.43.0

