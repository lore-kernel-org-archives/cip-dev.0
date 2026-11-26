Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16123.1795706772472901618
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:26:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D3F3F63699;
	Thu, 26 Nov 2026 15:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD101F000C0;
	Thu, 26 Nov 2026 15:26:10 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/11] ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
Date: Thu, 26 Nov 2026 17:25:51 +0200
Message-ID: <20261126152553.1298561-10-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
References: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25147
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9fcaec81ac56c9d2c5d779ffb5a76b622b4d0590 upstream.

On Renesas RZ/G2L and RZ/G3S SoCs (where this was tested), captured audio
files occasionally contained random spikes when viewed with a tool such
as Audacity. These spikes were also audible as popping noises.

Using cyclic DMA resolves this issue. The driver was reworked to use the
existing support provided by the generic PCM dmaengine APIs. In addition
to eliminating the random spikes, the following issues were addressed:
- blank periods at the beginning of recorded files, which occurred
  intermittently, are no longer present
- no overruns or underruns were observed when continuously recording
  short audio files (e.g. 5 seconds long) in a loop
- concurrency issues in the SSI driver when enqueuing DMA requests were
  eliminated; previously, DMA requests could be prepared and submitted
  both from the DMA completion callback and the interrupt handler, which
  led to crashes after several hours of testing
- the SSI driver logic is simplified
- the number of generated interrupts is reduced by approximately 250%

In the SSI platform driver probe function, the following changes were
made:
- the driver-specific DMA configuration was removed in favor of the
  generic PCM dmaengine APIs. As a result, explicit cleanup goto labels
  are no longer required and the driver remove callback was dropped,
  since resource management is now handled via devres helpers
- special handling was added for IP variants operating in half-duplex
  mode, where the DMA channel name in the device tree is "rt"; this DMA
  channel name is taken into account and passed to the generic PCM
  dmaengine configuration data

All code previously responsible for preparing and completing DMA
transfers was removed, as this functionality is now handled entirely by
the generic PCM dmaengine APIs.

Since DMA channels must be paused and resumed during recovery paths
(overruns and underruns reported by the hardware), the DMA channel
references are stored in rz_ssi_hw_params().

The logic in rz_ssi_is_dma_enabled() was updated to reflect that the
driver no longer manages DMA transfers directly.

To avoid software reported underruns (e.g. when running aplay during
consecutive suspend/resume cycles, or when the CPU is nearly 100%
loaded), rz_ssi_pcm_hardware.buffer_bytes_max was increased to 192K.
At the same time, rz_ssi_pcm_hardware.period_bytes_max was set to 48K
to reduce interrupt overhead.

Finally, rz_ssi_stream_is_play() was removed, as it had only a single
remaining user after this rework, and its logic was inlined at the call
site.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-18-claudiu.beznea@k=
ernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea:
 - fixed conflict by dropping the code dropped by the backported commit
 - dropped legacy_dai_naming initialization in rz_ssi_soc_component_pio
   since it is NA in v5.10 CIP
 - used .pcm_construct() instad of .pcm_new() in rz_ssi_soc_component_pio
 - moved snd_soc_dai_ops::probe() initialization to snd_soc_dai_driver::p=
robe()
   since the former is NA in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/Kconfig  |   1 +
 sound/soc/sh/rz-ssi.c | 401 +++++++++++++++---------------------------
 2 files changed, 138 insertions(+), 264 deletions(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 96d9d7160f30..a3182ced8f61 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -47,6 +47,7 @@ config SND_SOC_RCAR
 config SND_SOC_RZ
 	tristate "RZ/G2L series SSIF-2 support"
 	depends on ARCH_RZG2L || COMPILE_TEST
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  This option enables RZ/G2L SSIF-2 sound support.
=20
diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 1f0d25905631..09f4f7744a56 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -14,6 +14,8 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
=20
@@ -88,8 +90,6 @@ struct rz_ssi_stream {
 	struct rz_ssi_priv *priv;
 	struct snd_pcm_substream *substream;
 	int fifo_sample_size;	/* sample capacity of SSI FIFO */
-	int dma_buffer_pos;	/* The address for the next DMA descriptor */
-	int completed_dma_buf_pos; /* The address of the last completed DMA des=
criptor. */
 	int period_counter;	/* for keeping track of periods transferred */
 	int buffer_pos;		/* current frame position in the buffer */
 	int running;		/* 0=3Dstopped, 1=3Drunning */
@@ -97,8 +97,6 @@ struct rz_ssi_stream {
 	int uerr_num;
 	int oerr_num;
=20
-	struct dma_chan *dma_ch;
-
 	int (*transfer)(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm);
 };
=20
@@ -109,7 +107,6 @@ struct rz_ssi_priv {
 	struct clk *sfr_clk;
 	struct clk *clk;
=20
-	phys_addr_t phys;
 	int irq_int;
 	int irq_tx;
 	int irq_rx;
@@ -149,9 +146,10 @@ struct rz_ssi_priv {
 		unsigned int sample_width;
 		unsigned int sample_bits;
 	} hw_params_cache;
-};
=20
-static void rz_ssi_dma_complete(void *data);
+	struct snd_dmaengine_dai_dma_data dma_dais[SNDRV_PCM_STREAM_LAST + 1];
+	struct dma_chan *dmas[SNDRV_PCM_STREAM_LAST + 1];
+};
=20
 static void rz_ssi_reg_writel(struct rz_ssi_priv *priv, uint reg, u32 da=
ta)
 {
@@ -181,11 +179,6 @@ rz_ssi_get_dai(struct snd_pcm_substream *substream)
 	return asoc_rtd_to_cpu(rtd, 0);
 }
=20
-static inline bool rz_ssi_stream_is_play(struct snd_pcm_substream *subst=
ream)
-{
-	return substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
-}
-
 static inline struct rz_ssi_stream *
 rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *sub=
stream)
 {
@@ -194,7 +187,7 @@ rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd=
_pcm_substream *substream)
=20
 static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
 {
-	return (ssi->playback.dma_ch && (ssi->dma_rt || ssi->capture.dma_ch));
+	return !ssi->playback.transfer && !ssi->capture.transfer;
 }
=20
 static void rz_ssi_set_substream(struct rz_ssi_stream *strm,
@@ -224,8 +217,6 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *=
strm,
 			       struct snd_pcm_substream *substream)
 {
 	rz_ssi_set_substream(strm, substream);
-	strm->dma_buffer_pos =3D 0;
-	strm->completed_dma_buf_pos =3D 0;
 	strm->period_counter =3D 0;
 	strm->buffer_pos =3D 0;
=20
@@ -251,12 +242,13 @@ static void rz_ssi_stream_quit(struct rz_ssi_priv *=
ssi,
 		dev_info(dai->dev, "underrun =3D %d\n", strm->uerr_num);
 }
=20
-static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
-			    unsigned int channels)
+static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, struct snd_pcm_subs=
tream *substream,
+			    unsigned int rate, unsigned int channels)
 {
 	static u8 ckdv[] =3D { 1,  2,  4,  8, 16, 32, 64, 128, 6, 12, 24, 48, 9=
6 };
 	unsigned int channel_bits =3D 32;	/* System Word Length */
 	unsigned long bclk_rate =3D rate * channels * channel_bits;
+	struct snd_dmaengine_dai_dma_data *dma_dai;
 	unsigned int div;
 	unsigned int i;
 	u32 ssicr =3D 0;
@@ -299,6 +291,8 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, =
unsigned int rate,
 		return -EINVAL;
 	}
=20
+	dma_dai =3D &ssi->dma_dais[substream->stream];
+
 	/*
 	 * DWL: Data Word Length =3D {16, 24, 32} bits
 	 * SWL: System Word Length =3D 32 bits
@@ -307,12 +301,15 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi=
, unsigned int rate,
 	switch (ssi->hw_params_cache.sample_width) {
 	case 16:
 		ssicr |=3D SSICR_DWL(1);
+		dma_dai->addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
 	case 24:
 		ssicr |=3D SSICR_DWL(5) | SSICR_PDTA;
+		dma_dai->addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	case 32:
 		ssicr |=3D SSICR_DWL(6);
+		dma_dai->addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
 		break;
 	default:
 		dev_err(ssi->dev, "Not support %u data width",
@@ -355,7 +352,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
=20
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *s=
trm)
 {
-	bool is_play =3D rz_ssi_stream_is_play(strm->substream);
+	bool is_play =3D strm->substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBA=
CK;
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
=20
@@ -434,14 +431,6 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, stru=
ct rz_ssi_stream *strm)
 	/* Disable TX/RX */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
=20
-	/* Cancel all remaining DMA transactions */
-	if (rz_ssi_is_dma_enabled(ssi)) {
-		if (ssi->playback.dma_ch)
-			dmaengine_terminate_async(ssi->playback.dma_ch);
-		if (ssi->capture.dma_ch)
-			dmaengine_terminate_async(ssi->capture.dma_ch);
-	}
-
 	rz_ssi_set_idle(ssi);
=20
 	return 0;
@@ -469,10 +458,6 @@ static void rz_ssi_pointer_update(struct rz_ssi_stre=
am *strm, int frames)
 		snd_pcm_period_elapsed(strm->substream);
 		strm->period_counter =3D current_period;
 	}
-
-	strm->completed_dma_buf_pos +=3D runtime->period_size;
-	if (strm->completed_dma_buf_pos >=3D runtime->buffer_size)
-		strm->completed_dma_buf_pos =3D 0;
 }
=20
 static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream=
 *strm)
@@ -617,12 +602,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *d=
ata)
 	if (irq =3D=3D ssi->irq_int) { /* error or idle */
 		bool is_stopped =3D !!(ssisr & (SSISR_RUIRQ | SSISR_ROIRQ |
 					      SSISR_TUIRQ | SSISR_TOIRQ));
-		int i, count;
-
-		if (rz_ssi_is_dma_enabled(ssi))
-			count =3D 4;
-		else
-			count =3D 1;
=20
 		if (ssi->capture.substream && is_stopped) {
 			if (ssisr & SSISR_RUIRQ)
@@ -642,19 +621,41 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *=
data)
 			rz_ssi_stop(ssi, strm_playback);
 		}
=20
+		if (!rz_ssi_is_stream_running(&ssi->playback) &&
+		    !rz_ssi_is_stream_running(&ssi->capture) &&
+		    rz_ssi_is_dma_enabled(ssi) && is_stopped) {
+			if (ssi->playback.substream &&
+			    ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK])
+				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
+			if (ssi->capture.substream &&
+			    ssi->dmas[SNDRV_PCM_STREAM_CAPTURE] &&
+			    /* Avoid calling pause twice in case of half duplex. */
+			    ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK] !=3D
+			    ssi->dmas[SNDRV_PCM_STREAM_CAPTURE])
+				dmaengine_pause(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
+		}
+
 		/* Clear all flags */
 		rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ | SSISR_TUIRQ |
 				     SSISR_ROIRQ | SSISR_RUIRQ, 0);
=20
 		/* Add/remove more data */
 		if (ssi->capture.substream && is_stopped) {
-			for (i =3D 0; i < count; i++)
+			if (rz_ssi_is_dma_enabled(ssi)) {
+				if (ssi->dmas[SNDRV_PCM_STREAM_CAPTURE])
+					dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_CAPTURE]);
+			} else {
 				strm_capture->transfer(ssi, strm_capture);
+			}
 		}
=20
 		if (ssi->playback.substream && is_stopped) {
-			for (i =3D 0; i < count; i++)
+			if (rz_ssi_is_dma_enabled(ssi)) {
+				if (ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK])
+					dmaengine_resume(ssi->dmas[SNDRV_PCM_STREAM_PLAYBACK]);
+			} else {
 				strm_playback->transfer(ssi, strm_playback);
+			}
 		}
=20
 		/* Resume */
@@ -690,153 +691,11 @@ static irqreturn_t rz_ssi_interrupt(int irq, void =
*data)
 	return IRQ_HANDLED;
 }
=20
-static int rz_ssi_dma_slave_config(struct rz_ssi_priv *ssi,
-				   struct dma_chan *dma_ch, bool is_play)
-{
-	struct dma_slave_config cfg;
-
-	memset(&cfg, 0, sizeof(cfg));
-
-	cfg.direction =3D is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
-	cfg.dst_addr =3D ssi->phys + SSIFTDR;
-	cfg.src_addr =3D ssi->phys + SSIFRDR;
-	if (ssi->hw_params_cache.sample_width =3D=3D 16) {
-		cfg.src_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
-		cfg.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
-	} else {
-		cfg.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
-		cfg.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
-	}
-
-	return dmaengine_slave_config(dma_ch, &cfg);
-}
-
-static int rz_ssi_dma_transfer(struct rz_ssi_priv *ssi,
-			       struct rz_ssi_stream *strm)
-{
-	struct snd_pcm_substream *substream =3D strm->substream;
-	struct dma_async_tx_descriptor *desc;
-	struct snd_pcm_runtime *runtime;
-	enum dma_transfer_direction dir;
-	u32 dma_paddr, dma_size;
-	int amount;
-
-	if (!rz_ssi_stream_is_valid(ssi, strm))
-		return -EINVAL;
-
-	runtime =3D substream->runtime;
-	if (runtime->status->state =3D=3D SNDRV_PCM_STATE_DRAINING)
-		/*
-		 * Stream is ending, so do not queue up any more DMA
-		 * transfers otherwise we play partial sound clips
-		 * because we can't shut off the DMA quick enough.
-		 */
-		return 0;
-
-	dir =3D rz_ssi_stream_is_play(substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_=
MEM;
-
-	/* Always transfer 1 period */
-	amount =3D runtime->period_size;
-
-	/* DMA physical address and size */
-	dma_paddr =3D runtime->dma_addr + frames_to_bytes(runtime,
-							strm->dma_buffer_pos);
-	dma_size =3D frames_to_bytes(runtime, amount);
-	desc =3D dmaengine_prep_slave_single(strm->dma_ch, dma_paddr, dma_size,
-					   dir,
-					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-	if (!desc) {
-		dev_err(ssi->dev, "dmaengine_prep_slave_single() fail\n");
-		return -ENOMEM;
-	}
-
-	desc->callback =3D rz_ssi_dma_complete;
-	desc->callback_param =3D strm;
-
-	if (dmaengine_submit(desc) < 0) {
-		dev_err(ssi->dev, "dmaengine_submit() fail\n");
-		return -EIO;
-	}
-
-	/* Update DMA pointer */
-	strm->dma_buffer_pos +=3D amount;
-	if (strm->dma_buffer_pos >=3D runtime->buffer_size)
-		strm->dma_buffer_pos =3D 0;
-
-	/* Start DMA */
-	dma_async_issue_pending(strm->dma_ch);
-
-	return 0;
-}
-
-static void rz_ssi_dma_complete(void *data)
-{
-	struct rz_ssi_stream *strm =3D (struct rz_ssi_stream *)data;
-
-	if (!strm->running || !strm->substream || !strm->substream->runtime)
-		return;
-
-	/* Note that next DMA transaction has probably already started */
-	rz_ssi_pointer_update(strm, strm->substream->runtime->period_size);
-
-	/* Queue up another DMA transaction */
-	rz_ssi_dma_transfer(strm->priv, strm);
-}
-
-static void rz_ssi_release_dma_channels(struct rz_ssi_priv *ssi)
-{
-	if (ssi->playback.dma_ch) {
-		dma_release_channel(ssi->playback.dma_ch);
-		ssi->playback.dma_ch =3D NULL;
-		if (ssi->dma_rt)
-			ssi->dma_rt =3D false;
-	}
-
-	if (ssi->capture.dma_ch) {
-		dma_release_channel(ssi->capture.dma_ch);
-		ssi->capture.dma_ch =3D NULL;
-	}
-}
-
-static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *de=
v)
-{
-	ssi->playback.dma_ch =3D dma_request_chan(dev, "tx");
-	if (IS_ERR(ssi->playback.dma_ch))
-		ssi->playback.dma_ch =3D NULL;
-
-	ssi->capture.dma_ch =3D dma_request_chan(dev, "rx");
-	if (IS_ERR(ssi->capture.dma_ch))
-		ssi->capture.dma_ch =3D NULL;
-
-	if (!ssi->playback.dma_ch && !ssi->capture.dma_ch) {
-		ssi->playback.dma_ch =3D dma_request_chan(dev, "rt");
-		if (IS_ERR(ssi->playback.dma_ch)) {
-			ssi->playback.dma_ch =3D NULL;
-			goto no_dma;
-		}
-
-		ssi->dma_rt =3D true;
-	}
-
-	if (!rz_ssi_is_dma_enabled(ssi))
-		goto no_dma;
-
-	return 0;
-
-no_dma:
-	rz_ssi_release_dma_channels(ssi);
-
-	return -ENODEV;
-}
-
 static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi, struct rz_ssi_=
stream *strm)
 {
 	struct snd_pcm_substream *substream =3D strm->substream;
-	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	int ret;
=20
-	strm->dma_buffer_pos =3D strm->completed_dma_buf_pos + runtime->period_=
size;
-
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture))
 		return 0;
@@ -845,7 +704,7 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *=
ssi, struct rz_ssi_stream *
 	if (ret)
 		return ret;
=20
-	return rz_ssi_clk_setup(ssi, ssi->hw_params_cache.rate,
+	return rz_ssi_clk_setup(ssi, substream, ssi->hw_params_cache.rate,
 				ssi->hw_params_cache.channels);
 }
=20
@@ -854,7 +713,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substrea=
m *substream, int cmd,
 {
 	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
 	struct rz_ssi_stream *strm =3D rz_ssi_stream_get(ssi, substream);
-	int ret =3D 0, i, num_transfer =3D 1;
+	int ret =3D 0;
=20
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
@@ -869,28 +728,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substre=
am *substream, int cmd,
 		if (cmd =3D=3D SNDRV_PCM_TRIGGER_START)
 			rz_ssi_stream_init(strm, substream);
=20
-		if (rz_ssi_is_dma_enabled(ssi)) {
-			bool is_playback =3D rz_ssi_stream_is_play(substream);
-
-			if (ssi->dma_rt)
-				ret =3D rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
-							      is_playback);
-			else
-				ret =3D rz_ssi_dma_slave_config(ssi, strm->dma_ch,
-							      is_playback);
-
-			/* Fallback to pio */
-			if (ret < 0) {
-				ssi->playback.transfer =3D rz_ssi_pio_send;
-				ssi->capture.transfer =3D rz_ssi_pio_recv;
-				rz_ssi_release_dma_channels(ssi);
-			} else {
-				/* For DMA, queue up multiple DMA descriptors */
-				num_transfer =3D 4;
-			}
-		}
-
-		for (i =3D 0; i < num_transfer; i++) {
+		if (!rz_ssi_is_dma_enabled(ssi)) {
 			ret =3D strm->transfer(ssi, strm);
 			if (ret)
 				return ret;
@@ -986,6 +824,8 @@ static void rz_ssi_shutdown(struct snd_pcm_substream =
*substream,
 		ssi->dup.tx_active =3D false;
 	else
 		ssi->dup.rx_active =3D false;
+
+	ssi->dmas[substream->stream] =3D NULL;
 }
=20
 static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned =
int rate,
@@ -1037,6 +877,12 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_subs=
tream *substream,
 		return -EINVAL;
 	}
=20
+	/* Save the DMA channels for recovery. */
+	if (rz_ssi_is_dma_enabled(ssi))
+		ssi->dmas[substream->stream] =3D snd_dmaengine_pcm_get_chan(substream)=
;
+	else
+		ssi->dmas[substream->stream] =3D NULL;
+
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture)) {
 		if (rz_ssi_is_valid_hw_params(ssi, rate, channels, sample_width, sampl=
e_bits))
@@ -1052,7 +898,17 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_subs=
tream *substream,
 	if (ret)
 		return ret;
=20
-	return rz_ssi_clk_setup(ssi, rate, channels);
+	return rz_ssi_clk_setup(ssi, substream, rate, channels);
+}
+
+static int rz_ssi_dai_probe(struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi =3D snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &ssi->dma_dais[SNDRV_PCM_STREAM_PLAYBACK=
],
+				  &ssi->dma_dais[SNDRV_PCM_STREAM_CAPTURE]);
+
+	return 0;
 }
=20
 static const struct snd_soc_dai_ops rz_ssi_dai_ops =3D {
@@ -1069,9 +925,9 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hard=
ware =3D {
 				  SNDRV_PCM_INFO_MMAP_VALID	|
 				  SNDRV_PCM_INFO_RESUME		|
 				  SNDRV_PCM_INFO_PAUSE,
-	.buffer_bytes_max	=3D PREALLOC_BUFFER,
+	.buffer_bytes_max	=3D 192 * 1024,
 	.period_bytes_min	=3D 32,
-	.period_bytes_max	=3D 8192,
+	.period_bytes_max	=3D 48 * 1024,
 	.channels_min		=3D SSI_CHAN_MIN,
 	.channels_max		=3D SSI_CHAN_MAX,
 	.periods_min		=3D 1,
@@ -1079,8 +935,8 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hard=
ware =3D {
 	.fifo_size		=3D 32 * 2,
 };
=20
-static int rz_ssi_pcm_open(struct snd_soc_component *component,
-			   struct snd_pcm_substream *substream)
+static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
 {
 	snd_soc_set_runtime_hwparams(substream, &rz_ssi_pcm_hardware);
=20
@@ -1088,6 +944,13 @@ static int rz_ssi_pcm_open(struct snd_soc_component=
 *component,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
 }
=20
+static int rz_ssi_pcm_open_dma(struct snd_soc_component *component,
+			       struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_integer(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_PERIODS);
+}
+
 static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *co=
mponent,
 					    struct snd_pcm_substream *substream)
 {
@@ -1103,7 +966,8 @@ static int rz_ssi_pcm_new(struct snd_soc_component *=
component,
 {
 	snd_pcm_set_managed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
 				       rtd->card->snd_card->dev,
-				       PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+				       rz_ssi_pcm_hardware.buffer_bytes_max,
+				       rz_ssi_pcm_hardware.buffer_bytes_max);
 	return 0;
 }
=20
@@ -1123,18 +987,32 @@ static struct snd_soc_dai_driver rz_ssi_soc_dai[] =
=3D {
 			.channels_max	=3D SSI_CHAN_MAX,
 		},
 		.ops =3D &rz_ssi_dai_ops,
+		.probe =3D rz_ssi_dai_probe,
 	},
 };
=20
-static const struct snd_soc_component_driver rz_ssi_soc_component =3D {
-	.name		=3D "rz-ssi",
-	.open		=3D rz_ssi_pcm_open,
-	.pointer	=3D rz_ssi_pcm_pointer,
-	.pcm_construct	=3D rz_ssi_pcm_new,
+static const struct snd_soc_component_driver rz_ssi_soc_component_pio =3D=
 {
+	.name			=3D "rz-ssi",
+	.open			=3D rz_ssi_pcm_open_pio,
+	.pointer		=3D rz_ssi_pcm_pointer,
+	.pcm_construct		=3D rz_ssi_pcm_new,
+};
+
+static const struct snd_soc_component_driver rz_ssi_soc_component_dma =3D=
 {
+	.name			=3D "rz-ssi",
+	.open			=3D rz_ssi_pcm_open_dma,
+};
+
+static const struct snd_dmaengine_pcm_config rz_ssi_dmaengine_pcm_conf =3D=
 {
+	.pcm_hardware		=3D &rz_ssi_pcm_hardware,
+	.prealloc_buffer_size	=3D 192 * 1024,
+	.prepare_slave_config	=3D snd_dmaengine_pcm_prepare_slave_config,
 };
=20
 static int rz_ssi_probe(struct platform_device *pdev)
 {
+	const struct snd_soc_component_driver *component_driver;
+	struct device_node *np =3D pdev->dev.of_node;
 	struct device *dev =3D &pdev->dev;
 	struct rz_ssi_priv *ssi;
 	struct clk *audio_clk;
@@ -1150,7 +1028,6 @@ static int rz_ssi_probe(struct platform_device *pde=
v)
 	if (IS_ERR(ssi->base))
 		return PTR_ERR(ssi->base);
=20
-	ssi->phys =3D res->start;
 	ssi->clk =3D devm_clk_get(dev, "ssi");
 	if (IS_ERR(ssi->clk))
 		return PTR_ERR(ssi->clk);
@@ -1174,16 +1051,43 @@ static int rz_ssi_probe(struct platform_device *p=
dev)
=20
 	ssi->audio_mck =3D ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk=
_2;
=20
-	/* Detect DMA support */
-	ret =3D rz_ssi_dma_request(ssi, dev);
-	if (ret < 0) {
+	ssi->dma_dais[SNDRV_PCM_STREAM_PLAYBACK].addr =3D (dma_addr_t)res->star=
t + SSIFTDR;
+	ssi->dma_dais[SNDRV_PCM_STREAM_CAPTURE].addr =3D  (dma_addr_t)res->star=
t + SSIFRDR;
+
+	if (of_property_present(np, "dma-names")) {
+		struct snd_dmaengine_pcm_config *config;
+		unsigned int flags =3D 0;
+
+		config =3D devm_kzalloc(dev, sizeof(*config), GFP_KERNEL);
+		if (!config)
+			return -ENOMEM;
+
+		config->pcm_hardware =3D rz_ssi_dmaengine_pcm_conf.pcm_hardware;
+		config->prealloc_buffer_size =3D rz_ssi_dmaengine_pcm_conf.prealloc_bu=
ffer_size;
+		config->prepare_slave_config =3D rz_ssi_dmaengine_pcm_conf.prepare_sla=
ve_config;
+
+		if (of_property_match_string(np, "dma-names", "rt") =3D=3D 0) {
+			flags =3D SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX;
+			config->chan_names[SNDRV_PCM_STREAM_PLAYBACK] =3D "rt";
+		} else {
+			config->chan_names[SNDRV_PCM_STREAM_PLAYBACK] =3D "tx";
+			config->chan_names[SNDRV_PCM_STREAM_CAPTURE] =3D "rx";
+		}
+		ret =3D devm_snd_dmaengine_pcm_register(&pdev->dev, config, flags);
+	} else {
+		ret =3D -ENODEV;
+	}
+
+	if (ret =3D=3D -EPROBE_DEFER) {
+		return ret;
+	} else if (ret) {
 		dev_warn(dev, "DMA not available, using PIO\n");
 		ssi->playback.transfer =3D rz_ssi_pio_send;
 		ssi->capture.transfer =3D rz_ssi_pio_recv;
+		component_driver =3D &rz_ssi_soc_component_pio;
 	} else {
-		dev_info(dev, "DMA enabled");
-		ssi->playback.transfer =3D rz_ssi_dma_transfer;
-		ssi->capture.transfer =3D rz_ssi_dma_transfer;
+		dev_info(dev, "DMA enabled\n");
+		component_driver =3D &rz_ssi_soc_component_dma;
 	}
=20
 	ssi->playback.priv =3D ssi;
@@ -1194,17 +1098,13 @@ static int rz_ssi_probe(struct platform_device *p=
dev)
=20
 	/* Error Interrupt */
 	ssi->irq_int =3D platform_get_irq_byname(pdev, "int_req");
-	if (ssi->irq_int < 0) {
-		ret =3D ssi->irq_int;
-		goto err_release_dma_chs;
-	}
+	if (ssi->irq_int < 0)
+		return ssi->irq_int;
=20
 	ret =3D devm_request_irq(dev, ssi->irq_int, rz_ssi_interrupt,
 			       0, dev_name(dev), ssi);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "irq request error (int_req)\n");
-		goto err_release_dma_chs;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "irq request error (int_req)\n");
=20
 	if (!rz_ssi_is_dma_enabled(ssi)) {
 		/* Tx and Rx interrupts (pio only) */
@@ -1245,45 +1145,19 @@ static int rz_ssi_probe(struct platform_device *p=
dev)
 	}
=20
 	ssi->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(ssi->rstc)) {
-		ret =3D PTR_ERR(ssi->rstc);
-		goto err_release_dma_chs;
-	}
+	if (IS_ERR(ssi->rstc))
+		return dev_err_probe(dev, PTR_ERR(ssi->rstc), "Failed to get reset\n")=
;
=20
 	/* Default 0 for power saving. Can be overridden via sysfs. */
 	pm_runtime_set_autosuspend_delay(dev, 0);
 	pm_runtime_use_autosuspend(dev);
 	ret =3D devm_pm_runtime_enable(dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable runtime PM!\n");
-		goto err_release_dma_chs;
-	}
-
-	ret =3D devm_snd_soc_register_component(dev, &rz_ssi_soc_component,
-					      rz_ssi_soc_dai,
-					      ARRAY_SIZE(rz_ssi_soc_dai));
-	if (ret < 0) {
-		dev_err(dev, "failed to register snd component\n");
-		goto err_release_dma_chs;
-	}
-
-	return 0;
-
-err_release_dma_chs:
-	rz_ssi_release_dma_channels(ssi);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM!\n");
=20
-	return ret;
-}
-
-static int rz_ssi_remove(struct platform_device *pdev)
-{
-	struct rz_ssi_priv *ssi =3D dev_get_drvdata(&pdev->dev);
-
-	rz_ssi_release_dma_channels(ssi);
-
-	reset_control_assert(ssi->rstc);
-
-	return 0;
+	return devm_snd_soc_register_component(dev, component_driver,
+					       rz_ssi_soc_dai,
+					       ARRAY_SIZE(rz_ssi_soc_dai));
 }
=20
 static const struct of_device_id rz_ssi_of_match[] =3D {
@@ -1318,7 +1192,6 @@ static struct platform_driver rz_ssi_driver =3D {
 		.pm =3D pm_ptr(&rz_ssi_pm_ops),
 	},
 	.probe		=3D rz_ssi_probe,
-	.remove		=3D rz_ssi_remove,
 };
=20
 module_platform_driver(rz_ssi_driver);
--=20
2.43.0

