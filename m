Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15991.1795706565471968602
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4887046566;
	Thu, 26 Nov 2026 15:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110521F0093C;
	Thu, 26 Nov 2026 15:22:43 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 25/27] dmaengine: sh: rz-dmac: Add runtime PM support
Date: Thu, 26 Nov 2026 17:22:01 +0200
Message-ID: <20261126152204.1297798-26-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25135
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7c27a4d54d48d0774518390e4ce6cf3309aac141 upstream.

Protect the driver exposed APIs with runtime PM suspend/resume calls
before accessing HW registers. As the current driver leaves runtime PM
enabled in probe, the purpose of the changes in this patch is to avoid
accessing HW registers after a failed system suspend leaves the runtime
PM state of the device improperly reinitialized.

In that case, the driver remains bound to the device, the APIs are still
exposed, and any access to HW registers without runtime resuming the
device may lead to synchronous aborts.

To avoid leaking resources in case of runtime PM failures, save the error
code returned by PM_RUNTIME_ACQUIRE_ERR() in rz_dmac_terminate_all() and
return it only at the end of the function to allow the cleanup code to
run. A similar approach is used in rz_dmac_free_chan_resources().

Because some exposed APIs (e.g. ->device_terminate_all()) may be called
from atomic context according to the documentation, mark the DMA device a=
s
pm_runtime_irq_safe().

This patch prepares the driver for suspend-to-RAM support.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-15-claudiu.beznea@k=
ernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea:
 - PM_RUNTIME_ACQUIRE_IF_ENABLED()/PM_RUNTIME_ACQUIRE_ERR()
   with the equivalent open-coded pm_runtime_resume_and_get()/
   pm_runtime_put()
 - replace guard() with spin_lock_irqsave()/spin_unlock_irqrestore() in
   rz_dmac_device_pause() and rz_dmac_device_resume()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 86 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d5181f21538b..5b6d08fdade1 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -520,12 +520,21 @@ static void rz_dmac_free_chan_resources(struct dma_=
chan *chan)
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	struct rz_dmac_desc *desc, *_desc;
 	unsigned long flags;
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret) {
+		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=3D%d\n!",
+			dma_chan_name(chan), ret);
+	}
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
=20
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
-	rz_dmac_disable_hw(channel);
+	/*  Skip touching HW if RPM resume failed. Let the cleanup do its jobs.=
 */
+	if (!ret)
+		rz_dmac_disable_hw(channel);
=20
 	if (channel->mid_rid >=3D 0) {
 		clear_bit(channel->mid_rid, dmac->modules);
@@ -549,6 +558,9 @@ static void rz_dmac_free_chan_resources(struct dma_ch=
an *chan)
 	INIT_LIST_HEAD(&channel->ld_free);
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
+
+	if (!ret)
+		pm_runtime_put(dmac->dev);
 }
=20
 static struct dma_async_tx_descriptor *
@@ -684,11 +696,21 @@ rz_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_=
addr_t buf_addr,
 static int rz_dmac_terminate_all(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	unsigned long flags;
 	LIST_HEAD(head);
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret) {
+		dev_err(dmac->dev, "RPM resume failed for channel %s, ret=3D%d\n!",
+			dma_chan_name(chan), ret);
+	}
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
-	rz_dmac_disable_hw(channel);
+	/* Don't return if RPM failed. Let the cleanup do its jobs. */
+	if (!ret)
+		rz_dmac_disable_hw(channel);
 	rz_lmdesc_setup(channel, channel->lmdesc.base);
=20
 	if (channel->desc) {
@@ -703,13 +725,22 @@ static int rz_dmac_terminate_all(struct dma_chan *c=
han)
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
=20
-	return 0;
+	if (!ret)
+		pm_runtime_put(dmac->dev);
+
+	return ret;
 }
=20
 static void rz_dmac_issue_pending(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
 	unsigned long flags;
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return;
=20
 	spin_lock_irqsave(&channel->vc.lock, flags);
=20
@@ -721,6 +752,8 @@ static void rz_dmac_issue_pending(struct dma_chan *ch=
an)
 		rz_dmac_xfer_desc(channel);
=20
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
+
+	pm_runtime_put(dmac->dev);
 }
=20
 static u8 rz_dmac_ds_to_val_mapping(enum dma_slave_buswidth ds)
@@ -794,12 +827,18 @@ static void rz_dmac_device_synchronize(struct dma_c=
han *chan)
=20
 	vchan_synchronize(&channel->vc);
=20
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return;
+
 	ret =3D read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_E=
N),
 				100, 100000, false, channel, CHSTAT, 1);
 	if (ret < 0)
 		dev_warn(dmac->dev, "DMA Timeout");
=20
 	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+
+	pm_runtime_put(dmac->dev);
 }
=20
 static struct rz_lmdesc *
@@ -853,6 +892,7 @@ static int rz_dmac_chan_get_residue(struct device *de=
v, struct rz_dmac_chan *cha
 	struct rz_dmac_desc *desc =3D NULL;
 	struct virt_dma_desc *vd;
 	u32 crla, crtb, i;
+	int ret;
=20
 	vd =3D vchan_find_desc(&channel->vc, cookie);
 	if (vd) {
@@ -871,6 +911,10 @@ static int rz_dmac_chan_get_residue(struct device *d=
ev, struct rz_dmac_chan *cha
 		return 0;
 	}
=20
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
 	/*
 	 * We need to read two registers. Make sure the hardware does not move
 	 * to next lmdesc while reading the current lmdesc. Trying it 3 times
@@ -892,6 +936,8 @@ static int rz_dmac_chan_get_residue(struct device *de=
v, struct rz_dmac_chan *cha
 	 */
 	*residue =3D crtb + rz_dmac_calculate_residue_bytes_in_vd(channel, desc=
, crla);
=20
+	pm_runtime_put(dev);
+
 	return 0;
 }
=20
@@ -956,10 +1002,21 @@ static int rz_dmac_device_pause_set(struct rz_dmac=
_chan *channel,
 static int rz_dmac_device_pause(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+	unsigned long flags;
+	int ret;
=20
-	guard(spinlock_irqsave)(&channel->vc.lock);
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&channel->vc.lock, flags);
+	ret =3D rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSE=
D));
+	spin_unlock_irqrestore(&channel->vc.lock, flags);
+
+	pm_runtime_put(dmac->dev);
=20
-	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED=
));
+	return ret;
 }
=20
 static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
@@ -985,13 +1042,25 @@ static int rz_dmac_device_resume_set(struct rz_dma=
c_chan *channel,
 static int rz_dmac_device_resume(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
+	unsigned long flags;
+	int ret;
=20
-	guard(spinlock_irqsave)(&channel->vc.lock);
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return ret;
=20
+	spin_lock_irqsave(&channel->vc.lock, flags);
 	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
-		return 0;
+		goto unlock;
+
+	ret =3D rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUS=
ED));
+unlock:
+	spin_unlock_irqrestore(&channel->vc.lock, flags);
+
+	pm_runtime_put(dmac->dev);
=20
-	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSE=
D));
+	return ret;
 }
=20
 /*
@@ -1221,6 +1290,7 @@ static int rz_dmac_probe(struct platform_device *pd=
ev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
 				     "failed to get resets\n");
=20
+	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	ret =3D pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
--=20
2.43.0

