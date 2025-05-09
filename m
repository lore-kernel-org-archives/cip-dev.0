Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58073C3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:15 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.10358.1746783313764719779
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JWFv/mu2;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so202187166b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783312; x=1747388112; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab+VsF2XFLDF+D+lpWKxt6mTrRFz1Al4Z6fPTs+ka1U=;
        b=JWFv/mu2KJ3iskJ10L2gEal09JRvgxTecoQcQnMh+IKpW/LW3/k6vWw3Yjubd+df0w
         4CdcjVmIw6W6ooEl2m0xjnbuZPIi8aMaLkhlHmjgzM1/r+s0lBP0XKnvoS9ikSPH2I9i
         ITtXbNMrABfUi/iYFC74k6GdfeSr9mt2O1kMWAtiyk9TlWxPnUj7dLwWfg2XEXtTaia6
         aD6IhO3esA4//eBpt9hok2ufNpChJAWkwnuLXcOU0cWJzWqzlxt36Z/+XlIVPmwxAqcO
         Y3oFlK/nBX77o/8bJB+/pSw13dmr805Qp8fFkCkvNKnqfH5AsoRI3AjfN1bBDZ5sCctd
         +blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783312; x=1747388112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab+VsF2XFLDF+D+lpWKxt6mTrRFz1Al4Z6fPTs+ka1U=;
        b=UP0q9tobAtVGM2hAfnZHWP2t6frM29Mqv1sa4tZNd/tO8a5mxBQScw7krBjhOJeCyU
         V2rK+lCBvJsf9FuemcLGv5ZCETE2h2Am1e6FfFlENsX8uOYyQ/Ru5fMeQV8INtq3gYhT
         UCJmZ8SE7UU0KjkxzIXX63jnHuHS2F8HZrMyjUnwE0dyBIJQvKEGFr88f3R6kQAHV4z2
         JZ7JmLH4DNvMOrHsEBJRfG5GTXLQ3Jloi7XUEmhtpA8XpgiwItBpvRkUU9gGCSSEOp8D
         JVnFfl1HsqpKK7LZKVqok/fXwZnZKzokToU8zwSvZAYP9cDtEcqm7Ki1KX0kOpLFHDio
         K4cg==
X-Forwarded-Encrypted: i=1; AJvYcCUyTx+5xz+vykif7zmx9IMf6MjnyPbtDfuWZ/g3dvqkVQEXwQ3Bc4BwQiGAcWsd+e/QmCe0c5ua@lists.cip-project.org
X-Gm-Message-State: AOJu0YxWcVjU9nsSUsaObE+OA4Ugh7J3gCnjxSxpXjqQlQJ1XVir2jdj
	LLBf56K8WEsHA+rKZSIdy27HFMQD3/jJSO89lI/zGPKytF8241N/Mbd+TWTJbXI=
X-Gm-Gg: ASbGnctHw4X+k4cDOO8Zee7+QE9TDMNe7oS2acnu7YXAKRJGuXf56q6A9S9aBduzCHO
	/nAp2WEXe2jBxZ15C587P12snn2+UBrxQ1VMQF1dO0V84pC3ZWXQSke0jIz0HoaxzJ2aBInagQO
	vToMunrtgAbmP7JmMSnX37IUHrgtt+dLxMiofWSgMDdC2lBhvcVSUqWPLMCXbvC0wQADT9gtrni
	MCX7lafcesmQzmOvAsLtXpBzyy8G9Mtkdve/yab4A+JRhUz0kWN1VhOL53h1R5DEnhYrWtFwhCi
	b6GKYj4HFgab3kBrxzqQN/caY3S0iSqfPBPg/WBZ4KsiCJiNCFFoWnw9KQ4Bwff6tuZu7KJzgX2
	fcYEm
X-Google-Smtp-Source: AGHT+IHcvn1/yzso9oyBgpJHRzjNfpvtCmFdQV/AL8VzrTWddQx61uRRKFTaf/nuMIh7XkdHW/fPCg==
X-Received: by 2002:a17:907:9801:b0:ace:dd27:7c68 with SMTP id a640c23a62f3a-ad2191697dcmr278441666b.46.1746783312171;
        Fri, 09 May 2025 02:35:12 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:11 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 20/37] ASoC: renesas: rz-ssi: Remove the first argument of rz_ssi_stream_is_play()
Date: Fri,  9 May 2025 12:34:25 +0300
Message-ID: <20250509093442.4015145-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18872

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 109e60866f11c7db8f720f01b0bda3105c47b463 upstream.

The first argument of the rz_ssi_stream_is_play() is not used. Remove it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: fixed conflict with rz_ssi_get_dai() by keeping it]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index c1b729822747..ff8c04d4c07f 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -171,8 +171,7 @@ rz_ssi_get_dai(struct snd_pcm_substream *substream)
 	return asoc_rtd_to_cpu(rtd, 0);
 }
 
-static inline bool rz_ssi_stream_is_play(struct rz_ssi_priv *ssi,
-					 struct snd_pcm_substream *substream)
+static inline bool rz_ssi_stream_is_play(struct snd_pcm_substream *substream)
 {
 	return substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 }
@@ -348,7 +347,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
-	bool is_play = rz_ssi_stream_is_play(ssi, strm->substream);
+	bool is_play = rz_ssi_stream_is_play(strm->substream);
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
@@ -685,7 +684,7 @@ static int rz_ssi_dma_transfer(struct rz_ssi_priv *ssi,
 		 */
 		return 0;
 
-	dir = rz_ssi_stream_is_play(ssi, substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	dir = rz_ssi_stream_is_play(substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
 	/* Always transfer 1 period */
 	amount = runtime->period_size;
@@ -811,7 +810,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (ssi->dma_rt) {
 			bool is_playback;
 
-			is_playback = rz_ssi_stream_is_play(ssi, substream);
+			is_playback = rz_ssi_stream_is_play(substream);
 			ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
 						      is_playback);
 			/* Fallback to pio */
-- 
2.43.0


