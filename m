Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5AFC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:04 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web10.10384.1746783238967319157
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SKlW0/x9;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so3565149a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783237; x=1747388037; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xxe6Uz270HXF+ofTMXelPGLiREMHFQAsbMCdb+C0y4E=;
        b=SKlW0/x97N+ksuxW8N0fY+HpNlrmQw/nKPJaGC8J6QBeSuSeutZ64skvN3o7bVS8RF
         /1/rVbygPCmtMMeO+V1Yfaf/x6sET7+oJYXUghReYDyxeUA+adgbRPognDKY7hODR4Hq
         1BS0Db5ZTE4/wrTyVO9/yUhlGZWwGsl2SEcq7YMBdv9TxWtgksCHZls0XCWKLncJPM92
         aC83BGLY+9jLb3zKHrqevewIcUQLv2bEENUydysvQ9r1OYeAXD5vVeijsv+V9REqgYff
         LJHLHKE1PvDVG8pkwGkEhQU84hogIj7XuSK9SkFLYMS4wcuVvkKI1FIcn+ATnwgnMAf/
         s0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783237; x=1747388037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxe6Uz270HXF+ofTMXelPGLiREMHFQAsbMCdb+C0y4E=;
        b=ogJE6UHQJUbJIU9RXqLe2gGsMOKXJbMWMI6uYkCifMhy0q9ODF/izKsqNqNTPTKymT
         uzRs8wt4klMpMZPS6Dvg8wa1KBZSn1ETSZSzZc1z94npbu5qfZTxtIZWlBGQXunhkrep
         ps/oxKZNNo+XvclZZjQ1FhSTwnvJbfl+87aMb0DnLZjGaNBNI2Ls4ZgEWahrgMb2Kdld
         CBaABs4Fn9gwf4t3BPEBdn9NJwyxgNpJaQZm7fRudQw8KFb9a67DAXuWTFLADprp3VHa
         fIKExoVe8XAgeB1cMMeYFbfwngFMrljc+zVUpn4+mikqfFfLCq0Vup67W2x+zKXsFXer
         xVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDGa958WaE6cgXq4lcE6niXfUsQiY20OH5ISdYrgKDwXBJyNueHGQshhNaecNx0dgW9AqHl988@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyx5M9nDKD/B4ewm3s5GuGxf+SHyR/3GfpwF+mTsUZjVx64ADmr
	dOwemz0NvzQYTCkNyoFnUFSDs3UEVbQiwY0iVpPM9oCso5cWNtW10oR8rDcBH7M=
X-Gm-Gg: ASbGncvVFylieBOXn0aqk/o/9aGzmEA+kD+uRSPDcyMXXth1sxJmYsQVk2nOtVrsaSA
	DA32x3Dm4c0m263S8DO3ZDDNjep1qFkIdCQyD5JaldSbLCCcckIamqi63USgr4e7SeUf5EEnOnU
	KIt0o8Ib5XrJysPBCJD1LN0ZSLxF2D6V6xT0lo2CDZm7atDpb0QCJPWru/Nxzxf3npB0TxEzZIG
	u5bvXLXh93HIXbWn0lG/nbByfn/TGZ8E9bNmKukymsm9ZG/MdP09C7KKk/WxO32Cv4pnNk4Wer3
	iGH0IZ7a8WPvaYPZLM7uvGG+1fVfBWW6ay1LrPBf1D2XuKo8Wx0AHd5K51KPQKwbSDUPUQ==
X-Google-Smtp-Source: AGHT+IEVQEtnTTLtzwetRIcWurhmF3Q5MJRNDZQ7NV//YKYZKJ06SX4wMg2ofn18iMFd6o0LYkiupQ==
X-Received: by 2002:a05:6402:3514:b0:5fb:afca:dd6c with SMTP id 4fb4d7f45d1cf-5fca0731523mr2098704a12.5.1746783237372;
        Fri, 09 May 2025 02:33:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 25/34] ASoC: renesas: rz-ssi: Add suspend to RAM support
Date: Fri,  9 May 2025 12:33:09 +0300
Message-ID: <20250509093318.4014916-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18842

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 1fc778f7c833aeb13041adc06f016f1a2dff7350 upstream.

The SSIF-2 IP is available on the Renesas RZ/G3S SoC. The Renesas RZ/G3S
SoC supports a power-saving mode where power to most of the SoC
components is turned off. Add suspend/resume support to the SSIF-2 driver
to support this power-saving mode.

On SNDRV_PCM_TRIGGER_SUSPEND trigger the SSI is stopped (the stream
user pointer is left untouched to avoid breaking user space and the dma
buffer pointer is set to zero), on SNDRV_PCM_TRIGGER_RESUME software reset
is issued for the SSIF-2 IP and the clocks are re-configured.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-18-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 46 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 6c39cf392f20..c5e0dd1c78b2 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -795,6 +795,32 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
 	return -ENODEV;
 }
 
+static int rz_ssi_trigger_resume(struct rz_ssi_priv *ssi)
+{
+	int ret;
+
+	if (rz_ssi_is_stream_running(&ssi->playback) ||
+	    rz_ssi_is_stream_running(&ssi->capture))
+		return 0;
+
+	ret = rz_ssi_swreset(ssi);
+	if (ret)
+		return ret;
+
+	return rz_ssi_clk_setup(ssi, ssi->hw_params_cache.rate,
+				ssi->hw_params_cache.channels);
+}
+
+static void rz_ssi_streams_suspend(struct rz_ssi_priv *ssi)
+{
+	if (rz_ssi_is_stream_running(&ssi->playback) ||
+	    rz_ssi_is_stream_running(&ssi->capture))
+		return;
+
+	ssi->playback.dma_buffer_pos = 0;
+	ssi->capture.dma_buffer_pos = 0;
+}
+
 static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 			      struct snd_soc_dai *dai)
 {
@@ -803,8 +829,16 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	int ret = 0, i, num_transfer = 1;
 
 	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = rz_ssi_trigger_resume(ssi);
+		if (ret)
+			return ret;
+
+		fallthrough;
+
 	case SNDRV_PCM_TRIGGER_START:
-		rz_ssi_stream_init(strm, substream);
+		if (cmd == SNDRV_PCM_TRIGGER_START)
+			rz_ssi_stream_init(strm, substream);
 
 		if (ssi->dma_rt) {
 			bool is_playback;
@@ -832,6 +866,12 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		ret = rz_ssi_start(ssi, strm);
 		break;
+
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		rz_ssi_stop(ssi, strm);
+		rz_ssi_streams_suspend(ssi);
+		break;
+
 	case SNDRV_PCM_TRIGGER_STOP:
 		rz_ssi_stop(ssi, strm);
 		rz_ssi_stream_quit(ssi, strm);
@@ -971,7 +1011,8 @@ static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
 static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED	|
 				  SNDRV_PCM_INFO_MMAP		|
-				  SNDRV_PCM_INFO_MMAP_VALID,
+				  SNDRV_PCM_INFO_MMAP_VALID	|
+				  SNDRV_PCM_INFO_RESUME,
 	.buffer_bytes_max	= PREALLOC_BUFFER,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
@@ -1215,6 +1256,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
-- 
2.43.0


