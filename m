Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA8FD9E01
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 19:42:43 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78942.1772134962397715262
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Feb 2026 11:42:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fOi0ozTE;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43988056dc3so1267339f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 11:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134961; x=1772739761; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQnvUkV6mZYR+zMdKDeHRjYld3vvbKTnPQPUGaOFlJo=;
        b=fOi0ozTEO5bn9qVptvAUFSYFOwiyuYDS/oka2giAmx1vrdUt8v/bw6EQgfHBw1mhuz
         8C6zcDVN4VrI2fe6dlar408cu14jQRjXF5YAl97AFXd31fwb0ANOFyYVOlazvbWE2RV+
         P9L5/VnDYLzMOWBWOlG1T/3/NVJQK0qaKmMfsal34pygu4m7A4xLKMP1mZroqsO5AaOY
         NUSgh0rNgnt52hFfOPC7pGpf0ddt6LscXBfezN2GKbXonxvcx7AypvO/FCqSULI8Bqur
         /SCp2klfRJiFqHhIFi8hZZS9mv4ijoBWTsLtWp/EHz0yxoEbkbnKQ+MyVk8KHbOVGa/O
         mdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134961; x=1772739761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQnvUkV6mZYR+zMdKDeHRjYld3vvbKTnPQPUGaOFlJo=;
        b=Gz6LsiQ2xsdu6+74Ccso1IRek8mCgbGT1yCMwzzvycRq3MPnaCvDQVrqU9wKPFetud
         /nF0gqbA81nfT3goFJW05VrTUFNVl72JMSy/JmNk7YRlkGJFArP/lt3bd54A19TTsqQL
         qjbXjd18kwThEYq1A8hsbygXaZRzy/eEgFUZZu814cB8C6q5odLlmJTK7nJdBE+Ch+p8
         4MVhbNqMZ9aPimvnrrRs96XZCP8L+nQ+rFMw4qyTuS14HeTsIARUF+q+DbbO9R3C6o7L
         LC1SA+STuD7zTsbx+aimL0cd7bL/nw4XustASZMmgDzD6MMww6A6tKmVLOGdqMlpZ4ux
         ZbOw==
X-Gm-Message-State: AOJu0YwA+nQtTuVp8JXqbiK/5KBDApzJR7C5D7oG9LzE0UjJ95ZZiC0t
	KnDCSlZb76xBC5Q88Zgl+U6NNVrcmgNbQPQszszBaX++eSGgFsiMDf5bUixJyUMp
X-Gm-Gg: ATEYQzyb1+Q0cb/9XpRxAix9x4hTF4C6zH7//KyxHf55rUIUVfWtYLCLjso8W8ycjM0
	qzsMrSijqqY0aXMYffZK0H9XDyjFGrymVxfwp1k+AyWvsAF9aJfw0MLHJk5XVA/dziKXIZoaho8
	b2/SyN6UlllCT7wG5Dvi8IzJ6Rbcw2co233L+Q3gh7e/DOwNdvpfpeM0AqZbUZd27f8erzRczSH
	q+y19LOwiSHFRepMkU8is2sOtTN9J1PN+uX7YRkAWGUAv7lG+dfIzimTuZh8TBk19IV9C875O3b
	Zb7wbSEsm/23coKG/WrDHHXUohGDDKISk9Tmpq8lgFwMHppnye5/u5cq+khQKsHsmBGC7hTZ+iP
	txE5agD81M5Q1vFfNWpQiEtC2uFH7fUDkdvwKvr/CSNHoFYLZ+FS3VUctKZeN1f4Qcekal5pEYg
	yY15zI8sRDWl6Zi27TI5zfayNY1SAimSsptpTAoJ+zR0R1Ezw=
X-Received: by 2002:a05:6000:2081:b0:437:711c:8754 with SMTP id ffacd0b85a97d-4399de0b754mr52931f8f.7.1772134960529;
        Thu, 26 Feb 2026 11:42:40 -0800 (PST)
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
Subject: [PATCH 5.10.y-cip 3/9] ASoC: renesas: rz-ssi: Fix channel swap issue in full duplex mode
Date: Thu, 26 Feb 2026 19:42:24 +0000
Message-ID: <20260226194237.449383-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
References: <20260226194237.449383-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Feb 2026 19:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22014

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 52a525011cb8e293799a085436f026f2958403f9 ]

The full duplex audio starts with half duplex mode and then switch to
full duplex mode (another FIFO reset) when both playback/capture
streams available leading to random audio left/right channel swap
issue. Fix this channel swap issue by detecting the full duplex
condition by populating struct dup variable in startup() callback
and synchronize starting both the play and capture at the same time
in rz_ssi_start().

Cc: stable@kernel.org
Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Co-developed-by: Tony Tang <tony.tang.ks@renesas.com>
Signed-off-by: Tony Tang <tony.tang.ks@renesas.com>
Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251114073709.4376-2-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 51 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index f32ad81b08f8..90ee5564622a 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -134,6 +134,12 @@ struct rz_ssi_priv {
 	bool bckp_rise;	/* Bit clock polarity (SSICR.BCKP) */
 	bool dma_rt;
 
+	struct {
+		bool tx_active;
+		bool rx_active;
+		bool one_stream_triggered;
+	} dup;
+
 	/* Full duplex communication support */
 	struct {
 		unsigned int rate;
@@ -349,13 +355,12 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	bool is_full_duplex;
 	u32 ssicr, ssifcr;
 
-	is_full_duplex = rz_ssi_is_stream_running(&ssi->playback) ||
-		rz_ssi_is_stream_running(&ssi->capture);
+	is_full_duplex = ssi->dup.tx_active && ssi->dup.rx_active;
 	ssicr = rz_ssi_reg_readl(ssi, SSICR);
 	ssifcr = rz_ssi_reg_readl(ssi, SSIFCR);
 	if (!is_full_duplex) {
 		ssifcr &= ~0xF;
-	} else {
+	} else if (ssi->dup.one_stream_triggered) {
 		rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 		rz_ssi_set_idle(ssi);
 		ssifcr &= ~SSIFCR_FIFO_RST;
@@ -391,12 +396,16 @@ static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 			      SSISR_RUIRQ), 0);
 
 	strm->running = 1;
-	if (is_full_duplex)
-		ssicr |= SSICR_TEN | SSICR_REN;
-	else
+	if (!is_full_duplex) {
 		ssicr |= is_play ? SSICR_TEN : SSICR_REN;
-
-	rz_ssi_reg_writel(ssi, SSICR, ssicr);
+		rz_ssi_reg_writel(ssi, SSICR, ssicr);
+	} else if (ssi->dup.one_stream_triggered) {
+		ssicr |= SSICR_TEN | SSICR_REN;
+		rz_ssi_reg_writel(ssi, SSICR, ssicr);
+		ssi->dup.one_stream_triggered = false;
+	} else {
+		ssi->dup.one_stream_triggered = true;
+	}
 
 	return 0;
 }
@@ -930,6 +939,30 @@ static int rz_ssi_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int rz_ssi_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi->dup.tx_active = true;
+	else
+		ssi->dup.rx_active = true;
+
+	return 0;
+}
+
+static void rz_ssi_shutdown(struct snd_pcm_substream *substream,
+			    struct snd_soc_dai *dai)
+{
+	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi->dup.tx_active = false;
+	else
+		ssi->dup.rx_active = false;
+}
+
 static bool rz_ssi_is_valid_hw_params(struct rz_ssi_priv *ssi, unsigned int rate,
 				      unsigned int channels,
 				      unsigned int sample_width,
@@ -1000,6 +1033,8 @@ static int rz_ssi_dai_hw_params(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops rz_ssi_dai_ops = {
+	.startup	= rz_ssi_startup,
+	.shutdown	= rz_ssi_shutdown,
 	.trigger	= rz_ssi_dai_trigger,
 	.set_fmt	= rz_ssi_dai_set_fmt,
 	.hw_params	= rz_ssi_dai_hw_params,
-- 
2.43.0


