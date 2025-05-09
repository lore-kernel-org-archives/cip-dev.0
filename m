Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EB2C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:23 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.10324.1746783142730307662
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Qp+he1Wq;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso3717133a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783141; x=1747387941; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XirDBk3IZtVTp6IXmdEtTb2Lb2ar7qPw8XPts4/kuZs=;
        b=Qp+he1WqZO4JbYsyIU5BuyocP0fx6CAa0gZIbw2gMdmyqE4qbbtEf9mUomwV5LRDnG
         tn9ljIWl8htv+SC6XLAq5x4amEicHfjs6jWuiljXk6lEQ3M9LlZF60O/vQ6IKfgD4uXE
         p4pksYF3c2xY2yTK09NxAwqT0dAurEOAWAgnymwC8eQ+Ns9k88UT2mReFDc6QEEt7mf1
         yV5RM2Ff7qgJ2hp7h8H9HTCaYz0ZdsSqpVWvB5+0YtSJ33Mi4+m9e0PDhB+UxIO+rSA7
         hAmmXdkD7gWb7A+7qC1pZ7GdnhPSYXgGp9rSYKMhL1vkHlAPr6h602x+aiy3ikcc3dUG
         L6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783141; x=1747387941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XirDBk3IZtVTp6IXmdEtTb2Lb2ar7qPw8XPts4/kuZs=;
        b=I51WczEZhbnwd8fE5+XaWhiW3TWzWMtpu4ZSfkbLhvLdn+LI6ClZnCgjcsnx+LAv5E
         snhQZxFSWOlO2jOrn4nR9RKDmDrLr5ZKjQrl9F9taAwri9LzcEZsgmCG294wNil+tOzc
         18xs35DhVWT+D2TNwZDMGyF7z2am637wl2zo/BBFSSOnKRrtQP2dnO3ES3CbRF4c/VyV
         E9ptZI9eUVWLaV9F2AWXjeeskK0BY5Mzopl+3Uec+Lzh4WgVXkj0dexQwiH44ev55ySi
         XuNY8eZpYNIujjNZYQxj+tKOatOBDAcAOyLuA4iJ3SPnIfnmKhlFv9qOK5amuhnCAqV5
         2tfg==
X-Forwarded-Encrypted: i=1; AJvYcCU/tPv3dNDSnOGLXai4c5fzpe5KbIjoEpri3qYsjYcadHszJ8IAC4t1SD9JOb56wzu/RPtLsmMC@lists.cip-project.org
X-Gm-Message-State: AOJu0YwoKC7SAnI1adHZ3R5wlyqq2fkBumEonvMoCBe4DzUF5lDl/PaN
	F3vdskzxPD4k5cjRjJ6fq3S0fYgkgYhn/3LOaGlu0IdR8G/8pkFidcE9+Ql/ZMI=
X-Gm-Gg: ASbGncvoUMn1TAKzTKpRhErgSdEjd5s+Tfz9CH+1X6P4hK3n/KvYq+1XEUsWAidIPMX
	MDafUXL1ULaV3kTVCFWnxrjRzuKd3BC6E3BJeT7pS+wp5JSZzc6CIbZ4yIZsQ35VPbdvFAFjNDn
	btWJtrWyHJ0C9jGNj6cfrHJVns1Eoxmylh2Jh64r/UMpIpo8aWquwXsq/HEKauUI6OOaTysSu17
	Ld8d4ih8bpIYNtDSbtLCadOvaVPbSc/P5AikYCE/g5YyaIRRZ24laOQSSo7+2hFRA+LaIdDkggy
	Vds/zGca8Gjf/tCQf4CgFis4AtedcYT7pHsjFIH2IZYKeeZVWu3zEr5DE90kC13DjELo08goSUB
	IGPKk
X-Google-Smtp-Source: AGHT+IHC+cWkVQHCAf7toeg3ALbajI0oEd45IW8IE+GEI8+FREC9EHXIUtMBPo654rrSEKoAmuw8DQ==
X-Received: by 2002:a05:6402:348a:b0:5f8:d7e6:df0e with SMTP id 4fb4d7f45d1cf-5fca07eb741mr2088555a12.24.1746783141149;
        Fri, 09 May 2025 02:32:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 12/29] ASoC: renesas: rz-ssi: Remove the first argument of rz_ssi_stream_is_play()
Date: Fri,  9 May 2025 12:31:46 +0300
Message-ID: <20250509093203.4014750-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18799

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 109e60866f11c7db8f720f01b0bda3105c47b463 upstream.

The first argument of the rz_ssi_stream_is_play() is not used. Remove it.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-10-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index be913a69bc4c..c475d32dc76e 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -162,8 +162,7 @@ static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *priv, uint reg,
 	writel(val, (priv->base + reg));
 }
 
-static inline bool rz_ssi_stream_is_play(struct rz_ssi_priv *ssi,
-					 struct snd_pcm_substream *substream)
+static inline bool rz_ssi_stream_is_play(struct snd_pcm_substream *substream)
 {
 	return substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 }
@@ -339,7 +338,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 {
-	bool is_play = rz_ssi_stream_is_play(ssi, strm->substream);
+	bool is_play = rz_ssi_stream_is_play(strm->substream);
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
@@ -678,7 +677,7 @@ static int rz_ssi_dma_transfer(struct rz_ssi_priv *ssi,
 		 */
 		return 0;
 
-	dir = rz_ssi_stream_is_play(ssi, substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
+	dir = rz_ssi_stream_is_play(substream) ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
 
 	/* Always transfer 1 period */
 	amount = runtime->period_size;
@@ -804,7 +803,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (ssi->dma_rt) {
 			bool is_playback;
 
-			is_playback = rz_ssi_stream_is_play(ssi, substream);
+			is_playback = rz_ssi_stream_is_play(substream);
 			ret = rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch,
 						      is_playback);
 			/* Fallback to pio */
-- 
2.43.0


