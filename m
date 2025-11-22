Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C75CFC529
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:39 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7145.1763808693917490860
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=C6Zsk8Ia;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so25156555e9.2
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808692; x=1764413492; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCXl+JxMxCnsY0MKvI+ilz1Moyf9dN97hQ4akavXoVQ=;
        b=C6Zsk8IaLPJfx2IfFt99Fetqb+cP0Aq0QGrKXVAOQzRmiU3ZM5RVIk1y0wLf3zsoV2
         beLSGwP5o7M+Kf8dAq+Cwa5G5cEkbSvdFX33B50F4L+mDHzSu9WA4G70hN56QLQm12UX
         Z58IJclHmcf7SohwUTRqL36ljfdgLVkjXBHvuefAHrtoqsy+/27epVHKA2iJIUqoePgn
         DZeOEj6gP58DTpM7dU1NhhSV5Ij4PwCv9nxfHlTV56a5hTXAiZG8lK8CR2A0TywUldmt
         FHr7oj1bSe2kiA+ZqJ2XdcAfUkH21Xq59hUVN3xe1yOeioEVhdyV7Djw2ea9/pcxTNoQ
         zmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808692; x=1764413492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCXl+JxMxCnsY0MKvI+ilz1Moyf9dN97hQ4akavXoVQ=;
        b=IK6IGRs818yj+JFlu1U80i14ZoKpVrBRDvQInuPogczFVsPx1FTTGLs5er8n3RXT5e
         1QMLinLA/IVDgGeWcXLqidoz2uAMsblHlEzyO4tbI4ljyl+uk5lswnlApxqsrXlmO8f1
         ZSsmI4cnqHTGDI0+YYOnwwaPm9bB0PhvHZNEkQjvGFAQtjYRQ/0BSIdXiUcANDC1lzIm
         0SUoeS7O+LRjYHcSwSBFLmWDlmlxGw6RPEgzjvMVdT21hCUZVbyA+BF66RK80wOGqFAC
         BfGr0a1TAsMTwy4G3/WT02vOsYMPYP9DvFNJLdTOuDQ+4PWEbbtUoTFdNUeaz9kbGpCd
         nBWA==
X-Forwarded-Encrypted: i=1; AJvYcCXB7KgNgIrj7JkqU+0b72mNuUdd7IUYhmfyGvdaKslIMdwm5LFaeknEbl1SBXUjTzLpjOLdL/NH@lists.cip-project.org
X-Gm-Message-State: AOJu0YwAczHBak0l6AJmTByXA6JcMNTca8c24w9ORKmlIrSrDW867fmH
	c2atX0jNYE79NX2XUZROUSzvopATArRsVw4JaJfUH8Em96hq80byRm9H5Cf18VW0+Vc=
X-Gm-Gg: ASbGnct1SxrVzwOGLpnG+yY22RSGTUapvCJKM3Hau1xsg5G7k+c10j97zc/tTNxztI0
	QfuGBUynr4h+iFBr78SmiMwIDIbo30p7ZOFjNmWiRS4lM0XlOEYTxkvvSJKEQ+sI7Rknx+zu8Dz
	gd9mdCDLfX2RiaelWmu0HKbgOAOmfndnAizYZnj4HwAPGkVOcReIRUT82RqCn1cH84IO9HaDQwg
	JllzrXR5WYP9p8TKQYM2aO0xfhZpcCMdeOtcXLq2Cai6LhmUGfsGsEAn+h/XRqBcWTZ7YefmCqZ
	beCfJtogxViUPuJDkIOqcDLCfeKzlOe6hZydeoJMfnu95DDdBaylBW1kGTsdMpC/IScnYbdl253
	WbT9KtUH32cJRw0286mvemB3SP2UWKYEbwp17IeN2gkLD2jkK5op9/Kq0FGmPlAOCG2m4YRcNlD
	oWdQH16o9ZRRBq8duL/SWpaAaNC9CYcQOYrs/9tZE8
X-Google-Smtp-Source: AGHT+IFPfHh3fROdx35QLrRZMKDNVeTxMzYCabNYEUxoZLlGVSotS9XTXFzVxnI++/QlUaxWpBG9vw==
X-Received: by 2002:a05:600c:45d1:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-477c01df160mr45396195e9.25.1763808692266;
        Sat, 22 Nov 2025 02:51:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm16335859f8f.39.2025.11.22.02.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:31 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 2/2] ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume
Date: Sat, 22 Nov 2025 12:51:27 +0200
Message-ID: <20251122105127.2783085-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122105127.2783085-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251122105127.2783085-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20692

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 22897e568646de5907d4981eae6cc895be2978d1 upstream.

When the driver supports DMA, it enqueues four DMA descriptors per
substream before the substream is started. New descriptors are enqueued in
the DMA completion callback, and each time a new descriptor is queued, the
dma_buffer_pos is incremented.

During suspend, the DMA transactions are terminated. There might be cases
where the four extra enqueued DMA descriptors are not completed and are
instead canceled on suspend. However, the cancel operation does not take
into account that the dma_buffer_pos was already incremented.

Previously, the suspend code reinitialized dma_buffer_pos to zero, but this
is not always correct.

To avoid losing any audio periods during suspend/resume and to prevent
clip sound, save the completed DMA buffer position in the DMA callback and
reinitialize dma_buffer_pos on resume.

Cc: stable@vger.kernel.org
Fixes: 1fc778f7c833a ("ASoC: renesas: rz-ssi: Add suspend to RAM support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251029141134.2556926-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 56aeb867135f..19247a641a6d 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -86,6 +86,7 @@ struct rz_ssi_stream {
 	struct snd_pcm_substream *substream;
 	int fifo_sample_size;	/* sample capacity of SSI FIFO */
 	int dma_buffer_pos;	/* The address for the next DMA descriptor */
+	int completed_dma_buf_pos; /* The address of the last completed DMA descriptor. */
 	int period_counter;	/* for keeping track of periods transferred */
 	int sample_width;
 	int buffer_pos;		/* current frame position in the buffer */
@@ -230,6 +231,7 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 	rz_ssi_set_substream(strm, substream);
 	strm->sample_width = samples_to_bytes(runtime, 1);
 	strm->dma_buffer_pos = 0;
+	strm->completed_dma_buf_pos = 0;
 	strm->period_counter = 0;
 	strm->buffer_pos = 0;
 
@@ -454,6 +456,10 @@ static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int frames)
 		snd_pcm_period_elapsed(strm->substream);
 		strm->period_counter = current_period;
 	}
+
+	strm->completed_dma_buf_pos += runtime->period_size;
+	if (strm->completed_dma_buf_pos >= runtime->buffer_size)
+		strm->completed_dma_buf_pos = 0;
 }
 
 static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
@@ -795,10 +801,14 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
 	return -ENODEV;
 }
 
-static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi)
+static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
+	struct snd_pcm_substream *substream = strm->substream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	int ret;
 
+	strm->dma_buffer_pos = strm->completed_dma_buf_pos + runtime->period_size;
+
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture))
 		return 0;
@@ -811,16 +821,6 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi)
 				ssi->hw_params_cache.channels);
 }
 
-static void rz_ssi_streams_suspend(struct rz_ssi_priv *ssi)
-{
-	if (rz_ssi_is_stream_running(&ssi->playback) ||
-	    rz_ssi_is_stream_running(&ssi->capture))
-		return;
-
-	ssi->playback.dma_buffer_pos = 0;
-	ssi->capture.dma_buffer_pos = 0;
-}
-
 static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 			      struct snd_soc_dai *dai)
 {
@@ -830,7 +830,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
-		ret = rz_ssi_trigger_resume(ssi);
+		ret = rz_ssi_trigger_resume(ssi, strm);
 		if (ret)
 			return ret;
 
@@ -869,7 +869,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		rz_ssi_stop(ssi, strm);
-		rz_ssi_streams_suspend(ssi);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.43.0


