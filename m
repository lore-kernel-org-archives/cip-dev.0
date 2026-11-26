Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15972.1795706541687298922
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7CF8F4484D;
	Thu, 26 Nov 2026 15:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9431F000C0;
	Thu, 26 Nov 2026 15:22:19 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/27] dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate descriptors
Date: Thu, 26 Nov 2026 17:21:45 +0200
Message-ID: <20261126152204.1297798-10-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25119
Content-Type: text/plain; charset="utf-8"

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit bfaa60be647842cece968769f208e57fa5dee594 upstream.

rz_lmdesc_setup() invalidates DMA descriptors more comprehensively.
It resets the base, head, and tail pointers of the descriptor list and
clears the descriptor headers and their NXLA pointers. Use
rz_lmdesc_setup() instead of open-coding parts of its logic.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260316133252.240348-7-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index a16828509ba5..585c6c597de0 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -431,15 +431,12 @@ static void rz_dmac_free_chan_resources(struct dma_=
chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
 	struct rz_dmac_desc *desc, *_desc;
 	unsigned long flags;
-	unsigned int i;
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
=20
-	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
-		lmdesc[i].header =3D 0;
+	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
 	rz_dmac_disable_hw(channel);
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
@@ -542,15 +539,12 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct=
 scatterlist *sgl,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
-	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
 	unsigned long flags;
-	unsigned int i;
 	LIST_HEAD(head);
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
 	rz_dmac_disable_hw(channel);
-	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
-		lmdesc[i].header =3D 0;
+	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
 	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
 	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
--=20
2.43.0

