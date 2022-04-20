Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6554AC4321E
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.13570.1650490470612843250
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 14:34:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,276,1643641200";
   d="scan'208";a="118607256"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2022 06:34:37 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3CF1D4108B7B;
	Thu, 21 Apr 2022 06:34:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/24] ASoC: sh: rz-ssi: Add SSI DMAC support
Date: Wed, 20 Apr 2022 22:34:05 +0100
Message-Id: <20220420213424.27837-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8127

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 26ac471c5354583cf4fe0e42537a2c6b84d6d74e upstream.

Add SSI DMAC support to RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210813091156.10700-4-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 256 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 224 insertions(+), 32 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 7e0d3a4485e3..4e702b7d5b49 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -7,6 +7,7 @@
 //
 
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -86,6 +87,7 @@ struct rz_ssi_stream {
 	struct rz_ssi_priv *priv;
 	struct snd_pcm_substream *substream;
 	int fifo_sample_size;	/* sample capacity of SSI FIFO */
+	int dma_buffer_pos;	/* The address for the next DMA descriptor */
 	int period_counter;	/* for keeping track of periods transferred */
 	int sample_width;
 	int buffer_pos;		/* current frame position in the buffer */
@@ -94,6 +96,8 @@ struct rz_ssi_stream {
 	int uerr_num;
 	int oerr_num;
 
+	struct dma_chan *dma_ch;
+
 	int (*transfer)(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm);
 };
 
@@ -105,6 +109,7 @@ struct rz_ssi_priv {
 	struct clk *sfr_clk;
 	struct clk *clk;
 
+	phys_addr_t phys;
 	int irq_int;
 	int irq_tx;
 	int irq_rx;
@@ -128,8 +133,11 @@ struct rz_ssi_priv {
 
 	bool lrckp_fsync_fall;	/* LR clock polarity (SSICR.LRCKP) */
 	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
+	bool dma_rt;
 };
 
+static void rz_ssi_dma_complete(void *data);
+
 static void rz_ssi_reg_writel(struct rz_ssi_priv *priv, uint reg, u32 data)
 {
 	writel(data, (priv->base + reg));
@@ -175,6 +183,11 @@ rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *substream)
 	return stream;
 }
 
+static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
+{
+	return (ssi->playback.dma_ch || ssi->capture.dma_ch);
+}
+
 static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
 				  struct rz_ssi_stream *strm)
 {
@@ -196,6 +209,7 @@ static int rz_ssi_stream_init(struct rz_ssi_priv *ssi,
 
 	strm->substream = substream;
 	strm->sample_width = samples_to_bytes(runtime, 1);
+	strm->dma_buffer_pos = 0;
 	strm->period_counter = 0;
 	strm->buffer_pos = 0;
 
@@ -297,9 +311,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	ssifcr = rz_ssi_reg_readl(ssi, SSIFCR) & ~0xF;
 
 	/* FIFO interrupt thresholds */
-	rz_ssi_reg_writel(ssi, SSISCR,
-			  SSISCR_TDES(strm->fifo_sample_size / 2 - 1) |
-			  SSISCR_RDFS(0));
+	if (rz_ssi_is_dma_enabled(ssi))
+		rz_ssi_reg_writel(ssi, SSISCR, 0);
+	else
+		rz_ssi_reg_writel(ssi, SSISCR,
+				  SSISCR_TDES(strm->fifo_sample_size / 2 - 1) |
+				  SSISCR_RDFS(0));
 
 	/* enable IRQ */
 	if (is_play) {
@@ -334,6 +351,10 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	/* Disable TX/RX */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 
+	/* Cancel all remaining DMA transactions */
+	if (rz_ssi_is_dma_enabled(ssi))
+		dmaengine_terminate_async(strm->dma_ch);
+
 	/* Disable irqs */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
 			     SSICR_RUIEN | SSICR_ROIEN, 0);
@@ -549,12 +570,143 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int rz_ssi_dma_slave_config(struct rz_ssi_priv *ssi,
+				   struct dma_chan *dma_ch, bool is_play)
+{
+	struct dma_slave_config cfg;
+
+	memset(&cfg, 0, sizeof(cfg));
+
+	cfg.direction = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	cfg.dst_addr = ssi->phys + SSIFTDR;
+	cfg.src_addr = ssi->phys + SSIFRDR;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+
+	return dmaengine_slave_config(dma_ch, &cfg);
+}
+
+static int rz_ssi_dma_transfer(struct rz_ssi_priv *ssi,
+			       struct rz_ssi_stream *strm)
+{
+	struct snd_pcm_substream *substream = strm->substream;
+	struct dma_async_tx_descriptor *desc;
+	struct snd_pcm_runtime *runtime;
+	enum dma_transfer_direction dir;
+	u32 dma_paddr, dma_size;
+	int amount;
+
+	if (!rz_ssi_stream_is_valid(ssi, strm))
+		return -EINVAL;
+
+	runtime = substream->runtime;
+	if (runtime->status->state == SNDRV_PCM_STATE_DRAINING)
+		/*
+		 * Stream is ending, so do not queue up any more DMA
+		 * transfers otherwise we play partial sound clips
+		 * because we can't shut off the DMA quick enough.
+		 */
+		return 0;
+
+	dir = rz_ssi_stream_is_play(ssi, substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+
+	/* Always transfer 1 period */
+	amount = runtime->period_size;
+
+	/* DMA physical address and size */
+	dma_paddr = runtime->dma_addr + frames_to_bytes(runtime,
+							strm->dma_buffer_pos);
+	dma_size = frames_to_bytes(runtime, amount);
+	desc = dmaengine_prep_slave_single(strm->dma_ch, dma_paddr, dma_size,
+					   dir,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(ssi->dev, "dmaengine_prep_slave_single() fail\n");
+		return -ENOMEM;
+	}
+
+	desc->callback = rz_ssi_dma_complete;
+	desc->callback_param = strm;
+
+	if (dmaengine_submit(desc) < 0) {
+		dev_err(ssi->dev, "dmaengine_submit() fail\n");
+		return -EIO;
+	}
+
+	/* Update DMA pointer */
+	strm->dma_buffer_pos += amount;
+	if (strm->dma_buffer_pos >= runtime->buffer_size)
+		strm->dma_buffer_pos = 0;
+
+	/* Start DMA */
+	dma_async_issue_pending(strm->dma_ch);
+
+	return 0;
+}
+
+static void rz_ssi_dma_complete(void *data)
+{
+	struct rz_ssi_stream *strm = (struct rz_ssi_stream *)data;
+
+	if (!strm->running || !strm->substream || !strm->substream->runtime)
+		return;
+
+	/* Note that next DMA transaction has probably already started */
+	rz_ssi_pointer_update(strm, strm->substream->runtime->period_size);
+
+	/* Queue up another DMA transaction */
+	rz_ssi_dma_transfer(strm->priv, strm);
+}
+
+static void rz_ssi_release_dma_channels(struct rz_ssi_priv *ssi)
+{
+	if (ssi->playback.dma_ch) {
+		dma_release_channel(ssi->playback.dma_ch);
+		ssi->playback.dma_ch = NULL;
+		if (ssi->dma_rt)
+			ssi->dma_rt = false;
+	}
+
+	if (ssi->capture.dma_ch) {
+		dma_release_channel(ssi->capture.dma_ch);
+		ssi->capture.dma_ch = NULL;
+	}
+}
+
+static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
+{
+	ssi->playback.dma_ch = dma_request_chan(dev, "tx");
+	ssi->capture.dma_ch = dma_request_chan(dev, "rx");
+	if (!ssi->playback.dma_ch && !ssi->capture.dma_ch) {
+		ssi->playback.dma_ch = dma_request_chan(dev, "rt");
+		if (!ssi->playback.dma_ch)
+			goto no_dma;
+
+		ssi->dma_rt = true;
+	}
+
+	if (ssi->playback.dma_ch &&
+	    (rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch, true) < 0))
+		goto no_dma;
+
+	if (ssi->capture.dma_ch &&
+	    (rz_ssi_dma_slave_config(ssi, ssi->capture.dma_ch, false) < 0))
+		goto no_dma;
+
+	return 0;
+
+no_dma:
+	rz_ssi_release_dma_channels(ssi);
+
+	return -ENODEV;
+}
+
 static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 			      struct snd_soc_dai *dai)
 {
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
 	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
-	int ret = 0;
+	int ret = 0, i, num_transfer = 1;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -567,9 +719,29 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (ret)
 			goto done;
 
-		ret = strm->transfer(ssi, strm);
-		if (ret)
-			goto done;
+		if (ssi->dma_rt) {
+			bool is_playback;
+
+			is_playback = rz_ssi_stream_is_play(ssi, substream);
+			ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
+						      is_playback);
+			/* Fallback to pio */
+			if (ret < 0) {
+				ssi->playback.transfer = rz_ssi_pio_send;
+				ssi->capture.transfer = rz_ssi_pio_recv;
+				rz_ssi_release_dma_channels(ssi);
+			}
+		}
+
+		/* For DMA, queue up multiple DMA descriptors */
+		if (rz_ssi_is_dma_enabled(ssi))
+			num_transfer = 4;
+
+		for (i = 0; i < num_transfer; i++) {
+			ret = strm->transfer(ssi, strm);
+			if (ret)
+				goto done;
+		}
 
 		ret = rz_ssi_start(ssi, strm);
 		break;
@@ -737,6 +909,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 {
 	struct rz_ssi_priv *ssi;
 	struct clk *audio_clk;
+	struct resource *res;
 	int ret;
 
 	ssi = devm_kzalloc(&pdev->dev, sizeof(*ssi), GFP_KERNEL);
@@ -745,10 +918,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	ssi->pdev = pdev;
 	ssi->dev = &pdev->dev;
-	ssi->base = devm_platform_ioremap_resource(pdev, 0);
+	ssi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ssi->base))
 		return PTR_ERR(ssi->base);
 
+	ssi->phys = res->start;
 	ssi->clk = devm_clk_get(&pdev->dev, "ssi");
 	if (IS_ERR(ssi->clk))
 		return PTR_ERR(ssi->clk);
@@ -775,8 +949,18 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	ssi->audio_mck = ssi->audio_clk_1 ? ssi->audio_clk_1 : ssi->audio_clk_2;
 
-	ssi->playback.transfer = rz_ssi_pio_send;
-	ssi->capture.transfer = rz_ssi_pio_recv;
+	/* Detect DMA support */
+	ret = rz_ssi_dma_request(ssi, &pdev->dev);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
+		ssi->playback.transfer = rz_ssi_pio_send;
+		ssi->capture.transfer = rz_ssi_pio_recv;
+	} else {
+		dev_info(&pdev->dev, "DMA enabled");
+		ssi->playback.transfer = rz_ssi_dma_transfer;
+		ssi->capture.transfer = rz_ssi_dma_transfer;
+	}
+
 	ssi->playback.priv = ssi;
 	ssi->capture.priv = ssi;
 
@@ -792,28 +976,32 @@ static int rz_ssi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "irq request error (int_req)\n");
 
-	/* Tx and Rx interrupts (pio only) */
-	ssi->irq_tx = platform_get_irq_byname(pdev, "dma_tx");
-	if (ssi->irq_tx < 0)
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "Unable to get SSI dma_tx IRQ\n");
-
-	ret = devm_request_irq(&pdev->dev, ssi->irq_tx, &rz_ssi_interrupt, 0,
-			       dev_name(&pdev->dev), ssi);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "irq request error (dma_tx)\n");
-
-	ssi->irq_rx = platform_get_irq_byname(pdev, "dma_rx");
-	if (ssi->irq_rx < 0)
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "Unable to get SSI dma_rx IRQ\n");
-
-	ret = devm_request_irq(&pdev->dev, ssi->irq_rx, &rz_ssi_interrupt, 0,
-			       dev_name(&pdev->dev), ssi);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "irq request error (dma_rx)\n");
+	if (!rz_ssi_is_dma_enabled(ssi)) {
+		/* Tx and Rx interrupts (pio only) */
+		ssi->irq_tx = platform_get_irq_byname(pdev, "dma_tx");
+		if (ssi->irq_tx < 0)
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "Unable to get SSI dma_tx IRQ\n");
+
+		ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
+				       &rz_ssi_interrupt, 0,
+				       dev_name(&pdev->dev), ssi);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "irq request error (dma_tx)\n");
+
+		ssi->irq_rx = platform_get_irq_byname(pdev, "dma_rx");
+		if (ssi->irq_rx < 0)
+			return dev_err_probe(&pdev->dev, -ENODEV,
+					     "Unable to get SSI dma_rx IRQ\n");
+
+		ret = devm_request_irq(&pdev->dev, ssi->irq_rx,
+				       &rz_ssi_interrupt, 0,
+				       dev_name(&pdev->dev), ssi);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "irq request error (dma_rx)\n");
+	}
 
 	ssi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(ssi->rstc))
@@ -829,6 +1017,8 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      rz_ssi_soc_dai,
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
+		rz_ssi_release_dma_channels(ssi);
+
 		pm_runtime_put(ssi->dev);
 		pm_runtime_disable(ssi->dev);
 		reset_control_assert(ssi->rstc);
@@ -842,6 +1032,8 @@ static int rz_ssi_remove(struct platform_device *pdev)
 {
 	struct rz_ssi_priv *ssi = dev_get_drvdata(&pdev->dev);
 
+	rz_ssi_release_dma_channels(ssi);
+
 	pm_runtime_put(ssi->dev);
 	pm_runtime_disable(ssi->dev);
 	reset_control_assert(ssi->rstc);
-- 
2.17.1


