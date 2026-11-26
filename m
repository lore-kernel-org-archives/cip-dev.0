Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15992.1795706567110872607
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E3B5B4657F;
	Thu, 26 Nov 2026 15:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70011F0093C;
	Thu, 26 Nov 2026 15:22:45 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 26/27] dmaengine: sh: rz-dmac: Add suspend to RAM support
Date: Thu, 26 Nov 2026 17:22:02 +0200
Message-ID: <20261126152204.1297798-27-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
References: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25136
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c13ce43e70719dead7009e7e708971ba1c447568 upstream.

The Renesas RZ/G3S SoC supports a power saving mode in which power to mos=
t
of the SoC components is turned off, including the DMA IP. Add suspend to
RAM support to save and restore the DMA IP registers.

Cyclic DMA channels require special handling. Since they can be paused an=
d
resumed during system suspend/resume, the driver restores additional
registers for these channels during the system resume phase. If a channel
was not explicitly paused during suspend, the driver ensures that it is
paused and resumed as part of the system suspend/resume flow.

Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-16-claudiu.beznea@k=
ernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea:
 - dropped rz_dmac_{v,t}2h_info, rz_dmac_generic_info since these are
   not applicable to v5.10 CIP
 - replace rz_dmac_set_dma_req_no() with rz_dmac_set_dmars_register()
   since the former is NA in v5.10 CIP
 - in rz_dmac_suspend_recover(): replaced PM_RUNTIME_ACQUIRE_IF_ENABLED()=
/
   PM_RUNTIME_ACQUIRE_ERR() in rz_dmac_suspend_recover() with the
   equivalent open-coded pm_runtime_resume_and_get()/pm_runtime_put
 - in rz_dmac_suspend(), rz_dmac_suspend_recover(), rz_dmac_resume():
   moved the declaration of i iterator outside of for block
 - dropped static keyword in front of DEFINE_SIMPLE_DEV_PM_OPS() since th=
e
   macro already includes the static declaration]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 184 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 179 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 5b6d08fdade1..f2ec90e3f52a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -67,10 +67,12 @@ struct rz_dmac_desc {
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine call=
backs
  * @RZ_DMAC_CHAN_STATUS_CYCLIC: Channel is cyclic
+ * @RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL: Channel is paused through drive=
r internal logic
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_PAUSED,
 	RZ_DMAC_CHAN_STATUS_CYCLIC,
+	RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL,
 };
=20
 struct rz_dmac_chan {
@@ -90,6 +92,10 @@ struct rz_dmac_chan {
 	u32 chctrl;
 	int mid_rid;
=20
+	struct {
+		u32 nxla;
+	} pm_state;
+
 	struct list_head ld_free;
=20
 	struct {
@@ -1019,20 +1025,57 @@ static int rz_dmac_device_pause(struct dma_chan *=
chan)
 	return ret;
 }
=20
+static int rz_dmac_device_pause_internal(struct rz_dmac_chan *channel)
+{
+	lockdep_assert_held(&channel->vc.lock);
+
+	/* Skip channels explicitly paused by consummers or disabled. */
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED) ||
+	    !rz_dmac_chan_is_enabled(channel))
+		return 0;
+
+	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED=
_INTERNAL));
+}
+
 static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
 				     unsigned long clear_bitmask)
 {
-	int ret =3D 0;
 	u32 val;
+	int ret;
=20
 	lockdep_assert_held(&channel->vc.lock);
=20
-	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+	/*
+	 * We can be:
+	 *
+	 * 1/ after the channel was paused by a consummer and now it
+	 *    needs to be resummed
+	 * 2/ after the channel was paused internally (as a result of
+	 *    a system suspend with power loss or not)
+	 * 3/ after the channel was paused by a consummer, the system
+	 *    went through a system suspend (with power loss or not)
+	 *    and the consummer wants to resume the channel
+	 *
+	 * To cover all the above cases we set both CLRSUS and SETEN.
+	 *
+	 * In case 1/ setting SETEN while the channel is still enabled
+	 * is harmless for the controller.
+	 *
+	 * In case 2/ the channel is disabled when calling this function
+	 * and setting CLRSUS is harmless for the controller as the
+	 * channel is disabled anyway.
+	 *
+	 * In case 3/ the channel is disabled/enabled if the system
+	 * went though a suspend with power loss/or not and setting
+	 * CLRSUS/SETEN is harmless for the controller as the channel
+	 * is enabled/disabled anyway.
+	 */
+
+	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS | CHCTRL_SETEN, CHCTRL, 1);
=20
-	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
 	ret =3D read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-				       !(val & CHSTAT_SUS), 1, 1024, false,
-				       channel, CHSTAT, 1);
+				       ((val & (CHSTAT_SUS | CHSTAT_EN)) =3D=3D CHSTAT_EN),
+				       1, 1024, false, channel, CHSTAT, 1);
=20
 	channel->status &=3D ~clear_bitmask;
=20
@@ -1063,6 +1106,16 @@ static int rz_dmac_device_resume(struct dma_chan *=
chan)
 	return ret;
 }
=20
+static int rz_dmac_device_resume_internal(struct rz_dmac_chan *channel)
+{
+	lockdep_assert_held(&channel->vc.lock);
+
+	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED_INTERNAL)))
+		return 0;
+
+	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSE=
D_INTERNAL));
+}
+
 /*
  * ---------------------------------------------------------------------=
--------
  * IRQ handling
@@ -1389,6 +1442,126 @@ static int rz_dmac_remove(struct platform_device =
*pdev)
 	return 0;
 }
=20
+static void rz_dmac_suspend_recover(struct rz_dmac *dmac)
+{
+	unsigned int i;
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dmac->dev);
+	if (ret)
+		return;
+
+	for (i =3D 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel =3D &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		rz_dmac_device_resume_internal(channel);
+	}
+
+	pm_runtime_put(dmac->dev);
+}
+
+static int rz_dmac_suspend(struct device *dev)
+{
+	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
+	unsigned int i;
+	int ret =3D 0;
+
+	for (i =3D 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel =3D &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		ret =3D rz_dmac_device_pause_internal(channel);
+		if (ret) {
+			dev_err(dev, "Failed to suspend channel %s\n",
+				dma_chan_name(&channel->vc.chan));
+			break;
+		}
+
+		channel->pm_state.nxla =3D rz_dmac_ch_readl(channel, NXLA, 1);
+	}
+
+	if (ret)
+		goto suspend_recover;
+
+	ret =3D reset_control_assert(dmac->rstc);
+	if (ret)
+		goto suspend_recover;
+
+	ret =3D pm_runtime_put_sync(dev);
+	if (ret < 0)
+		goto reset_deassert;
+
+	return 0;
+
+reset_deassert:
+	reset_control_deassert(dmac->rstc);
+suspend_recover:
+	rz_dmac_suspend_recover(dmac);
+	return ret;
+}
+
+static int rz_dmac_resume(struct device *dev)
+{
+	struct rz_dmac *dmac =3D dev_get_drvdata(dev);
+	int errors =3D 0, ret;
+	unsigned int i;
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret =3D reset_control_deassert(dmac->rstc);
+	if (ret) {
+		/*
+		 * Do not put runtime PM here and keep the same state as in
+		 * probe. As subsequent suspend/resume cycles may follow, leave
+		 * the runtime PM as is, here, to avoid imbalances.
+		 */
+		return ret;
+	}
+
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
+
+	for (i =3D 0; i < dmac->n_channels; i++) {
+		struct rz_dmac_chan *channel =3D &dmac->channels[i];
+
+		guard(spinlock_irqsave)(&channel->vc.lock);
+
+		rz_dmac_disable_hw(&dmac->channels[i]);
+
+		if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_CYCLIC)))
+			continue;
+
+		rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid);
+
+		rz_dmac_ch_writel(channel, channel->pm_state.nxla, NXLA, 1);
+		rz_dmac_ch_writel(channel, channel->chcfg, CHCFG, 1);
+		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
+		rz_dmac_ch_writel(channel, channel->chctrl, CHCTRL, 1);
+
+		ret =3D rz_dmac_device_resume_internal(channel);
+		if (ret) {
+			errors =3D ret;
+			dev_err(dev, "Failed to resume channel %s, ret=3D%d\n",
+				dma_chan_name(&channel->vc.chan), ret);
+		}
+	}
+
+	return errors ? : 0;
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(rz_dmac_pm_ops, rz_dmac_suspend, rz_dmac_resume=
);
+
 static const struct of_device_id of_rz_dmac_match[] =3D {
 	{ .compatible =3D "renesas,rz-dmac", },
 	{ /* Sentinel */ }
@@ -1399,6 +1572,7 @@ static struct platform_driver rz_dmac_driver =3D {
 	.driver		=3D {
 		.name	=3D "rz-dmac",
 		.of_match_table =3D of_rz_dmac_match,
+		.pm	=3D pm_ptr(&rz_dmac_pm_ops),
 	},
 	.probe		=3D rz_dmac_probe,
 	.remove		=3D rz_dmac_remove,
--=20
2.43.0

