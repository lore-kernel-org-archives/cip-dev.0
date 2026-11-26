Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15982.1795706554058111247
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D867440F0F;
	Thu, 26 Nov 2026 15:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BAA1F000C4;
	Thu, 26 Nov 2026 15:22:32 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 18/27] dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
Date: Thu, 26 Nov 2026 17:21:54 +0200
Message-ID: <20261126152204.1297798-19-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25128
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7a94c109a5def4f0f25705a82ed5870f794ff4ed upstream.

Add the rz_dmac_chan_is_enabled() helper to check if a channel is
enabled. This helper will be reused in subsequent patches.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-8-claudiu.beznea@ke=
rnel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 50c46917d4e1..5f7d53e43194 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -261,6 +261,13 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_ch=
an *channel)
 	channel->lmdesc.head =3D lmdesc;
 }
=20
+static bool rz_dmac_chan_is_enabled(struct rz_dmac_chan *channel)
+{
+	u32 val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+
+	return !!(val & CHSTAT_EN);
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
@@ -823,8 +830,7 @@ static int rz_dmac_device_pause(struct dma_chan *chan=
)
=20
 	guard(spinlock_irqsave)(&channel->vc.lock);
=20
-	val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (!(val & CHSTAT_EN))
+	if (!rz_dmac_chan_is_enabled(channel))
 		return 0;
=20
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
--=20
2.43.0

