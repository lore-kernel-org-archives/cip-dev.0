Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16011.1795706564382592461
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ADD78612F3;
	Thu, 26 Nov 2026 15:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EDF1F000D3;
	Thu, 26 Nov 2026 15:22:42 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 24/27] dmaengine: sh: rz-dmac: Adjust rz_dmac_chan_get_residue() to return error codes
Date: Thu, 26 Nov 2026 17:22:00 +0200
Message-ID: <20261126152204.1297798-25-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25134
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 16ba40151b1e6a52b28296a2173457bc6c31f022 upstream.

Adjust rz_dmac_chan_get_residue() to return error codes on failure and
provide the residue to callers through the residue parameter. This
prepares the code for the addition of runtime PM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-14-claudiu.beznea@k=
ernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict in rz_dmac_tx_status()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 968754752401..d5181f21538b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -847,8 +847,8 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(stru=
ct rz_dmac_chan *channel,
 	return residue;
 }
=20
-static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
-				    dma_cookie_t cookie)
+static int rz_dmac_chan_get_residue(struct device *dev, struct rz_dmac_c=
han *channel,
+				    dma_cookie_t cookie, u32 *residue)
 {
 	struct rz_dmac_desc *desc =3D NULL;
 	struct virt_dma_desc *vd;
@@ -858,7 +858,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
 	if (vd) {
 		/* Descriptor has been issued but not yet processed. */
 		desc =3D to_rz_dmac_desc(vd);
-		return desc->len;
+		*residue =3D desc->len;
+		return 0;
 	} else if (channel->desc && channel->desc->vd.tx.cookie =3D=3D cookie) =
{
 		/* Descriptor is currently processed. */
 		desc =3D channel->desc;
@@ -866,6 +867,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
=20
 	if (!desc) {
 		/* Descriptor was not found. May be already completed by now. */
+		*residue =3D 0;
 		return 0;
 	}
=20
@@ -888,7 +890,9 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
 	 * Calculate number of bytes transferred in processing virtual descript=
or.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla=
);
+	*residue =3D crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc=
, crla);
+
+	return 0;
 }
=20
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
@@ -896,9 +900,11 @@ static enum dma_status rz_dmac_tx_status(struct dma_=
chan *chan,
 					 struct dma_tx_state *txstate)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	enum dma_status status;
 	unsigned long flags;
 	u32 residue;
+	int ret;
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
 	status =3D dma_cookie_status(chan, cookie, txstate);
@@ -907,7 +913,11 @@ static enum dma_status rz_dmac_tx_status(struct dma_=
chan *chan,
 		return status;
 	}
=20
-	residue =3D rz_dmac_chan_get_residue(channel, cookie);
+	ret =3D rz_dmac_chan_get_residue(dmac->dev, channel, cookie, &residue);
+	if (ret) {
+		spin_unlock_irqrestore(&channel->vc.lock, flags);
+		return DMA_ERROR;
+	}
=20
 	if (status =3D=3D DMA_IN_PROGRESS && rz_dmac_chan_is_paused(channel))
 		status =3D DMA_PAUSED;
--=20
2.43.0

