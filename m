Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15999.1795706548409881608
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 37D8D43DE1;
	Thu, 26 Nov 2026 15:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3FC1F000CA;
	Thu, 26 Nov 2026 15:22:27 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 14/27] dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
Date: Thu, 26 Nov 2026 17:21:50 +0200
Message-ID: <20261126152204.1297798-15-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25124
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 89975baaa9ea2490b75d69842561a32ca888b7e5 upstream.

Use list_first_entry_or_null() instead of open-coding it with a
list_empty() check and list_first_entry(). This simplifies the code.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-4-claudiu.beznea@ke=
rnel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict as a result of previous commits dropping
 scoped_guard()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 83499f481821..3fb00da4407f 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -476,13 +476,12 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_=
addr_t dest, dma_addr_t src,
=20
 	spin_lock_irqsave(&channel->vc.lock, lock_flags);
=20
-	if (list_empty(&channel->ld_free)) {
+	desc =3D list_first_entry_or_null(&channel->ld_free, struct rz_dmac_des=
c, node);
+	if (!desc) {
 		spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
 		return NULL;
 	}
=20
-	desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc, node)=
;
-
 	desc->type =3D RZ_DMAC_DESC_MEMCPY;
 	desc->src =3D src;
 	desc->dest =3D dest;
@@ -511,7 +510,8 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
=20
 	spin_lock_irqsave(&channel->vc.lock, lock_flags);
=20
-	if (list_empty(&channel->ld_free)) {
+	desc =3D list_first_entry_or_null(&channel->ld_free, struct rz_dmac_des=
c, node);
+	if (!desc) {
 		spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
 		return NULL;
 	}
--=20
2.43.0

