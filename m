Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C07C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:43 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web10.10334.1746783157365768604
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KW4QHZqB;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fbed53b421so2915553a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783156; x=1747387956; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRuGo5tEGCyIKAzMsV330q5VV5Qi8wAVinXrwFLwx54=;
        b=KW4QHZqBL+A6tAogMiQzYVS/D4hmLyZW6V0aaKwa17FBBvIZUg0VWFkQk/vQD8ShVA
         emoufI5Ral8+kOfhTjLEqS8np16ZwGndGh1vW0Mod4iEj/vjFMbnLlb/cMvA5ZNn5HZQ
         NpsHJ1YRTzAsWh8Z10pmt6flhA66gbtaKKCyVBgQFVdvj54xpvddrYTLd6Y9WKThxgw/
         beu8F0PRT6/1PRN1/Q/JLl2cZ5AJHStD5MIA7fMnu7vOL5EEFWnSD3WTJbO+6OiyUEc7
         oU3zqahAgr164o6XSDH9ZGvgq2DDk/K//59qLme08pHBpBe3UUIyuHIlWw+BKC/qw3W9
         I9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783156; x=1747387956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRuGo5tEGCyIKAzMsV330q5VV5Qi8wAVinXrwFLwx54=;
        b=cHtsY05SE2lzvKNgys61k/6zlGugoSnU1+pjv0cEVVXbS06tIEbqDar2DbvdTF3//l
         AwIHMZZAZXCvSpZ1BIfkQHKoqoQbOjGOOwcNnyOd2P5+O644fGu0xIiemoRn2LM+1Mfd
         +pBjdVAmHcdGvjLZ+/XZA7L5upAFW0yM2wNYIHZ6T3wt6hkzA+uw3dGdDdxtY81N87IV
         +jPjEwA0NaLKxpK6OITF3p3IHYiNsHSl251m0fh3Z6NSNwg+q8dQMOOH+4ljbss40YI1
         +XsQ80XvfUfpgLMpqvYaBZ5YuUB4dtAFQQJowYF6oQJ+VfjYmAXppklD4fxkI0eidIXv
         rhZg==
X-Forwarded-Encrypted: i=1; AJvYcCWCAnejUblOd8ekYU3SqORW4NXLvXwvg6WUWXsm5fx+VXBhsfxyp7q8W12kuZ4DSb5WiPgOJU5J@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy9QAUAV9lZCJRJihURrOEotQeJwfMzseLqkULE/KaKRWzb5Aoq
	IDmybNLTOGGfuKHR4wE1N6RdPsmGcq4qYq6y2Orx1zd/5vATHsnp0cS9Z1s5bzU=
X-Gm-Gg: ASbGncsId99sVIc+bTAJQ/o3PFblRfpL7ipda3pubQizl2FSvI4qV1D+Pl0EdVvd97n
	yDF5r2KNTv5yjwcD45MpaUv8sv2xbSrpCmgvARq8n+VLV6lZRq1QsEKFh4rqPaR9ntzm588n5lP
	z2/bUiTYbcBG/R7eNqhQkLNUKq8jwMZLBjtjkmzbdL74lvgxzhfW+F+WJ8CxPx5VHTo31S7RNBv
	p3FbCzlpP3JBKvVBP72SWz+UfEccLEAwaCh8+bKIr25rUwd6MVqXs0HN5P069gotw2a5W3U9f7a
	dUQLY79XM0KykkF3IbtFjh+Svjz+do6pFY5ouYSd5t4qNHD4U7SFQL1mEKMwqyZagPNS1g==
X-Google-Smtp-Source: AGHT+IGUFgV+I8DKiYBm9o5S1biiyzK+Wc3iyQKU2FJOdvDXxcvXIljWXqmrAk5yprQGu6tmEXWbtw==
X-Received: by 2002:a05:6402:2813:b0:5fb:1fbd:e3ad with SMTP id 4fb4d7f45d1cf-5fca0759c82mr2104717a12.13.1746783155726;
        Fri, 09 May 2025 02:32:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 20/29] ASoC: renesas: rz-ssi: Add suspend to RAM support
Date: Fri,  9 May 2025 12:31:54 +0300
Message-ID: <20250509093203.4014750-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18807

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
index 2d1ffea84159..bffd41742200 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -786,6 +786,32 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
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
@@ -794,8 +820,16 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -823,6 +857,12 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
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
@@ -962,7 +1002,8 @@ static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
 static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED	|
 				  SNDRV_PCM_INFO_MMAP		|
-				  SNDRV_PCM_INFO_MMAP_VALID,
+				  SNDRV_PCM_INFO_MMAP_VALID	|
+				  SNDRV_PCM_INFO_RESUME,
 	.buffer_bytes_max	= PREALLOC_BUFFER,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
@@ -1205,6 +1246,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
-- 
2.43.0


