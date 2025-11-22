Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EF9CFC52A
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:49 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7117.1763808699473693858
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kfS1mI47;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so1596544f8f.0
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808698; x=1764413498; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O21r0X1iBy2dGrVQmFAOJDmq+AVcFMhhBaIAKquZnPY=;
        b=kfS1mI47e3xutZpIThcTecxK1HjhUPLcyU6XNXZlRUcyZyVwayag5h6B5tBkUvweq1
         XHAL/+TbVVIVCesVvn3GMovpQFWj5nBufLyAfdIoHu/R68kRHVbPIwBoDlzseLudPctl
         w8UJmffmLKBmbi262uoiDxyvl6xK1ceEbhy/J1eSDsKwZ2KDBkksj3sBM5k3eC1NXXv/
         oYc0M5Czk23jOG0690Cko+JbJeCYcyvDK6bBgFtXpPvTiowpoFsptARAokTZmxAYxCz6
         92EhdobEDPwEO9Hj/3AKPlE5ge3oRVsWNmRZ4ccBLbYy9kT08t0fIeCIZQdhwlcDbMHb
         zz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808698; x=1764413498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O21r0X1iBy2dGrVQmFAOJDmq+AVcFMhhBaIAKquZnPY=;
        b=dVFWnxCQpC3ATwfRjCPBl0ins+PAQZ9tmQvyjBIwO3Ey2ocaJBlxfv8L0OKNfErvCO
         scshvkMTEG/oP13nbNK1dY0SZ/WSBggqUHDOHor4iDh09tUh3enxJQeWaGVN9Ox/nW8z
         ZpwlK1Qk0cZ4d4MNizgTxOoF4F+hyR/gRimsKaAsiMoxmIiXTnZTCVrHpmJW9s3fOsgN
         SGdqL3OVZAZEpsdKgoYUMkbunpV3b7yEgITje1Yq09vyElwPSzxQSCCmC3AWxjtWZ/4l
         1FaHJ0plJktuTn5cVr36CyRtD5bTe7v/QffZTJdeH8UBcxkMaubL8Doxy5T0KFmB9lWM
         9rJA==
X-Forwarded-Encrypted: i=1; AJvYcCWzATNFl79bV4pw9VXoPdL0MIiysioZTT1TD2nJvT8UxseYxXk6nFQZUjvJ6tMVxLmJKGaOouvQ@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxl9rsta4rc7b6s3J9rUwD3nVdfFjrjy2PPC8GkJ2B1tnkLtgMO
	HeaeSksI5NJMN1Ll1PlP/I3XmASgbPttmxrfWlAMCieWQJpPNSXCTUr0EK+4QptVgrg=
X-Gm-Gg: ASbGncvjuAxtnMYbmRZEamCjr0m81mnTCYQEGXkoxY/cT45LSj0J9cjcHZTMdbB7Zv6
	PMncqNJir8hgjwxe/0aRTarkjxGrkqwyGZc1qDHHqNF68Dl1wd9MrJDiS5fsddw+aCTlZ8qzNKP
	XyDWNE69KbIhjl/e7LZbpUNd7EBCWxvCqJDFKpjY6te8ycIpxg9A9Cc2riWix+XqLj4CoQXSpaF
	/ymQBMLSGwQisTKctaPuvnzVzVdiKthkM9HAeZ87krIX6Rl3sqi3LwrjYIeoDm77WeflVGDIRYP
	Pwn5VniH4SJ7h3FFpn6112eR7+UsKSYkAH6jbt+qbZOZ6AeqWNZIS4gm8OVRMBY7tIWheU8DVk1
	vZfvXQrFRGbpZp9ycqscRsFcmstejj7b9KSeoSgBT4wPS1WXFOPJZPNbkn79YXxADfuLsM/fH5a
	Mu4AQctIcp0fmipl9L56bLq+D8ZS8i7JuS/BEq7cmE
X-Google-Smtp-Source: AGHT+IGkROUmwwxuoQtiK146pcWC6jNwSDTFQ7GEserBcMz3kfueC42oJJ64KzQv8sqUbeoee3PEjA==
X-Received: by 2002:a05:6000:290f:b0:42b:5521:31c6 with SMTP id ffacd0b85a97d-42cc1d198fcmr5680990f8f.54.1763808697753;
        Sat, 22 Nov 2025 02:51:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e5a3sm16263356f8f.6.2025.11.22.02.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 2/2] ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume
Date: Sat, 22 Nov 2025 12:51:33 +0200
Message-ID: <20251122105133.2783194-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20695

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
index f9f67f20aa75..223ec903ad38 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -85,6 +85,7 @@ struct rz_ssi_stream {
 	struct snd_pcm_substream *substream;
 	int fifo_sample_size;	/* sample capacity of SSI FIFO */
 	int dma_buffer_pos;	/* The address for the next DMA descriptor */
+	int completed_dma_buf_pos; /* The address of the last completed DMA descriptor. */
 	int period_counter;	/* for keeping track of periods transferred */
 	int sample_width;
 	int buffer_pos;		/* current frame position in the buffer */
@@ -221,6 +222,7 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 	rz_ssi_set_substream(strm, substream);
 	strm->sample_width = samples_to_bytes(runtime, 1);
 	strm->dma_buffer_pos = 0;
+	strm->completed_dma_buf_pos = 0;
 	strm->period_counter = 0;
 	strm->buffer_pos = 0;
 
@@ -445,6 +447,10 @@ static void rz_ssi_pointer_update(struct rz_ssi_stream *strm, int frames)
 		snd_pcm_period_elapsed(strm->substream);
 		strm->period_counter = current_period;
 	}
+
+	strm->completed_dma_buf_pos += runtime->period_size;
+	if (strm->completed_dma_buf_pos >= runtime->buffer_size)
+		strm->completed_dma_buf_pos = 0;
 }
 
 static int rz_ssi_pio_recv(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
@@ -786,10 +792,14 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
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
@@ -802,16 +812,6 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi)
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
@@ -821,7 +821,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
-		ret = rz_ssi_trigger_resume(ssi);
+		ret = rz_ssi_trigger_resume(ssi, strm);
 		if (ret)
 			return ret;
 
@@ -860,7 +860,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		rz_ssi_stop(ssi, strm);
-		rz_ssi_streams_suspend(ssi);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.43.0


