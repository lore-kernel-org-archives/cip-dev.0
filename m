Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15991.1795706535593987710
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:15 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F0F6360DCA;
	Thu, 26 Nov 2026 15:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB461F000C0;
	Thu, 26 Nov 2026 15:22:13 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/27] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Thu, 26 Nov 2026 17:21:41 +0200
Message-ID: <20261126152204.1297798-6-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25115
Content-Type: text/plain; charset="utf-8"

commit 89a8567d84bde88cb7cdbbac2ab2299c4f991490 upstream.

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL register. To avoid concurrency issues when configuring
functionalities exposed by this registers, take the virtual channel lock.
All other CHCTRL updates were already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, befo=
re
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-3-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: replaced scoped_guard() with
 spin_lock_irqsave()/spin_unlock_irqrestore()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 70410def8181..8f2baf32d338 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -285,13 +285,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan =
*channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	unsigned long flags;
=20
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
=20
-	local_irq_save(flags);
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-	local_irq_restore(flags);
 }
=20
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32=
 dmars)
@@ -555,8 +552,8 @@ static int rz_dmac_terminate_all(struct dma_chan *cha=
n)
 	unsigned int i;
 	LIST_HEAD(head);
=20
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i =3D 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header =3D 0;
=20
@@ -681,13 +678,17 @@ static void rz_dmac_irq_handle_channel(struct rz_dm=
ac_chan *channel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+	unsigned long flags;
 	u32 chstat, chctrl;
=20
 	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d =3D %08X\n",
 			channel->index, chstat);
+
+		spin_lock_irqsave(&channel->vc.lock, flags);
 		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+		spin_unlock_irqrestore(&channel->vc.lock, flags);
 		goto done;
 	}
=20
--=20
2.43.0

