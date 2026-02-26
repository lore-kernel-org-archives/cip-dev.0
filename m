Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1087AFCE08C
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:29:03 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78619.1772134132952867931
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:28:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q3CXji+P;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso11468935e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134131; x=1772738931; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPu7zdLeiSJz1AEKf6hvqWs7p0r8pDiNdKKo12Qc/9M=;
        b=Q3CXji+PWwmMwHQ26GVzYN8zMWU6J5EERKHRxXv9VhVwz3sc6MCNX9xajo99eb8Rky
         WiarhP84c+tIsYiULWblPfGvEeujHrU0SrUL2uO3BikNFiF4NA4iJRcgr5sXMbgQQeLK
         ZlzULmokHvwM8cgVSmf+qxJm7sC9mxhO7KyF3rk1+aMb2sPkIC3hcaEF6F44ip7FmPAS
         yqZdfSy/qYdJZSTFBpd4O5FfYxObzxO0lL7jlNPigO1k92rgmgci3lgLKqT8VjomrkSm
         QE9QGxoGnFBS6DFaNcloE44HyM84mw9GP+l2hNlgUkM7Bgt0aDjO+GOBx9dZt+osd5g3
         KgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134131; x=1772738931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPu7zdLeiSJz1AEKf6hvqWs7p0r8pDiNdKKo12Qc/9M=;
        b=GrltiWzFpqPEDGoG2R3MI0ncwEmdva2OE5Mg5kKPbdRfh9N/cZvVK3qdBSP/1IspzR
         2J1QCpKfG5BdQ++0ebn9F0KHqBxia0MTb1D/Dy8fv2WAo1Nxz3LbS/NWh6L+/VTFlVyP
         3cT7XrHb8LowJVUerwvuiJtRBbdhi083llNeEC1art+YJ73u2OA20D2MLHuzxxrgsmC1
         q41t5KOY+KPDdz47xRBDqPb3+RWJemcHKtbxy5PvMWQriSJfliU9XnKn707oBnnQjn3J
         a+KFj022ubuBDsJr47j++pawWHEktyBebztHASl3lgvOvuVyBay8mKLoxThisNlqqaiB
         GQtA==
X-Gm-Message-State: AOJu0Ywe0J8ut+rUUbJmE2TeT8VegQV/MKslE9N8MDfEjY1ibCFC3Yha
	bxuujq5q5bpi1R5Ls6Y0k8r9nnLY9DZTAv5FARx9pjhkMTKT2IAzby7yW7Etiww0
X-Gm-Gg: ATEYQzzKit8RTydp+60tJLs6tHTN+2mB0vho8S2kxS9mE8EgDbicR/ykmin3Dih/toI
	UqNRuH2eQ03eY9v7n5qfu1cfBMYKgYqyo1L79lxBUpr0E+Hx0tb1ENtxx4T5Y/48Hh/SqNk91FJ
	SbbQVwODGvlDrsV0WseM6vQ4+J/7taUETp0HbmMb/aMJlHaCjlF0wZ7aeKubsaYj73DzM4/HMBs
	LWRYmAPoPgH87nfFavHXdyetHr65uVa4SdyVBwfRsFvJxIWy1HQUyz/fs6b5+UeJbVYD4psGxbZ
	ec6YcTiXklrgBuQJfF3pwqpkN9K0A6WtXKl5ICQutGZphjcgeNIS7TeYZUgvRHsMP1e+CPKp1Ec
	LMA8XzBt7jdlHoOkOgX3/NDpUD2ajVj72XqJ35e+pkNfmYi8z4oXL8PALyeCfVlbC2vudoukKg/
	uSsUfRt8WsO4tr5NkThoWNDxVcDIezfJIqqHqTPDDbDDwAZno=
X-Received: by 2002:a05:600c:6296:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-483c3df7964mr56651285e9.33.1772134130819;
        Thu, 26 Feb 2026 11:28:50 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm76701365e9.1.2026.02.26.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:28:50 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 4/5] ASoC: renesas: rz-ssi: Add support for 24 bits sample width
Date: Thu, 26 Feb 2026 19:28:41 +0000
Message-ID: <20260226192846.449277-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
References: <20260226192846.449277-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:29:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22000

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
index 8c326bd4ba7d..53a5d0b9d58c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -38,6 +38,7 @@
 #define SSICR_MST		BIT(14)
 #define SSICR_BCKP		BIT(13)
 #define SSICR_LRCKP		BIT(12)
+#define SSICR_PDTA		BIT(9)
 #define SSICR_CKDV(x)		(((x) & 0xf) << 4)
 #define SSICR_TEN		BIT(1)
 #define SSICR_REN		BIT(0)
@@ -74,7 +75,7 @@
 #define PREALLOC_BUFFER_MAX	(SZ_32K)
 
 #define SSI_RATES		SNDRV_PCM_RATE_8000_48000 /* 8k-48kHz */
-#define SSI_FMTS		SNDRV_PCM_FMTBIT_S16_LE
+#define SSI_FMTS		(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 #define SSI_CHAN_MIN		2
 #define SSI_CHAN_MAX		2
 #define SSI_FIFO_DEPTH		32
@@ -300,11 +301,24 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
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
@@ -463,7 +477,6 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
 	struct snd_pcm_substream *substream = strm->substream;
 	struct snd_pcm_runtime *runtime;
-	u16 *buf;
 	int fifo_samples;
 	int frames_left;
 	int samples;
@@ -498,12 +511,23 @@ static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
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
@@ -521,7 +545,6 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	int frames_left;
 	int i;
 	u32 ssifsr;
-	u16 *buf;
 
 	if (!rz_ssi_stream_is_valid(ssi, strm))
 		return -EINVAL;
@@ -550,12 +573,23 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
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
@@ -666,8 +700,13 @@ static int rz_ssi_dma_slave_config(struct rz_ssi_priv *ssi,
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
@@ -985,7 +1024,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int rate = params_rate(params);
 	int ret;
 
-	if (sample_bits != 16) {
+	if (!(sample_bits == 16 || sample_bits == 24)) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
 			sample_bits);
 		return -EINVAL;
-- 
2.43.0


