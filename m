Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16008.1795706561939510490
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B9F3C4624B;
	Thu, 26 Nov 2026 15:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2131F000EB;
	Thu, 26 Nov 2026 15:22:40 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 23/27] dmaengine: sh: rz-dmac: Add cyclic DMA support
Date: Thu, 26 Nov 2026 17:21:59 +0200
Message-ID: <20261126152204.1297798-24-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25133
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 172bfb57481c65fcc94ebcae3a730f6df2f953d4 upstream.

Add cyclic DMA support to the RZ DMAC driver. A per-channel status bit is
introduced to mark cyclic channels and is set during the DMA prepare
callback. The IRQ handler checks this status bit and calls
vchan_cyclic_callback() accordingly.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-13-claudiu.beznea@k=
ernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea:
- in rz_dmac_prepare_descs_for_cyclic() moved the declaration of i
  iterator outside of for block
- replaced rz_dmac_set_dma_req_no() with rz_dmac_set_dmars_register()
- replaced scoped_guard() with spin_lock_irqsave()/spin_unlock_irqrestore=
()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 141 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 135 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 55654588f0b2..968754752401 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -33,6 +33,7 @@
 enum  rz_dmac_prep_type {
 	RZ_DMAC_DESC_MEMCPY,
 	RZ_DMAC_DESC_SLAVE_SG,
+	RZ_DMAC_DESC_CYCLIC,
 };
=20
 struct rz_lmdesc {
@@ -65,9 +66,11 @@ struct rz_dmac_desc {
 /**
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine call=
backs
+ * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_PAUSED,
+	RZ_DMAC_CHAN_STATUS_CYCLIC,
 };
=20
 struct rz_dmac_chan {
@@ -176,6 +179,7 @@ struct rz_dmac {
=20
 /* LINK MODE DESCRIPTOR */
 #define HEADER_LV			BIT(0)
+#define HEADER_WBD			BIT(2)
=20
 #define RZ_DMAC_MAX_CHAN_DESCRIPTORS	16
 #define RZ_DMAC_MAX_CHANNELS		16
@@ -402,6 +406,57 @@ static void rz_dmac_prepare_descs_for_slave_sg(struc=
t rz_dmac_chan *channel)
 	channel->chctrl =3D 0;
 }
=20
+static void rz_dmac_prepare_descs_for_cyclic(struct rz_dmac_chan *channe=
l)
+{
+	struct dma_chan *chan =3D &channel->vc.chan;
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+	struct rz_dmac_desc *d =3D channel->desc;
+	size_t period_len =3D d->sgcount, i;
+	struct rz_lmdesc *lmdesc;
+	size_t buf_len =3D d->len;
+	size_t periods =3D buf_len / period_len;
+
+	lockdep_assert_held(&channel->vc.lock);
+
+	channel->chcfg |=3D CHCFG_SEL(channel->index) | CHCFG_DMS;
+
+	if (d->direction =3D=3D DMA_DEV_TO_MEM) {
+		channel->chcfg |=3D CHCFG_SAD;
+		channel->chcfg &=3D ~CHCFG_REQD;
+	} else {
+		channel->chcfg |=3D CHCFG_DAD | CHCFG_REQD;
+	}
+
+	lmdesc =3D channel->lmdesc.tail;
+	d->start_lmdesc =3D lmdesc;
+
+	for (i =3D 0; i < periods; i++) {
+		if (d->direction =3D=3D DMA_DEV_TO_MEM) {
+			lmdesc->sa =3D d->src;
+			lmdesc->da =3D d->dest + (i * period_len);
+		} else {
+			lmdesc->sa =3D d->src + (i * period_len);
+			lmdesc->da =3D d->dest;
+		}
+
+		lmdesc->tb =3D period_len;
+		lmdesc->chitvl =3D 0;
+		lmdesc->chext =3D 0;
+		lmdesc->chcfg =3D channel->chcfg;
+		lmdesc->header =3D HEADER_LV | HEADER_WBD;
+
+		if (i =3D=3D periods - 1)
+			lmdesc->nxla =3D rz_dmac_lmdesc_addr(channel, d->start_lmdesc);
+
+		if (++lmdesc >=3D (channel->lmdesc.base + DMAC_NR_LMDESC))
+			lmdesc =3D channel->lmdesc.base;
+	}
+
+	channel->lmdesc.tail =3D lmdesc;
+
+	rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+}
+
 static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 {
 	struct virt_dma_desc *vd;
@@ -423,6 +478,10 @@ static void rz_dmac_xfer_desc(struct rz_dmac_chan *c=
han)
 	case RZ_DMAC_DESC_SLAVE_SG:
 		rz_dmac_prepare_descs_for_slave_sg(chan);
 		break;
+
+	case RZ_DMAC_DESC_CYCLIC:
+		rz_dmac_prepare_descs_for_cyclic(chan);
+		break;
 	}
=20
 	rz_dmac_enable_hw(chan);
@@ -568,6 +627,60 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct =
scatterlist *sgl,
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
=20
+static struct dma_async_tx_descriptor *
+rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
+			size_t buf_len, size_t period_len,
+			enum dma_transfer_direction direction,
+			unsigned long flags)
+{
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac_desc *desc;
+	unsigned long lock_flags;
+	size_t periods;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	if (!period_len || !buf_len)
+		return NULL;
+
+	periods =3D buf_len / period_len;
+	if (!periods || periods > DMAC_NR_LMDESC)
+		return NULL;
+
+	spin_lock_irqsave(&channel->vc.lock, lock_flags);
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
+		return NULL;
+	}
+
+	desc =3D list_first_entry_or_null(&channel->ld_free, struct rz_dmac_des=
c, node);
+	if (!desc) {
+		spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
+		return NULL;
+	}
+
+	list_del(&desc->node);
+
+	channel->status |=3D BIT(RZ_DMAC_CHAN_STATUS_CYCLIC);
+	spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
+
+	desc->type =3D RZ_DMAC_DESC_CYCLIC;
+	desc->sgcount =3D period_len;
+	desc->len =3D buf_len;
+	desc->direction =3D direction;
+
+	if (direction =3D=3D DMA_DEV_TO_MEM) {
+		desc->src =3D channel->src_per_address;
+		desc->dest =3D buf_addr;
+	} else {
+		desc->src =3D buf_addr;
+		desc->dest =3D channel->dst_per_address;
+	}
+
+	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
+}
+
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
@@ -715,9 +828,18 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(str=
uct rz_dmac_chan *channel,
 	}
=20
 	/* Calculate residue from next lmdesc to end of virtual desc */
-	while (lmdesc->chcfg & CHCFG_DEM) {
-		residue +=3D lmdesc->tb;
-		lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		u32 start_lmdesc_addr =3D rz_dmac_lmdesc_addr(channel, desc->start_lmd=
esc);
+
+		while (lmdesc->nxla !=3D start_lmdesc_addr) {
+			residue +=3D lmdesc->tb;
+			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		}
+	} else {
+		while (lmdesc->chcfg & CHCFG_DEM) {
+			residue +=3D lmdesc->tb;
+			lmdesc =3D rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+		}
 	}
=20
 	dev_dbg(dmac->dev, "%s: VD residue is %u\n", __func__, residue);
@@ -915,10 +1037,14 @@ static irqreturn_t rz_dmac_irq_handler_thread(int =
irq, void *dev_id)
 	if (!desc)
 		return IRQ_HANDLED;
=20
-	vchan_cookie_complete(&desc->vd);
-	channel->desc =3D NULL;
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)) {
+		vchan_cyclic_callback(&desc->vd);
+	} else {
+		vchan_cookie_complete(&desc->vd);
+		channel->desc =3D NULL;
=20
-	rz_dmac_xfer_desc(channel);
+		rz_dmac_xfer_desc(channel);
+	}
=20
 	return IRQ_HANDLED;
 }
@@ -1127,6 +1253,8 @@ static int rz_dmac_probe(struct platform_device *pd=
ev)
 	engine =3D &dmac->engine;
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
+	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
+	engine->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	engine->residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
@@ -1138,6 +1266,7 @@ static int rz_dmac_probe(struct platform_device *pd=
ev)
 	engine->device_tx_status =3D rz_dmac_tx_status;
 	engine->device_prep_slave_sg =3D rz_dmac_prep_slave_sg;
 	engine->device_prep_dma_memcpy =3D rz_dmac_prep_dma_memcpy;
+	engine->device_prep_dma_cyclic =3D rz_dmac_prep_dma_cyclic;
 	engine->device_config =3D rz_dmac_config;
 	engine->device_terminate_all =3D rz_dmac_terminate_all;
 	engine->device_issue_pending =3D rz_dmac_issue_pending;
--=20
2.43.0

