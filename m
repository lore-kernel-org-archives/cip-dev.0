Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15984.1795706555586760677
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 608DB41B09;
	Thu, 26 Nov 2026 15:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE1B1F000D2;
	Thu, 26 Nov 2026 15:22:34 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 19/27] dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
Date: Thu, 26 Nov 2026 17:21:55 +0200
Message-ID: <20261126152204.1297798-20-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25129
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1dddc864dfa844efaf36345eb58b121b2cdffa5f upstream.

Add the rz_dmac_chan_is_paused() helper to check if the channel is paused=
.
This helper will be reused in subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-9-claudiu.beznea@ke=
rnel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 5f7d53e43194..58c44f9d19ce 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -268,6 +268,13 @@ static bool rz_dmac_chan_is_enabled(struct rz_dmac_c=
han *channel)
 	return !!(val & CHSTAT_EN);
 }
=20
+static bool rz_dmac_chan_is_paused(struct rz_dmac_chan *channel)
+{
+	u32 val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+
+	return !!(val & CHSTAT_SUS);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
@@ -800,7 +807,7 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
 	enum dma_status status;
 	unsigned long flags;
-	u32 residue, val;
+	u32 residue;
=20
 	status =3D dma_cookie_status(chan, cookie, txstate);
 	if (status =3D=3D DMA_COMPLETE || !txstate)
@@ -809,8 +816,7 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 	spin_lock_irqsave(&channel->vc.lock, flags);
 	residue =3D rz_dmac_chan_get_residue(channel, cookie);
=20
-	val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (val & CHSTAT_SUS)
+	if (rz_dmac_chan_is_paused(channel))
 		status =3D DMA_PAUSED;
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
=20
--=20
2.43.0

