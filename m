Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15992.1795706536904659044
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4F9FB60E5F;
	Thu, 26 Nov 2026 15:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C851F000C0;
	Thu, 26 Nov 2026 15:22:14 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 06/27] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
Date: Thu, 26 Nov 2026 17:21:42 +0200
Message-ID: <20261126152204.1297798-7-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25116
Content-Type: text/plain; charset="utf-8"

commit be342fb7f2bb5f641419fef3109eaffd469b0d44 upstream.

The CHCTRL register has 11 bits that can be updated by software. The
documentation for all these bits states the following:
- A read operation results in 0 being read
- Writing zero does not affect the operation

All bits in the CHCTRL register accessible by software are set and clear
bits.

The documentation for the CLREND bit of CHCTRL states:
Setting this bit to 1 can clear the END bit of the CHSTAT_n/nS register.
Also, the DMA transfer end interrupt is cleared. An attempt to read this
bit results in 0 being read.
1: Clears the END bit.
0: Does not affect the operation.

Since writing zero to any bit in this register does not affect controller
operation and reads always return zero, there is no need to perform
read-modify-write accesses to set the CLREND bit. Drop the read of the
CHCTRL register.

Also, since setting the CLREND bit does not interact with other
functionalities exposed through this register and only clears the END
interrupt, there is no need to lock around this operation. Add a comment
to document this.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-4-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict in rz_dmac_irq_handle_channel()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 8f2baf32d338..e0f8c4f462a8 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -679,7 +679,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac=
_chan *channel)
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	unsigned long flags;
-	u32 chstat, chctrl;
+	u32 chstat;
=20
 	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
@@ -692,8 +692,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dma=
c_chan *channel)
 		goto done;
 	}
=20
-	chctrl =3D rz_dmac_ch_readl(channel, CHCTRL, 1);
-	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
+	/*
+	 * No need to lock. This just clears the END interrupt. Writing
+	 * zeros to CHCTRL is just ignored by HW.
+	 */
+	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
 done:
 	return;
 }
--=20
2.43.0

