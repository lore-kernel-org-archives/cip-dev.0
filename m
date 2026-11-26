Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15993.1795706540348305135
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BC30F60E87;
	Thu, 26 Nov 2026 15:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456A71F000C0;
	Thu, 26 Nov 2026 15:22:18 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 08/27] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Thu, 26 Nov 2026 17:21:44 +0200
Message-ID: <20261126152204.1297798-9-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25118
Content-Type: text/plain; charset="utf-8"

commit be25945d0ca3ac736c448b530c47e854c82a0343 upstream.

rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
this is not needed because the callers of rz_dmac_enable_hw() already
protect the critical section using
spin_lock_irqsave()/spin_lock_irqrestore().

Remove the local_irq_save()/local_irq_restore() calls.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-6-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 5086e1e19200..a16828509ba5 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -254,15 +254,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *=
channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	unsigned long flags;
 	u32 nxla;
 	u32 chctrl;
 	u32 chstat;
=20
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
=20
-	local_irq_save(flags);
-
 	rz_dmac_lmdesc_recycle(channel);
=20
 	nxla =3D channel->lmdesc.base_dma +
@@ -277,8 +274,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *ch=
annel)
 		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
 		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 	}
-
-	local_irq_restore(flags);
 }
=20
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
--=20
2.43.0

