Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830BEC3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:43 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.web10.10332.1746783155392861135
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=p7blJYeZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fbfa0a7d2cso3176460a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783154; x=1747387954; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGisDsbcqRAbv/rC9e9fiwiXkNqmca8ucwOSce4LQSY=;
        b=p7blJYeZbJtlb4e7dKWeA1y+ttQjS2oLY4A7JaKsBLdhQqWzF5Y1r4YWPKJFNZ5VN1
         0zqKhZWM80WwhYEt+HTPI2qnWXMO5yec17On4NQUyNrtFr7HU94mKJPmJue9i55Mebtz
         2u96XaL5I19czMK2yIReDpAZlAqXQZcuMppKdCq/xrFhZVHg1MJTOLAqXoftpU2lgBy3
         VA/KI4k25nwX4eNesGLCH69kGfqFDxZb8N63xim2A3RyInmTqzjjADwG4gxN+SrkuIJl
         nfNCadwucFy/Po0ZSJ7vwypPK91A8M9rMS8LdDvNbvlgnAmzh0GY9Tz8dwD9G6vcgg/6
         nbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783154; x=1747387954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGisDsbcqRAbv/rC9e9fiwiXkNqmca8ucwOSce4LQSY=;
        b=tfOFZOtm1GHhvJUVL4sv6qBhW93+gmASm2eGv8WXmSdT0453ctuVJCY2SVNKvC53YF
         zt2RnaPDOqph2vQc8+wcUj/W+vkKmTk9eLnZb8OR+XeRsZN19299aD1Vh/WJuyGZdSA1
         FuYRU+03hQn8A0YXZRD0bVZJscH3VSgBIByzFouAO27/tYnNi7gU51HNB/E9BaD12vQg
         9GrEKqBAtiWJYgLhWZosTVIoE5TVb1nydH/I/B5WG9P3xFtY2xKLOE6Y+UrwANB74FN7
         L+v9wLep/t9aeeY8sMLxNt6Ny14Hs1edXvMBTiVLiHKd/MpcHNErtqUu4UcPKZB+LG6i
         9Yrw==
X-Forwarded-Encrypted: i=1; AJvYcCVEQ2dGeBGWhxh/mG9MtL6ZlEC8CuKlHYzQdWOgFm8zKIN88eDzbXW2PwXcBbxE71pvXY2tJFIM@lists.cip-project.org
X-Gm-Message-State: AOJu0YyfD6cKvDtHYP+Mq565FxI8LwyAHIixR18Un2ls/m1VXC6swwHv
	9XD3n7cti3TpA4JYQdTWeQ+ZZEvD74cm5N+qTlSB6SQEEl5x3AsgH8Tw2EOgcA4=
X-Gm-Gg: ASbGncvMT9iTZKZNvPYpVBJCEYFcxwHUSb2lmU7TIpssk63URetUY58BBtdk5b8h7WD
	CKzu2WGkn3uhDyvGZp6EkSwKLBZbX4pAt0Ba5ojaxYcI7XzQBxNqjWz0pUJQxdxqE8+kBgn2tNE
	BWIqhD7riNGA9KWR0THuy0vj1jsr6eAuVLsK+sNSH7GTxuFVnVpFZwT1XZlAK4G6K/KOMS7Ej/3
	FI85vz3uqTv3douHONx7ipHALJlOnYg8oKtiJlHFFwC85L2qeAmZQaAnRc/MnVdWF872zcIPUTs
	htgKd4HSv1kTC/nEj5th7kt6dKPcbxIvJSieirHuLV4FNGjXfKmlgOjKr/WCLrkRrMERBwKZ2Kj
	Zn1JD
X-Google-Smtp-Source: AGHT+IHEEmow7FxZ17e8izGQoPD64hfn9ZnyfBToe9ZWxjoSONr1J7Q78ViKWa4QlpYwb+RN4lBzqw==
X-Received: by 2002:a05:6402:3582:b0:5f4:370d:96bc with SMTP id 4fb4d7f45d1cf-5fca07423c9mr1942658a12.2.1746783153726;
        Fri, 09 May 2025 02:32:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:32 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 19/29] ASoC: renesas: rz-ssi: Issue software reset in hw_params API
Date: Fri,  9 May 2025 12:31:53 +0300
Message-ID: <20250509093203.4014750-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18806

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit fc2a31affb22394d1d74d3ecc86b5c68da33d52a upstream.

The code initially issued software reset on SNDRV_PCM_TRIGGER_START
action only before starting the first stream. This can be easily moved to
hw_params() as the action is similar to setting the clocks. Moreover,
according to the hardware manual (Table 35.7 Bits Initialized by Software
Reset of the SSIFCR.SSIRST Bit) the software reset action acts also on the
clock dividers bits. Due to this issue the software reset in hw_params()
before configuring the clock dividers. This also simplifies the code in
trigger API.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-17-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 34eb079a6aea..2d1ffea84159 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -390,6 +390,15 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	return 0;
 }
 
+static int rz_ssi_swreset(struct rz_ssi_priv *ssi)
+{
+	u32 tmp;
+
+	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_SSIRST);
+	rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
+	return readl_poll_timeout_atomic(ssi->base + SSIFCR, tmp, !(tmp & SSIFCR_SSIRST), 1, 5);
+}
+
 static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
 	strm->running = 0;
@@ -786,14 +795,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		/* Soft Reset */
-		if (!rz_ssi_is_stream_running(&ssi->playback) &&
-		    !rz_ssi_is_stream_running(&ssi->capture)) {
-			rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_SSIRST);
-			rz_ssi_reg_mask_setl(ssi, SSIFCR, SSIFCR_SSIRST, 0);
-			udelay(5);
-		}
-
 		rz_ssi_stream_init(strm, substream);
 
 		if (ssi->dma_rt) {
@@ -918,6 +919,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
+	int ret;
 
 	if (sample_bits != 16) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
@@ -944,6 +946,10 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 	rz_ssi_cache_hw_params(ssi, rate, channels, strm->sample_width,
 			       sample_bits);
 
+	ret = rz_ssi_swreset(ssi);
+	if (ret)
+		return ret;
+
 	return rz_ssi_clk_setup(ssi, rate, channels);
 }
 
-- 
2.43.0


