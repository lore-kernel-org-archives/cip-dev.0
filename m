Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E529C3ABC9
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:54 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.10372.1746783228038346468
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eCVV4oFU;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so3492700a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783226; x=1747388026; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JGHETYI8p8q6LOPsOAAdd56RcgjkHCoMqlYzoMs5XU=;
        b=eCVV4oFUOCG2uV5yGdNpevFYH1YF169KxCJYLAS/ds1xM0lUMJDSM6sXBcXej/NsbP
         kfiWPWd9KtY3Y8jb+tdyHm3LDlGvsEwAW0SJ4wfJk5M9S5/1ZVfLIWFcaqUd4+PShOct
         0RWJ816zsVsjZUtjqsuKdAnz/BMNzLiFdAxFIhsL4GckdPs86ebZRRs6DQezt8eWAHeB
         8GP3A246RIbGvdW4f6h0X3/cZ/09dOnLJsQvoOve9tR5j5FBP+Y1AwuiILGeppCjZHf9
         GD2Zlwa0NjOzNhYenxMTEZ3v6WNtDy7JHRDB9XX65k5hleAz8qGLbfpxFWMQpMwaS0Lo
         7Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783226; x=1747388026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JGHETYI8p8q6LOPsOAAdd56RcgjkHCoMqlYzoMs5XU=;
        b=OvSHrlSr3cZyHc6KO0AHl6L72ufWE55acZKtIRM8nOrJPkjX2quLkBhlVzNnLzXiqW
         LuFsLV2cpSkIPQkWX6NxcAUajdIxg0OdJkpp4ovGUa7Ro9bsBGc+ar+O3lWVA8aAbY93
         SSCOLrtNOhyV9+mMHwERBr8Y1WdrIF+o5bCxDHs/vXp1GjKn5HIdtDY36ZyO9R0tzWQ4
         /wqkcOPi7Zui6W/9/5ok4o7WeZ3HoyCycCwwIC8oD8udCFe6s22JRdyKoVYNgeaCk7se
         P+7FcWbDr2ssmrHKMlpwiSdIBKNKt2ikn4twS/7LDYX3Xk67uqfhNqbWCi6WNLF1qZ/U
         1+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVY8lFyVFuRpB4+odROn+/lf/QF8/dzCbcI34FR2F5EeyO5MHtGKfyH5aw4c6fjXYnIXOu4LT0z@lists.cip-project.org
X-Gm-Message-State: AOJu0YzphnSmSNZaI22tduKolV1wHD7WEmL2MXHfrEV7ieyRPrc4jxkH
	1/j07IcB3lJkg8YF7hQyJlXW8Ap94ZYoMaDgdcoLWGN028HBkumotcqOj3BW2xw=
X-Gm-Gg: ASbGncumyPMCFMdsCQSyaMwpydvy3CuI9ZEOyGA8IcBBZ7HK1ubGG7Tcz6hU346fYpo
	rUTzRsqo7VGj5gHx0HZD1g1B7G6K7gLQ3AqJT8vLj02uLJ3XNTG7afk1pRPIeZtkD7j25VL5a2C
	VkIbbf9A1jb30WSC9nvTu7D26UOICoay8qFcBjtKJIrf6GRdCKE0kMz3Wh7/aT9tKRzkr7iWFwQ
	UC61wyN6ID3hZMUR+IOAv/oHkStybr7bj+O+srx0UCDZ7X5hkoOj+4QpBfF6JOs5aWkDwJvt5dU
	rLksUmqEq0UjICXctfHTNX1O4aava4lGsBETDmnvrRB5SFb8OdLF3QDYqY3/INppQFbeEg==
X-Google-Smtp-Source: AGHT+IFz2vLCQhi5AQtE5xEuASCMYk98qPFRaHIAXQaQZB75SqJuKOKr7bNALsNxoOxpbmicmJXWYQ==
X-Received: by 2002:a05:6402:518b:b0:5f6:2249:d424 with SMTP id 4fb4d7f45d1cf-5fca07ed756mr1975822a12.24.1746783226373;
        Fri, 09 May 2025 02:33:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 17/34] ASoC: renesas: rz-ssi: Remove the first argument of rz_ssi_stream_is_play()
Date: Fri,  9 May 2025 12:33:01 +0300
Message-ID: <20250509093318.4014916-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18834

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 109e60866f11c7db8f720f01b0bda3105c47b463 upstream.

The first argument of the rz_ssi_stream_is_play() is not used. Remove it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: fixed conflict by keeping rz_ssi_get_dai()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 88f058921e1d..33800ee587fd 100644
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
 
@@ -687,7 +686,7 @@ static int rz_ssi_dma_transfer(struct rz_ssi_priv *ssi,
 		 */
 		return 0;
 
-	dir = rz_ssi_stream_is_play(ssi, substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	dir = rz_ssi_stream_is_play(substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
 	/* Always transfer 1 period */
 	amount = runtime->period_size;
@@ -813,7 +812,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (ssi->dma_rt) {
 			bool is_playback;
 
-			is_playback = rz_ssi_stream_is_play(ssi, substream);
+			is_playback = rz_ssi_stream_is_play(substream);
 			ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
 						      is_playback);
 			/* Fallback to pio */
-- 
2.43.0


