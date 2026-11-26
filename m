Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15978.1795706551393500705
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:31 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 33F6140F0F;
	Thu, 26 Nov 2026 15:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405A61F000C0;
	Thu, 26 Nov 2026 15:22:30 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 16/27] dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
Date: Thu, 26 Nov 2026 17:21:52 +0200
Message-ID: <20261126152204.1297798-17-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25126
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 32a69f1487819766d2084ed32b1350b18f971c10 upstream.

Add a the rz_dmac_lmdesc_addr() helper function to compute the lmdesc
address, to make the code easier to understand. The helper will be used i=
n
subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-6-claudiu.beznea@ke=
rnel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index f44a1e66120f..02bd4ddf4765 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -241,6 +241,12 @@ static void rz_lmdesc_setup(struct rz_dmac_chan *cha=
nnel,
  * Descriptors preparation
  */
=20
+static u32 rz_dmac_lmdesc_addr(struct rz_dmac_chan *channel, struct rz_l=
mdesc *lmdesc)
+{
+	return channel->lmdesc.base_dma +
+	       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
+}
+
 static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 {
 	struct rz_lmdesc *lmdesc =3D channel->lmdesc.head;
@@ -266,9 +272,7 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *ch=
annel)
=20
 	rz_dmac_lmdesc_recycle(channel);
=20
-	nxla =3D channel->lmdesc.base_dma +
-		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
-					     channel->lmdesc.base));
+	nxla =3D rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
=20
 	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (!(chstat & CHSTAT_EN)) {
--=20
2.43.0

