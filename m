Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37BECFC521
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:29 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7110.1763808681578029945
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=psZZUsUT;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so18896325e9.0
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808680; x=1764413480; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOf5ekhE9yH/LrkP5usncH/jveY1QzLXMxT9ThkhbJs=;
        b=psZZUsUTTL1yIN9nkz1aCkmwSvJAq+N2xh3IMxBDerCGVYsrB09QiKZEinBueVEIfV
         VIb/1Y64y7n1WVdOcy7aUYZFce0jJutVUSrh0wksyah4Sd8nCEpsjUgR6JunK/oiHAN4
         VpcxXLYPsfXm8ddCkNQRcRwUPVYIGvzLq6ZAZs+JSNuz+gje+3DKdv9vibrfDBgAVLQe
         n+7YGt+Y9JZ+qqf/EipeAHA2rAf8leHMf1Mub0t0E91anCgqWeQZb5NbqYBq8fQ2qJ0t
         l0//D2+3beDkybXyOTbx25zamXGIrI2feEUehG9i80p+EeV8jwv1TX3sxLvou/0ZyVJO
         ItmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808680; x=1764413480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOf5ekhE9yH/LrkP5usncH/jveY1QzLXMxT9ThkhbJs=;
        b=rcXOgW80lhDKYGvx8gDerWw22ewsknrHk6Wly+kkoeLs2G/XZtcJ5S+M6qYWaNPcy1
         HFifEHp7diS/pMO5csiJJwCj3OT/oRsXk+e8hb3Z/3YR9bO8lcCsS5jc4asctBWPiDXq
         AWNVzxf9FyzMzWj8DWoRpLooJ+FbRPIHuGUm1E4zE/V3rAt39SGDv5cI+P719SHCzXVw
         3Pk7Cx7gNq0OixMUSNn/9rYhmQeOexYsWB1hoUsgA9mUuyiZNGjF6hJc45AioXE8Qs5L
         e4lHGB40xuh+iu3ABlgCn64qBqo2Mh22PM9MEdlO0Scx4NwgNVeNAOvMToyxjxOsAVw1
         lSPA==
X-Forwarded-Encrypted: i=1; AJvYcCXNnZF7TSewYsOiQuR+J2Qo9kw6XM7KzMMzjnAyf1FTB+uTJveyDmWN2+eWotfH28tgb4JqRA/d@lists.cip-project.org
X-Gm-Message-State: AOJu0YybC2TgLM/P1NNBut2kigDymqmZf2SoJxiRLYRzrmWnKJ6/EQ3z
	Xbroehcv4vM6/TepcNZ1PzY6CT8BiECX9ab4Rsw+l2LNtcWUt3h3OsODyD0oqpOk8T4=
X-Gm-Gg: ASbGncuQ9mRRn5gWH9LaXG85AQ+qotkmSKTNHDYkJQmIY6MNQlxBbXG82kMEeaoxxFy
	joYzVqG3t9m9SmddYyoj72GiCEiTxCmrvmOGxmAgwe54l+Z4Q9iOWp+sR1QCS6zdMVKP9yFIJos
	k3hIdvXaw/0Y5S3NHgYbFAiJMRGe3NXoKZDHxO6vyOB305g/VpCHlNaNZAoW37cfaOryZw4qTDi
	qbBxnUV3DjuzLmmPMEEEwjN9ZMZe+pcbsmLzbDOj98zKayP2znZFDkkYTwCXYu3aCeYU+AoI7S2
	m+Y2KeQcbEtpc8cQsOzhLXoVcbRqqlFb4ZXkdSFKX/2zMBbrFOmHoD6hEQnhePS0JKp1MTev8QZ
	3ZBE4rN0TOlMzsWUeTgs3lV3ooVV134VRvaPgBDG179kzOziGG9+6DEt8llcN/GoUuW6mhEP0tQ
	QH7lDCCDvy17ElbASJVZJcEs8bK43JQatKLau393cG
X-Google-Smtp-Source: AGHT+IGyy7m6/Uq5BcIGTskEhwjupu3hCG1DDa30fcncopdTlZT/bUp8K/P3+4RHaEZJRm7HrYIyTQ==
X-Received: by 2002:a05:600c:3b01:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-477c1119e60mr41350015e9.21.1763808679957;
        Sat, 22 Nov 2025 02:51:19 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf227ae2sm88105385e9.9.2025.11.22.02.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:19 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 2/2] ASoC: renesas: rz-ssi: Use proper dma_buffer_pos after resume
Date: Sat, 22 Nov 2025 12:51:16 +0200
Message-ID: <20251122105116.2782841-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20689

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
index c431e67903f7..f32ad81b08f8 100644
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
@@ -793,10 +799,14 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
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
@@ -809,16 +819,6 @@ static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi)
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
@@ -828,7 +828,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
-		ret = rz_ssi_trigger_resume(ssi);
+		ret = rz_ssi_trigger_resume(ssi, strm);
 		if (ret)
 			return ret;
 
@@ -867,7 +867,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		rz_ssi_stop(ssi, strm);
-		rz_ssi_streams_suspend(ssi);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
-- 
2.43.0


