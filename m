Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC410CF6D42
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:04:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1049.1727888664329825039
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:04:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="220602638"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Oct 2024 02:04:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6CA41402586C;
	Thu,  3 Oct 2024 02:04:27 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 04/16] ASoC: sh: rz-ssi: Add full duplex support
Date: Wed,  2 Oct 2024 18:03:57 +0100
Message-ID: <20241002170417.655339-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:04:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16952

commit 4f8cd05a43058b165b83f12f656e60415d2ff5be upstream.

Add full duplex support, to support simultaneous
playback/record on the same ssi channel.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20240715092322.119879-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 257 ++++++++++++++++++++++++++++++------------
 1 file changed, 182 insertions(+), 75 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index d502aa55c5a8..6972b70baf73 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -53,6 +53,7 @@
 #define SSIFCR_RIE		BIT(2)
 #define SSIFCR_TFRST		BIT(1)
 #define SSIFCR_RFRST		BIT(0)
+#define SSIFCR_FIFO_RST		(SSIFCR_TFRST | SSIFCR_RFRST)
 
 #define SSIFSR_TDC_MASK		0x3f
 #define SSIFSR_TDC_SHIFT	24
@@ -131,6 +132,14 @@ struct rz_ssi_priv {
 	bool lrckp_fsync_fall;	/* LR clock polarity (SSICR.LRCKP) */
 	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
 	bool dma_rt;
+
+	/* Full duplex communication support */
+	struct {
+		unsigned int rate;
+		unsigned int channels;
+		unsigned int sample_width;
+		unsigned int sample_bits;
+	} hw_params_cache;
 };
 
 static void rz_ssi_dma_complete(void *data);
@@ -209,6 +218,11 @@ static bool rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
 	return ret;
 }
 
+static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
+{
+	return strm->substream && strm->running;
+}
+
 static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 			       struct snd_pcm_substream *substream)
 {
@@ -304,13 +318,53 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 	return 0;
 }
 
+static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
+{
+	int timeout;
+
+	/* Disable irqs */
+	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
+			     SSICR_RUIEN | SSICR_ROIEN, 0);
+	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
+
+	/* Clear all error flags */
+	rz_ssi_reg_mask_setl(ssi, SSISR,
+			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
+			      SSISR_RUIRQ), 0);
+
+	/* Wait for idle */
+	timeout = 100;
+	while (--timeout) {
+		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
+			break;
+		udelay(1);
+	}
+
+	if (!timeout)
+		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
+
+	/* Hold FIFOs in reset */
+	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
+			     SSIFCR_TFRST | SSIFCR_RFRST);
+}
+
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
 	bool is_play = rz_ssi_stream_is_play(ssi, strm->substream);
+	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
+	is_full_duplex = rz_ssi_is_stream_running(&ssi->playback) ||
+		rz_ssi_is_stream_running(&ssi->capture);
 	ssicr = rz_ssi_reg_readl(ssi, SSICR);
-	ssifcr = rz_ssi_reg_readl(ssi, SSIFCR) & ~0xF;
+	ssifcr = rz_ssi_reg_readl(ssi, SSIFCR);
+	if (!is_full_duplex) {
+		ssifcr &= ~0xF;
+	} else {
+		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
+		rz_ssi_set_idle(ssi);
+		ssifcr &= ~SSIFCR_FIFO_RST;
+	}
 
 	/* FIFO interrupt thresholds */
 	if (rz_ssi_is_dma_enabled(ssi))
@@ -323,10 +377,14 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	/* enable IRQ */
 	if (is_play) {
 		ssicr |= SSICR_TUIEN | SSICR_TOIEN;
-		ssifcr |= SSIFCR_TIE | SSIFCR_RFRST;
+		ssifcr |= SSIFCR_TIE;
+		if (!is_full_duplex)
+			ssifcr |= SSIFCR_RFRST;
 	} else {
 		ssicr |= SSICR_RUIEN | SSICR_ROIEN;
-		ssifcr |= SSIFCR_RIE | SSIFCR_TFRST;
+		ssifcr |= SSIFCR_RIE;
+		if (!is_full_duplex)
+			ssifcr |= SSIFCR_TFRST;
 	}
 
 	rz_ssi_reg_writel(ssi, SSICR, ssicr);
@@ -338,7 +396,11 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 			      SSISR_RUIRQ), 0);
 
 	strm->running = 1;
-	ssicr |= is_play ? SSICR_TEN : SSICR_REN;
+	if (is_full_duplex)
+		ssicr |= SSICR_TEN | SSICR_REN;
+	else
+		ssicr |= is_play ? SSICR_TEN : SSICR_REN;
+
 	rz_ssi_reg_writel(ssi, SSICR, ssicr);
 
 	return 0;
@@ -346,10 +408,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 
 static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
-	int timeout;
-
 	strm->running = 0;
 
+	if (rz_ssi_is_stream_running(&ssi->playback) ||
+	    rz_ssi_is_stream_running(&ssi->capture))
+		return 0;
+
 	/* Disable TX/RX */
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 
@@ -357,30 +421,7 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	if (rz_ssi_is_dma_enabled(ssi))
 		dmaengine_terminate_async(strm->dma_ch);
 
-	/* Disable irqs */
-	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TUIEN | SSICR_TOIEN |
-			     SSICR_RUIEN | SSICR_ROIEN, 0);
-	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_TIE | SSIFCR_RIE, 0);
-
-	/* Clear all error flags */
-	rz_ssi_reg_mask_setl(ssi, SSISR,
-			     (SSISR_TOIRQ | SSISR_TUIRQ | SSISR_ROIRQ |
-			      SSISR_RUIRQ), 0);
-
-	/* Wait for idle */
-	timeout = 100;
-	while (--timeout) {
-		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
-			break;
-		udelay(1);
-	}
-
-	if (!timeout)
-		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
-
-	/* Hold FIFOs in reset */
-	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
-			     SSIFCR_TFRST | SSIFCR_RFRST);
+	rz_ssi_set_idle(ssi);
 
 	return 0;
 }
@@ -513,66 +554,90 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 
 static irqreturn_t rz_ssi_interrupt(int irq, void *data)
 {
-	struct rz_ssi_stream *strm = NULL;
+	struct rz_ssi_stream *strm_playback = NULL;
+	struct rz_ssi_stream *strm_capture = NULL;
 	struct rz_ssi_priv *ssi = data;
 	u32 ssisr = rz_ssi_reg_readl(ssi, SSISR);
 
 	if (ssi->playback.substream)
-		strm = &ssi->playback;
-	else if (ssi->capture.substream)
-		strm = &ssi->capture;
-	else
+		strm_playback = &ssi->playback;
+	if (ssi->capture.substream)
+		strm_capture = &ssi->capture;
+
+	if (!strm_playback && !strm_capture)
 		return IRQ_HANDLED; /* Left over TX/RX interrupt */
 
 	if (irq == ssi->irq_int) { /* error or idle */
-		if (ssisr & SSISR_TUIRQ)
-			strm->uerr_num++;
-		if (ssisr & SSISR_TOIRQ)
-			strm->oerr_num++;
-		if (ssisr & SSISR_RUIRQ)
-			strm->uerr_num++;
-		if (ssisr & SSISR_ROIRQ)
-			strm->oerr_num++;
-
-		if (ssisr & (SSISR_TUIRQ | SSISR_TOIRQ | SSISR_RUIRQ |
-			     SSISR_ROIRQ)) {
-			/* Error handling */
-			/* You must reset (stop/restart) after each interrupt */
-			rz_ssi_stop(ssi, strm);
-
-			/* Clear all flags */
-			rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ |
-					     SSISR_TUIRQ | SSISR_ROIRQ |
-					     SSISR_RUIRQ, 0);
-
-			/* Add/remove more data */
-			strm->transfer(ssi, strm);
-
-			/* Resume */
-			rz_ssi_start(ssi, strm);
+		bool is_stopped = false;
+		int i, count;
+
+		if (rz_ssi_is_dma_enabled(ssi))
+			count = 4;
+		else
+			count = 1;
+
+		if (ssisr & (SSISR_RUIRQ | SSISR_ROIRQ | SSISR_TUIRQ | SSISR_TOIRQ))
+			is_stopped = true;
+
+		if (ssi->capture.substream && is_stopped) {
+			if (ssisr & SSISR_RUIRQ)
+				strm_capture->uerr_num++;
+			if (ssisr & SSISR_ROIRQ)
+				strm_capture->oerr_num++;
+
+			rz_ssi_stop(ssi, strm_capture);
 		}
+
+		if (ssi->playback.substream && is_stopped) {
+			if (ssisr & SSISR_TUIRQ)
+				strm_playback->uerr_num++;
+			if (ssisr & SSISR_TOIRQ)
+				strm_playback->oerr_num++;
+
+			rz_ssi_stop(ssi, strm_playback);
+		}
+
+		/* Clear all flags */
+		rz_ssi_reg_mask_setl(ssi, SSISR, SSISR_TOIRQ | SSISR_TUIRQ |
+				     SSISR_ROIRQ | SSISR_RUIRQ, 0);
+
+		/* Add/remove more data */
+		if (ssi->capture.substream && is_stopped) {
+			for (i = 0; i < count; i++)
+				strm_capture->transfer(ssi, strm_capture);
+		}
+
+		if (ssi->playback.substream && is_stopped) {
+			for (i = 0; i < count; i++)
+				strm_playback->transfer(ssi, strm_playback);
+		}
+
+		/* Resume */
+		if (ssi->playback.substream && is_stopped)
+			rz_ssi_start(ssi, &ssi->playback);
+		if (ssi->capture.substream && is_stopped)
+			rz_ssi_start(ssi, &ssi->capture);
 	}
 
-	if (!strm->running)
+	if (!rz_ssi_is_stream_running(&ssi->playback) &&
+	    !rz_ssi_is_stream_running(&ssi->capture))
 		return IRQ_HANDLED;
 
 	/* tx data empty */
-	if (irq == ssi->irq_tx)
-		strm->transfer(ssi, &ssi->playback);
+	if (irq == ssi->irq_tx && rz_ssi_is_stream_running(&ssi->playback))
+		strm_playback->transfer(ssi, &ssi->playback);
 
 	/* rx data full */
-	if (irq == ssi->irq_rx) {
-		strm->transfer(ssi, &ssi->capture);
+	if (irq == ssi->irq_rx && rz_ssi_is_stream_running(&ssi->capture)) {
+		strm_capture->transfer(ssi, &ssi->capture);
 		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
 	}
 
 	if (irq == ssi->irq_rt) {
-		struct snd_pcm_substream *substream = strm->substream;
-
-		if (rz_ssi_stream_is_play(ssi, substream)) {
-			strm->transfer(ssi, &ssi->playback);
+		if (ssi->playback.substream) {
+			strm_playback->transfer(ssi, &ssi->playback);
 		} else {
-			strm->transfer(ssi, &ssi->capture);
+			strm_capture->transfer(ssi, &ssi->capture);
 			rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
 		}
 	}
@@ -732,9 +797,12 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		/* Soft Reset */
-		rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_SSIRST);
-		rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
-		udelay(5);
+		if (!rz_ssi_is_stream_running(&ssi->playback) &&
+		    !rz_ssi_is_stream_running(&ssi->capture)) {
+			rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_SSIRST);
+			rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
+			udelay(5);
+		}
 
 		rz_ssi_stream_init(strm, substream);
 
@@ -825,14 +893,41 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned int rate,
+				      unsigned int channels,
+				      unsigned int sample_width,
+				      unsigned int sample_bits)
+{
+	if (ssi->hw_params_cache.rate != rate ||
+	    ssi->hw_params_cache.channels != channels ||
+	    ssi->hw_params_cache.sample_width != sample_width ||
+	    ssi->hw_params_cache.sample_bits != sample_bits)
+		return false;
+
+	return true;
+}
+
+static void rz_ssi_cache_hw_params(struct rz_ssi_priv *ssi, unsigned int rate,
+				   unsigned int channels,
+				   unsigned int sample_width,
+				   unsigned int sample_bits)
+{
+	ssi->hw_params_cache.rate = rate;
+	ssi->hw_params_cache.channels = channels;
+	ssi->hw_params_cache.sample_width = sample_width;
+	ssi->hw_params_cache.sample_bits = sample_bits;
+}
+
 static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
 	unsigned int sample_bits = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
 	unsigned int channels = params_channels(params);
+	unsigned int rate = params_rate(params);
 
 	if (sample_bits != 16) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
@@ -846,8 +941,20 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return rz_ssi_clk_setup(ssi, params_rate(params),
-				params_channels(params));
+	if (rz_ssi_is_stream_running(&ssi->playback) ||
+	    rz_ssi_is_stream_running(&ssi->capture)) {
+		if (rz_ssi_is_valid_hw_params(ssi, rate, channels,
+					      strm->sample_width, sample_bits))
+			return 0;
+
+		dev_err(ssi->dev, "Full duplex needs same HW params\n");
+		return -EINVAL;
+	}
+
+	rz_ssi_cache_hw_params(ssi, rate, channels, strm->sample_width,
+			       sample_bits);
+
+	return rz_ssi_clk_setup(ssi, rate, channels);
 }
 
 static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
-- 
2.43.0


