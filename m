Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058AC3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:35 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web10.10424.1746783326311973836
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fMSg3fmh;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so354998766b.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783325; x=1747388125; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rMsVeXTEjVpZm31lCU+Lf+gYKqNixFrlJD7ZX6l+JU=;
        b=fMSg3fmhwIbkD1imqzJ2Y4O7gb76pwKaUCM1CyU6ZYLXaM4SbzNMZZuqf3800451Cc
         4XiSUEOtWgajrcI+7JWlFKifyypmgOIg+jOfo0eGqJZUGz+iG81Zv/+kuQAWjQCyirVS
         pkZ2jMZAACsE7J2mkYne2oCwgkGsl+QTKl1amSrtQj6i7PmDIDoRgWN9OjwdPDFbJED0
         gQh9APvyA/dhu/2P+qb/7MnjeRpnj69F4OzRncB02TqtDv1J9Xd4vIbh12W4fU+q5HHP
         2YASnxe8piBGiEEN70ugkBMxPsz8mCt+Y7HYj9LyQ6Pj6ku1Kvjw68Z8PzKirP1vIXjb
         t0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783325; x=1747388125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rMsVeXTEjVpZm31lCU+Lf+gYKqNixFrlJD7ZX6l+JU=;
        b=chgP1jE1/hRRGfrAs96PKPpv6yUB7+w6jU0Lby5jfAMuWpLdXkMVWI360eJT9RxaQR
         RGKWdvhAtp3y1lLgFmezjUN9F9qKaAKSLfX2C0oYD1/ShJ7gBB9+0+EM5X8WttyFBVsU
         00YdzjiIX+MGYetnfATftRa1QKFqaYRnbygpUhoIv1PO98/fYQ5s/rMie/2UUF+PkxNT
         KaDI2/WE3lPdccVL6Uj6NX6IfRe5PPL9QUVVBAUAYkeAGQfZjeuuvkBjAoHw97w4UpPs
         Ig2q+sndeJcsH1Cj9vVhCfzrMRdCZ92NjpyDFh8WnTPS0UCZdCR+RguvekMrcaUE/5UK
         7Vzw==
X-Forwarded-Encrypted: i=1; AJvYcCWWRbjNTxqFoqr90VNTp/kuWK722f6DArbKAH41jhbSFgoTviCFBK+L0hvpP7lcfNgjy8O5+Nn3@lists.cip-project.org
X-Gm-Message-State: AOJu0YxsTaIvCNHR4f1SR8jWLEHCFw68unCdrznF8YIRoIFgwcZ/29pj
	PqwfJ9sqf6JUaMvR0sM5yvKeLGpYz5vMBDlc5ioKWdHPBgkDa/HqfjA5coDpgJ8=
X-Gm-Gg: ASbGncs55ZsRQbvj6Sq2Qim3lX7y2xlB58h39g88ehgbggY9b9xXkM+Ej+Wd9pcg6/n
	m4Z7TkZbvGxVgM1pYFvHmWriihYlV7aDXhmEOcfERcnK6ToylEwWBlByR+3R17Fttna/9QmL8Tq
	2GhHjMX8MIeXoj1uVTc/MS8CmIHoLqMPYfVc+2XA6TcoXkebYi4BiK2BDVTz2bvbVHMoIZZqr1y
	klbfwdgyAv4p13rvGmsywkDYalyvoWgNShIdjYKLAPdyp2RWlPS86aMw0ta0W1T5NDXvqRE7mIO
	SlBz8hAH7jaEJsWTEH50E7Gf54AF0WmxCiCiejVZiaQUz+xnoynbMuHtQaKpRLSASFQ61ZyRBDL
	f+pLU
X-Google-Smtp-Source: AGHT+IH+y+QJuexjMSSJocKs2vH18tDiWWUVxUC/8JUU+NWKiI4F2UmQgZbSdvP1IPj17bykdwdxSA==
X-Received: by 2002:a17:907:97d6:b0:ac2:dc00:b34d with SMTP id a640c23a62f3a-ad2192974f5mr249699166b.53.1746783324663;
        Fri, 09 May 2025 02:35:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 28/37] ASoC: renesas: rz-ssi: Add suspend to RAM support
Date: Fri,  9 May 2025 12:34:33 +0300
Message-ID: <20250509093442.4015145-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18880

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
[claudiu.beznea: use SET_SYSTEM_SLEEP_PM_OPS() as
 SYSTEM_SLEEP_PM_OPS() is not available in v5.10]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 46 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index bc9e75b04dcc..0f03739f920c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -793,6 +793,32 @@ static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
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
@@ -801,8 +827,16 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -830,6 +864,12 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
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
@@ -969,7 +1009,8 @@ static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
 static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED	|
 				  SNDRV_PCM_INFO_MMAP		|
-				  SNDRV_PCM_INFO_MMAP_VALID,
+				  SNDRV_PCM_INFO_MMAP_VALID	|
+				  SNDRV_PCM_INFO_RESUME,
 	.buffer_bytes_max	= PREALLOC_BUFFER,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
@@ -1212,6 +1253,7 @@ static int rz_ssi_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops rz_ssi_pm_ops = {
 	SET_RUNTIME_PM_OPS(rz_ssi_runtime_suspend, rz_ssi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver rz_ssi_driver = {
-- 
2.43.0


