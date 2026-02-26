Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16419FD4600
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:34:03 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78745.1772134433340450762
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:33:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UJMM7M5K;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so14262045e9.1
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134431; x=1772739231; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yQY4vGqrBHFoB7XpostarE8pLieK/MiO6ddIDdsAe0=;
        b=UJMM7M5KEpaKG3MtaEtAd36gV7OUXA1TNrFsm4/qyuKHPpPPxF2XofYWZCs0W8b/oL
         3HIps8EHTwNgM8aMISdzLOjkTKMF1M526vJTfA18yAw4huE/UM3a4d/SD6oQigFhv5Za
         gWtbU0B7SWUjfWos8C23yAhpZBzA7hkuPJNnp4hk7A2onyh5fQnfpdxvUz2Q/IWuLm74
         khpDmYrzaZeA/dWaihJ6MDA12sXq/uYiRVx2deZWpPbePtxfQBqV9vH4b26V8oy99ReL
         JM4+bdvLA1qO+tQkOh5QKlfB3D0W0YsLRziPGvcRv+Jv25t/EwAhVwAnNU3zfls/TcY1
         e/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134431; x=1772739231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7yQY4vGqrBHFoB7XpostarE8pLieK/MiO6ddIDdsAe0=;
        b=EUbPUJP8c6d/odDmUqTtbEERons7Qp7pFL7b2+hsIcgzQNOBU2HRgIt3xZLuwa/Sg3
         NNqUNz0KuBTaCQirE3y/kWCBkk6PBA3XPdJ+pdbgr3pb2Cz070uGh6FAsuNNaRI+VxbD
         mfVa03triiGGij2lmW7auXcPFneGl4hooe8voLJLIi4A11azx35mSmV6HywX8JXUBcwg
         77ZC7ZYWfki7kGST8BxG7xPmN+743zONE5NY4ucJlju7wO1ITjSSLSutWENXmlgJzTlj
         eFhDDycOdgtuWta5on6tRyQQzv7jK6TPKau7ZFmfsUAK8YOU09Yk9LLJLwrTkXfiu8aJ
         S+VA==
X-Gm-Message-State: AOJu0YwHtgJWiJg5aKfei24yh1297HuGE31jRqjNLzApDjUI0XcOaaAb
	iMDEgnl4nSK86IOFZEmFEmJ7OKTTVIaLEdYdhirq8jaOq5ubW9HzS34W6WMkEiIk
X-Gm-Gg: ATEYQzxQKp27tovzPGd00eFhrfAMB5UfsI7HgTpr+hhGMx+TdebXntpuSrtS6p9bwF1
	gcpkFUzzz9FJrRqIHC3RMwL93CdIfbZ6KCZRwnUteKT5452UWbj/L5rd/dKy7YHvhKtxKqsdt2m
	oLNI3e7pnVamFn0GNGQd2zROE3wSAC4A7l2bBQ5/DKFUZuUl4Kaypu6ZlmaIV6JoK97kpIBulqY
	kXXoIuuYDqfOrFXQs0JEZyypwTzwCeryfQiSQFWfbjT3Q/Xe0lveWhZ5k33xMkilu7PwTeMvHme
	Rmupw/dL5Hl57A8Y+xkR+oEbqNXRp+duOVJW8x5xRPHskF0s9pCUN5e20oWCe7ovjPsCgs1Cd4W
	1BvRSpocEws0IGb3m5ZE+gqiHkWnxNdPngpabpEpEW6gnwYjl37KnkcxW9kYiuXTCefxCF/tPIc
	9JRNpQ/Wf9JRuK1e0THWYlyj4RIBz3bX0Rs2/d9xTyk+kUFxs=
X-Received: by 2002:a05:600c:46cd:b0:477:9eb8:97d2 with SMTP id 5b1f17b1804b1-483c3dbb412mr57237285e9.8.1772134431400;
        Thu, 26 Feb 2026 11:33:51 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm167721555e9.14.2026.02.26.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:33:50 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/8] ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
Date: Thu, 26 Feb 2026 19:33:27 +0000
Message-ID: <20260226193348.449329-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
References: <20260226193348.449329-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:34:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22005

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 2bae7beda19f3b2dc6ab2062c94df19c27923712 ]

The strm->sample_width is not filled during rz_ssi_dai_hw_params(). This
wrong value is used for caching sample_width in struct hw_params_cache.
Fix this issue by replacing 'strm->sample_width'->'params_width(params)'
in rz_ssi_dai_hw_params(). After this drop the variable sample_width
from struct rz_ssi_stream as it is unused.

Cc: stable@kernel.org
Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114073709.4376-3-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 2cf8b21567b1..ee50ea30de72 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <sound/pcm_params.h>
 #include <sound/soc.h>
 
 /* REGISTER OFFSET */
@@ -88,7 +89,6 @@ struct rz_ssi_stream {
 	int dma_buffer_pos;	/* The address for the next DMA descriptor */
 	int completed_dma_buf_pos; /* The address of the last completed DMA descriptor. */
 	int period_counter;	/* for keeping track of periods transferred */
-	int sample_width;
 	int buffer_pos;		/* current frame position in the buffer */
 	int running;		/* 0=stopped, 1=running */
 
@@ -232,10 +232,7 @@ static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
 static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 			       struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-
 	rz_ssi_set_substream(strm, substream);
-	strm->sample_width = samples_to_bytes(runtime, 1);
 	strm->dma_buffer_pos = 0;
 	strm->completed_dma_buf_pos = 0;
 	strm->period_counter = 0;
@@ -995,9 +992,9 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
-	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
 	unsigned int sample_bits = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
+	unsigned int sample_width = params_width(params);
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
 	int ret;
@@ -1016,16 +1013,14 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 
 	if (rz_ssi_is_stream_running(&ssi->playback) ||
 	    rz_ssi_is_stream_running(&ssi->capture)) {
-		if (rz_ssi_is_valid_hw_params(ssi, rate, channels,
-					      strm->sample_width, sample_bits))
+		if (rz_ssi_is_valid_hw_params(ssi, rate, channels, sample_width, sample_bits))
 			return 0;
 
 		dev_err(ssi->dev, "Full duplex needs same HW params\n");
 		return -EINVAL;
 	}
 
-	rz_ssi_cache_hw_params(ssi, rate, channels, strm->sample_width,
-			       sample_bits);
+	rz_ssi_cache_hw_params(ssi, rate, channels, sample_width, sample_bits);
 
 	ret = rz_ssi_swreset(ssi);
 	if (ret)
-- 
2.43.0


