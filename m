Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15996.1795706544239587834
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 109A143283;
	Thu, 26 Nov 2026 15:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209D91F000C0;
	Thu, 26 Nov 2026 15:22:22 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 11/27] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Thu, 26 Nov 2026 17:21:47 +0200
Message-ID: <20261126152204.1297798-12-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25121
Content-Type: text/plain; charset="utf-8"

commit 44f991bd6e01bb6a3f78da98eafa6d2a72819a2f upstream.

The RZ/G2L SCIFA driver uses dmaengine_prep_slave_sg() to enqueue DMA
transfers and implements a timeout mechanism on RX to handle cases where
a DMA transfer does not complete. The timeout is implemented using an
hrtimer.

In the hrtimer callback, dmaengine_tx_status() is called (along with
dmaengine_pause()) to retrieve the transfer residue and handle incomplete
DMA transfers.

Add support for device_{pause, resume}() callbacks.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-9-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict in rz_dmac_tx_status() as a result of
 switch to spin_lock_irqsave()/spin_unlock_irqrestore()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 46 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ed9fb1c6aeb3..79d1ba71eb18 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -125,10 +125,12 @@ struct rz_dmac {
 #define CHANNEL_8_15_COMMON_BASE	0x0700
=20
 #define CHSTAT_ER			BIT(4)
+#define CHSTAT_SUS			BIT(3)
 #define CHSTAT_EN			BIT(0)
=20
 #define CHCTRL_CLRINTMSK		BIT(17)
 #define CHCTRL_CLRSUS			BIT(9)
+#define CHCTRL_SETSUS			BIT(8)
 #define CHCTRL_CLRTC			BIT(6)
 #define CHCTRL_CLREND			BIT(5)
 #define CHCTRL_CLRRQ			BIT(4)
@@ -782,7 +784,7 @@ static enum dma_status rz_dmac_tx_status(struct dma_c=
han *chan,
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
 	enum dma_status status;
 	unsigned long flags;
-	u32 residue;
+	u32 residue, val;
=20
 	status =3D dma_cookie_status(chan, cookie, txstate);
 	if (status =3D=3D DMA_COMPLETE || !txstate)
@@ -790,10 +792,14 @@ static enum dma_status rz_dmac_tx_status(struct dma=
_chan *chan,
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
 	residue =3D rz_dmac_chan_get_residue(channel, cookie);
+
+	val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+	if (val & CHSTAT_SUS)
+		status =3D DMA_PAUSED;
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
=20
-	/* if there's no residue, the cookie is complete */
-	if (!residue)
+	/* if there's no residue and no paused, the cookie is complete */
+	if (!residue && status !=3D DMA_PAUSED)
 		return DMA_COMPLETE;
=20
 	dma_set_residue(txstate, residue);
@@ -801,6 +807,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_=
chan *chan,
 	return status;
 }
=20
+static int rz_dmac_device_pause(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	u32 val;
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	val =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
+	if (!(val & CHSTAT_EN))
+		return 0;
+
+	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					(val & CHSTAT_SUS), 1, 1024,
+					false, channel, CHSTAT, 1);
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	u32 val;
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+
+	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					!(val & CHSTAT_SUS), 1, 1024,
+					false, channel, CHSTAT, 1);
+}
+
 /*
  * ---------------------------------------------------------------------=
--------
  * IRQ handling
@@ -1094,6 +1132,8 @@ static int rz_dmac_probe(struct platform_device *pd=
ev)
 	engine->device_terminate_all =3D rz_dmac_terminate_all;
 	engine->device_issue_pending =3D rz_dmac_issue_pending;
 	engine->device_synchronize =3D rz_dmac_device_synchronize;
+	engine->device_pause =3D rz_dmac_device_pause;
+	engine->device_resume =3D rz_dmac_device_resume;
=20
 	engine->copy_align =3D DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
--=20
2.43.0

