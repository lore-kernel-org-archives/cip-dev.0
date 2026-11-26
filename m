Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16013.1795706569307800107
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FA3745A10;
	Thu, 26 Nov 2026 15:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6741F000C0;
	Thu, 26 Nov 2026 15:22:47 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 27/27] dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc lookup
Date: Thu, 26 Nov 2026 17:22:03 +0200
Message-ID: <20261126152204.1297798-28-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25137
Content-Type: text/plain; charset="utf-8"

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit 9db8e502b34bc1df8078abd0169a4fa0624de3bb upstream.

lmdesc->nxla is the address of the next descriptor, so comparing it
against CRLA, which is the address of the current descriptor,
finds the descriptor before the active one, not the active one.
The residue loops below then summed one lmdesc too many on top of
that.

Compare each descriptor's own address to CRLA instead, and add tb
after advancing to the next lmdesc.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() call=
back")
Fixes: 172bfb57481c ("dmaengine: sh: rz-dmac: Add cyclic DMA support")
Cc: stable@vger.kernel.org
Suggested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260922092037.224884-1-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f2ec90e3f52a..5d5109510110 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -866,7 +866,7 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(stru=
ct rz_dmac_chan *channel,
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	u32 residue =3D 0, i =3D 0;
=20
-	while (lmdesc->nxla !=3D crla) {
+	while (rz_dmac_lmdesc_addr(channel, lmdesc) !=3D crla) {
 		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
 		if (++i >=3D DMAC_NR_LMDESC)
 			return 0;
@@ -877,13 +877,13 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(st=
ruct rz_dmac_chan *channel,
 		u32 start_lmdesc_addr =3D rz_dmac_lmdesc_addr(channel, desc->start_lmd=
esc);
=20
 		while (lmdesc->nxla !=3D start_lmdesc_addr) {
-			residue +=3D lmdesc->tb;
 			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+			residue +=3D lmdesc->tb;
 		}
 	} else {
 		while (lmdesc->chcfg & CHCFG_DEM) {
-			residue +=3D lmdesc->tb;
 			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+			residue +=3D lmdesc->tb;
 		}
 	}
=20
--=20
2.43.0

