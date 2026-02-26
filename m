Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7A9FD9E0A
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:53 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78968.1772134963302888240
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NEpdxTNk;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4398d9a12c6so976003f8f.2
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134961; x=1772739761; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LerMwLk0sNHXt/RnrwgVpKBUmMkvBCWtiKePDH1Po2s=;
        b=NEpdxTNk2VY3X3FXqeuRir8qBKCqHIClobS+pde4n+SDpJazK+0OmQXHRC+5ZsCXO5
         YuB2wt3gpEpywDbMg7kmea2pXI9pC1Z/hUEID5zCULLHlGwAx4FPE962arSZv52RgHu3
         ihtGb7efuIciomT4jTqu0XP9ripECnFScArqQuE2e8kMzJvxeJPkC6YM6J89uRp4RfTJ
         pWQriCYb7fMMVUBWhVJhrZOEYEaHn8fjkEorgOGHX3ze0H35h9fvX2W9UmSRNAcfHHCI
         yma5lfQVBY6R2jUb3I2ukkCqGRCgAZQEAxLT0bBwIi4Kl3OgmKrfo4Ieu3/5ZYk2/puS
         JxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134961; x=1772739761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LerMwLk0sNHXt/RnrwgVpKBUmMkvBCWtiKePDH1Po2s=;
        b=ZU5Y2N3zdHASstdqrcodzEvrfQieTSAijxRwuykBYZ64CQZmrAwTEXHK0h6DPFJCTX
         NW+/Ai/4rKBwIYgy1OhK3USCNWDl3x+YWyvx+IXpRNy5Ca3S/F1M+57uGOMYY8bPLfTE
         kWtB2KPRgvBrMyGPLcoyaH1ZX7LO+eHK5y2WGSsvnFRPl1WmYM6/da5KfwCf7Tg9GR7C
         Bib8qll7eLcj12HT9a5GcgN2wYg/2GZp4YN8yvdJsClyyhXlDuD3moeHi/orEateGnMH
         SI6B+bH8hRnGglVDVuQYG3u6e5HAb1qqUsdZMtJDgc5jhEgq6qGlVOC67C7fQhPvD4Cy
         UYxQ==
X-Gm-Message-State: AOJu0YyZ/EjawRHDx2iwDNQWainH0zL4Hqm3VyCGzjuuiO2zkH2XKeRc
	JOrhNg6guVmsdCM7inQXCBxeayGfi+sUKufWnhpjYa1FJEUN4IQeyDucjd5W1Uky
X-Gm-Gg: ATEYQzzdbDp9IpDcmIXnBLbAC+Li3Hy0SYDnBSYLnrJE6dD/vH9TWMJ+tItG37TJJFv
	P5zFBE6qpDtyHwa2d16OpI+xNtsvWWhA7XtOy37e53bn8HxHzCUMf9BDzDnMtYtwXLkK5d47iRq
	sAqlMYxiSiKnJfX0tlP9CubP6ZVL6m7uWSSYsW2k09jkfpOudloo0kQeuJ8/kd4c8W79LwxcN5P
	7NejbE7xiM8xAbDgwwIMTwGrhvbBSlQoIDstKDQRa/Q8pMLzcMGnWt0fpbDHgjJ/gsJ/joEk7Vj
	BusfP994S7O5djoYq/KZQB2Y28CSjh4OSD+bjuB7DSmfzITQ2lrziWy4dkqR/a3qZD4gtBvhK4u
	dXR1sL9PAqlvOEM+xzbfM3ncprrV1cfK/tG5RR6JYFwPLn88mqwvA5Ajp2R82peID2nSMZKfQ/m
	hK6KEYS4wTQoJ2ky5fdTwyZ1pyjo2MR/IjaHp/+iKCII/GE3Y=
X-Received: by 2002:a5d:5f49:0:b0:436:2fdf:b599 with SMTP id ffacd0b85a97d-4399ddff7d8mr65466f8f.21.1772134961321;
        Thu, 26 Feb 2026 11:42:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bf1f:8924:d67:fd04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c6100b8sm1854324f8f.2.2026.02.26.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:42:40 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/9] ASoC: renesas: rz-ssi: Fix rz_ssi_priv::hw_params_cache::sample_width
Date: Thu, 26 Feb 2026 19:42:25 +0000
Message-ID: <20260226194237.449383-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22015

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
index 90ee5564622a..d10ca9ee99fe 100644
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
@@ -993,9 +990,9 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
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
@@ -1014,16 +1011,14 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 
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


