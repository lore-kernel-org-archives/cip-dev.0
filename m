Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16005.1795706557655574244
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0574A60DCA;
	Thu, 26 Nov 2026 15:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34851F000C0;
	Thu, 26 Nov 2026 15:22:35 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 20/27] dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor processing
Date: Thu, 26 Nov 2026 17:21:56 +0200
Message-ID: <20261126152204.1297798-21-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25130
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit daa6d4617bee722e83f7d8584416e83b709c958a upstream.

The driver used a mix of virt-dma APIs and driver specific logic to
process descriptors. It maintained three internal queues: ld_free,
ld_queue, and ld_active as follows:
- ld_free: stores the descriptors pre-allocated at probe time
- ld_queue: stores descriptors after they are taken from ld_free and
  prepared. At the same time, vchan_tx_prep() queues them to
  vc->desc_allocated. The vc->desc_allocated list is then checked in
  rz_dmac_issue_pending() and rz_dmac_irq_handler_thread() before
  starting a new transfer via rz_dmac_xfer_desc(). In turn,
  rz_dmac_xfer_desc() grabs the next descriptor from vc->desc_issued and
  submits it for transfer
- ld_active: stores the descriptors currently being transferred

The interrupt handler moved a completed descriptor to ld_free before
invoking its completion callback. Once returned to ld_free, the
descriptor can be reused to prepare a new transfer. In theory, this
means the descriptor could be re-prepared before its completion
callback is called.

Commit fully back the driver by the virt-dma APIs. With this, only ld_fre=
e
need to be kept to track how many free descriptors are available. This
is now done as follows:
- the prepare stage removes the first descriptor from the ld_free and
  prepares it
- the completion calls for it vc->desc_free() (rz_dmac_virt_desc_free())
  which re-adds the descriptor at the end of ld_free

With this, the critical areas in prepare callbacks were minimized to only
getting the descriptor from the ld_free list.

Introduce struct rz_dmac_chan::desc to keep track of the currently
transferred descriptor. It is cleared in rz_dmac_terminate_all(),
referenced from rz_dmac_issue_pending() to determine whether a new transf=
er
can be started, and from rz_dmac_irq_handler_thread() once a descriptor h=
as
completed. Finally, the rz_dmac_device_synchronize() was updated with
vchan_synchronize() call to ensure the terminated descriptor is freed and
the tasklet is killed.

With this, residue computation is also simplified, as it can now be
handled entirely through the virt-dma APIs.

The spin_lock/unlock operations from rz_dmac_irq_handler_thread() were
replaced by guard as the final code after rework is simpler this way.

As subsequent commits will set the Link End bit on the last descriptor
of a transfer, rz_dmac_enable_hw() is also adjusted as part of the full
conversion to virt-dma APIs. It no longer checks the channel enable
status itself; instead, its callers verify whether the channel is
enabled and whether the previous transfer has completed before starting
a new one.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-10-claudiu.beznea@k=
ernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: fixed conflict]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 207 ++++++++++++++-------------------------
 1 file changed, 73 insertions(+), 134 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 58c44f9d19ce..f31dd1f80a10 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -77,8 +77,6 @@ struct rz_dmac_chan {
 	int mid_rid;
=20
 	struct list_head ld_free;
-	struct list_head ld_queue;
-	struct list_head ld_active;
=20
 	struct {
 		struct rz_lmdesc *base;
@@ -281,7 +279,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *ch=
annel)
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	u32 nxla;
 	u32 chctrl;
-	u32 chstat;
=20
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
=20
@@ -289,14 +286,11 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *=
channel)
=20
 	nxla =3D rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
=20
-	chstat =3D rz_dmac_ch_readl(channel, CHSTAT, 1);
-	if (!(chstat & CHSTAT_EN)) {
-		chctrl =3D (channel->chctrl | CHCTRL_SETEN);
-		rz_dmac_ch_writel(channel, nxla, NXLA, 1);
-		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
-		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
-		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
-	}
+	chctrl =3D (channel->chctrl | CHCTRL_SETEN);
+	rz_dmac_ch_writel(channel, nxla, NXLA, 1);
+	rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
+	rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
+	rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 }
=20
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
@@ -397,18 +391,20 @@ static void rz_dmac_prepare_descs_for_slave_sg(stru=
ct rz_dmac_chan *channel)
 	channel->chctrl =3D CHCTRL_SETEN;
 }
=20
-static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
+static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
 {
-	struct rz_dmac_desc *d =3D chan->desc;
 	struct virt_dma_desc *vd;
=20
 	vd =3D vchan_next_desc(&chan->vc);
-	if (!vd)
-		return 0;
+	if (!vd) {
+		chan->desc =3D NULL;
+		return;
+	}
=20
 	list_del(&vd->node);
+	chan->desc =3D to_rz_dmac_desc(vd);
=20
-	switch (d->type) {
+	switch (chan->desc->type) {
 	case RZ_DMAC_DESC_MEMCPY:
 		rz_dmac_prepare_desc_for_memcpy(chan);
 		break;
@@ -416,14 +412,9 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *ch=
an)
 	case RZ_DMAC_DESC_SLAVE_SG:
 		rz_dmac_prepare_descs_for_slave_sg(chan);
 		break;
-
-	default:
-		return -EINVAL;
 	}
=20
 	rz_dmac_enable_hw(chan);
-
-	return 0;
 }
=20
 /*
@@ -465,8 +456,6 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
 	rz_dmac_disable_hw(channel);
-	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
-	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
=20
 	if (channel->mid_rid >=3D 0) {
 		clear_bit(channel->mid_rid, dmac->modules);
@@ -475,13 +464,19 @@ static void rz_dmac_free_chan_resources(struct dma_=
chan *chan)
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
=20
+	vchan_free_chan_resources(&channel->vc);
+
+	spin_lock_irqsave(&channel->vc.lock, flags);
+
 	list_for_each_entry_safe(desc, _desc, &channel->ld_free, node) {
+		list_del(&desc->node);
 		kfree(desc);
 		channel->descs_allocated--;
 	}
=20
 	INIT_LIST_HEAD(&channel->ld_free);
-	vchan_free_chan_resources(&channel->vc);
+
+	spin_unlock_irqrestore(&channel->vc.lock, flags);
 }
=20
 static struct dma_async_tx_descriptor *
@@ -504,16 +499,16 @@ rz_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_=
addr_t dest, dma_addr_t src,
 		return NULL;
 	}
=20
+	list_del(&desc->node);
+
+	spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
+
 	desc->type =3D RZ_DMAC_DESC_MEMCPY;
 	desc->src =3D src;
 	desc->dest =3D dest;
 	desc->len =3D len;
 	desc->direction =3D DMA_MEM_TO_MEM;
=20
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
-
-	spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
-
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
=20
@@ -538,7 +533,9 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct s=
catterlist *sgl,
 		return NULL;
 	}
=20
-	desc =3D list_first_entry(&channel->ld_free, struct rz_dmac_desc, node)=
;
+	list_del(&desc->node);
+
+	spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
=20
 	for_each_sg(sgl, sg, sg_len, i) {
 		dma_length +=3D sg_dma_len(sg);
@@ -555,10 +552,6 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct =
scatterlist *sgl,
 	else
 		desc->dest =3D channel->dst_per_address;
=20
-	list_move_tail(channel->ld_free.next, &channel->ld_queue);
-
-	spin_unlock_irqrestore(&channel->vc.lock, lock_flags);
-
 	return vchan_tx_prep(&channel->vc, &desc->vd, flags);
 }
=20
@@ -572,8 +565,11 @@ static int rz_dmac_terminate_all(struct dma_chan *ch=
an)
 	rz_dmac_disable_hw(channel);
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
-	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
-	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
+	if (channel->desc) {
+		vchan_terminate_vdesc(&channel->desc->vd);
+		channel->desc =3D NULL;
+	}
+
 	vchan_get_all_descriptors(&channel->vc, &head);
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
@@ -584,25 +580,16 @@ static int rz_dmac_terminate_all(struct dma_chan *c=
han)
 static void rz_dmac_issue_pending(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
-	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	struct rz_dmac_desc *desc;
 	unsigned long flags;
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
=20
-	if (!list_empty(&channel->ld_queue)) {
-		desc =3D list_first_entry(&channel->ld_queue,
-					struct rz_dmac_desc, node);
-		channel->desc =3D desc;
-		if (vchan_issue_pending(&channel->vc)) {
-			if (rz_dmac_xfer_desc(channel) < 0)
-				dev_warn(dmac->dev, "ch: %d couldn't issue DMA xfer\n",
-					 channel->index);
-			else
-				list_move_tail(channel->ld_queue.next,
-					       &channel->ld_active);
-		}
-	}
+	/*
+	 * Issue the descriptor. If another transfer is already in progress, th=
e
+	 * issued descriptor will be handled after the current transfer finishe=
s.
+	 */
+	if (vchan_issue_pending(&channel->vc) && !channel->desc)
+		rz_dmac_xfer_desc(channel);
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 }
@@ -660,13 +647,13 @@ static int rz_dmac_config(struct dma_chan *chan,
=20
 static void rz_dmac_virt_desc_free(struct virt_dma_desc *vd)
 {
-	/*
-	 * Place holder
-	 * Descriptor allocation is done during alloc_chan_resources and
-	 * get freed during free_chan_resources.
-	 * list is used to manage the descriptors and avoid any memory
-	 * allocation/free during DMA read/write.
-	 */
+	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(vd->tx.chan);
+	struct virt_dma_chan *vc =3D to_virt_chan(vd->tx.chan);
+	struct rz_dmac_desc *desc =3D to_rz_dmac_desc(vd);
+
+	guard(spinlock_irqsave)(&vc->lock);
+
+	list_add_tail(&desc->node, &channel->ld_free);
 }
=20
 static void rz_dmac_device_synchronize(struct dma_chan *chan)
@@ -676,6 +663,8 @@ static void rz_dmac_device_synchronize(struct dma_cha=
n *chan)
 	u32 chstat;
 	int ret;
=20
+	vchan_synchronize(&channel->vc);
+
 	ret =3D read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_E=
N),
 				100, 100000, false, channel, CHSTAT, 1);
 	if (ret < 0)
@@ -723,58 +712,22 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(st=
ruct rz_dmac_chan *channel,
 static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 				    dma_cookie_t cookie)
 {
-	struct rz_dmac_desc *current_desc, *desc;
-	enum dma_status status;
+	struct rz_dmac_desc *desc =3D NULL;
+	struct virt_dma_desc *vd;
 	u32 crla, crtb, i;
=20
-	/* Get current processing virtual descriptor */
-	current_desc =3D list_first_entry_or_null(&channel->ld_active,
-						struct rz_dmac_desc, node);
-	if (!current_desc)
-		return 0;
-
-	/*
-	 * If the cookie corresponds to a descriptor that has been completed
-	 * there is no residue. The same check has already been performed by th=
e
-	 * caller but without holding the channel lock, so the descriptor could
-	 * now be complete.
-	 */
-	status =3D dma_cookie_status(&channel->vc.chan, cookie, NULL);
-	if (status =3D=3D DMA_COMPLETE)
-		return 0;
-
-	/*
-	 * If the cookie doesn't correspond to the currently processing virtual
-	 * descriptor then the descriptor hasn't been processed yet, and the
-	 * residue is equal to the full descriptor size. Also, a client driver
-	 * is possible to call this function before rz_dmac_irq_handler_thread(=
)
-	 * runs. In this case, the running descriptor will be the next
-	 * descriptor, and will appear in the done list. So, if the argument
-	 * cookie matches the done list's cookie, we can assume the residue is
-	 * zero.
-	 */
-	if (cookie !=3D current_desc->vd.tx.cookie) {
-		list_for_each_entry(desc, &channel->ld_free, node) {
-			if (cookie =3D=3D desc->vd.tx.cookie)
-				return 0;
-		}
-
-		list_for_each_entry(desc, &channel->ld_queue, node) {
-			if (cookie =3D=3D desc->vd.tx.cookie)
-				return desc->len;
-		}
-
-		list_for_each_entry(desc, &channel->ld_active, node) {
-			if (cookie =3D=3D desc->vd.tx.cookie)
-				return desc->len;
-		}
+	vd =3D vchan_find_desc(&channel->vc, cookie);
+	if (vd) {
+		/* Descriptor has been issued but not yet processed. */
+		desc =3D to_rz_dmac_desc(vd);
+		return desc->len;
+	} else if (channel->desc && channel->desc->vd.tx.cookie =3D=3D cookie) =
{
+		/* Descriptor is currently processed. */
+		desc =3D channel->desc;
+	}
=20
-		/*
-		 * No descriptor found for the cookie, there's thus no residue.
-		 * This shouldn't happen if the calling driver passes a correct
-		 * cookie value.
-		 */
-		WARN(1, "No descriptor for cookie!");
+	if (!desc) {
+		/* Descriptor was not found. May be already completed by now. */
 		return 0;
 	}
=20
@@ -797,7 +750,7 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_ch=
an *channel,
 	 * Calculate number of bytes transferred in processing virtual descript=
or.
 	 * One virtual descriptor can have many lmdesc.
 	 */
-	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, current_de=
sc, crla);
+	return crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc, crla=
);
 }
=20
 static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
@@ -809,21 +762,19 @@ static enum dma_status rz_dmac_tx_status(struct dma=
_chan *chan,
 	unsigned long flags;
 	u32 residue;
=20
+	spin_lock_irqsave(&channel->vc.lock, flags);
 	status =3D dma_cookie_status(chan, cookie, txstate);
-	if (status =3D=3D DMA_COMPLETE || !txstate)
+	if (status =3D=3D DMA_COMPLETE || !txstate) {
+		spin_unlock_irqrestore(&channel->vc.lock, flags);
 		return status;
+	}
=20
-	spin_lock_irqsave(&channel->vc.lock, flags);
 	residue =3D rz_dmac_chan_get_residue(channel, cookie);
=20
-	if (rz_dmac_chan_is_paused(channel))
+	if (status =3D=3D DMA_IN_PROGRESS && rz_dmac_chan_is_paused(channel))
 		status =3D DMA_PAUSED;
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
=20
-	/* if there's no residue and no paused, the cookie is complete */
-	if (!residue && status !=3D DMA_PAUSED)
-		return DMA_COMPLETE;
-
 	dma_set_residue(txstate, residue);
=20
 	return status;
@@ -905,28 +856,18 @@ static irqreturn_t rz_dmac_irq_handler(int irq, voi=
d *dev_id)
 static irqreturn_t rz_dmac_irq_handler_thread(int irq, void *dev_id)
 {
 	struct rz_dmac_chan *channel =3D dev_id;
-	struct rz_dmac_desc *desc =3D NULL;
-	unsigned long flags;
+	struct rz_dmac_desc *desc;
=20
-	spin_lock_irqsave(&channel->vc.lock, flags);
+	guard(spinlock_irqsave)(&channel->vc.lock);
=20
-	if (list_empty(&channel->ld_active)) {
-		/* Someone might have called terminate all */
-		goto out;
-	}
+	desc =3D channel->desc;
+	if (!desc)
+		return IRQ_HANDLED;
=20
-	desc =3D list_first_entry(&channel->ld_active, struct rz_dmac_desc, nod=
e);
 	vchan_cookie_complete(&desc->vd);
-	list_move_tail(channel->ld_active.next, &channel->ld_free);
-	if (!list_empty(&channel->ld_queue)) {
-		desc =3D list_first_entry(&channel->ld_queue, struct rz_dmac_desc,
-					node);
-		channel->desc =3D desc;
-		if (rz_dmac_xfer_desc(channel) =3D=3D 0)
-			list_move_tail(channel->ld_queue.next, &channel->ld_active);
-	}
-out:
-	spin_unlock_irqrestore(&channel->vc.lock, flags);
+	channel->desc =3D NULL;
+
+	rz_dmac_xfer_desc(channel);
=20
 	return IRQ_HANDLED;
 }
@@ -1007,9 +948,7 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
=20
 	channel->vc.desc_free =3D rz_dmac_virt_desc_free;
 	vchan_init(&channel->vc, &dmac->engine);
-	INIT_LIST_HEAD(&channel->ld_queue);
 	INIT_LIST_HEAD(&channel->ld_free);
-	INIT_LIST_HEAD(&channel->ld_active);
=20
 	/* Initialize register for each channel */
 	rz_dmac_disable_hw(channel);
--=20
2.43.0

