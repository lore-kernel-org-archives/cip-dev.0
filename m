Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79394FD9E0C
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:53 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78973.1772134966296975127
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kBI+Gf3r;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43992e3f9b8so1239818f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134964; x=1772739764; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Apk1dPWytWgJfP5hy7IZ+9cUkt9TK76p5CF2hcf4nhY=;
        b=kBI+Gf3royhXKPQlDk2xRmKqehmLDd5RWnY4YO7MCn2HTO1DIdxHChonIUMCX9N7TP
         8uhW5/5LBQ8soLotbXnw8FQipKD9PI4GLSP3xJjEIqhK86GGjouwoSGt/BvxATU8ovPS
         RSgI6/R43geM2pGi6iLUIcqGIpZdZ2cO6/cbufLaZeLApOk2yNND+cywvSvACGHj6Qe/
         A7OoP8MM2BThmtDHYyoEYwx/VZPhxW+Efd1TKjV7QlM8gF5oPsuzfxymhDE3+knpSHP2
         EPBsndLGLPzgvlGdVAFvQUKTAp4sUQv/ZOXRw5pxyzOg1G3ovTJ3mU69PnGfpZxRGzVp
         /ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134964; x=1772739764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Apk1dPWytWgJfP5hy7IZ+9cUkt9TK76p5CF2hcf4nhY=;
        b=gPm3VKsr4hyq8+AAwTOMAs6FXRwOGQdlSStsq38KFQDOc1V3wgnR+5J73PWB8zMSvd
         yQQhiQgJaONp8mMYcBucrNqpg9oBj9p31nXvkxzPeQzp2sX1WirBzFHos1w/A6sECRRd
         ETsSCkb+02D2hjK+894mnULgagCpc9qd+kRCv+1VFIFvdmPHBInDhJ4RpQH18uoQXlUV
         804b5l/xut7Sv4OdX2Le7GeP1Ar4gYGIyCb3AUa2HrayNi8eUqDBM8EePX5OTSBQQL6j
         2IngydHa76a2LM7h1HUA7ycDgJDK0A5PQ9mm2EHxvcjTWNQVG07RGNMdXrEGeKJhGjOG
         FoqQ==
X-Gm-Message-State: AOJu0Yz7sfQGzWuB/9RpwuMTms0R51+PExgx8pNJwlnuzNpfJLSXZwO4
	iZeVL0Bl8i9fm5sDJgTo2AUrl9gxdVlG5wpENHazqheG+OV3bXvjQfw8J7JhGdYE
X-Gm-Gg: ATEYQzxcwr6PqdsiKx0QrfjwhSxQcGIltjyiseV9Bhi1OKj4Wj/3Pwsnli8Zy+1PcZy
	x2nHfRuDp7waWKFLfMjOawtZMMVeToQl1ubuIgesBtd0v3HkJ6GioLVLmC2SnnhKzPkVMpme7c/
	7RkVh/5CAQU6gAlaaHV4sKFdKkhmV5GZsX3pGPTYXVmqAvlSlThKuLAwt4F3FQO3kvaOzW9H+e8
	BY0nJmePKmx4d44e3QAZSLBba8tttztQOWvCM8/N2bs0AX4atxwOEse3qlvutu1X7mFfDDVMTCo
	day+rZeHC4pdo9qOkuhkZYJZVz6Y0fKsiLzQUC89LFw/AzGliH3NAK4dfsJjaihz9O7/Y4zIvoR
	rmEekZ++2u241t/vW40qb8Pj/sIuFfWAcUbVNWxGkEkmQzWX0zaM07krV/E+obxgu5nbU5JIYRv
	EjYrU4OUyg4GxApXtd25Jo5Tl9K/qxIg+uXYXkmtzUtCnLu/E=
X-Received: by 2002:a5d:5f87:0:b0:435:930a:658e with SMTP id ffacd0b85a97d-4399de30508mr23761f8f.53.1772134964396;
        Thu, 26 Feb 2026 11:42:44 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c6100b8sm1854324f8f.2.2026.02.26.11.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:42:44 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 8/9] ASoC: renesas: rz-ssi: Add support for 24 bits sample width
Date: Thu, 26 Feb 2026 19:42:29 +0000
Message-ID: <20260226194237.449383-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22019

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
index 354fcdbd3805..ccc33ca34b48 100644
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
@@ -557,12 +580,23 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
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
@@ -673,8 +707,13 @@ static int rz_ssi_dma_slave_config(struct rz_ssi_priv *ssi,
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
@@ -992,7 +1031,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int rate = params_rate(params);
 	int ret;
 
-	if (sample_bits != 16) {
+	if (!(sample_bits == 16 || sample_bits == 24)) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
 			sample_bits);
 		return -EINVAL;
-- 
2.43.0


