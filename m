Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15979.1795706552704541148
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 80EBA41B09;
	Thu, 26 Nov 2026 15:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868AA1F000C0;
	Thu, 26 Nov 2026 15:22:31 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 17/27] dmaengine: sh: rz-dmac: Save the start LM descriptor
Date: Thu, 26 Nov 2026 17:21:53 +0200
Message-ID: <20261126152204.1297798-18-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25127
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e21aa306e82067457f2297ae56af4c91db86c59a upstream.

Save the start LM descriptor to avoid starting from the beginning of the
channel's LM descriptor list in rz_dmac_calculate_residue_bytes_in_vd().
This avoids unnecessary iterations.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-7-claudiu.beznea@ke=
rnel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 02bd4ddf4765..50c46917d4e1 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -56,6 +56,7 @@ struct rz_dmac_desc {
 	/* For slave sg */
 	struct scatterlist *sg;
 	unsigned int sgcount;
+	struct rz_lmdesc *start_lmdesc;
 };
=20
 #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
@@ -315,6 +316,8 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz=
_dmac_chan *channel)
 	struct rz_dmac_desc *d =3D channel->desc;
 	u32 chcfg =3D CHCFG_MEM_COPY;
=20
+	d->start_lmdesc =3D lmdesc;
+
 	/* prepare descriptor */
 	lmdesc->sa =3D d->src;
 	lmdesc->da =3D d->dest;
@@ -349,6 +352,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct=
 rz_dmac_chan *channel)
 	}
=20
 	lmdesc =3D channel->lmdesc.tail;
+	d->start_lmdesc =3D lmdesc;
=20
 	for (i =3D 0, sg =3D sgl; i < sg_len; i++, sg =3D sg_next(sg)) {
 		if (d->direction =3D=3D DMA_DEV_TO_MEM) {
@@ -677,9 +681,10 @@ rz_dmac_get_next_lmdesc(struct rz_lmdesc *base, stru=
ct rz_lmdesc *lmdesc)
 	return next;
 }
=20
-static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *ch=
annel, u32 crla)
+static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *ch=
annel,
+						 struct rz_dmac_desc *desc, u32 crla)
 {
-	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
+	struct rz_lmdesc *lmdesc =3D desc->start_lmdesc;
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	u32 residue =3D 0, i =3D 0;
@@ -778,7 +783,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
 	 * Calculate number of bytes transferred in processing virtual descript=
or.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, crla);
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_de=
sc, crla);
 }
=20
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
--=20
2.43.0

