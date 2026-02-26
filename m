Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2132FFD4618
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:34:03 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78749.1772134436681534440
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O9vXUL0f;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48069a48629so13462745e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134435; x=1772739235; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNIG6P97y6eOwGxVIloCFSz9U6CdotqeFxq1oZCdulY=;
        b=O9vXUL0fX2FOUl2exLUoeyVR9EwnNu6ttJ/20fPP6sh5stypITqlsErOhqEiFh4/Sm
         +Lqbpq0N+KzzKJYkBoFuxc0gvJlptwfY2Hv3gxwLJmyj0UDETIaIrLOGxA0H430vE+o+
         RJZr8T5787m2jQcAkrX4Lz2+TtgroXqRNtVBX4/ijHPaLmUTW9jFoLt+6FXgqheACWPx
         o7SqHI8IwEZZvd0Wk1lb0mYwOSCIrvrGBSbQLdbjNe+f7PStSzXMmqYX6KdyAPL/biSI
         WyFOG6E4iZdQkKy4ek6fxUrvpgzKOmd1CKbKQcx87VHDC1oATc4YPGdyRKzCXkdrrGbY
         khnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134435; x=1772739235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNIG6P97y6eOwGxVIloCFSz9U6CdotqeFxq1oZCdulY=;
        b=RHhFvXU+MxliTn3rjpx3+IGxkbkVlcIdBscLsARyHRXwJu4aB36R6BlKvnwORuXbpI
         zkmFKjp8l2kd73eVQty2riRR8NA+PRWGR0sCYPclg+mT4PSbNzUIVl52tV6s/bEvPl2I
         vd1ZGFLZugfJjxwzHhy+gKjOoCbuzYnzvt+UA+zB+7F5Y2+KGlqnNaCTJEW1Cdw28KCq
         tBjBXNcu5/RzX7ChftRZnjvtGfOCrHh2NHUaL8mxWsSSdwGVlMfn3p1IuKGXXzBJFF/b
         lnacWS+4qBi+MpSQtoCyShHlS+Zg+aNpcnpkRwFtwE41xVfSsS6vC97C4ak+qes8GoSO
         75UQ==
X-Gm-Message-State: AOJu0Yx8CQDIcHyEm535jgEAkJKmL0NxIYLMYQtS5EwsFsEIwUpIWuzr
	8rEFpiqTYVX+6ztBlN3Znv1V+ueI/BZ179Qkn7cZn7CKY479sxWqDTyd2wTUf5yV
X-Gm-Gg: ATEYQzxzYow9Z3qiAmGbGJ/NBrO7k9dq/Z5+zWZcN9DlJ2XUJlwQ8GkZPo8ymKAftd9
	F1U0piOCz+95q5gS5CZNrXwU0UM9Y87fIpTQ/G49NWI18dj/YIRzngKOzEVLIL/+SyT5qYstXhj
	hPIOVGIZ7G+K/2sK1B7S33Nxn7nD6VjVP0Prl6vMW0qsRhNOIM+OOMHAXV1q8UtsbQoatAl+d/C
	+nzUZJ9HJZEarbJBNiJpxeNfGzxSB09DEUa9izPYNPuj8mMZ08VE5Jb6kgbgFDsvG8QKyjNrlCA
	QbtcJL3aXrDAW2tMSMrFBUlbLsYQBEg8lUNCFsdS2QL07hI/K9aI0JY84MhOdFGhqf0yCTtc+TM
	cpLNk0H/F7S6M9ER7b9P65UEIv6fJrcCyoTE4mETP2DgKKwixYR3Y4vw065N6asgbspe68PBwui
	A0x+qxqlPzo2ziTOJ2CYMtA40HNLytFacCUe+RhXF7+/C/+es=
X-Received: by 2002:a05:600c:620c:b0:483:43d8:8d68 with SMTP id 5b1f17b1804b1-483a95f8988mr330341365e9.28.1772134434718;
        Thu, 26 Feb 2026 11:33:54 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:54 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 7/8] ASoC: renesas: rz-ssi: Add support for 24 bits sample width
Date: Thu, 26 Feb 2026 19:33:31 +0000
Message-ID: <20260226193348.449329-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22009

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 9e10709f831408d948be66bc8f6329fa37a3dc82 ]

Add support for 24 bits sample format width for RZ/G2L SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114075856.4751-5-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 75 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 570313c50232..b6692921eedb 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -39,6 +39,7 @@
 #define SSICR_MST		BIT(14)
 #define SSICR_BCKP		BIT(13)
 #define SSICR_LRCKP		BIT(12)
+#define SSICR_PDTA		BIT(9)
 #define SSICR_CKDV(x)		(((x) & 0xf) << 4)
 #define SSICR_TEN		BIT(1)
 #define SSICR_REN		BIT(0)
@@ -75,7 +76,7 @@
 #define PREALLOC_BUFFER_MAX	(SZ_32K)
 
 #define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-48kHz */
-#define SSI_FMTS		SNDRV_PCM_FMTBIT_S16_LE
+#define SSI_FMTS		(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 #define SSI_CHAN_MIN		2
 #define SSI_CHAN_MAX		2
 #define SSI_FIFO_DEPTH		32
@@ -309,11 +310,24 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
 	}
 
 	/*
-	 * DWL: Data Word Length = 16 bits
+	 * DWL: Data Word Length = {16, 24} bits
 	 * SWL: System Word Length = 32 bits
 	 */
 	ssicr |= SSICR_CKDV(clk_ckdv);
-	ssicr |= SSICR_DWL(1) | SSICR_SWL(3);
+	switch (ssi->hw_params_cache.sample_width) {
+	case 16:
+		ssicr |= SSICR_DWL(1);
+		break;
+	case 24:
+		ssicr |= SSICR_DWL(5) | SSICR_PDTA;
+		break;
+	default:
+		dev_err(ssi->dev, "Not support %u data width",
+			ssi->hw_params_cache.sample_width);
+		return -EINVAL;
+	}
+
+	ssicr |= SSICR_SWL(3);
 	rz_ssi_reg_writel(ssi, SSICR, ssicr);
 	rz_ssi_reg_writel(ssi, SSIFCR,
 			  (SSIFCR_AUCKE | SSIFCR_TFRST | SSIFCR_RFRST));
@@ -472,7 +486,6 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
 	struct snd_pcm_substream *substream = strm->substream;
 	struct snd_pcm_runtime *runtime;
-	u16 *buf;
 	int fifo_samples;
 	int frames_left;
 	int samples;
@@ -507,12 +520,23 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 			break;
 
 		/* calculate new buffer index */
-		buf = (u16 *)runtime->dma_area;
-		buf += strm->buffer_pos * runtime->channels;
+		if (ssi->hw_params_cache.sample_width == 16) {
+			u16 *buf;
 
-		/* Note, only supports 16-bit samples */
-		for (i = 0; i < samples; i++)
-			*buf++ = (u16)(rz_ssi_reg_readl(ssi, SSIFRDR) >> 16);
+			buf = (u16 *)runtime->dma_area;
+			buf += strm->buffer_pos * runtime->channels;
+
+			for (i = 0; i < samples; i++)
+				*buf++ = (u16)(rz_ssi_reg_readl(ssi, SSIFRDR) >> 16);
+		} else {
+			u32 *buf;
+
+			buf = (u32 *)runtime->dma_area;
+			buf += strm->buffer_pos * runtime->channels;
+
+			for (i = 0; i < samples; i++)
+				*buf++ = rz_ssi_reg_readl(ssi, SSIFRDR);
+		}
 
 		rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_RDF, 0);
 		rz_ssi_pointer_update(strm, samples / runtime->channels);
@@ -530,7 +554,6 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	int frames_left;
 	int i;
 	u32 ssifsr;
-	u16 *buf;
 
 	if (!rz_ssi_stream_is_valid(ssi, strm))
 		return -EINVAL;
@@ -559,12 +582,23 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 		return 0;
 
 	/* calculate new buffer index */
-	buf = (u16 *)(runtime->dma_area);
-	buf += strm->buffer_pos * runtime->channels;
+	if (ssi->hw_params_cache.sample_width == 16) {
+		u16 *buf;
+
+		buf = (u16 *)(runtime->dma_area);
+		buf += strm->buffer_pos * runtime->channels;
+
+		for (i = 0; i < samples; i++)
+			rz_ssi_reg_writel(ssi, SSIFTDR, ((u32)(*buf++) << 16));
+	} else {
+		u32 *buf;
 
-	/* Note, only supports 16-bit samples */
-	for (i = 0; i < samples; i++)
-		rz_ssi_reg_writel(ssi, SSIFTDR, ((u32)(*buf++) << 16));
+		buf = (u32 *)(runtime->dma_area);
+		buf += strm->buffer_pos * runtime->channels;
+
+		for (i = 0; i < samples; i++)
+			rz_ssi_reg_writel(ssi, SSIFTDR, *buf++);
+	}
 
 	rz_ssi_reg_mask_setl(ssi, SSIFSR, SSIFSR_TDE, 0);
 	rz_ssi_pointer_update(strm, samples / runtime->channels);
@@ -675,8 +709,13 @@ static int rz_ssi_dma_slave_config(struct rz_ssi_priv *ssi,
 	cfg.direction = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 	cfg.dst_addr = ssi->phys + SSIFTDR;
 	cfg.src_addr = ssi->phys + SSIFRDR;
-	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	if (ssi->hw_params_cache.sample_width == 16) {
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	} else {
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	}
 
 	return dmaengine_slave_config(dma_ch, &cfg);
 }
@@ -994,7 +1033,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int rate = params_rate(params);
 	int ret;
 
-	if (sample_bits != 16) {
+	if (!(sample_bits == 16 || sample_bits == 24)) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
 			sample_bits);
 		return -EINVAL;
-- 
2.43.0


