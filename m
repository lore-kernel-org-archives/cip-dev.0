Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD09DC3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:04 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.10383.1746783237890599580
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=DaQzCe9H;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f7ec0e4978so3492983a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783236; x=1747388036; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mL7mzAggHF4EEjqEUZK+/V3QTBGiFvD+t0Vww9WoU0=;
        b=DaQzCe9HFX4dR6SKemi6xLcRSNn29nhP8LJZxnZyye0uKoo6jN8ZrWAj4Cettw27zI
         k6JlhAjhkQS8168Z3KWJjQMYNd5U8qCZfap35ycSoUv9UCm31X7u+K6BxcsQCVZpA5a5
         Vocm5n4RyCFB9puTg46uEJ3BRQNkkNIBrQnyOfFMK5WkOoB9YnJHg0SLSbNV1Dj78rPQ
         IPm7/QxTvZFqjwYG63Sq5auGBTntx1sXdEDaWyj5GOCNf2kyMDZMoGQrJ04KFRCNsvEm
         w36IYXR4iC25oYHPUFA/vfvoU9rJXG0SJSEfRsKCn8bly77vU2hHBZh5JBs7x4fwVMWi
         8f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783236; x=1747388036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mL7mzAggHF4EEjqEUZK+/V3QTBGiFvD+t0Vww9WoU0=;
        b=WiNa4PeIUl1X1XG+2TqNoclp+TKuF5bMaRUYlx8zXeah6B8QvVaZSLgOoQuffyl0it
         4oCvFfv1fAYk1UpVfCbfWGRMDxZAI6GeQlk7+Nnh+QGy5swToD7dB2wl5mSSjsm0kXIP
         ENbmGe2VW2L5uXl+BRhn7arLB5iP5r7o9OcnsrgbhnmsnCZzNLkI+Q85wohpM8p0NXRP
         ccTRrXYr5S+dxc8ECDAPZyE0V9Q17SN7buM1WgnOCAW29ZcrHS9cgidc7+ZpWC1Ftrrq
         FqTpSsyLtsV8/HFVYykuq4D0R+q3g/mScSinwKUlriN0NDs5ogLJ2kV3B1+c9YP7T+nA
         G0zw==
X-Forwarded-Encrypted: i=1; AJvYcCWADYBVDNypKBSzTg1vU8A2ArDwBRKCorhWx4MbhXciGT4+oC8nM1ggCUJrgjsBJNkN5U49+A5R@lists.cip-project.org
X-Gm-Message-State: AOJu0YxYQ2QCUjlSGN8z6Q16QjDcLvPtZOZMEVHbK+/xt+tFfFdOOK/f
	jQtFPfGB0v3ktgMlK9sdss9T3UZBxgNJryYrsOWOdEtnaYtHMt8Q/tArjZH4uyY=
X-Gm-Gg: ASbGncske1MLXDNtJaXXtv9NfPBK3hpU/esQZVZ46IKYtF42Bh5EEoz2MFxWzOjCIUZ
	Rv1KCbzZwAJNpIbhQ9GkI+jSVjVaO8aryOJpzUc2c9xZ31iZ0JAydTk10ryLJDY6zJd5ergBLKD
	maUE3rfAASolVqjCfdmmH0GmSY8GlyylGiN8Lm+nT3Lt8I/eSPSmfJmLSSDSDaeerL06ktHjG14
	UBuN0joUGGGfa0+eXUxysBKYyEziki/9iMQUpoWVlWTZtRMyzfVm7Rdtji7STXUIZK0ixVfCaUq
	j6BqNJL7jgyMLpK4CcjiWGXMk8xqAKRhv87vItclZxNlaPXicYeGEptuEzPe/P/juA1jsQ==
X-Google-Smtp-Source: AGHT+IHumb5Ig5bnVBO98dQ9tsegRmECrhlsQ50mBiMf/Qi+ehEwmtUM3a2mV1WbCv1Uu3DLnsCBHw==
X-Received: by 2002:a05:6402:2747:b0:5fa:8277:3d5c with SMTP id 4fb4d7f45d1cf-5fca081a975mr2030566a12.30.1746783236162;
        Fri, 09 May 2025 02:33:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 24/34] ASoC: renesas: rz-ssi: Issue software reset in hw_params API
Date: Fri,  9 May 2025 12:33:08 +0300
Message-ID: <20250509093318.4014916-25-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18841

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
index 57c3fb48a7af..6c39cf392f20 100644
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
@@ -795,14 +804,6 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
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
@@ -927,6 +928,7 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 					SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min;
 	unsigned int channels = params_channels(params);
 	unsigned int rate = params_rate(params);
+	int ret;
 
 	if (sample_bits != 16) {
 		dev_err(ssi->dev, "Unsupported sample width: %d\n",
@@ -953,6 +955,10 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
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


