Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75894C3ABD2
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:25 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.10365.1746783324731217313
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Rhpctw9I;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb5ec407b1so323911566b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783323; x=1747388123; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdhmbNis7qjclOAYi7WYEtGdFAD87guhALBKL5SwpEM=;
        b=Rhpctw9I1QhIRtmW/+a2+lMtCY+2iqynScZGa9jAuY+D3A2Fqt9+vNEMOhjqiuYfuL
         jqasyWDOBKRK8gZ7HEcOfBTe4oeXvNotuliauv9rh7HqpEJ7n2j5Kr91DmPcmCLq+YCc
         KX1AuMRsrl4usEu3uvT5s8DHVYah+EZV1gLAI+KvvSPW3DBZTAZXsigAETMrq0ZneGMp
         we1w+lh3Jqf4aNloao+SLly7gcY4F8qwEpFBez/bfNyxYhKDvPUfOeJgDnWiajPbN9QA
         AlmfTOUbJ7+o2ECw3vIydRwlPGLR2hk27EaOavvGdwAN7GtHS9lJf7WeJUYgzEWPlO6c
         8wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783323; x=1747388123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdhmbNis7qjclOAYi7WYEtGdFAD87guhALBKL5SwpEM=;
        b=NeskKWDFWkcaQB9VFecH0Za6zgTsOqLs1or3K5N7BUGluOxNSCvz21LdH7KOcnRmC3
         EikLpROUIqmP1o0yUChBqImy2W+uBuKr+mbg3GMaDrEMfc4F7+vG4SKCVTw2DcpNFifA
         SNFVGD0VIl64nKYtKQgEav2ZqTnc4dYPFDkRJaUX6mmS/xTz0uU3AniHRmKSFd3gNTeW
         ZWQSc8TLsTOZv0OvuV0GeUsVc4nhbE8eiD0MlkmwG05xVH1nd+r1yNEFzRofu2MYCn3t
         faqF4lnwzPuFhLHebIesiivd/MgljV9WVybyrJGxF+U/Z04J38oea4yRE2LU5sIvyddf
         sibQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbyc16MBGgUc+98iDA8CHB4AGxqjsGIqdWKcFisKy2THn8DW/JFeZOCD46lq3rM6dYNRt4pd0z@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzou9ggqOBiwvmHIDpx4fpCwAoCxgt5SGGySM+u7HQSJJk4YWFT
	Gk+aTbDqIpKkqZE/QZ/gosBOKxZo9XTPz5VMI8ZSn97D6M713VAxjIsNfHBypd4=
X-Gm-Gg: ASbGncsBt8Nevn1d2mSHaW8LMZvqmQgV7Ou/9u2O4YF+w71C7M1O6xH79LLRqoWMQDZ
	U5fHrTLPZtOjmJEQZzvxPzVnMoWK/rcxkuSwuqlhX6pEULivP8be43RVJRvjlIb6de7ffyb5doH
	UqJ7hkfwZWo8eCOnoP8Dpo/dCDM21SntIfa7FGqy0QwzFY+0Ck/UFZvyO1UoxAMJ2N7bxmQns4v
	qiWx7uiQ2HmxWD+R8Y3bnJ+AuIC1VoVwq1+y6xuB+EW+8a5DCRajKdsGBlvbK2WU63FveyqPHxD
	j5JHQ/eBvyqWTvaHkfjd0jd+vfrU0eoKqGY/1Sb69Jq/LgwwQdgs2AkM5pikNW/CY/vE+g==
X-Google-Smtp-Source: AGHT+IF0nNTppVnp6bANyQAQufH1kV+hILcZyezO9MPrpm8Po6U6LwhcZ40P523V0XxM45VOu3fauA==
X-Received: by 2002:a17:907:a708:b0:ace:c5de:24cc with SMTP id a640c23a62f3a-ad2192dea1cmr215411466b.60.1746783323084;
        Fri, 09 May 2025 02:35:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 27/37] ASoC: renesas: rz-ssi: Issue software reset in hw_params API
Date: Fri,  9 May 2025 12:34:32 +0300
Message-ID: <20250509093442.4015145-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18879

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
index 2e688889653a..bc9e75b04dcc 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -399,6 +399,15 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
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
@@ -793,14 +802,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
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
@@ -925,6 +926,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
+	int ret;
 
 	if (sample_bits != 16) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
@@ -951,6 +953,10 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
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


